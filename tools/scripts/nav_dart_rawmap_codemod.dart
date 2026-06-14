// Throwaway dart raw-map codemod (NOT shipped). Converts raw map navigate
// actions in .dart files -- e.g. StacAction.fromJson({'actionType':'navigate',
// 'widgetType':X,...}) and result:{...} maps -- to fileName+navMode.
//
// Scopes edits to the navigate map's DIRECT members via brace matching.
// Source value may be a literal or a Dart variable (kept verbatim for fileName).
//
// Run:  dart run tools/scripts/nav_dart_rawmap_codemod.dart [--apply]

import 'dart:io';

const Set<String> kFlows = {
  'biometric_test', 'cartable', 'charge', 'child_loan', 'dashboard',
  'deposit_more_options', 'deposit_turnover', 'gift_card', 'home_page',
  'installment_payment', 'login', 'notification', 'internet_pakage', 'profile',
  'promissory', 'transaction', 'transfer', 'user_credit_validation', 'authentication',
};
String? flowOf(String f) {
  String? best;
  for (final fl in kFlows) {
    if (f == fl || f.startsWith('${fl}_')) {
      if (best == null || fl.length > best.length) best = fl;
    }
  }
  return best;
}

final Set<String> kRegistryKeys = (() {
  final src =
      File('lib/stac_core/registry/stac_widget_loader.dart').readAsStringSync();
  return RegExp(r"'([a-z0-9_]+)':\s*\(\)\s*=>")
      .allMatches(src)
      .map((m) => m.group(1)!)
      .toSet();
})();

final skips = <String, int>{};
void skip(String w) => skips[w] = (skips[w] ?? 0) + 1;

/// Finds the index of the `{` that opens the map directly containing [pos]
/// (scans backward; ignores braces inside strings).
int findMapOpen(String s, int pos) {
  var depth = 0;
  var i = pos;
  while (i >= 0) {
    final c = s[i];
    if (c == '}' || c == ')' || c == ']') {
      depth++;
    } else if (c == '{' || c == '(' || c == '[') {
      if (depth == 0) return c == '{' ? i : -1;
      depth--;
    }
    i--;
  }
  return -1;
}

/// Finds matching close `}` for an open `{` at [open].
int findMapClose(String s, int open) {
  var depth = 0;
  String? str;
  for (var i = open; i < s.length; i++) {
    final c = s[i];
    if (str != null) {
      if (c == str && s[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '{') {
      depth++;
    } else if (c == '}') {
      depth--;
      if (depth == 0) return i;
    }
  }
  return -1;
}

class Edit {
  final int start, end;
  final String rep;
  Edit(this.start, this.end, this.rep);
}

void main(List<String> args) {
  final apply = args.contains('--apply');
  final files = Directory('lib/stac')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  var totalConv = 0, filesChanged = 0;

  for (final file in files) {
    var text = file.readAsStringSync();
    if (!text.contains("'actionType': 'navigate'")) continue;

    final edits = <Edit>[];
    final navMarker = RegExp(r"'actionType'\s*:\s*'navigate'");
    for (final mm in navMarker.allMatches(text)) {
      final open = findMapOpen(text, mm.start);
      if (open < 0) continue;
      final close = findMapClose(text, open);
      if (close < 0) continue;
      final baseIndent = lineIndent(text, open);
      final memberIndent = '$baseIndent  ';

      // If the map is wrapped in the TYPED StacNavigateAction.fromJson(, the
      // typed model drops fileName/navMode on toJson. Rewrite the wrapper to
      // StacAction.fromJson( which stores the raw map verbatim (survives to
      // the parser). Other wrappers (StacRawJsonAction / StacAction.fromJson /
      // bare result: maps) already pass through.
      final pre = text.substring(0, open);
      const tok = 'StacNavigateAction.fromJson(';
      final widx = pre.lastIndexOf(tok);
      Edit? wrapperEdit;
      if (widx >= 0 && pre.substring(widx + tok.length).trim().isEmpty) {
        wrapperEdit = Edit(widx, widx + tok.length, 'StacAction.fromJson(');
      }

      // Direct-member source-key matchers (depth-1 within this map).
      // widgetType: literal or variable.
      final wt = _directMember(text, open, close, 'widgetType');
      final rn = _directMember(text, open, close, 'routeName');
      final ap = _directMember(text, open, close, 'assetPath');
      final rq = _directMember(text, open, close, 'request');

      String? fileNameExpr, navMode;
      Edit? extraDelete;

      if (ap != null) {
        final p = _strLit(ap.valueText);
        if (p == null) {
          skip('assetPath-non-literal');
          continue;
        }
        final m = RegExp(r'lib/stac/tobank/flows/([^/]+)/json/([^/]+)\.json$')
            .firstMatch(p);
        if (m == null || flowOf(m.group(2)!) != m.group(1)) {
          skip('assetPath-non-canonical');
          continue;
        }
        fileNameExpr = "'${m.group(2)}'";
        navMode = 'localJson';
        _applySource(edits, ap, fileNameExpr, navMode, memberIndent);
      } else if (wt != null) {
        // literal -> 'X'; variable -> keep expr
        fileNameExpr = wt.valueText.trim();
        navMode = 'dart';
        _applySource(edits, wt, fileNameExpr, navMode, memberIndent);
      } else if (rn != null) {
        final r = _strLit(rn.valueText);
        if (r == null || r.startsWith('/') || !kRegistryKeys.contains(r)) {
          skip('routeName-non-literal/unregistered');
          continue;
        }
        fileNameExpr = "'$r'";
        navMode = 'dart';
        _applySource(edits, rn, fileNameExpr, navMode, memberIndent);
      } else if (rq != null) {
        final rv = rq.valueText;
        final um = RegExp(r"resolveUrl\(\s*'([^']+)'\s*\)").firstMatch(rv);
        final canonical = rv.contains("'method': 'post'") &&
            rv.contains("'operator': 'is'") &&
            rv.contains("'app': 'mobile'");
        if (um == null || !canonical) {
          skip('request-non-canonical-manual');
          continue;
        }
        fileNameExpr = "'${um.group(1)}'";
        navMode = 'apiJson';
        _applySource(edits, rq, fileNameExpr, navMode, memberIndent);
      } else {
        skip('pop/no-source');
        continue;
      }
      totalConv++;
      if (wrapperEdit != null) edits.add(wrapperEdit);
      if (extraDelete != null) edits.add(extraDelete);
    }

    if (edits.isEmpty) continue;
    edits.sort((a, b) => b.start.compareTo(a.start));
    // de-overlap (skip edits that overlap an already-applied later edit)
    int? lastStart;
    for (final e in edits) {
      if (lastStart != null && e.end > lastStart) continue;
      text = text.substring(0, e.start) + e.rep + text.substring(e.end);
      lastStart = e.start;
    }
    filesChanged++;
    print('${apply ? "WROTE" : "DRY"}  ${file.path.replaceAll("\\", "/")}');
    if (apply) file.writeAsStringSync(text);
  }

  print('\n=== DART RAWMAP CODEMOD ${apply ? "APPLIED" : "DRY"} ===');
  print('files changed: $filesChanged   converted: $totalConv');
  (skips.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
      .forEach((e) => print('  ${e.value}x  ${e.key}'));
}

class MemberSpan {
  final int keyStart, valueEnd;
  final String valueText;
  MemberSpan(this.keyStart, this.valueEnd, this.valueText);
}

/// Locates a direct member `'key': value` within (open,close) at brace-depth 1.
MemberSpan? _directMember(String s, int open, int close, String key) {
  final re = RegExp("'" + key + r"'\s*:\s*");
  for (final m in re.allMatches(s, open, )) {
    if (m.start > close) break;
    // depth-1 check: count braces between open and m.start
    if (_depthBetween(s, open, m.start) != 0) continue;
    final vStart = m.end;
    final vEnd = _valueEnd(s, vStart);
    if (vEnd < 0 || vEnd > close) continue;
    return MemberSpan(m.start, vEnd, s.substring(vStart, vEnd).trim());
  }
  return null;
}

int _depthBetween(String s, int from, int to) {
  var depth = 0;
  String? str;
  for (var i = from + 1; i < to; i++) {
    final c = s[i];
    if (str != null) {
      if (c == str && s[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '{' || c == '(' || c == '[') {
      depth++;
    } else if (c == '}' || c == ')' || c == ']') {
      depth--;
    }
  }
  return depth;
}

/// End offset of a value starting at [start] (until top-level , or } ).
int _valueEnd(String s, int start) {
  var depth = 0;
  String? str;
  for (var i = start; i < s.length; i++) {
    final c = s[i];
    if (str != null) {
      if (c == str && s[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '{' || c == '(' || c == '[') {
      depth++;
    } else if (c == '}' || c == ')' || c == ']') {
      if (depth == 0) return i; // closing brace of the map
      depth--;
    } else if (c == ',' && depth == 0) {
      return i;
    }
  }
  return -1;
}

String? _strLit(String v) {
  final m = RegExp(r"^'([^']*)'$").firstMatch(v.trim());
  return m?.group(1);
}

String lineIndent(String s, int pos) {
  var start = pos;
  while (start > 0 && s[start - 1] != '\n') {
    start--;
  }
  final m = RegExp(r'^[ \t]*').firstMatch(s.substring(start, pos));
  return m?.group(0) ?? '';
}

void _applySource(List<Edit> edits, MemberSpan src, String fileNameExpr,
    String navMode, String memberIndent) {
  final rep = "'fileName': $fileNameExpr,\r\n$memberIndent'navMode': '$navMode'";
  edits.add(Edit(src.keyStart, src.valueEnd, rep));
}

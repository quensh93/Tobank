// Throwaway dart codemod (NOT shipped). Converts typed
// `StacNavigateAction(routeName:/widgetType:/assetPath:, navigationStyle:)`
// constructions to `StacRawJsonAction({...})` carrying fileName+navMode, so
// Dart-authored screens use the same nav style as JSON.
//
// Only converts CLEAN forms (single source + optional navigationStyle). Skips
// pop-only, result/arguments, request, variable sources, non-registered routes.
// The Dart compiler (flutter analyze) verifies the result.
//
// Run:  dart run tools/scripts/nav_dart_codemod.dart [--apply]

import 'dart:io';

const Set<String> kFlows = {
  'biometric_test', 'cartable', 'charge', 'child_loan', 'dashboard',
  'deposit_more', 'deposit_turnover', 'gift_card', 'home_page',
  'installment_payment', 'login', 'notification', 'package', 'profile',
  'promissory', 'transaction', 'transfer', 'user_validation', 'verify_identity',
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

/// Splits a constructor arg string on top-level commas.
List<String> splitArgs(String s) {
  final out = <String>[];
  var depth = 0;
  var start = 0;
  String? str;
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (str != null) {
      if (c == str && s[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '(' || c == '[' || c == '{') {
      depth++;
    } else if (c == ')' || c == ']' || c == '}') {
      depth--;
    } else if (c == ',' && depth == 0) {
      out.add(s.substring(start, i).trim());
      start = i + 1;
    }
  }
  final tail = s.substring(start).trim();
  if (tail.isNotEmpty) out.add(tail);
  return out;
}

class Stats {
  int converted = 0, skipped = 0;
}

/// True for a simple variable/identifier expression (e.g. `routeName`,
/// `nextRouteName`) — safe to place verbatim as the fileName value.
bool _isIdentifierExpr(String v) =>
    RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(v.trim());

final skipReasons = <String, int>{};
void skip(String why) => skipReasons[why] = (skipReasons[why] ?? 0) + 1;

void main(List<String> args) {
  final apply = args.contains('--apply');
  final dartFiles = Directory('lib/stac')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  var totalConv = 0, filesChanged = 0;

  for (final file in dartFiles) {
    var text = file.readAsStringSync();
    if (!text.contains('StacNavigateAction(')) continue;

    final edits = <List>[]; // [start, end, replacement]
    final marker = 'StacNavigateAction(';
    var searchFrom = 0;
    while (true) {
      final idx = text.indexOf(marker, searchFrom);
      if (idx < 0) break;
      searchFrom = idx + marker.length;

      // Balanced-paren capture of args.
      var depth = 1;
      var i = idx + marker.length;
      String? str;
      while (i < text.length && depth > 0) {
        final c = text[i];
        if (str != null) {
          if (c == str && text[i - 1] != '\\') str = null;
        } else if (c == "'" || c == '"') {
          str = c;
        } else if (c == '(') {
          depth++;
        } else if (c == ')') {
          depth--;
        }
        i++;
      }
      if (depth != 0) continue;
      final argStr = text.substring(idx + marker.length, i - 1);

      // Constructor start incl. optional `const `.
      var ctorStart = idx;
      final before = text.substring(0, idx);
      final constMatch = RegExp(r'const\s+$').firstMatch(before);
      if (constMatch != null) ctorStart = constMatch.start;

      final parsed = <String, String>{};
      var ok = true;
      for (final a in splitArgs(argStr)) {
        final ci = a.indexOf(':');
        if (ci < 0) {
          ok = false;
          break;
        }
        parsed[a.substring(0, ci).trim()] = a.substring(ci + 1).trim();
      }
      if (!ok) {
        skip('unparsable-args');
        continue;
      }

      // Reject complex args.
      const allowed = {'routeName', 'widgetType', 'assetPath', 'navigationStyle'};
      if (parsed.keys.any((k) => !allowed.contains(k))) {
        skip('has-result/arguments/request');
        continue;
      }

      String? lit(String v) {
        final m = RegExp(r"^'([^']*)'$").firstMatch(v.trim());
        return m?.group(1);
      }

      // fileNameExpr is a Dart expression placed verbatim in the map:
      // a quoted literal ('promissory_intro') or a variable (routeName).
      String? fileNameExpr, navMode;
      if (parsed.containsKey('routeName')) {
        final raw = parsed['routeName']!.trim();
        final r = lit(raw);
        if (r != null) {
          // String literal: must be a registered dart key (else it's a named
          // route -> leave untouched to preserve named-route behavior).
          if (r.startsWith('/') || !kRegistryKeys.contains(r)) {
            skip('routeName-named-route/unregistered');
            continue;
          }
          fileNameExpr = "'$r'";
        } else if (_isIdentifierExpr(raw)) {
          // Variable: parser's routeName(push) path already calls
          // loadWidgetJson(routeName) -> identical to navMode dart.
          fileNameExpr = raw;
        } else {
          skip('routeName-complex-expr');
          continue;
        }
        navMode = 'dart';
      } else if (parsed.containsKey('widgetType')) {
        final raw = parsed['widgetType']!.trim();
        final w = lit(raw);
        fileNameExpr = w != null ? "'$w'" : (_isIdentifierExpr(raw) ? raw : null);
        if (fileNameExpr == null) {
          skip('widgetType-complex-expr');
          continue;
        }
        navMode = 'dart';
      } else if (parsed.containsKey('assetPath')) {
        final p = lit(parsed['assetPath']!);
        final m = p == null
            ? null
            : RegExp(r'lib/stac/tobank/flows/([^/]+)/json/([^/]+)\.json$')
                .firstMatch(p);
        if (m != null && flowOf(m.group(2)!) == m.group(1)) {
          fileNameExpr = "'${m.group(2)}'";
          navMode = 'localJson';
        } else {
          skip('assetPath-non-canonical/non-literal');
          continue;
        }
      } else {
        skip('pop/no-source');
        continue;
      }

      // navigationStyle -> string.
      String? navStyle;
      if (parsed.containsKey('navigationStyle')) {
        final m =
            RegExp(r'NavigationStyle\.(\w+)').firstMatch(parsed['navigationStyle']!);
        if (m == null) {
          skip('navStyle-non-literal');
          continue;
        }
        navStyle = m.group(1);
      }

      final buf = StringBuffer("StacRawJsonAction({'actionType': 'navigate', ");
      buf.write("'fileName': $fileNameExpr, 'navMode': '$navMode'");
      if (navStyle != null) buf.write(", 'navigationStyle': '$navStyle'");
      buf.write('})');

      edits.add([ctorStart, i, buf.toString()]);
    }

    if (edits.isEmpty) continue;
    edits.sort((a, b) => (b[0] as int).compareTo(a[0] as int));
    for (final e in edits) {
      text = text.substring(0, e[0] as int) +
          (e[2] as String) +
          text.substring(e[1] as int);
    }
    totalConv += edits.length;
    filesChanged++;
    print('${apply ? "WROTE" : "DRY"}  ${file.path.replaceAll("\\", "/")}  +${edits.length}');
    if (apply) file.writeAsStringSync(text);
  }

  print('');
  print('=== DART CODEMOD ${apply ? "APPLIED" : "DRY"} ===');
  print('files changed: $filesChanged   converted: $totalConv');
  print('skips:');
  (skipReasons.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
      .forEach((e) => print('  ${e.value}x  ${e.key}'));
}

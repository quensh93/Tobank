// ignore_for_file: avoid_print
// Throwaway codemod (NOT shipped). Swaps raw-map navigate actions in .dart
// files -- StacRawJsonAction({...navMode...}) / StacAction.fromJson({...navMode...})
// -- to the typed NavigationAction(...). Behavior identical: NavigationAction
// .toJson() emits the same map.
//
// Run:  dart run tools/scripts/nav_to_typed_codemod.dart [--apply]

import 'dart:io';

const String kImport =
    "import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';";

final skips = <String, int>{};
void skip(String w) => skips[w] = (skips[w] ?? 0) + 1;

/// Balanced capture: given index of `(` returns index just past matching `)`.
int matchParen(String s, int openParen) {
  var depth = 0;
  String? str;
  for (var i = openParen; i < s.length; i++) {
    final c = s[i];
    if (str != null) {
      if (c == str && s[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '(') {
      depth++;
    } else if (c == ')') {
      depth--;
      if (depth == 0) return i + 1;
    }
  }
  return -1;
}

/// Extract `'key': <value>` from a map body. Value runs until top-level comma
/// or closing brace. Returns trimmed value text or null.
String? memberValue(String mapText, String key) {
  final m = RegExp("'$key'\\s*:\\s*").firstMatch(mapText);
  if (m == null) return null;
  var depth = 0;
  String? str;
  final start = m.end;
  for (var i = start; i < mapText.length; i++) {
    final c = mapText[i];
    if (str != null) {
      if (c == str && mapText[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      str = c;
    } else if (c == '{' || c == '(' || c == '[') {
      depth++;
    } else if (c == '}' || c == ')' || c == ']') {
      if (depth == 0) return mapText.substring(start, i).trim();
      depth--;
    } else if (c == ',' && depth == 0) {
      return mapText.substring(start, i).trim();
    }
  }
  return null;
}

/// All top-level keys in a map body (depth-1 'key': ).
Set<String> topKeys(String mapText) {
  final keys = <String>{};
  var depth = 0;
  String? str;
  for (var i = 0; i < mapText.length; i++) {
    final c = mapText[i];
    if (str != null) {
      if (c == str && mapText[i - 1] != '\\') str = null;
      continue;
    }
    if (c == "'" || c == '"') {
      // potential key at depth 1
      if (depth == 1) {
        final km = RegExp(r"^'([a-zA-Z0-9_]+)'\s*:").firstMatch(mapText.substring(i));
        if (km != null) keys.add(km.group(1)!);
      }
      // skip string
      final q = c;
      i++;
      while (i < mapText.length && !(mapText[i] == q && mapText[i - 1] != '\\')) {
        i++;
      }
    } else if (c == '{' || c == '(' || c == '[') {
      depth++;
    } else if (c == '}' || c == ')' || c == ']') {
      depth--;
    }
  }
  return keys;
}

class Edit {
  final int start, end;
  final String rep;
  Edit(this.start, this.end, this.rep);
}

const allowed = {
  'actionType', 'fileName', 'navMode', 'pathOverride', 'navigationStyle',
};

void main(List<String> args) {
  final apply = args.contains('--apply');
  final files = Directory('lib/stac')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  var totalConv = 0, filesChanged = 0, importsAdded = 0;

  for (final file in files) {
    var text = file.readAsStringSync();
    if (!text.contains("'navMode'")) continue;

    final edits = <Edit>[];
    for (final wrapper in ['StacRawJsonAction(', 'StacAction.fromJson(']) {
      var from = 0;
      while (true) {
        final idx = text.indexOf(wrapper, from);
        if (idx < 0) break;
        from = idx + wrapper.length;
        final openParen = idx + wrapper.length - 1; // the '('
        final endParen = matchParen(text, openParen);
        if (endParen < 0) continue;
        final inner = text.substring(openParen + 1, endParen - 1).trim();
        if (!inner.startsWith('{') || !inner.endsWith('}')) continue;
        final mapText = inner;
        if (!RegExp(r"'actionType'\s*:\s*'navigate'").hasMatch(mapText)) continue;
        if (!mapText.contains("'navMode'")) continue;

        final keys = topKeys(mapText);
        if (keys.any((k) => !allowed.contains(k))) {
          skip('extra-keys(${keys.where((k) => !allowed.contains(k)).join(",")})');
          continue;
        }

        final fileName = memberValue(mapText, 'fileName');
        final navModeLit = memberValue(mapText, 'navMode');
        final pathOverride = memberValue(mapText, 'pathOverride');
        final navStyleLit = memberValue(mapText, 'navigationStyle');
        if (navModeLit == null) {
          skip('no-navMode-value');
          continue;
        }
        final navMode = RegExp(r"^'(\w+)'$").firstMatch(navModeLit)?.group(1);
        if (navMode == null) {
          skip('navMode-non-literal');
          continue;
        }
        final navStyle =
            navStyleLit == null ? null : RegExp(r"^'(\w+)'$").firstMatch(navStyleLit)?.group(1);

        final parts = <String>[];
        if (fileName != null) parts.add('fileName: $fileName');
        parts.add('navMode: NavModes.$navMode');
        if (pathOverride != null) parts.add('pathOverride: $pathOverride');
        if (navStyle != null) parts.add('navigationStyle: NavigationStyle.$navStyle');

        // Drop a leading `const ` before the wrapper if present.
        var repStart = idx;
        final pre = text.substring(0, idx);
        final cm = RegExp(r'const\s+$').firstMatch(pre);
        if (cm != null) repStart = cm.start;

        edits.add(Edit(repStart, endParen, 'NavigationAction(${parts.join(', ')})'));
        totalConv++;
      }
    }

    if (edits.isEmpty) continue;
    edits.sort((a, b) => b.start.compareTo(a.start));
    int? last;
    for (final e in edits) {
      if (last != null && e.end > last) continue;
      text = text.substring(0, e.start) + e.rep + text.substring(e.end);
      last = e.start;
    }

    // Ensure import present.
    if (!text.contains('stac_common_builders')) {
      final lines = text.split('\n');
      final i = lines.indexWhere((l) => l.trimLeft().startsWith('import '));
      if (i >= 0) {
        lines.insert(i + 1, kImport);
        text = lines.join('\n');
        importsAdded++;
      }
    }

    filesChanged++;
    print('${apply ? "WROTE" : "DRY"}  ${file.path.replaceAll("\\", "/")}  +${edits.length}');
    if (apply) file.writeAsStringSync(text);
  }

  print('\n=== NAV->TYPED ${apply ? "APPLIED" : "DRY"} ===');
  print('files changed: $filesChanged   converted: $totalConv   imports added: $importsAdded');
  for (final e in (skips.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))) {
    print('  ${e.value}x  ${e.key}');
  }
}

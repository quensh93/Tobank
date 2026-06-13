// Throwaway surgical codemod (NOT shipped). Rewrites navigate actions in JSON
// screens to the fileName+navMode shape, editing ONLY the source-key byte span
// so CRLF / indentation / Persian text / number formatting are preserved.
//
// Run:  dart run tools/scripts/nav_migration_codemod.dart            (dry run)
//       dart run tools/scripts/nav_migration_codemod.dart --apply    (write)

import 'dart:convert';
import 'dart:io';

// --- Convention constants (mirror FlowRegistry + SduiConfig) ---
const Set<String> kFlows = {
  'biometric_test', 'cartable', 'charge', 'child_loan', 'dashboard',
  'deposit_more', 'deposit_turnover', 'gift_card', 'home_page',
  'installment_payment', 'login', 'notification', 'package', 'profile',
  'promissory', 'transaction', 'transfer', 'user_validation', 'verify_identity',
};
const String kConfigBaseUrl = 'http://192.168.179.21:8101';
const String kPathKeyPrefix = 'ipaam.builder.form.form';
const int kBuild = 1;

String? flowOf(String fileName) {
  String? best;
  for (final f in kFlows) {
    if (fileName == f || fileName.startsWith('${f}_')) {
      if (best == null || f.length > best.length) best = f;
    }
  }
  return best;
}

String resolveUrl(String name) =>
    '$kConfigBaseUrl/api/configurations/v1.0/configs/resolve/$kPathKeyPrefix.$name/$kBuild';

final Set<String> kRegistryKeys = (() {
  final src =
      File('lib/stac_core/registry/stac_widget_loader.dart').readAsStringSync();
  return RegExp(r"'([a-z0-9_]+)':\s*\(\)\s*=>")
      .allMatches(src)
      .map((m) => m.group(1)!)
      .toSet();
})();

// ---------------------------------------------------------------------------
// Minimal span-tracking JSON parser. Records, per object, its direct members
// with byte offsets so we can edit exact spans in the original text.
// ---------------------------------------------------------------------------
class Member {
  final String key;
  final int keyStart; // offset of opening quote of key
  final int valueEnd; // offset just past end of value
  final dynamic value;
  Member(this.key, this.keyStart, this.valueEnd, this.value);
}

class ObjNode {
  final List<Member> members;
  ObjNode(this.members);
  Member? get(String k) {
    for (final m in members) {
      if (m.key == k) return m;
    }
    return null;
  }
}

class _Parser {
  final String s;
  int i = 0;
  final List<ObjNode> objects = [];
  _Parser(this.s);

  void ws() {
    while (i < s.length) {
      final c = s.codeUnitAt(i);
      if (c == 0x20 || c == 0x09 || c == 0x0a || c == 0x0d) {
        i++;
      } else {
        break;
      }
    }
  }

  dynamic parseValue() {
    ws();
    final c = s[i];
    if (c == '{') return parseObject();
    if (c == '[') return parseArray();
    if (c == '"') return parseString();
    return parseLiteral();
  }

  ObjNode parseObject() {
    final members = <Member>[];
    i++; // {
    ws();
    if (s[i] == '}') {
      i++;
      final node = ObjNode(members);
      objects.add(node);
      return node;
    }
    while (true) {
      ws();
      final keyStart = i;
      final key = parseString();
      ws();
      i++; // :
      final value = parseValue();
      final valueEnd = i;
      members.add(Member(key, keyStart, valueEnd, value));
      ws();
      if (s[i] == ',') {
        i++;
        continue;
      }
      if (s[i] == '}') {
        i++;
        break;
      }
      throw FormatException('expected , or } at $i');
    }
    final node = ObjNode(members);
    objects.add(node);
    return node;
  }

  List parseArray() {
    final list = [];
    i++; // [
    ws();
    if (s[i] == ']') {
      i++;
      return list;
    }
    while (true) {
      list.add(parseValue());
      ws();
      if (s[i] == ',') {
        i++;
        continue;
      }
      if (s[i] == ']') {
        i++;
        break;
      }
      throw FormatException('expected , or ] at $i');
    }
    return list;
  }

  String parseString() {
    // assumes s[i] == '"'
    final sb = StringBuffer();
    i++; // opening quote
    while (true) {
      final c = s[i];
      if (c == '\\') {
        final n = s[i + 1];
        switch (n) {
          case 'n':
            sb.write('\n');
          case 't':
            sb.write('\t');
          case 'r':
            sb.write('\r');
          case 'b':
            sb.write('\b');
          case 'f':
            sb.write('\f');
          case '/':
            sb.write('/');
          case '"':
            sb.write('"');
          case '\\':
            sb.write('\\');
          case 'u':
            final hex = s.substring(i + 2, i + 6);
            sb.writeCharCode(int.parse(hex, radix: 16));
            i += 4;
        }
        i += 2;
        continue;
      }
      if (c == '"') {
        i++;
        break;
      }
      sb.write(c);
      i++;
    }
    return sb.toString();
  }

  dynamic parseLiteral() {
    final start = i;
    while (i < s.length) {
      final c = s[i];
      if (c == ',' || c == '}' || c == ']' || c == ' ' || c == '\n' ||
          c == '\r' || c == '\t') {
        break;
      }
      i++;
    }
    final tok = s.substring(start, i);
    if (tok == 'true') return true;
    if (tok == 'false') return false;
    if (tok == 'null') return null;
    return num.tryParse(tok) ?? tok;
  }
}

// ---------------------------------------------------------------------------
class Edit {
  final int start;
  final int end;
  final String replacement;
  Edit(this.start, this.end, this.replacement);
}

const sourceKeys = ['assetPath', 'widgetType', 'request', 'routeName'];

/// True when a `request` object exactly matches the config-resolve contract
/// that FlowSourceResolver.apiJson rebuilds: POST + fixed headers + fixed body.
bool _isCanonical(ObjNode r) {
  if (r.get('method')?.value != 'post') return false;
  final h = r.get('headers')?.value;
  if (h is! ObjNode) return false;
  if (h.get('Content-Type')?.value != 'application/json') return false;
  if (h.get('Accept')?.value != '*/*') return false;
  final b = r.get('body')?.value;
  if (b is! ObjNode) return false;
  if (b.get('operator')?.value != 'is') return false;
  final dim = b.get('dimension')?.value;
  if (dim is! ObjNode) return false;
  if (dim.get('app')?.value != 'mobile') return false;
  // Reject extra body keys beyond operator/dimension to stay strict.
  if (b.members.length != 2) return false;
  if (dim.members.length != 1) return false;
  return true;
}

class FileResult {
  int converted = 0;
  int skippedMultiSource = 0;
  int skippedUnregistered = 0;
  int skippedNonClassifiable = 0;
}

String indentBefore(String text, int offset) {
  var j = offset - 1;
  final chars = <String>[];
  while (j >= 0) {
    final c = text[j];
    if (c == ' ' || c == '\t') {
      chars.add(c);
      j--;
    } else {
      break;
    }
  }
  return chars.reversed.join();
}

/// Returns the new member-list text for a converted navigate source, or null
/// if not classifiable (behavior cannot be proven identical -> skip).
List<String>? classify(ObjNode obj) {
  final asset = obj.get('assetPath');
  final widget = obj.get('widgetType');
  final req = obj.get('request');
  final route = obj.get('routeName');

  // assetPath wins (matches current getModel precedence).
  if (asset != null && asset.value is String &&
      (asset.value as String).isNotEmpty &&
      !(asset.value as String).contains('{{')) {
    final p = asset.value as String;
    final m = RegExp(r'lib/stac/tobank/flows/([^/]+)/json/([^/]+)\.json$')
        .firstMatch(p);
    if (m != null) {
      final f = m.group(2)!;
      final flow = flowOf(f);
      if (flow != null && 'lib/stac/tobank/flows/$flow/json/$f.json' == p &&
          flow == m.group(1)) {
        return ['"fileName": "$f"', '"navMode": "localJson"'];
      }
    }
    // non-canonical -> keep verbatim via pathOverride
    return [
      '"navMode": "localJson"',
      '"pathOverride": ${jsonEncode(p)}',
    ];
  }

  if (widget != null && widget.value is String &&
      (widget.value as String).isNotEmpty) {
    return ['"fileName": "${widget.value}"', '"navMode": "dart"'];
  }

  if (req != null && req.value is ObjNode) {
    final r = req.value as ObjNode;
    final url = r.get('url')?.value?.toString();
    if (url != null && url.isNotEmpty) {
      final m = RegExp(
        r'/configs/resolve/' + RegExp.escape(kPathKeyPrefix) + r'\.([^/]+)/',
      ).firstMatch(url);
      // Only convert when the WHOLE request equals the canonical config-resolve
      // contract (the resolver rebuilds exactly this). Anything else (GET,
      // different body/headers, mock url) is left as a legacy request block.
      if (m != null && resolveUrl(m.group(1)!) == url && _isCanonical(r)) {
        return ['"fileName": "${m.group(1)}"', '"navMode": "apiJson"'];
      }
    }
    return null; // leave legacy request untouched
  }

  if (route != null && route.value is String &&
      (route.value as String).isNotEmpty &&
      !(route.value as String).startsWith('/')) {
    final r = route.value as String;
    if (kRegistryKeys.contains(r)) {
      return ['"fileName": "$r"', '"navMode": "dart"'];
    }
    return null; // named route, not a dart key -> leave
  }
  return null;
}

void main(List<String> args) {
  final apply = args.contains('--apply');
  final root = Directory('lib/stac/tobank');
  final files = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList();

  var totalConverted = 0, totalMulti = 0, totalSkip = 0, filesChanged = 0;

  for (final file in files) {
    final text = file.readAsStringSync();
    if (!text.contains('"navigate"')) continue;
    final List<ObjNode> objects;
    try {
      final p = _Parser(text);
      p.parseValue();
      objects = p.objects;
    } catch (e) {
      stderr.writeln('parse-fail ${file.path}: $e');
      continue;
    }

    final edits = <Edit>[];
    final res = FileResult();

    for (final obj in objects) {
      final at = obj.get('actionType');
      if (at == null || at.value != 'navigate') continue;

      final present = sourceKeys.where((k) {
        final m = obj.get(k);
        if (m == null || m.value == null) return false;
        if (m.value is String && (m.value as String).isEmpty) return false;
        return true;
      }).toList();
      if (present.isEmpty) continue; // pop / no source
      if (present.length > 1) {
        res.skippedMultiSource++;
        totalMulti++;
        stderr.writeln(
            'MULTI-SOURCE ${file.path.replaceAll('\\', '/')} keys=$present');
        continue;
      }
      final newMembers = classify(obj);
      if (newMembers == null) {
        res.skippedNonClassifiable++;
        totalSkip++;
        continue;
      }
      final src = obj.get(present.first)!;
      final indent = indentBefore(text, src.keyStart);
      final replacement = newMembers.join(',\r\n$indent');
      edits.add(Edit(src.keyStart, src.valueEnd, replacement));
      res.converted++;
    }

    if (edits.isEmpty) continue;
    filesChanged++;
    totalConverted += res.converted;

    // Apply right-to-left.
    edits.sort((a, b) => b.start.compareTo(a.start));
    var out = text;
    for (final e in edits) {
      out = out.substring(0, e.start) + e.replacement + out.substring(e.end);
    }

    // Self-check: result must still parse, and re-parsing must produce a
    // navigate object resolving to the SAME address as before.
    try {
      jsonDecode(out);
    } catch (e) {
      stderr.writeln('SELF-CHECK FAIL (json invalid) ${file.path}: $e');
      continue;
    }

    final rel = file.path.replaceAll('\\', '/');
    print('${apply ? "WROTE" : "DRY"}  $rel  '
        'converted=${res.converted}'
        '${res.skippedMultiSource > 0 ? " multiSrc=${res.skippedMultiSource}" : ""}'
        '${res.skippedNonClassifiable > 0 ? " skip=${res.skippedNonClassifiable}" : ""}');

    if (apply) file.writeAsStringSync(out);
  }

  print('');
  print('=== CODEMOD ${apply ? "APPLIED" : "DRY RUN"} ===');
  print('files changed: $filesChanged');
  print('actions converted: $totalConverted');
  print('skipped multi-source: $totalMulti');
  print('skipped non-classifiable: $totalSkip');
}

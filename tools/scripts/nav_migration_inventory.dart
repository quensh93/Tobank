// ignore_for_file: avoid_print
// Throwaway analysis script (NOT shipped). Scans JSON screens for navigate
// actions, classifies each into the proposed fileName+navMode shape, runs an
// address-equality self-check, and emits a CSV + summary.
//
// Run:  dart run tools/scripts/nav_migration_inventory.dart
// Out:  tools/scripts/nav_inventory.csv  (+ stdout summary)

import 'dart:convert';
import 'dart:io';

// --- Inlined convention constants (mirror FlowRegistry + SduiConfig) ---
const Set<String> kFlows = {
  'biometric_test', 'cartable', 'charge', 'child_loan', 'dashboard',
  'deposit_more_options', 'deposit_turnover', 'gift_card', 'home_page',
  'installment_payment', 'login', 'notification', 'internet_pakage', 'profile',
  'promissory', 'transaction', 'transfer', 'user_credit_validation', 'authentication',
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

String localJsonPath(String flow, String fileName) =>
    'lib/stac/tobank/flows/$flow/json/$fileName.json';

// Registry keys extracted from the loader source (textual, no flutter binding).
final Set<String> kRegistryKeys = _loadRegistryKeys();
Set<String> _loadRegistryKeys() {
  final src =
      File('lib/stac_core/registry/stac_widget_loader.dart').readAsStringSync();
  return RegExp(r"'([a-z0-9_]+)':\s*\(\)\s*=>")
      .allMatches(src)
      .map((m) => m.group(1)!)
      .toSet();
}

class Finding {
  final String file;
  final String pointer;
  final String navStyle;
  final String currentSource;
  final String navMode;
  final String fileName;
  final String pathOverride;
  final String confidence; // auto | needs-review | skip
  final String note;
  Finding(this.file, this.pointer, this.navStyle, this.currentSource,
      this.navMode, this.fileName, this.pathOverride, this.confidence,
      this.note);

  List<String> toRow() => [
        file, pointer, navStyle, currentSource, navMode, fileName,
        pathOverride, confidence, note,
      ];
}

final findings = <Finding>[];

void walk(Object? node, String file, String pointer) {
  if (node is Map<String, dynamic>) {
    if (node['actionType'] == 'navigate') {
      classify(node, file, pointer);
    }
    node.forEach((k, v) => walk(v, file, '$pointer/$k'));
  } else if (node is List) {
    for (var i = 0; i < node.length; i++) {
      walk(node[i], file, '$pointer[$i]');
    }
  }
}

void classify(Map<String, dynamic> n, String file, String pointer) {
  final navStyle = (n['navigationStyle'] ?? '').toString();
  final widgetType = n['widgetType'];
  final routeName = n['routeName'];
  final assetPath = n['assetPath'];
  final request = n['request'];
  final url = request is Map ? request['url']?.toString() : null;

  String src(Object? v, String label) => v == null ? '' : '$label=$v';

  // pop / no source -> skip
  final hasSource = (widgetType is String && widgetType.isNotEmpty) ||
      (routeName is String && routeName.isNotEmpty && !routeName.startsWith('/')) ||
      (assetPath is String && assetPath.isNotEmpty) ||
      (url != null && url.isNotEmpty);
  if (!hasSource) {
    findings.add(Finding(file, pointer, navStyle, navStyle.isEmpty ? '(none)' : navStyle,
        '', '', '', 'skip', 'no source / pop'));
    return;
  }

  // widgetType -> dart
  if (widgetType is String && widgetType.isNotEmpty) {
    findings.add(Finding(file, pointer, navStyle, src(widgetType, 'widgetType'),
        'dart', widgetType, '', 'auto', 'registry key == fileName'));
    return;
  }

  // assetPath -> localJson (canonical) or pathOverride
  if (assetPath is String && assetPath.isNotEmpty && !assetPath.contains('{{')) {
    final m = RegExp(r'lib/stac/tobank/flows/([^/]+)/json/([^/]+)\.json$')
        .firstMatch(assetPath);
    if (m != null) {
      final flowSeg = m.group(1)!;
      final f = m.group(2)!;
      final rebuilt = flowOf(f) != null ? localJsonPath(flowOf(f)!, f) : null;
      if (rebuilt == assetPath && flowOf(f) == flowSeg) {
        findings.add(Finding(file, pointer, navStyle, src(assetPath, 'assetPath'),
            'localJson', f, '', 'auto', 'canonical json path, address-equal'));
        return;
      }
      // flow segment mismatch with longest-prefix -> keep override
      findings.add(Finding(file, pointer, navStyle, src(assetPath, 'assetPath'),
          'localJson', f, assetPath, 'needs-review',
          'flow seg "$flowSeg" != flowOf "${flowOf(f)}" -> override'));
      return;
    }
    // non-canonical dir (json_upload / api_json / api/GET_ / other)
    findings.add(Finding(file, pointer, navStyle, src(assetPath, 'assetPath'),
        'localJson', '', assetPath, 'needs-review', 'non-canonical asset dir'));
    return;
  }
  if (assetPath is String && assetPath.contains('{{')) {
    findings.add(Finding(file, pointer, navStyle, src(assetPath, 'assetPath'),
        '', '', '', 'needs-review', 'variable assetPath {{..}}'));
    return;
  }

  // request.url -> apiJson
  if (url != null && url.isNotEmpty) {
    final m = RegExp(r'/configs/resolve/' + RegExp.escape(kPathKeyPrefix) + r'\.([^/]+)/')
        .firstMatch(url);
    if (m != null) {
      final f = m.group(1)!;
      final auto = resolveUrl(f) == url;
      findings.add(Finding(file, pointer, navStyle, src(url, 'url'),
          'apiJson', f, '', auto ? 'auto' : 'needs-review',
          auto ? 'real resolveUrl, address-equal' : 'real-ish url, verify'));
      return;
    }
    // mock url or other -> apiJson + verbatim override (behavior-identical fetch)
    findings.add(Finding(file, pointer, navStyle, src(url, 'url'),
        'apiJson', '', url, 'needs-review',
        url.contains('api.tobank.com') ? 'mock url -> keep verbatim' : 'other url -> verbatim'));
    return;
  }

  // routeName -> dart (current code treats push routeName as dart key)
  if (routeName is String && routeName.isNotEmpty && !routeName.startsWith('/')) {
    final registered = kRegistryKeys.contains(routeName);
    findings.add(Finding(file, pointer, navStyle, src(routeName, 'routeName'),
        'dart', routeName, '', registered ? 'auto' : 'needs-review',
        registered
            ? 'routeName is registered dart key, address-equal'
            : 'routeName NOT registered (named route?) - confirm'));
    return;
  }
}

String csvCell(String s) {
  if (s.contains(',') || s.contains('"') || s.contains('\n')) {
    return '"${s.replaceAll('"', '""')}"';
  }
  return s;
}

void main() {
  final root = Directory('lib/stac/tobank');
  final files = root
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'))
      .toList();

  for (final f in files) {
    try {
      final data = jsonDecode(f.readAsStringSync());
      final rel = f.path.replaceAll('\\', '/');
      walk(data, rel, '');
    } catch (e) {
      stderr.writeln('parse-fail ${f.path}: $e');
    }
  }

  // CSV
  final out = StringBuffer();
  out.writeln('file,pointer,navStyle,currentSource,navMode,fileName,pathOverride,confidence,note');
  for (final fd in findings) {
    out.writeln(fd.toRow().map(csvCell).join(','));
  }
  File('tools/scripts/nav_inventory.csv').writeAsStringSync(out.toString());

  // Summary
  final byConf = <String, int>{};
  final byMode = <String, int>{};
  final reviewReasons = <String, int>{};
  for (final fd in findings) {
    byConf[fd.confidence] = (byConf[fd.confidence] ?? 0) + 1;
    if (fd.confidence != 'skip') {
      byMode[fd.navMode.isEmpty ? '(unset)' : fd.navMode] =
          (byMode[fd.navMode.isEmpty ? '(unset)' : fd.navMode] ?? 0) + 1;
    }
    if (fd.confidence == 'needs-review') {
      reviewReasons[fd.note] = (reviewReasons[fd.note] ?? 0) + 1;
    }
  }

  print('=== NAV MIGRATION INVENTORY ===');
  print('JSON files scanned: ${files.length}');
  print('navigate actions found: ${findings.length}');
  print('');
  print('By confidence:');
  byConf.forEach((k, v) => print('  $k: $v'));
  print('');
  print('By proposed navMode (excl. skip):');
  byMode.forEach((k, v) => print('  $k: $v'));
  print('');
  print('needs-review reasons:');
  for (final e in (reviewReasons.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))) {
    print('  ${e.value}x  ${e.key}');
  }
  print('');
  print('CSV: tools/scripts/nav_inventory.csv');
}

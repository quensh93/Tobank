// ignore_for_file: use_null_aware_elements
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/custom_navigate_action_parser.dart';

/// Pilot proof (promissory): the same `fileName` flipped across navMode values
/// produces the correct existing channel on the model — proving behavior is
/// re-expressed, not changed.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const parser = CustomNavigateActionParser();

  StacNavigateActionView modelFor(String navMode, {String? pathOverride}) {
    final action = parser.getModel({
      'actionType': 'navigate',
      'fileName': 'promissory_intro',
      'navMode': navMode,
      if (pathOverride != null) 'pathOverride': pathOverride,
      'navigationStyle': 'push',
    });
    return StacNavigateActionView(action);
  }

  test('localJson -> assetPath channel (canonical path)', () {
    final m = modelFor('localJson');
    expect(
      m.assetPath,
      'lib/stac/tobank/flows/promissory/json/promissory_intro.json',
    );
    expect(m.request, isNull);
  });

  test('apiJson -> request channel (real resolveUrl)', () {
    final m = modelFor('apiJson');
    expect(m.assetPath, anyOf(isNull, isEmpty));
    expect(m.requestUrl, SduiConfig.resolveUrl('promissory_intro'));
  });

  test('dart -> widgetJson channel with original type', () {
    final m = modelFor('dart');
    expect(m.widgetJson, isNotNull);
    expect(m.widgetJson!['_originalWidgetType'], 'promissory_intro');
  });

  test('pathOverride (localJson) is honored verbatim', () {
    final m = modelFor(
      'localJson',
      pathOverride: 'lib/stac/tobank/flows/promissory/json_upload/x.json',
    );
    expect(m.assetPath, 'lib/stac/tobank/flows/promissory/json_upload/x.json');
  });

  // Post-migration: every nav uses fileName+navMode. Raw `widgetType` is no
  // longer a supported source (0 usages remain), so the parser does NOT
  // auto-resolve it — it passes through untouched.
  test('legacy widgetType-only is no longer auto-resolved', () {
    final action = parser.getModel({
      'actionType': 'navigate',
      'widgetType': 'promissory_intro',
      'navigationStyle': 'push',
    });
    final m = StacNavigateActionView(action);
    expect(m.widgetJson, isNull);
  });

  // A legacy assetPath-only action still passes through (onCall assetPath
  // branch handles it) — real back-compat retained.
  test('legacy assetPath-only passes through', () {
    final action = parser.getModel({
      'actionType': 'navigate',
      'assetPath': 'lib/stac/tobank/flows/profile/json/profile_intro.json',
      'navigationStyle': 'push',
    });
    expect(StacNavigateActionView(action).assetPath,
        'lib/stac/tobank/flows/profile/json/profile_intro.json');
  });
}

/// Thin reflective view over the package model's fields used by the parser's
/// onCall, so the test does not depend on the package's public getter names.
class StacNavigateActionView {
  final dynamic _a;
  StacNavigateActionView(this._a);

  String? get assetPath => _a.assetPath as String?;
  Map<String, dynamic>? get widgetJson =>
      _a.widgetJson as Map<String, dynamic>?;
  Object? get request => _a.request;
  String? get requestUrl => _a.request?.url as String?;
}

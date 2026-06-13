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

  test('legacy action (no fileName/navMode) still resolves widgetType', () {
    final action = parser.getModel({
      'actionType': 'navigate',
      'widgetType': 'promissory_intro',
      'navigationStyle': 'push',
    });
    final m = StacNavigateActionView(action);
    expect(m.widgetJson, isNotNull);
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

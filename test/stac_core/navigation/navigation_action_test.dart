import 'package:flutter_test/flutter_test.dart';
import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

/// NavigationAction is the typed Dart authoring class. Its toJson() must emit
/// exactly the raw map the navigate parser reads.
void main() {
  test('dart mode toJson', () {
    expect(
      const NavigationAction(
        fileName: 'profile_customer_referrals',
        navMode: NavModes.dart,
      ).toJson(),
      {
        'actionType': 'navigate',
        'fileName': 'profile_customer_referrals',
        'navMode': 'dart',
        'navigationStyle': 'push',
      },
    );
  });

  test('apiJson + pushReplacement toJson', () {
    expect(
      const NavigationAction(
        fileName: 'promissory_intro',
        navMode: NavModes.apiJson,
        navigationStyle: NavigationStyle.pushReplacement,
      ).toJson(),
      {
        'actionType': 'navigate',
        'fileName': 'promissory_intro',
        'navMode': 'apiJson',
        'navigationStyle': 'pushReplacement',
      },
    );
  });

  test('override-only (no fileName) toJson omits fileName', () {
    final json = const NavigationAction(
      navMode: NavModes.localJson,
      pathOverride: 'lib/stac/tobank/flows/x/json/y.json',
    ).toJson();
    expect(json.containsKey('fileName'), false);
    expect(json['navMode'], 'localJson');
    expect(json['pathOverride'], 'lib/stac/tobank/flows/x/json/y.json');
  });

  test('actionType is navigate', () {
    expect(const NavigationAction(navMode: NavModes.dart).actionType,
        'navigate');
  });
}

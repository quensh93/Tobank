import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';
import 'package:tobank_sdui/stac_core/navigation/flow_registry.dart';
import 'package:tobank_sdui/stac_core/navigation/flow_source_resolver.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

void main() {
  group('NavModes.fromJson', () {
    test('parses known names', () {
      expect(NavModes.fromJson('dart'), NavModes.dart);
      expect(NavModes.fromJson('localJson'), NavModes.localJson);
      expect(NavModes.fromJson('apiJson'), NavModes.apiJson);
    });

    test('null/unknown -> null', () {
      expect(NavModes.fromJson(null), isNull);
      expect(NavModes.fromJson('bogus'), isNull);
    });
  });

  group('FlowRegistry.flowOf longest-prefix', () {
    test('multi-word flow is not shadowed by short prefix', () {
      expect(FlowRegistry.flowOf('deposit_more_options_intro'), 'deposit_more_options');
      expect(FlowRegistry.flowOf('deposit_turnover_intro'), 'deposit_turnover');
      expect(FlowRegistry.flowOf('child_loan_rules'), 'child_loan');
      expect(
        FlowRegistry.flowOf('installment_payment_list_main'),
        'installment_payment',
      );
      expect(FlowRegistry.flowOf('user_credit_validation_receipt'), 'user_credit_validation');
      expect(FlowRegistry.flowOf('gift_card_intro'), 'gift_card');
    });

    test('single-word flow', () {
      expect(FlowRegistry.flowOf('profile_customer_referrals'), 'profile');
      expect(FlowRegistry.flowOf('transfer_amount'), 'transfer');
      expect(FlowRegistry.flowOf('promissory_intro'), 'promissory');
    });

    test('exact flow name', () {
      expect(FlowRegistry.flowOf('promissory'), 'promissory');
    });

    test('no match -> null', () {
      expect(FlowRegistry.flowOf('totally_unknown_screen'), isNull);
      expect(FlowRegistry.flowOf('depositish'), isNull);
    });
  });

  group('FlowSourceResolver.localJson', () {
    test('convention builds canonical json path', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'promissory_intro',
        navMode: NavModes.localJson,
      );
      expect(r, isA<NavAsset>());
      expect(
        (r as NavAsset).assetPath,
        'lib/stac/tobank/flows/promissory/json/promissory_intro.json',
      );
    });

    test('multi-word flow path', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'deposit_more_options_intro',
        navMode: NavModes.localJson,
      );
      expect(
        (r as NavAsset).assetPath,
        'lib/stac/tobank/flows/deposit_more_options/json/deposit_more_options_intro.json',
      );
    });

    test('pathOverride used verbatim', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'promissory_intro',
        navMode: NavModes.localJson,
        pathOverride: 'lib/stac/tobank/flows/promissory/json_upload/x.json',
      );
      expect(
        (r as NavAsset).assetPath,
        'lib/stac/tobank/flows/promissory/json_upload/x.json',
      );
    });

    test('unknown flow -> NavError', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'totally_unknown',
        navMode: NavModes.localJson,
      );
      expect(r, isA<NavError>());
    });
  });

  group('FlowSourceResolver.apiJson', () {
    test('convention builds canonical POST request to resolveUrl', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'promissory_intro',
        navMode: NavModes.apiJson,
      );
      expect(r, isA<NavNetwork>());
      final net = r as NavNetwork;
      expect(net.url, SduiConfig.resolveUrl('promissory_intro'));
      expect(
        net.url,
        contains('/configs/resolve/ipaam.builder.form.form.promissory_intro/'),
      );
      expect(net.request['method'], 'post');
      expect(net.request['headers'], {
        'Content-Type': 'application/json',
        'Accept': '*/*',
      });
      expect(net.request['body'], {
        'operator': 'is',
        'dimension': {'app': 'mobile'},
      });
    });

    test('pathOverride url used verbatim (still canonical POST)', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'promissory_intro',
        navMode: NavModes.apiJson,
        pathOverride: 'https://www.tobank.ir/custom',
      );
      final net = r as NavNetwork;
      expect(net.url, 'https://www.tobank.ir/custom');
      expect(net.request['method'], 'post');
    });
  });

  group('override-only (no fileName)', () {
    test('localJson override without fileName -> NavAsset(verbatim)', () {
      final r = FlowSourceResolver.resolve(
        navMode: NavModes.localJson,
        pathOverride: 'lib/stac/tobank/flows/x/json/y.json',
      );
      expect((r as NavAsset).assetPath, 'lib/stac/tobank/flows/x/json/y.json');
    });

    test('apiJson override without fileName -> NavNetwork(verbatim url)', () {
      final r = FlowSourceResolver.resolve(
        navMode: NavModes.apiJson,
        pathOverride: 'https://api.tobank.com/flows/a/b',
      );
      expect((r as NavNetwork).url, 'https://api.tobank.com/flows/a/b');
    });

    test('localJson without fileName or override -> NavError', () {
      expect(FlowSourceResolver.resolve(navMode: NavModes.localJson),
          isA<NavError>());
    });
  });

  group('FlowSourceResolver.dart', () {
    test('unknown key -> NavError naming the key', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'definitely_not_a_registered_key',
        navMode: NavModes.dart,
      );
      expect(r, isA<NavError>());
      expect(
        (r as NavError).message,
        contains('definitely_not_a_registered_key'),
      );
    });

    test('pathOverride is used as the registry key', () {
      final r = FlowSourceResolver.resolve(
        fileName: 'ignored',
        navMode: NavModes.dart,
        pathOverride: 'also_not_registered_key',
      );
      expect(r, isA<NavError>());
      expect((r as NavError).message, contains('also_not_registered_key'));
    });
  });
}

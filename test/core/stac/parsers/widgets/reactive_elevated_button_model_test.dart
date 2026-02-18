import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/stac/parsers/widgets/reactive_elevated_button_parser.dart';

void main() {
  group('ReactiveElevatedButtonModel.fromJson', () {
    test('decodes rawOnPressed and restores template tokens', () {
      final action = <String, dynamic>{
        'actionType': 'networkRequest',
        'data': <String, dynamic>{
          'sourceAccount': '{{selectedDeposit.depositNumber}}',
        },
      };

      final rawOnPressed = jsonEncode(action).replaceAll('{{', '__STAC_OPEN__');

      final model = ReactiveElevatedButtonModel.fromJson(<String, dynamic>{
        'rawOnPressed': rawOnPressed,
      });

      expect(model.onPressed, equals(action));
    });

    test('falls back to onPressed when rawOnPressed is missing', () {
      final onPressed = <String, dynamic>{
        'actionType': 'navigate',
        'widgetType': 'promissory_real_sign',
      };

      final model = ReactiveElevatedButtonModel.fromJson(<String, dynamic>{
        'onPressed': onPressed,
      });

      expect(model.onPressed, equals(onPressed));
    });

    test('prefers decoded rawOnPressed over legacy onPressed', () {
      final rawAction = <String, dynamic>{
        'actionType': 'setValue',
        'key': 'draft.sourceAccount',
        'value': '{{selectedDeposit.depositNumber}}',
      };

      final rawOnPressed = jsonEncode(
        rawAction,
      ).replaceAll('{{', '__STAC_OPEN__');

      final model = ReactiveElevatedButtonModel.fromJson(<String, dynamic>{
        'onPressed': <String, dynamic>{
          'actionType': 'setValue',
          'key': 'draft.sourceAccount',
          'value': 'stale-value',
        },
        'rawOnPressed': rawOnPressed,
      });

      expect(model.onPressed, equals(rawAction));
    });

    test('keeps legacy onPressed if rawOnPressed decode fails', () {
      final onPressed = <String, dynamic>{
        'actionType': 'navigate',
        'widgetType': 'fallback_target',
      };

      final model = ReactiveElevatedButtonModel.fromJson(<String, dynamic>{
        'onPressed': onPressed,
        'rawOnPressed': '{broken-json',
      });

      expect(model.onPressed, equals(onPressed));
    });
  });
}

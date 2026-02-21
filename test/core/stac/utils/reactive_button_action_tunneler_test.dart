import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/stac/utils/reactive_button_action_tunneler.dart';

void main() {
  group('tunnelReactiveButtonActions', () {
    test('converts reactiveElevatedButton onPressed to rawOnPressed', () {
      final input = <String, dynamic>{
        'type': 'reactiveElevatedButton',
        'enabledKey': 'hasSelection',
        'onPressed': <String, dynamic>{
          'actionType': 'networkRequest',
          'data': <String, dynamic>{
            'sourceAccount': '{{selectedDeposit.depositNumber}}',
          },
        },
      };

      final output = tunnelReactiveButtonActions(input) as Map<String, dynamic>;

      expect(output.containsKey('onPressed'), isFalse);
      expect(output['rawOnPressed'], isA<String>());

      final raw = output['rawOnPressed'] as String;
      final decoded =
          jsonDecode(raw.replaceAll('__STAC_OPEN__', '{{'))
              as Map<String, dynamic>;
      expect(decoded['actionType'], equals('networkRequest'));
      expect(
        (decoded['data'] as Map<String, dynamic>)['sourceAccount'],
        equals('{{selectedDeposit.depositNumber}}'),
      );
    });

    test('leaves non-reactive widgets unchanged', () {
      final input = <String, dynamic>{
        'type': 'text',
        'data': '{{appStrings.common.continue}}',
      };

      final output = tunnelReactiveButtonActions(input) as Map<String, dynamic>;

      expect(output, equals(input));
    });

    test('handles nested maps and lists', () {
      final input = <String, dynamic>{
        'type': 'stateFull',
        'child': <String, dynamic>{
          'type': 'column',
          'children': <dynamic>[
            <String, dynamic>{
              'type': 'reactiveElevatedButton',
              'onPressed': <String, dynamic>{
                'actionType': 'navigate',
                'widgetType': 'next',
              },
            },
            <String, dynamic>{
              'type': 'container',
              'child': <String, dynamic>{
                'type': 'reactiveElevatedButton',
                'onPressed': <String, dynamic>{
                  'actionType': 'setValue',
                  'key': 'x',
                  'value': '{{selectedDeposit.depositNumber}}',
                },
              },
            },
          ],
        },
      };

      final output = tunnelReactiveButtonActions(input) as Map<String, dynamic>;
      final children =
          ((output['child'] as Map<String, dynamic>)['children'] as List)
              .cast<Map<String, dynamic>>();

      expect(children[0].containsKey('rawOnPressed'), isTrue);
      expect(children[0].containsKey('onPressed'), isFalse);

      final nestedButton = ((children[1]['child'] as Map<String, dynamic>));
      expect(nestedButton.containsKey('rawOnPressed'), isTrue);
      expect(nestedButton.containsKey('onPressed'), isFalse);
    });

    test('is idempotent when called multiple times', () {
      final input = <String, dynamic>{
        'type': 'reactiveElevatedButton',
        'onPressed': <String, dynamic>{
          'actionType': 'navigate',
          'widgetType': 'next',
        },
      };

      final first = tunnelReactiveButtonActions(input) as Map<String, dynamic>;
      final second = tunnelReactiveButtonActions(first) as Map<String, dynamic>;

      expect(second, equals(first));
      expect(second.containsKey('onPressed'), isFalse);
      expect(second['rawOnPressed'], isA<String>());
    });
  });
}

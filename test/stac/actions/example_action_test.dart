import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../stac/actions/example_action/example_action_model.dart';
import '../../../stac/actions/example_action/example_action_parser.dart';

void main() {
  group('ExampleActionModel', () {
    group('JSON Serialization', () {
      test('should serialize to JSON correctly with all properties', () {
        // Arrange
        final model = ExampleActionModel(
          message: 'Test Message',
          duration: 5,
          backgroundColor: '#4CAF50',
          textColor: '#FFFFFF',
          showAction: true,
          actionText: 'Dismiss',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['actionType'], equals('exampleAction'));
        expect(json['message'], equals('Test Message'));
        expect(json['duration'], equals(5));
        expect(json['backgroundColor'], equals('#4CAF50'));
        expect(json['textColor'], equals('#FFFFFF'));
        expect(json['showAction'], equals(true));
        expect(json['actionText'], equals('Dismiss'));
      });

      test('should serialize to JSON correctly with minimal properties', () {
        // Arrange
        const model = ExampleActionModel(
          message: 'Simple Message',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['actionType'], equals('exampleAction'));
        expect(json['message'], equals('Simple Message'));
        expect(json.containsKey('duration'), isFalse);
        expect(json.containsKey('backgroundColor'), isFalse);
        expect(json.containsKey('textColor'), isFalse);
        expect(json.containsKey('showAction'), isFalse);
        expect(json.containsKey('actionText'), isFalse);
      });

      test('should deserialize from JSON correctly with all properties', () {
        // Arrange
        final json = {
          'actionType': 'exampleAction',
          'message': 'Test Message',
          'duration': 3,
          'backgroundColor': '#FF5722',
          'textColor': '#000000',
          'showAction': true,
          'actionText': 'OK',
        };

        // Act
        final model = ExampleActionModel.fromJson(json);

        // Assert
        expect(model.message, equals('Test Message'));
        expect(model.duration, equals(3));
        expect(model.backgroundColor, equals('#FF5722'));
        expect(model.textColor, equals('#000000'));
        expect(model.showAction, equals(true));
        expect(model.actionText, equals('OK'));
      });

      test('should deserialize from JSON correctly with minimal properties', () {
        // Arrange
        final json = {
          'message': 'Simple Message',
        };

        // Act
        final model = ExampleActionModel.fromJson(json);

        // Assert
        expect(model.message, equals('Simple Message'));
        expect(model.duration, isNull);
        expect(model.backgroundColor, isNull);
        expect(model.textColor, isNull);
        expect(model.showAction, isNull);
        expect(model.actionText, isNull);
        expect(model.onActionPressed, isNull);
      });

      test('should serialize and deserialize nested action from JSON', () {
        // Arrange
        final nestedActionJson = {
          'actionType': 'navigate',
          'routeName': '/home',
        };
        final modelJson = {
          'message': 'Action with nested action',
          'showAction': true,
          'actionText': 'Go Home',
          'onActionPressed': nestedActionJson,
        };

        // Act
        final model = ExampleActionModel.fromJson(modelJson);
        final json = model.toJson();

        // Assert
        expect(json['onActionPressed'], isNotNull);
        expect(json['onActionPressed'], equals(nestedActionJson));
        expect(model.onActionPressed, isNotNull);
      });
    });

    group('Props Equality', () {
      test('should have equal props for identical models', () {
        // Arrange
        const model1 = ExampleActionModel(
          message: 'Test',
          duration: 2,
          backgroundColor: '#4CAF50',
        );
        const model2 = ExampleActionModel(
          message: 'Test',
          duration: 2,
          backgroundColor: '#4CAF50',
        );

        // Act & Assert
        expect(model1.props, equals(model2.props));
      });

      test('should have different props for different models', () {
        // Arrange
        const model1 = ExampleActionModel(
          message: 'Test 1',
        );
        const model2 = ExampleActionModel(
          message: 'Test 2',
        );

        // Act & Assert
        expect(model1.props, isNot(equals(model2.props)));
      });
    });
  });

  group('ExampleActionParser', () {
    late ExampleActionParser parser;

    setUp(() {
      parser = const ExampleActionParser();
    });

    group('Parser Configuration', () {
      test('should have correct actionType', () {
        // Assert
        expect(parser.actionType, equals('exampleAction'));
      });

      test('should create model from JSON', () {
        // Arrange
        final json = {
          'message': 'Test Message',
          'duration': 3,
        };

        // Act
        final model = parser.getModel(json);

        // Assert
        expect(model, isA<ExampleActionModel>());
        expect(model.message, equals('Test Message'));
        expect(model.duration, equals(3));
      });
    });

    group('Action Execution', () {
      testWidgets('should show snackbar with message', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Test Snackbar',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        expect(find.text('Test Snackbar'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should apply custom duration', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Custom Duration',
          duration: 5,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.duration, equals(const Duration(seconds: 5)));
      });

      testWidgets('should apply default duration when not specified', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Default Duration',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.duration, equals(const Duration(seconds: 2)));
      });

      testWidgets('should show action button when showAction is true', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'With Action',
          showAction: true,
          actionText: 'Dismiss',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        expect(find.text('Dismiss'), findsOneWidget);
        expect(find.byType(SnackBarAction), findsOneWidget);
      });

      testWidgets('should not show action button when showAction is false', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Without Action',
          showAction: false,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        expect(find.byType(SnackBarAction), findsNothing);
      });

      testWidgets('should use default action text when not specified', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Default Action Text',
          showAction: true,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        expect(find.text('OK'), findsOneWidget);
      });
    });

    group('Color Parsing', () {
      testWidgets('should parse background color with 6 digits', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Custom Background',
          backgroundColor: '#FF5722',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.backgroundColor, equals(const Color(0xFFFF5722)));
      });

      testWidgets('should parse background color with 8 digits (with alpha)', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Custom Background with Alpha',
          backgroundColor: '#80FF5722',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.backgroundColor, equals(const Color(0x80FF5722)));
      });

      testWidgets('should use default background color when not specified', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Default Background',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.backgroundColor, equals(const Color(0xFF4CAF50)));
      });

      testWidgets('should parse text color correctly', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Custom Text Color',
          textColor: '#000000',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final text = tester.widget<Text>(find.text('Custom Text Color'));
        expect(text.style?.color, equals(const Color(0xFF000000)));
      });

      testWidgets('should use default text color when not specified', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Default Text Color',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert
        final text = tester.widget<Text>(find.text('Default Text Color'));
        expect(text.style?.color, equals(const Color(0xFFFFFFFF)));
      });

      testWidgets('should fallback to green for invalid background color', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Invalid Color',
          backgroundColor: 'invalid-color',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => parser.onCall(context, model),
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert - Should not throw and should use fallback color
        expect(find.byType(SnackBar), findsOneWidget);
        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackBar.backgroundColor, equals(Colors.green));
      });
    });

    group('Return Value', () {
      testWidgets('should return null when executed', (tester) async {
        // Arrange
        const model = ExampleActionModel(
          message: 'Test',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      final result = parser.onCall(context, model);
                      expect(result, isNull);
                    },
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        // Assert - Test passes if no exception is thrown
      });
    });
  });
}

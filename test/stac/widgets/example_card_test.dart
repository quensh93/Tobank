import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../stac/widgets/example_card/example_card_model.dart';
import '../../../stac/widgets/example_card/example_card_parser.dart';

void main() {
  group('ExampleCardModel', () {
    group('JSON Serialization', () {
      test('should serialize to JSON correctly with all properties', () {
        // Arrange
        final model = ExampleCardModel(
          title: 'Test Title',
          subtitle: 'Test Subtitle',
          backgroundColor: '#FFFFFF',
          elevation: 4.0,
          borderRadius: 12.0,
          padding: 20.0,
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['type'], equals('exampleCard'));
        expect(json['title'], equals('Test Title'));
        expect(json['subtitle'], equals('Test Subtitle'));
        expect(json['backgroundColor'], equals('#FFFFFF'));
        expect(json['elevation'], equals(4.0));
        expect(json['borderRadius'], equals(12.0));
        expect(json['padding'], equals(20.0));
      });

      test('should serialize to JSON correctly with minimal properties', () {
        // Arrange
        const model = ExampleCardModel(
          title: 'Minimal Card',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json['type'], equals('exampleCard'));
        expect(json['title'], equals('Minimal Card'));
        expect(json.containsKey('subtitle'), isFalse);
        expect(json.containsKey('icon'), isFalse);
        expect(json.containsKey('backgroundColor'), isFalse);
        expect(json.containsKey('elevation'), isFalse);
      });

      test('should deserialize from JSON correctly with all properties', () {
        // Arrange
        final json = {
          'type': 'exampleCard',
          'title': 'Test Title',
          'subtitle': 'Test Subtitle',
          'backgroundColor': '#FF5722',
          'elevation': 8.0,
          'borderRadius': 16.0,
          'padding': 24.0,
        };

        // Act
        final model = ExampleCardModel.fromJson(json);

        // Assert
        expect(model.title, equals('Test Title'));
        expect(model.subtitle, equals('Test Subtitle'));
        expect(model.backgroundColor, equals('#FF5722'));
        expect(model.elevation, equals(8.0));
        expect(model.borderRadius, equals(16.0));
        expect(model.padding, equals(24.0));
      });

      test('should deserialize from JSON correctly with minimal properties', () {
        // Arrange
        final json = {
          'title': 'Minimal Card',
        };

        // Act
        final model = ExampleCardModel.fromJson(json);

        // Assert
        expect(model.title, equals('Minimal Card'));
        expect(model.subtitle, isNull);
        expect(model.icon, isNull);
        expect(model.backgroundColor, isNull);
        expect(model.elevation, isNull);
        expect(model.borderRadius, isNull);
        expect(model.padding, isNull);
      });

      test('should handle numeric types correctly', () {
        // Arrange - Test with int values that should convert to double
        final json = {
          'title': 'Test',
          'elevation': 2,
          'borderRadius': 8,
          'padding': 16,
        };

        // Act
        final model = ExampleCardModel.fromJson(json);

        // Assert
        expect(model.elevation, equals(2.0));
        expect(model.borderRadius, equals(8.0));
        expect(model.padding, equals(16.0));
      });

      test('should serialize and deserialize icon widget from JSON', () {
        // Arrange
        final iconJson = {
          'type': 'icon',
          'icon': 'star',
          'color': '#FFD700',
        };
        final modelJson = {
          'title': 'Card with Icon',
          'icon': iconJson,
        };

        // Act
        final model = ExampleCardModel.fromJson(modelJson);
        final json = model.toJson();

        // Assert
        expect(json['icon'], isNotNull);
        expect(json['icon'], equals(iconJson));
        expect(model.icon, isNotNull);
      });

      test('should serialize and deserialize onTap action from JSON', () {
        // Arrange
        final actionJson = {
          'actionType': 'navigate',
          'routeName': '/details',
        };
        final modelJson = {
          'title': 'Tappable Card',
          'onTap': actionJson,
        };

        // Act
        final model = ExampleCardModel.fromJson(modelJson);
        final json = model.toJson();

        // Assert
        expect(json['onTap'], isNotNull);
        expect(json['onTap'], equals(actionJson));
        expect(model.onTap, isNotNull);
      });
    });

    group('Props Equality', () {
      test('should have equal props for identical models', () {
        // Arrange
        const model1 = ExampleCardModel(
          title: 'Test',
          subtitle: 'Subtitle',
          backgroundColor: '#FFFFFF',
          elevation: 2.0,
        );
        const model2 = ExampleCardModel(
          title: 'Test',
          subtitle: 'Subtitle',
          backgroundColor: '#FFFFFF',
          elevation: 2.0,
        );

        // Act & Assert
        expect(model1.props, equals(model2.props));
      });

      test('should have different props for different models', () {
        // Arrange
        const model1 = ExampleCardModel(
          title: 'Test 1',
        );
        const model2 = ExampleCardModel(
          title: 'Test 2',
        );

        // Act & Assert
        expect(model1.props, isNot(equals(model2.props)));
      });
    });
  });

  group('ExampleCardParser', () {
    late ExampleCardParser parser;

    setUp(() {
      parser = const ExampleCardParser();
    });

    group('Parser Configuration', () {
      test('should have correct type', () {
        // Assert
        expect(parser.type, equals('exampleCard'));
      });

      test('should create model from JSON', () {
        // Arrange
        final json = {
          'title': 'Test Card',
          'subtitle': 'Test Subtitle',
        };

        // Act
        final model = parser.getModel(json);

        // Assert
        expect(model, isA<ExampleCardModel>());
        expect(model.title, equals('Test Card'));
        expect(model.subtitle, equals('Test Subtitle'));
      });
    });

    group('Widget Rendering', () {
      testWidgets('should render card with title only', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test Title',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Test Title'), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should render card with title and subtitle', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test Title',
          subtitle: 'Test Subtitle',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Test Subtitle'), findsOneWidget);
      });

      testWidgets('should apply custom elevation', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          elevation: 8.0,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.elevation, equals(8.0));
      });

      testWidgets('should apply default elevation when not specified', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.elevation, equals(2.0));
      });

      testWidgets('should apply custom border radius', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          borderRadius: 16.0,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        final card = tester.widget<Card>(find.byType(Card));
        final shape = card.shape as RoundedRectangleBorder;
        final borderRadius = shape.borderRadius as BorderRadius;
        expect(borderRadius.topLeft.x, equals(16.0));
      });

      testWidgets('should apply custom padding', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          padding: 24.0,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert - Find all Padding widgets and check if one has the custom padding
        final paddingWidgets = tester.widgetList<Padding>(find.byType(Padding));
        final customPadding = paddingWidgets.firstWhere(
          (p) => p.padding == const EdgeInsets.all(24.0),
        );
        expect(customPadding.padding, equals(const EdgeInsets.all(24.0)));
      });

      testWidgets('should render with InkWell when onTap is provided', (tester) async {
        // Arrange
        final modelJson = {
          'title': 'Tappable Card',
          'onTap': {
            'actionType': 'navigate',
            'routeName': '/test',
          },
        };
        final model = ExampleCardModel.fromJson(modelJson);

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        expect(find.byType(InkWell), findsOneWidget);
      });

      testWidgets('should not render InkWell when onTap is not provided', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Non-tappable Card',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        expect(find.byType(InkWell), findsNothing);
      });
    });

    group('Color Parsing', () {
      testWidgets('should parse hex color with 6 digits', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          backgroundColor: '#FF5722',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, equals(const Color(0xFFFF5722)));
      });

      testWidgets('should parse hex color with 8 digits (with alpha)', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          backgroundColor: '#80FF5722',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, equals(const Color(0x80FF5722)));
      });

      testWidgets('should use theme color for invalid color string', (tester) async {
        // Arrange
        const model = ExampleCardModel(
          title: 'Test',
          backgroundColor: 'invalid-color',
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => parser.parse(context, model),
              ),
            ),
          ),
        );

        // Assert - Should not throw and should use theme color
        expect(find.byType(Card), findsOneWidget);
      });
    });
  });
}

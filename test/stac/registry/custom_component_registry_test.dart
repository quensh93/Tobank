import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stac_framework/stac_framework.dart';

import '../../../stac/actions/example_action/example_action_parser.dart';
import '../../../stac/registry/custom_component_registry.dart';
import '../../../stac/widgets/example_card/example_card_parser.dart';

void main() {
  group('CustomComponentRegistry', () {
    late CustomComponentRegistry registry;

    setUp(() {
      // Get the singleton instance
      registry = CustomComponentRegistry.instance;
      // Clear all parsers before each test
      registry.clearAll();
    });

    tearDown(() {
      // Clean up after each test
      registry.clearAll();
    });

    group('Singleton Instance', () {
      test('should return the same instance', () {
        // Act
        final instance1 = CustomComponentRegistry.instance;
        final instance2 = CustomComponentRegistry();
        final instance3 = CustomComponentRegistry.instance;

        // Assert
        expect(instance1, same(instance2));
        expect(instance1, same(instance3));
        expect(instance2, same(instance3));
      });
    });

    group('Widget Parser Registration', () {
      test('should register a widget parser successfully', () {
        // Arrange
        const parser = ExampleCardParser();

        // Act
        final result = registry.registerWidget(parser);

        // Assert
        expect(result, isTrue);
        expect(registry.hasWidgetParser('exampleCard'), isTrue);
        expect(registry.getWidgetParser('exampleCard'), equals(parser));
      });

      test('should return false when registering duplicate widget parser without override', () {
        // Arrange
        const parser1 = ExampleCardParser();
        const parser2 = ExampleCardParser();

        // Act
        final result1 = registry.registerWidget(parser1);
        final result2 = registry.registerWidget(parser2, false);

        // Assert
        expect(result1, isTrue);
        expect(result2, isFalse);
        expect(registry.getWidgetParser('exampleCard'), equals(parser1));
      });

      test('should override widget parser when override flag is true', () {
        // Arrange
        const parser1 = ExampleCardParser();
        const parser2 = ExampleCardParser();

        // Act
        registry.registerWidget(parser1);
        final result = registry.registerWidget(parser2, true);

        // Assert
        expect(result, isTrue);
        expect(registry.getWidgetParser('exampleCard'), equals(parser2));
      });

      test('should register multiple widget parsers', () {
        // Arrange
        const parser1 = ExampleCardParser();
        final parser2 = _MockWidgetParser('customWidget');

        // Act
        registry.registerWidget(parser1);
        registry.registerWidget(parser2);

        // Assert
        expect(registry.hasWidgetParser('exampleCard'), isTrue);
        expect(registry.hasWidgetParser('customWidget'), isTrue);
        expect(registry.getRegisteredWidgets().length, equals(2));
      });

      test('should register all widgets from list', () async {
        // Arrange
        final parsers = <StacParser>[
          const ExampleCardParser(),
          _MockWidgetParser('widget1'),
          _MockWidgetParser('widget2'),
        ];

        // Act
        await registry.registerAllWidgets(parsers);

        // Assert
        expect(registry.getRegisteredWidgets().length, equals(3));
        expect(registry.hasWidgetParser('exampleCard'), isTrue);
        expect(registry.hasWidgetParser('widget1'), isTrue);
        expect(registry.hasWidgetParser('widget2'), isTrue);
      });
    });

    group('Action Parser Registration', () {
      test('should register an action parser successfully', () {
        // Arrange
        const parser = ExampleActionParser();

        // Act
        final result = registry.registerAction(parser);

        // Assert
        expect(result, isTrue);
        expect(registry.hasActionParser('exampleAction'), isTrue);
        expect(registry.getActionParser('exampleAction'), equals(parser));
      });

      test('should return false when registering duplicate action parser without override', () {
        // Arrange
        const parser1 = ExampleActionParser();
        const parser2 = ExampleActionParser();

        // Act
        final result1 = registry.registerAction(parser1);
        final result2 = registry.registerAction(parser2, false);

        // Assert
        expect(result1, isTrue);
        expect(result2, isFalse);
        expect(registry.getActionParser('exampleAction'), equals(parser1));
      });

      test('should override action parser when override flag is true', () {
        // Arrange
        const parser1 = ExampleActionParser();
        const parser2 = ExampleActionParser();

        // Act
        registry.registerAction(parser1);
        final result = registry.registerAction(parser2, true);

        // Assert
        expect(result, isTrue);
        expect(registry.getActionParser('exampleAction'), equals(parser2));
      });

      test('should register multiple action parsers', () {
        // Arrange
        const parser1 = ExampleActionParser();
        final parser2 = _MockActionParser('customAction');

        // Act
        registry.registerAction(parser1);
        registry.registerAction(parser2);

        // Assert
        expect(registry.hasActionParser('exampleAction'), isTrue);
        expect(registry.hasActionParser('customAction'), isTrue);
        expect(registry.getRegisteredActions().length, equals(2));
      });

      test('should register all actions from list', () async {
        // Arrange
        final parsers = <StacActionParser>[
          const ExampleActionParser(),
          _MockActionParser('action1'),
          _MockActionParser('action2'),
        ];

        // Act
        await registry.registerAllActions(parsers);

        // Assert
        expect(registry.getRegisteredActions().length, equals(3));
        expect(registry.hasActionParser('exampleAction'), isTrue);
        expect(registry.hasActionParser('action1'), isTrue);
        expect(registry.hasActionParser('action2'), isTrue);
      });
    });

    group('Parser Retrieval', () {
      test('should retrieve registered widget parser', () {
        // Arrange
        const parser = ExampleCardParser();
        registry.registerWidget(parser);

        // Act
        final retrieved = registry.getWidgetParser('exampleCard');

        // Assert
        expect(retrieved, isNotNull);
        expect(retrieved, equals(parser));
      });

      test('should return null for unregistered widget parser', () {
        // Act
        final retrieved = registry.getWidgetParser('nonExistent');

        // Assert
        expect(retrieved, isNull);
      });

      test('should retrieve registered action parser', () {
        // Arrange
        const parser = ExampleActionParser();
        registry.registerAction(parser);

        // Act
        final retrieved = registry.getActionParser('exampleAction');

        // Assert
        expect(retrieved, isNotNull);
        expect(retrieved, equals(parser));
      });

      test('should return null for unregistered action parser', () {
        // Act
        final retrieved = registry.getActionParser('nonExistent');

        // Assert
        expect(retrieved, isNull);
      });

      test('should get list of registered widget types', () {
        // Arrange
        registry.registerWidget(const ExampleCardParser());
        registry.registerWidget(_MockWidgetParser('widget1'));
        registry.registerWidget(_MockWidgetParser('widget2'));

        // Act
        final widgets = registry.getRegisteredWidgets();

        // Assert
        expect(widgets.length, equals(3));
        expect(widgets, contains('exampleCard'));
        expect(widgets, contains('widget1'));
        expect(widgets, contains('widget2'));
      });

      test('should get list of registered action types', () {
        // Arrange
        registry.registerAction(const ExampleActionParser());
        registry.registerAction(_MockActionParser('action1'));
        registry.registerAction(_MockActionParser('action2'));

        // Act
        final actions = registry.getRegisteredActions();

        // Assert
        expect(actions.length, equals(3));
        expect(actions, contains('exampleAction'));
        expect(actions, contains('action1'));
        expect(actions, contains('action2'));
      });

      test('should return empty list when no parsers registered', () {
        // Act
        final widgets = registry.getRegisteredWidgets();
        final actions = registry.getRegisteredActions();

        // Assert
        expect(widgets, isEmpty);
        expect(actions, isEmpty);
      });
    });

    group('Conflict Detection', () {
      test('should detect widget parser conflict', () {
        // Arrange
        const parser1 = ExampleCardParser();
        const parser2 = ExampleCardParser();

        // Act
        final result1 = registry.registerWidget(parser1);
        final result2 = registry.registerWidget(parser2);

        // Assert
        expect(result1, isTrue);
        expect(result2, isFalse);
        expect(registry.getRegisteredWidgets().length, equals(1));
      });

      test('should detect action parser conflict', () {
        // Arrange
        const parser1 = ExampleActionParser();
        const parser2 = ExampleActionParser();

        // Act
        final result1 = registry.registerAction(parser1);
        final result2 = registry.registerAction(parser2);

        // Assert
        expect(result1, isTrue);
        expect(result2, isFalse);
        expect(registry.getRegisteredActions().length, equals(1));
      });

      test('should allow same type name for widget and action', () {
        // Arrange
        final widgetParser = _MockWidgetParser('sameType');
        final actionParser = _MockActionParser('sameType');

        // Act
        final widgetResult = registry.registerWidget(widgetParser);
        final actionResult = registry.registerAction(actionParser);

        // Assert
        expect(widgetResult, isTrue);
        expect(actionResult, isTrue);
        expect(registry.hasWidgetParser('sameType'), isTrue);
        expect(registry.hasActionParser('sameType'), isTrue);
      });

      test('should handle conflict with override in batch registration', () async {
        // Arrange
        final parser1 = _MockWidgetParser('widget1');
        final parser2 = _MockWidgetParser('widget1'); // Duplicate

        // Act
        await registry.registerAllWidgets(<StacParser>[parser1, parser2], false);

        // Assert - Only first one should be registered
        expect(registry.getRegisteredWidgets().length, equals(1));
        expect(registry.getWidgetParser('widget1'), equals(parser1));
      });

      test('should override conflicts in batch registration when override is true', () async {
        // Arrange
        final parser1 = _MockWidgetParser('widget1');
        final parser2 = _MockWidgetParser('widget1'); // Duplicate

        // Act
        await registry.registerAllWidgets(<StacParser>[parser1, parser2], true);

        // Assert - Second one should override
        expect(registry.getRegisteredWidgets().length, equals(1));
        expect(registry.getWidgetParser('widget1'), equals(parser2));
      });
    });

    group('Parser Unregistration', () {
      test('should unregister widget parser', () {
        // Arrange
        const parser = ExampleCardParser();
        registry.registerWidget(parser);

        // Act
        final result = registry.unregisterWidget('exampleCard');

        // Assert
        expect(result, isTrue);
        expect(registry.hasWidgetParser('exampleCard'), isFalse);
        expect(registry.getWidgetParser('exampleCard'), isNull);
      });

      test('should return false when unregistering non-existent widget parser', () {
        // Act
        final result = registry.unregisterWidget('nonExistent');

        // Assert
        expect(result, isFalse);
      });

      test('should unregister action parser', () {
        // Arrange
        const parser = ExampleActionParser();
        registry.registerAction(parser);

        // Act
        final result = registry.unregisterAction('exampleAction');

        // Assert
        expect(result, isTrue);
        expect(registry.hasActionParser('exampleAction'), isFalse);
        expect(registry.getActionParser('exampleAction'), isNull);
      });

      test('should return false when unregistering non-existent action parser', () {
        // Act
        final result = registry.unregisterAction('nonExistent');

        // Assert
        expect(result, isFalse);
      });
    });

    group('Clear All', () {
      test('should clear all registered parsers', () {
        // Arrange
        registry.registerWidget(const ExampleCardParser());
        registry.registerWidget(_MockWidgetParser('widget1'));
        registry.registerAction(const ExampleActionParser());
        registry.registerAction(_MockActionParser('action1'));

        // Act
        registry.clearAll();

        // Assert
        expect(registry.getRegisteredWidgets(), isEmpty);
        expect(registry.getRegisteredActions(), isEmpty);
      });

      test('should allow re-registration after clear', () {
        // Arrange
        const parser = ExampleCardParser();
        registry.registerWidget(parser);
        registry.clearAll();

        // Act
        final result = registry.registerWidget(parser);

        // Assert
        expect(result, isTrue);
        expect(registry.hasWidgetParser('exampleCard'), isTrue);
      });
    });

    group('Summary', () {
      test('should return correct summary with no parsers', () {
        // Act
        final summary = registry.getSummary();

        // Assert
        expect(summary['widgetCount'], equals(0));
        expect(summary['actionCount'], equals(0));
        expect(summary['widgets'], isEmpty);
        expect(summary['actions'], isEmpty);
      });

      test('should return correct summary with registered parsers', () {
        // Arrange
        registry.registerWidget(const ExampleCardParser());
        registry.registerWidget(_MockWidgetParser('widget1'));
        registry.registerAction(const ExampleActionParser());

        // Act
        final summary = registry.getSummary();

        // Assert
        expect(summary['widgetCount'], equals(2));
        expect(summary['actionCount'], equals(1));
        expect(summary['widgets'], hasLength(2));
        expect(summary['actions'], hasLength(1));
        expect(summary['widgets'], contains('exampleCard'));
        expect(summary['widgets'], contains('widget1'));
        expect(summary['actions'], contains('exampleAction'));
      });
    });

    group('Has Parser Checks', () {
      test('should correctly check if widget parser exists', () {
        // Arrange
        registry.registerWidget(const ExampleCardParser());

        // Act & Assert
        expect(registry.hasWidgetParser('exampleCard'), isTrue);
        expect(registry.hasWidgetParser('nonExistent'), isFalse);
      });

      test('should correctly check if action parser exists', () {
        // Arrange
        registry.registerAction(const ExampleActionParser());

        // Act & Assert
        expect(registry.hasActionParser('exampleAction'), isTrue);
        expect(registry.hasActionParser('nonExistent'), isFalse);
      });
    });
  });
}

// Mock widget parser for testing
class _MockWidgetParser extends StacParser<dynamic> {
  final String _type;

  _MockWidgetParser(this._type);

  @override
  String get type => _type;

  @override
  dynamic getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(context, model) => const SizedBox.shrink();
}

// Mock action parser for testing
class _MockActionParser extends StacActionParser<dynamic> {
  final String _actionType;

  _MockActionParser(this._actionType);

  @override
  String get actionType => _actionType;

  @override
  dynamic getModel(Map<String, dynamic> json) => json;

  @override
  dynamic onCall(context, model) => null;
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/stac/custom_component_registry.dart';
import 'package:tobank_sdui/core/validation/stac_json_validator.dart';

void main() {
  late StacJsonValidator validator;
  late CustomComponentRegistry registry;

  setUp(() {
    validator = StacJsonValidator();
    registry = CustomComponentRegistry.instance;
    // Clear registry before each test
    registry.clearAll();
  });

  tearDown(() {
    // Clean up registry after each test
    registry.clearAll();
  });

  group('StacJsonValidator - Valid JSON Structures', () {
    test('should validate simple text widget', () {
      // Arrange
      final json = {
        'type': 'text',
        'data': 'Hello World',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with child', () {
      // Arrange
      final json = {
        'type': 'container',
        'child': {
          'type': 'text',
          'data': 'Child text',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with children array', () {
      // Arrange
      final json = {
        'type': 'column',
        'children': [
          {'type': 'text', 'data': 'First'},
          {'type': 'text', 'data': 'Second'},
          {'type': 'text', 'data': 'Third'},
        ],
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate nested widget structure', () {
      // Arrange
      final json = {
        'type': 'container',
        'child': {
          'type': 'column',
          'children': [
            {
              'type': 'row',
              'children': [
                {'type': 'text', 'data': 'A'},
                {'type': 'text', 'data': 'B'},
              ],
            },
            {'type': 'text', 'data': 'C'},
          ],
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with properties', () {
      // Arrange
      final json = {
        'type': 'container',
        'properties': {
          'width': 100,
          'height': 200,
          'color': '#FF0000',
        },
        'child': {
          'type': 'text',
          'data': 'Content',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with action', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'child': {
          'type': 'text',
          'data': 'Click Me',
        },
        'onPressed': {
          'actionType': 'navigate',
          'route': '/home',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with multiple actions', () {
      // Arrange
      final json = {
        'type': 'textField',
        'onChanged': {
          'actionType': 'setState',
          'key': 'inputValue',
        },
        'onSubmitted': {
          'actionType': 'request',
          'url': '/api/submit',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate widget with action array', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'child': {
          'type': 'text',
          'data': 'Submit',
        },
        'onPressed': [
          {
            'actionType': 'vibrate',
          },
          {
            'actionType': 'navigate',
            'route': '/success',
          },
        ],
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('should validate all built-in widget types', () {
      // Test a sample of built-in widgets
      final widgetTypes = [
        'text',
        'container',
        'column',
        'row',
        'elevatedButton',
        'textField',
        'image',
        'icon',
        'scaffold',
        'appBar',
      ];

      for (final type in widgetTypes) {
        final json = {'type': type};
        final result = validator.validate(json);
        expect(result.isValid, isTrue, reason: 'Widget type "$type" should be valid');
      }
    });

    test('should validate all built-in action types', () {
      // Test a sample of built-in actions
      final actionTypes = [
        'navigate',
        'back',
        'showDialog',
        'hideDialog',
        'setState',
        'request',
        'refresh',
        'launch',
      ];

      for (final actionType in actionTypes) {
        final json = {
          'type': 'elevatedButton',
          'onPressed': {
            'actionType': actionType,
          },
        };
        final result = validator.validate(json);
        expect(result.isValid, isTrue, reason: 'Action type "$actionType" should be valid');
      }
    });
  });

  group('StacJsonValidator - Invalid JSON Structures', () {
    test('should fail when type field is missing', () {
      // Arrange
      final json = {
        'data': 'Hello World',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('MISSING_TYPE'));
      expect(result.errors.first.path, equals('root'));
      expect(result.errors.first.message, contains('Missing required field: type'));
    });

    test('should fail when type is not a string', () {
      // Arrange
      final json = {
        'type': 123,
        'data': 'Hello',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_TYPE_VALUE'));
      expect(result.errors.first.message, contains('must be a string'));
    });

    test('should fail when widget type is unknown', () {
      // Arrange
      final json = {
        'type': 'unknownWidget',
        'data': 'Test',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('UNKNOWN_WIDGET_TYPE'));
      expect(result.errors.first.message, contains('Unknown widget type: unknownWidget'));
      expect(result.errors.first.suggestion, isNotNull);
    });

    test('should fail when child is not an object', () {
      // Arrange
      final json = {
        'type': 'container',
        'child': 'invalid',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_CHILD'));
      expect(result.errors.first.path, equals('root.child'));
    });

    test('should fail when children is not an array', () {
      // Arrange
      final json = {
        'type': 'column',
        'children': 'invalid',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_CHILDREN'));
      expect(result.errors.first.path, equals('root.children'));
    });

    test('should fail when child in children array is not an object', () {
      // Arrange
      final json = {
        'type': 'column',
        'children': [
          {'type': 'text', 'data': 'Valid'},
          'invalid',
          {'type': 'text', 'data': 'Valid'},
        ],
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_CHILD_ITEM'));
      expect(result.errors.first.path, equals('root.children[1]'));
    });

    test('should fail when action is missing actionType', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'onPressed': {
          'route': '/home',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('MISSING_ACTION_TYPE'));
      expect(result.errors.first.path, equals('root.onPressed'));
    });

    test('should fail when actionType is not a string', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'onPressed': {
          'actionType': 123,
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_ACTION_TYPE_VALUE'));
    });

    test('should fail when action type is unknown', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'onPressed': {
          'actionType': 'unknownAction',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('UNKNOWN_ACTION_TYPE'));
      expect(result.errors.first.message, contains('Unknown action type: unknownAction'));
    });

    test('should fail when action is not an object or array', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'onPressed': 'invalid',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_ACTION'));
    });

    test('should fail when properties is not an object', () {
      // Arrange
      final json = {
        'type': 'container',
        'properties': 'invalid',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, hasLength(1));
      expect(result.errors.first.code, equals('INVALID_PROPERTIES'));
    });

    test('should fail when nesting depth exceeds maximum', () {
      // Arrange - Create deeply nested structure (51 levels)
      Map<String, dynamic> json = {'type': 'text', 'data': 'Deep'};
      for (var i = 0; i < 51; i++) {
        json = {
          'type': 'container',
          'child': json,
        };
      }

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors.any((e) => e.code == 'MAX_DEPTH_EXCEEDED'), isTrue);
    });

    test('should collect multiple errors in complex structure', () {
      // Arrange
      final json = {
        'type': 'column',
        'children': [
          {'type': 'unknownWidget'},
          {
            'type': 'elevatedButton',
            'onPressed': {
              'actionType': 'unknownAction',
            },
          },
          'invalid',
        ],
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors.length, greaterThan(1));
    });
  });

  group('StacJsonValidator - Error Messages', () {
    test('should generate clear error message for missing type', () {
      // Arrange
      final json = {'data': 'test'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.errors.first.message, equals('Missing required field: type'));
      expect(result.errors.first.suggestion, contains('Add a "type" field'));
    });

    test('should generate clear error message for unknown widget', () {
      // Arrange
      final json = {'type': 'customWidget'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.errors.first.message, contains('Unknown widget type: customWidget'));
      expect(result.errors.first.suggestion, contains('register a custom parser'));
    });

    test('should generate clear error message for unknown action', () {
      // Arrange
      final json = {
        'type': 'elevatedButton',
        'onPressed': {
          'actionType': 'customAction',
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.errors.first.message, contains('Unknown action type: customAction'));
      expect(result.errors.first.suggestion, contains('register a custom parser'));
    });

    test('should include path in error message', () {
      // Arrange
      final json = {
        'type': 'container',
        'child': {
          'type': 'column',
          'children': [
            {'type': 'unknownWidget'},
          ],
        },
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.errors.first.path, equals('root.child.children[0].type'));
    });

    test('should include value in error when applicable', () {
      // Arrange
      final json = {
        'type': 123,
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.errors.first.value, equals(123));
    });

    test('should provide formatted error message', () {
      // Arrange
      final json = {'type': 'unknownWidget'};

      // Act
      final result = validator.validate(json);
      final formattedMessage = result.errors.first.formattedMessage;

      // Assert
      expect(formattedMessage, contains('[root.type]'));
      expect(formattedMessage, contains('Unknown widget type'));
      expect(formattedMessage, contains('Suggestion:'));
    });
  });

  group('StacJsonValidator - Warnings', () {
    test('should generate warning for text widget without data', () {
      // Arrange
      final json = {
        'type': 'text',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.warnings, hasLength(1));
      expect(result.warnings.first.code, equals('MISSING_TEXT_DATA'));
      expect(result.warnings.first.message, contains('missing "data" property'));
    });

    test('should generate warning for image widget without src', () {
      // Arrange
      final json = {
        'type': 'image',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.warnings, hasLength(1));
      expect(result.warnings.first.code, equals('MISSING_IMAGE_SRC'));
      expect(result.warnings.first.message, contains('missing "src" property'));
    });

    test('should have warnings but still be valid', () {
      // Arrange
      final json = {
        'type': 'text',
      };

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.warnings, isNotEmpty);
      expect(result.summary, contains('warning'));
    });
  });

  group('StacJsonValidator - Interface Methods', () {
    test('getErrors should return errors from last validation', () {
      // Arrange
      final json = {'data': 'test'};

      // Act
      validator.validate(json);
      final errors = validator.getErrors();

      // Assert
      expect(errors, hasLength(1));
      expect(errors.first.code, equals('MISSING_TYPE'));
    });

    test('isValid should return true for valid JSON', () {
      // Arrange
      final json = {'type': 'text', 'data': 'test'};

      // Act
      validator.validate(json);

      // Assert
      expect(validator.isValid(), isTrue);
    });

    test('isValid should return false for invalid JSON', () {
      // Arrange
      final json = {'data': 'test'};

      // Act
      validator.validate(json);

      // Assert
      expect(validator.isValid(), isFalse);
    });

    test('should clear errors between validations', () {
      // Arrange
      final invalidJson = {'data': 'test'};
      final validJson = {'type': 'text', 'data': 'test'};

      // Act
      validator.validate(invalidJson);
      expect(validator.isValid(), isFalse);

      validator.validate(validJson);

      // Assert
      expect(validator.isValid(), isTrue);
      expect(validator.getErrors(), isEmpty);
    });
  });

  group('StacJsonValidator - ValidationResult', () {
    test('should create success result', () {
      // Arrange
      final json = {'type': 'text', 'data': 'test'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
      expect(result.timestamp, isNotNull);
    });

    test('should create failure result', () {
      // Arrange
      final json = {'data': 'test'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.isValid, isFalse);
      expect(result.errors, isNotEmpty);
      expect(result.timestamp, isNotNull);
    });

    test('should have correct summary for success', () {
      // Arrange
      final json = {'type': 'text', 'data': 'test'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.summary, equals('Validation successful'));
    });

    test('should have correct summary for success with warnings', () {
      // Arrange
      final json = {'type': 'text'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.summary, contains('successful with'));
      expect(result.summary, contains('warning'));
    });

    test('should have correct summary for failure', () {
      // Arrange
      final json = {'data': 'test'};

      // Act
      final result = validator.validate(json);

      // Assert
      expect(result.summary, contains('failed with'));
      expect(result.summary, contains('error'));
    });
  });
}

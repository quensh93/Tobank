import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/features/stac_test_app/data/utils/stac_error_handler.dart';
import 'package:dio/dio.dart';

void main() {
  group('StacErrorHandler', () {
    group('getUserFriendlyMessage', () {
      test('should handle FileSystemException - file not found', () {
        // Arrange
        final error = FileSystemException('File not found', '/path/to/file.json');

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('File not found'));
        expect(message, contains('/path/to/file.json'));
      });

      test('should handle FileSystemException - permission denied', () {
        // Arrange
        final error = FileSystemException(
          'Permission denied',
          '/path/to/file.json',
          OSError('', 13), // Unix permission denied
        );

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('Permission denied'));
        expect(message, contains('/path/to/file.json'));
      });

      test('should handle FormatException with location info', () {
        // Arrange
        final source = '{"type": "text", "data": invalid}';
        final error = FormatException('Unexpected character', source, 25);

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('Invalid JSON format'));
        expect(message, contains('Unexpected character'));
      });

      test('should handle DioException - connection timeout', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: 'https://example.com/data.json'),
          type: DioExceptionType.connectionTimeout,
        );

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('Network timeout'));
        expect(message, contains('https://example.com/data.json'));
      });

      test('should handle DioException - connection error', () {
        // Arrange
        final error = DioException(
          requestOptions: RequestOptions(path: 'https://example.com/data.json'),
          type: DioExceptionType.connectionError,
        );

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('Connection error'));
        expect(message, contains('https://example.com/data.json'));
      });

      test('should handle EntryPointValidationException', () {
        // Arrange
        final error = EntryPointValidationException('Missing required field: screens');

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, 'Missing required field: screens');
      });

      test('should handle ScreenValidationException', () {
        // Arrange
        final error = ScreenValidationException('Template file is missing');

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, 'Template file is missing');
      });

      test('should handle unknown error types', () {
        // Arrange
        final error = Exception('Unknown error');

        // Act
        final message = StacErrorHandler.getUserFriendlyMessage(error);

        // Assert
        expect(message, contains('unexpected error'));
        expect(message, contains('Unknown error'));
      });
    });

    group('validateEntryPoint', () {
      test('should validate correct entry point structure', () {
        // Arrange
        final json = {
          'initial_screen': 'login',
          'screens': {
            'login': {
              'template': 'login_template.json',
              'data': 'login_data.json',
            },
          },
        };

        // Act & Assert
        expect(() => StacErrorHandler.validateEntryPoint(json), returnsNormally);
      });

      test('should throw for empty entry point', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for missing initial_screen', () {
        // Arrange
        final json = {
          'screens': {
            'login': {
              'template': 'login_template.json',
              'data': 'login_data.json',
            },
          },
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for missing screens', () {
        // Arrange
        final json = {
          'initial_screen': 'login',
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for empty screens', () {
        // Arrange
        final json = {
          'initial_screen': 'login',
          'screens': <String, dynamic>{},
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for initial_screen not in screens', () {
        // Arrange
        final json = {
          'initial_screen': 'nonexistent',
          'screens': {
            'login': {
              'template': 'login_template.json',
              'data': 'login_data.json',
            },
          },
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for screen missing template', () {
        // Arrange
        final json = {
          'initial_screen': 'login',
          'screens': {
            'login': {
              'data': 'login_data.json',
            },
          },
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });

      test('should throw for screen missing data', () {
        // Arrange
        final json = {
          'initial_screen': 'login',
          'screens': {
            'login': {
              'template': 'login_template.json',
            },
          },
        };

        // Act & Assert
        expect(
          () => StacErrorHandler.validateEntryPoint(json),
          throwsA(isA<EntryPointValidationException>()),
        );
      });
    });

    group('validateScreenJson', () {
      test('should validate non-empty screen JSON', () {
        // Arrange
        final json = {'type': 'scaffold', 'body': {'type': 'text'}};

        // Act & Assert
        expect(
          () => StacErrorHandler.validateScreenJson(json, 'test_screen'),
          returnsNormally,
        );
      });

      test('should throw for empty screen JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act & Assert
        expect(
          () => StacErrorHandler.validateScreenJson(json, 'test_screen'),
          throwsA(isA<ScreenValidationException>()),
        );
      });
    });

    group('hasInvalidPathCharacters', () {
      test('should detect invalid characters in path', () {
        // Act & Assert
        expect(StacErrorHandler.hasInvalidPathCharacters('file<name>.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file>name.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file:name.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file"name.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file|name.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file?name.json'), isTrue);
        expect(StacErrorHandler.hasInvalidPathCharacters('file*name.json'), isTrue);
      });

      test('should allow valid paths', () {
        // Act & Assert
        expect(StacErrorHandler.hasInvalidPathCharacters('file_name.json'), isFalse);
        expect(StacErrorHandler.hasInvalidPathCharacters('file-name.json'), isFalse);
        expect(StacErrorHandler.hasInvalidPathCharacters('file.name.json'), isFalse);
        expect(StacErrorHandler.hasInvalidPathCharacters('path/to/file.json'), isFalse);
      });
    });

    group('isEmptyFile', () {
      test('should detect empty file content', () {
        // Act & Assert
        expect(StacErrorHandler.isEmptyFile(''), isTrue);
        expect(StacErrorHandler.isEmptyFile('   '), isTrue);
        expect(StacErrorHandler.isEmptyFile('\n\t  '), isTrue);
      });

      test('should detect non-empty file content', () {
        // Act & Assert
        expect(StacErrorHandler.isEmptyFile('content'), isFalse);
        expect(StacErrorHandler.isEmptyFile('  content  '), isFalse);
      });
    });

    group('isJsonTooLarge', () {
      test('should detect large JSON files', () {
        // Arrange
        final largeContent = 'x' * (11 * 1024 * 1024); // 11 MB

        // Act & Assert
        expect(StacErrorHandler.isJsonTooLarge(largeContent), isTrue);
      });

      test('should allow normal-sized JSON files', () {
        // Arrange
        final normalContent = 'x' * (5 * 1024 * 1024); // 5 MB

        // Act & Assert
        expect(StacErrorHandler.isJsonTooLarge(normalContent), isFalse);
      });

      test('should respect custom max size', () {
        // Arrange
        final content = 'x' * (6 * 1024 * 1024); // 6 MB

        // Act & Assert
        expect(StacErrorHandler.isJsonTooLarge(content, maxSizeMB: 5), isTrue);
        expect(StacErrorHandler.isJsonTooLarge(content, maxSizeMB: 10), isFalse);
      });
    });
  });
}


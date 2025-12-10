import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';

const _testSupabaseUrl = 'https://example.supabase.co';
const _testSupabaseAnonKey = 'public-anon-key';

void main() {
  group('ApiMode', () {
    test('should have correct enum values', () {
      expect(ApiMode.values.length, equals(3));
      expect(ApiMode.values, contains(ApiMode.mock));
      expect(ApiMode.values, contains(ApiMode.supabase));
      expect(ApiMode.values, contains(ApiMode.custom));
    });
  });

  group('ApiConfig', () {
    group('Constructor', () {
      test('should create ApiConfig with required parameters', () {
        // Arrange & Act
        final config = ApiConfig(
          mode: ApiMode.mock,
        );

        // Assert
        expect(config.mode, equals(ApiMode.mock));
        expect(config.enableCaching, isTrue);
        expect(config.cacheExpiry, equals(const Duration(minutes: 5)));
        expect(config.headers, isEmpty);
        expect(config.supabaseUrl, isNull);
        expect(config.customApiUrl, isNull);
        expect(config.authToken, isNull);
      });

      test('should create ApiConfig with all parameters', () {
        // Arrange & Act
        final config = ApiConfig(
          mode: ApiMode.custom,
          customApiUrl: 'https://api.example.com',
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 10),
          headers: {'Authorization': 'Bearer token'},
          authToken: 'test-token',
        );

        // Assert
        expect(config.mode, equals(ApiMode.custom));
        expect(config.customApiUrl, equals('https://api.example.com'));
        expect(config.enableCaching, isFalse);
        expect(config.cacheExpiry, equals(const Duration(minutes: 10)));
        expect(config.headers, equals({'Authorization': 'Bearer token'}));
        expect(config.authToken, equals('test-token'));
      });
    });

    group('Factory Constructors', () {
      test('mock() should create mock configuration with defaults', () {
        // Act
        final config = ApiConfig.mock();

        // Assert
        expect(config.mode, equals(ApiMode.mock));
        expect(config.enableCaching, isTrue);
        expect(config.cacheExpiry, equals(const Duration(minutes: 5)));
        expect(config.supabaseUrl, isNull);
        expect(config.customApiUrl, isNull);
      });

      test('mock() should create mock configuration with custom parameters', () {
        // Act
        final config = ApiConfig.mock(
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 15),
        );

        // Assert
        expect(config.mode, equals(ApiMode.mock));
        expect(config.enableCaching, isFalse);
        expect(config.cacheExpiry, equals(const Duration(minutes: 15)));
      });

      test('Supabase() should create Supabase configuration', () {
        // Act
        final config = ApiConfig.supabase(
          _testSupabaseUrl,
          _testSupabaseAnonKey,
        );

        // Assert
        expect(config.mode, equals(ApiMode.supabase));
        expect(config.supabaseUrl, equals(_testSupabaseUrl));
        expect(config.supabaseAnonKey, equals(_testSupabaseAnonKey));
        expect(config.enableCaching, isTrue);
        expect(config.cacheExpiry, equals(const Duration(minutes: 5)));
      });

      test('Supabase() should create Supabase configuration with custom parameters', () {
        // Act
        final config = ApiConfig.supabase(
          _testSupabaseUrl,
          _testSupabaseAnonKey,
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 20),
        );

        // Assert
        expect(config.mode, equals(ApiMode.supabase));
        expect(config.supabaseUrl, equals(_testSupabaseUrl));
        expect(config.supabaseAnonKey, equals(_testSupabaseAnonKey));
        expect(config.enableCaching, isFalse);
        expect(config.cacheExpiry, equals(const Duration(minutes: 20)));
      });

      test('custom() should create custom API configuration', () {
        // Act
        final config = ApiConfig.custom('https://api.example.com');

        // Assert
        expect(config.mode, equals(ApiMode.custom));
        expect(config.customApiUrl, equals('https://api.example.com'));
        expect(config.enableCaching, isTrue);
        expect(config.cacheExpiry, equals(const Duration(minutes: 5)));
        expect(config.headers, isEmpty);
        expect(config.authToken, isNull);
      });

      test('custom() should create custom API configuration with all parameters', () {
        // Act
        final config = ApiConfig.custom(
          'https://api.example.com',
          enableCaching: false,
          cacheExpiry: const Duration(minutes: 30),
          headers: {'X-Custom-Header': 'value'},
          authToken: 'bearer-token',
        );

        // Assert
        expect(config.mode, equals(ApiMode.custom));
        expect(config.customApiUrl, equals('https://api.example.com'));
        expect(config.enableCaching, isFalse);
        expect(config.cacheExpiry, equals(const Duration(minutes: 30)));
        expect(config.headers, equals({'X-Custom-Header': 'value'}));
        expect(config.authToken, equals('bearer-token'));
      });
    });

    group('Configuration Switching', () {
      test('should switch from mock to Supabase configuration', () {
        // Arrange
        final mockConfig = ApiConfig.mock();

        // Act
        final supabaseConfig = mockConfig.copyWith(
          mode: ApiMode.supabase,
          supabaseUrl: 'new-project',
        );

        // Assert
        expect(supabaseConfig.mode, equals(ApiMode.supabase));
        expect(supabaseConfig.supabaseUrl, equals('new-project'));
        expect(supabaseConfig.enableCaching, equals(mockConfig.enableCaching));
      });

      test('should switch from Supabase to custom configuration', () {
        // Arrange
        final supabaseConfig = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Act
        final customConfig = supabaseConfig.copyWith(
          mode: ApiMode.custom,
          customApiUrl: 'https://api.example.com',
        );

        // Assert
        expect(customConfig.mode, equals(ApiMode.custom));
        expect(customConfig.customApiUrl, equals('https://api.example.com'));
        expect(customConfig.enableCaching, equals(supabaseConfig.enableCaching));
      });

      test('should update caching settings', () {
        // Arrange
        final config = ApiConfig.mock();

        // Act
        final updatedConfig = config.copyWith(
          enableCaching: false,
          cacheExpiry: const Duration(hours: 1),
        );

        // Assert
        expect(updatedConfig.enableCaching, isFalse);
        expect(updatedConfig.cacheExpiry, equals(const Duration(hours: 1)));
        expect(updatedConfig.mode, equals(config.mode));
      });

      test('should update headers and auth token', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        // Act
        final updatedConfig = config.copyWith(
          headers: {'Authorization': 'Bearer new-token'},
          authToken: 'new-token',
        );

        // Assert
        expect(updatedConfig.headers, equals({'Authorization': 'Bearer new-token'}));
        expect(updatedConfig.authToken, equals('new-token'));
      });
    });

    group('copyWith', () {
      test('should return same config when no parameters provided', () {
        // Arrange
        final config = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Act
        final copiedConfig = config.copyWith();

        // Assert
        expect(copiedConfig.mode, equals(config.mode));
        expect(copiedConfig.supabaseUrl, equals(config.supabaseUrl));
        expect(copiedConfig.enableCaching, equals(config.enableCaching));
        expect(copiedConfig.cacheExpiry, equals(config.cacheExpiry));
      });

      test('should update only specified parameters', () {
        // Arrange
        final config = ApiConfig.custom(
          'https://api.example.com',
          authToken: 'old-token',
        );

        // Act
        final updatedConfig = config.copyWith(authToken: 'new-token');

        // Assert
        expect(updatedConfig.authToken, equals('new-token'));
        expect(updatedConfig.customApiUrl, equals(config.customApiUrl));
        expect(updatedConfig.mode, equals(config.mode));
      });
    });

    group('toString', () {
      test('should return string representation of mock config', () {
        // Arrange
        final config = ApiConfig.mock();

        // Act
        final result = config.toString();

        // Assert
        expect(result, contains('ApiConfig'));
        expect(result, contains('mode: ApiMode.mock'));
        expect(result, contains('enableCaching: true'));
      });

      test('should return string representation of Supabase config', () {
        // Arrange
        final config = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Act
        final result = config.toString();

        // Assert
        expect(result, contains('ApiConfig'));
        expect(result, contains('mode: ApiMode.supabase'));
        expect(result, contains('supabaseUrl: test-project'));
      });

      test('should return string representation of custom config', () {
        // Arrange
        final config = ApiConfig.custom('https://api.example.com');

        // Act
        final result = config.toString();

        // Assert
        expect(result, contains('ApiConfig'));
        expect(result, contains('mode: ApiMode.custom'));
        expect(result, contains('customApiUrl: https://api.example.com'));
      });
    });

    group('Equality', () {
      test('should be equal when all properties match', () {
        // Arrange
        final config1 = ApiConfig.mock();
        final config2 = ApiConfig.mock();

        // Assert
        expect(config1, equals(config2));
        expect(config1.hashCode, equals(config2.hashCode));
      });

      test('should be equal for Supabase configs with same project', () {
        // Arrange
        final config1 = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);
        final config2 = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Assert
        expect(config1, equals(config2));
        expect(config1.hashCode, equals(config2.hashCode));
      });

      test('should not be equal when mode differs', () {
        // Arrange
        final config1 = ApiConfig.mock();
        final config2 = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Assert
        expect(config1, isNot(equals(config2)));
      });

      test('should not be equal when Supabase project differs', () {
        // Arrange
        final config1 = ApiConfig.supabase(
          'https://project-1.supabase.co',
          _testSupabaseAnonKey,
        );
        final config2 = ApiConfig.supabase(
          'https://project-2.supabase.co',
          _testSupabaseAnonKey,
        );

        // Assert
        expect(config1, isNot(equals(config2)));
      });

      test('should not be equal when custom URL differs', () {
        // Arrange
        final config1 = ApiConfig.custom('https://api1.example.com');
        final config2 = ApiConfig.custom('https://api2.example.com');

        // Assert
        expect(config1, isNot(equals(config2)));
      });

      test('should not be equal when caching settings differ', () {
        // Arrange
        final config1 = ApiConfig.mock(enableCaching: true);
        final config2 = ApiConfig.mock(enableCaching: false);

        // Assert
        expect(config1, isNot(equals(config2)));
      });

      test('should not be equal when auth token differs', () {
        // Arrange
        final config1 = ApiConfig.custom('https://api.example.com', authToken: 'token1');
        final config2 = ApiConfig.custom('https://api.example.com', authToken: 'token2');

        // Assert
        expect(config1, isNot(equals(config2)));
      });

      test('should be equal to itself', () {
        // Arrange
        final config = ApiConfig.supabase('https://test-project.supabase.co', _testSupabaseAnonKey);

        // Assert
        expect(config, equals(config));
        expect(identical(config, config), isTrue);
      });
    });
  });

  group('Exception Handling', () {
    group('ApiException', () {
      test('should create ApiException with message', () {
        // Act
        const exception = ApiException('Test error');

        // Assert
        expect(exception.message, equals('Test error'));
        expect(exception.statusCode, isNull);
        expect(exception.originalError, isNull);
      });

      test('should create ApiException with all parameters', () {
        // Arrange
        final originalError = Exception('Original');
        final stackTrace = StackTrace.current;

        // Act
        final exception = ApiException(
          'Test error',
          statusCode: 500,
          originalError: originalError,
          stackTrace: stackTrace,
        );

        // Assert
        expect(exception.message, equals('Test error'));
        expect(exception.statusCode, equals(500));
        expect(exception.originalError, equals(originalError));
        expect(exception.stackTrace, equals(stackTrace));
      });

      test('toString should include message', () {
        // Arrange
        const exception = ApiException('Test error');

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('ApiException'));
        expect(result, contains('Test error'));
      });

      test('toString should include status code when present', () {
        // Arrange
        const exception = ApiException('Test error', statusCode: 404);

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('Status: 404'));
      });

      test('toString should include original error when present', () {
        // Arrange
        final originalError = Exception('Original error');
        final exception = ApiException('Test error', originalError: originalError);

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('Original error'));
      });
    });

    group('ScreenNotFoundException', () {
      test('should create exception with screen name', () {
        // Act
        final exception = ScreenNotFoundException('home_screen');

        // Assert
        expect(exception.screenName, equals('home_screen'));
        expect(exception.message, contains('home_screen'));
        expect(exception.statusCode, equals(404));
      });

      test('toString should include screen name', () {
        // Arrange
        final exception = ScreenNotFoundException('profile_screen');

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('ScreenNotFoundException'));
        expect(result, contains('profile_screen'));
      });

      test('should be an ApiException', () {
        // Act
        final exception = ScreenNotFoundException('test_screen');

        // Assert
        expect(exception, isA<ApiException>());
      });
    });

    group('NetworkException', () {
      test('should create exception with message', () {
        // Act
        final exception = NetworkException('Network error');

        // Assert
        expect(exception.message, equals('Network error'));
        expect(exception.errorType, equals(NetworkErrorType.unknown));
      });

      test('timeout factory should create timeout exception', () {
        // Act
        final exception = NetworkException.timeout();

        // Assert
        expect(exception.message, contains('timed out'));
        expect(exception.errorType, equals(NetworkErrorType.timeout));
        expect(exception.statusCode, equals(408));
      });

      test('connection factory should create connection exception', () {
        // Act
        final exception = NetworkException.connection();

        // Assert
        expect(exception.message, contains('Connection'));
        expect(exception.errorType, equals(NetworkErrorType.connection));
      });

      test('serverError factory should create server error exception', () {
        // Act
        final exception = NetworkException.serverError();

        // Assert
        expect(exception.message, contains('Server'));
        expect(exception.errorType, equals(NetworkErrorType.serverError));
        expect(exception.statusCode, equals(500));
      });

      test('unauthorized factory should create unauthorized exception', () {
        // Act
        final exception = NetworkException.unauthorized();

        // Assert
        expect(exception.message, contains('Unauthorized'));
        expect(exception.errorType, equals(NetworkErrorType.unauthorized));
        expect(exception.statusCode, equals(401));
      });

      test('toString should include error type', () {
        // Arrange
        final exception = NetworkException.timeout();

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('NetworkException'));
        expect(result, contains('timeout'));
      });

      test('should be an ApiException', () {
        // Act
        final exception = NetworkException('Test');

        // Assert
        expect(exception, isA<ApiException>());
      });
    });

    group('ValidationException', () {
      test('should create exception with validation errors', () {
        // Arrange
        const errors = [
          ValidationError(path: 'field1', message: 'Required'),
          ValidationError(path: 'field2', message: 'Invalid format'),
        ];

        // Act
        final exception = ValidationException(errors);

        // Assert
        expect(exception.errors, equals(errors));
        expect(exception.message, contains('2 error(s)'));
      });

      test('toString should list all errors', () {
        // Arrange
        const errors = [
          ValidationError(path: 'name', message: 'Required'),
          ValidationError(path: 'email', message: 'Invalid email'),
        ];
        final exception = ValidationException(errors);

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('ValidationException'));
        expect(result, contains('name'));
        expect(result, contains('Required'));
        expect(result, contains('email'));
        expect(result, contains('Invalid email'));
      });

      test('should be an ApiException', () {
        // Arrange
        const errors = [ValidationError(path: 'test', message: 'Error')];

        // Act
        final exception = ValidationException(errors);

        // Assert
        expect(exception, isA<ApiException>());
      });
    });

    group('ValidationError', () {
      test('should create validation error with required fields', () {
        // Act
        const error = ValidationError(path: 'field', message: 'Error message');

        // Assert
        expect(error.path, equals('field'));
        expect(error.message, equals('Error message'));
        expect(error.value, isNull);
      });

      test('should create validation error with value', () {
        // Act
        const error = ValidationError(
          path: 'age',
          message: 'Must be positive',
          value: -5,
        );

        // Assert
        expect(error.path, equals('age'));
        expect(error.message, equals('Must be positive'));
        expect(error.value, equals(-5));
      });

      test('toString should include all fields', () {
        // Arrange
        const error = ValidationError(
          path: 'email',
          message: 'Invalid format',
          value: 'not-an-email',
        );

        // Act
        final result = error.toString();

        // Assert
        expect(result, contains('ValidationError'));
        expect(result, contains('email'));
        expect(result, contains('Invalid format'));
        expect(result, contains('not-an-email'));
      });
    });

    group('JsonParsingException', () {
      test('should create exception with message', () {
        // Act
        final exception = JsonParsingException('Parse error');

        // Assert
        expect(exception.message, equals('Parse error'));
        expect(exception.jsonPath, isNull);
      });

      test('should create exception with JSON path', () {
        // Act
        final exception = JsonParsingException(
          'Invalid type',
          jsonPath: 'data.items[0].name',
        );

        // Assert
        expect(exception.message, equals('Invalid type'));
        expect(exception.jsonPath, equals('data.items[0].name'));
      });

      test('toString should include JSON path when present', () {
        // Arrange
        final exception = JsonParsingException(
          'Type mismatch',
          jsonPath: 'config.settings',
        );

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('JsonParsingException'));
        expect(result, contains('Type mismatch'));
        expect(result, contains('config.settings'));
      });

      test('should be an ApiException', () {
        // Act
        final exception = JsonParsingException('Test');

        // Assert
        expect(exception, isA<ApiException>());
      });
    });

    group('CacheException', () {
      test('should create exception with message', () {
        // Act
        final exception = CacheException('Cache write failed');

        // Assert
        expect(exception.message, equals('Cache write failed'));
      });

      test('toString should include message', () {
        // Arrange
        final exception = CacheException('Cache read failed');

        // Act
        final result = exception.toString();

        // Assert
        expect(result, contains('CacheException'));
        expect(result, contains('Cache read failed'));
      });

      test('should be an ApiException', () {
        // Act
        final exception = CacheException('Test');

        // Assert
        expect(exception, isA<ApiException>());
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/security/input_validator.dart';
import 'package:tobank_sdui/core/security/secure_config_storage.dart';

void main() {
  group('InputValidator - JSON Validation', () {
    test('should validate valid JSON string', () {
      // Arrange
      const jsonString = '{"type": "text", "data": "Hello"}';

      // Act & Assert
      expect(() => InputValidator.validateJsonStructure(jsonString), returnsNormally);
    });

    test('should validate JSON array', () {
      // Arrange
      const jsonString = '[{"type": "text"}, {"type": "container"}]';

      // Act & Assert
      expect(() => InputValidator.validateJsonStructure(jsonString), returnsNormally);
    });

    test('should throw ValidationException for invalid JSON', () {
      // Arrange
      const jsonString = '{invalid json}';

      // Act & Assert
      expect(
        () => InputValidator.validateJsonStructure(jsonString),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw ValidationException for primitive JSON', () {
      // Arrange
      const jsonString = '"just a string"';

      // Act & Assert
      expect(
        () => InputValidator.validateJsonStructure(jsonString),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw ValidationException for excessively deep nesting', () {
      // Arrange - Create JSON with 51 levels of nesting
      String jsonString = '{"level": 0}';
      for (var i = 1; i <= 51; i++) {
        jsonString = '{"level": $i, "child": $jsonString}';
      }

      // Act & Assert
      expect(
        () => InputValidator.validateJsonStructure(jsonString),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('InputValidator - Input Sanitization', () {
    test('should remove HTML tags from input', () {
      // Arrange
      const input = '<p>Hello <b>World</b></p>';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('Hello World'));
    });

    test('should remove script tags and content', () {
      // Arrange
      const input = 'Hello <script>alert("XSS")</script> World';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('Hello  World'));
    });

    test('should remove javascript protocol', () {
      // Arrange
      const input = 'javascript:alert("XSS")';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('alert("XSS")'));
    });

    test('should remove data protocol', () {
      // Arrange
      const input = 'data:text/html,<script>alert("XSS")</script>';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('text/html,alert("XSS")'));
    });

    test('should remove event handlers', () {
      // Arrange
      const input = '<div onclick="alert()">Click</div>';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('Click'));
    });

    test('should trim whitespace', () {
      // Arrange
      const input = '  Hello World  ';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals('Hello World'));
    });

    test('should handle empty string', () {
      // Arrange
      const input = '';

      // Act
      final sanitized = InputValidator.sanitizeInput(input);

      // Assert
      expect(sanitized, equals(''));
    });
  });

  group('InputValidator - URL Sanitization', () {
    test('should allow valid HTTPS URL', () {
      // Arrange
      const url = 'https://example.com/page';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, equals(url));
    });

    test('should allow valid HTTP URL', () {
      // Arrange
      const url = 'http://example.com/page';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, equals(url));
    });

    test('should allow mailto URL', () {
      // Arrange
      const url = 'mailto:test@example.com';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, equals(url));
    });

    test('should reject javascript protocol', () {
      // Arrange
      const url = 'javascript:alert("XSS")';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, isNull);
    });

    test('should reject data protocol', () {
      // Arrange
      const url = 'data:text/html,<script>alert("XSS")</script>';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, isNull);
    });

    test('should reject file protocol', () {
      // Arrange
      const url = 'file:///etc/passwd';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, isNull);
    });

    test('should handle null URL', () {
      // Act
      final sanitized = InputValidator.sanitizeUrl(null);

      // Assert
      expect(sanitized, isNull);
    });

    test('should handle empty URL', () {
      // Act
      final sanitized = InputValidator.sanitizeUrl('');

      // Assert
      expect(sanitized, isNull);
    });

    test('should handle invalid URL format', () {
      // Arrange
      const url = 'not a valid url';

      // Act
      final sanitized = InputValidator.sanitizeUrl(url);

      // Assert
      expect(sanitized, isNull);
    });
  });

  group('InputValidator - Email Validation', () {
    test('should validate correct email format', () {
      // Arrange
      const email = 'test@example.com';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate email with subdomain', () {
      // Arrange
      const email = 'user@mail.example.com';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate email with plus sign', () {
      // Arrange
      const email = 'user+tag@example.com';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject email without @', () {
      // Arrange
      const email = 'testexample.com';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject email without domain', () {
      // Arrange
      const email = 'test@';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject email without TLD', () {
      // Arrange
      const email = 'test@example';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject empty email', () {
      // Arrange
      const email = '';

      // Act
      final isValid = InputValidator.isValidEmail(email);

      // Assert
      expect(isValid, isFalse);
    });
  });

  group('InputValidator - Phone Number Validation', () {
    test('should validate standard phone number', () {
      // Arrange
      const phone = '1234567890';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate phone with country code', () {
      // Arrange
      const phone = '+1234567890';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate phone with separators', () {
      // Arrange
      const phone = '(123) 456-7890';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate phone with dots', () {
      // Arrange
      const phone = '123.456.7890';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject phone with letters', () {
      // Arrange
      const phone = '123-ABC-7890';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject too short phone number', () {
      // Arrange
      const phone = '12345';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject empty phone number', () {
      // Arrange
      const phone = '';

      // Act
      final isValid = InputValidator.isValidPhoneNumber(phone);

      // Assert
      expect(isValid, isFalse);
    });
  });

  group('InputValidator - SQL Injection Detection', () {
    test('should detect SQL SELECT statement', () {
      // Arrange
      const input = "SELECT * FROM users";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isTrue);
    });

    test('should detect SQL UNION attack', () {
      // Arrange
      const input = "1' UNION SELECT password FROM users--";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isTrue);
    });

    test('should detect SQL OR attack', () {
      // Arrange
      const input = "admin' OR '1'='1";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isTrue);
    });

    test('should detect SQL comment', () {
      // Arrange
      const input = "admin'--";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isTrue);
    });

    test('should not flag normal text', () {
      // Arrange
      const input = "This is a normal text";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isFalse);
    });

    test('should handle empty string', () {
      // Arrange
      const input = "";

      // Act
      final hasSqlInjection = InputValidator.containsSqlInjection(input);

      // Assert
      expect(hasSqlInjection, isFalse);
    });
  });

  group('InputValidator - XSS Detection', () {
    test('should detect script tag', () {
      // Arrange
      const input = '<script>alert("XSS")</script>';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isTrue);
    });

    test('should detect javascript protocol', () {
      // Arrange
      const input = 'javascript:alert("XSS")';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isTrue);
    });

    test('should detect event handler', () {
      // Arrange
      const input = '<img src="x" onerror="alert(1)">';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isTrue);
    });

    test('should detect iframe tag', () {
      // Arrange
      const input = '<iframe src="evil.com"></iframe>';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isTrue);
    });

    test('should detect object tag', () {
      // Arrange
      const input = '<object data="evil.swf"></object>';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isTrue);
    });

    test('should not flag normal text', () {
      // Arrange
      const input = 'This is normal text';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isFalse);
    });

    test('should handle empty string', () {
      // Arrange
      const input = '';

      // Act
      final hasXss = InputValidator.containsXss(input);

      // Assert
      expect(hasXss, isFalse);
    });
  });

  group('InputValidator - JSON Map Validation', () {
    test('should validate JSON with required fields', () {
      // Arrange
      final json = {'type': 'text', 'data': 'Hello'};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          requiredFields: ['type', 'data'],
        ),
        returnsNormally,
      );
    });

    test('should throw when required field is missing', () {
      // Arrange
      final json = {'type': 'text'};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          requiredFields: ['type', 'data'],
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should validate field types', () {
      // Arrange
      final json = {'name': 'John', 'age': 30};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          fieldTypes: {'name': String, 'age': int},
        ),
        returnsNormally,
      );
    });

    test('should throw when field type is wrong', () {
      // Arrange
      final json = {'name': 'John', 'age': '30'};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          fieldTypes: {'name': String, 'age': int},
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should validate JSON size limit', () {
      // Arrange
      final json = {'data': 'short'};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          maxSize: 1000,
        ),
        returnsNormally,
      );
    });

    test('should throw when JSON exceeds size limit', () {
      // Arrange
      final json = {'data': 'x' * 1000};

      // Act & Assert
      expect(
        () => InputValidator.validateJsonMap(
          json,
          maxSize: 100,
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('InputValidator - Utility Methods', () {
    test('should validate string length within bounds', () {
      // Arrange
      const input = 'Hello';

      // Act
      final isValid = InputValidator.validateLength(
        input,
        minLength: 3,
        maxLength: 10,
      );

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject string shorter than minimum', () {
      // Arrange
      const input = 'Hi';

      // Act
      final isValid = InputValidator.validateLength(
        input,
        minLength: 5,
      );

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject string longer than maximum', () {
      // Arrange
      const input = 'This is a very long string';

      // Act
      final isValid = InputValidator.validateLength(
        input,
        maxLength: 10,
      );

      // Assert
      expect(isValid, isFalse);
    });

    test('should validate alphanumeric string', () {
      // Arrange
      const input = 'abc123';

      // Act
      final isValid = InputValidator.isAlphanumeric(input);

      // Assert
      expect(isValid, isTrue);
    });

    test('should validate alphanumeric with spaces when allowed', () {
      // Arrange
      const input = 'abc 123';

      // Act
      final isValid = InputValidator.isAlphanumeric(input, allowSpaces: true);

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject alphanumeric with spaces when not allowed', () {
      // Arrange
      const input = 'abc 123';

      // Act
      final isValid = InputValidator.isAlphanumeric(input);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject alphanumeric with special characters', () {
      // Arrange
      const input = 'abc@123';

      // Act
      final isValid = InputValidator.isAlphanumeric(input);

      // Assert
      expect(isValid, isFalse);
    });

    test('should escape HTML special characters', () {
      // Arrange
      const input = '<div class="test">Hello & "World"</div>';

      // Act
      final escaped = InputValidator.escapeHtml(input);

      // Assert
      expect(escaped, equals('&lt;div class=&quot;test&quot;&gt;Hello &amp; &quot;World&quot;&lt;&#x2F;div&gt;'));
    });

    test('should validate file path without traversal', () {
      // Arrange
      const path = 'assets/images/logo.png';

      // Act
      final isValid = InputValidator.isValidFilePath(path);

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject file path with directory traversal', () {
      // Arrange
      const path = '../../../etc/passwd';

      // Act
      final isValid = InputValidator.isValidFilePath(path);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject absolute file path', () {
      // Arrange
      const path = '/etc/passwd';

      // Act
      final isValid = InputValidator.isValidFilePath(path);

      // Assert
      expect(isValid, isFalse);
    });

    test('should validate API key format', () {
      // Arrange
      const apiKey = 'abcd1234efgh5678ijkl';

      // Act
      final isValid = InputValidator.isValidApiKey(apiKey);

      // Assert
      expect(isValid, isTrue);
    });

    test('should reject short API key', () {
      // Arrange
      const apiKey = 'short';

      // Act
      final isValid = InputValidator.isValidApiKey(apiKey);

      // Assert
      expect(isValid, isFalse);
    });

    test('should reject API key with invalid characters', () {
      // Arrange
      const apiKey = 'abcd1234@#\$%5678ijkl';

      // Act
      final isValid = InputValidator.isValidApiKey(apiKey);

      // Assert
      expect(isValid, isFalse);
    });
  });

  group('InputValidator - JSON Sanitization', () {
    test('should sanitize string values in JSON map', () {
      // Arrange
      final json = {
        'name': '<script>alert("XSS")</script>John',
        'description': 'Hello <b>World</b>',
      };

      // Act
      final sanitized = InputValidator.sanitizeJsonMap(json);

      // Assert
      expect(sanitized['name'], equals('John'));
      expect(sanitized['description'], equals('Hello World'));
    });

    test('should sanitize nested JSON maps', () {
      // Arrange
      final json = {
        'user': {
          'name': '<script>alert(1)</script>Jane',
          'email': 'jane@example.com',
        },
      };

      // Act
      final sanitized = InputValidator.sanitizeJsonMap(json);

      // Assert
      expect(sanitized['user']['name'], equals('Jane'));
      expect(sanitized['user']['email'], equals('jane@example.com'));
    });

    test('should sanitize arrays in JSON', () {
      // Arrange
      final json = {
        'items': [
          '<script>alert(1)</script>Item 1',
          'Item 2',
          '<b>Item 3</b>',
        ],
      };

      // Act
      final sanitized = InputValidator.sanitizeJsonMap(json);

      // Assert
      expect(sanitized['items'][0], equals('Item 1'));
      expect(sanitized['items'][1], equals('Item 2'));
      expect(sanitized['items'][2], equals('Item 3'));
    });

    test('should preserve non-string values', () {
      // Arrange
      final json = {
        'count': 42,
        'active': true,
        'price': 19.99,
      };

      // Act
      final sanitized = InputValidator.sanitizeJsonMap(json);

      // Assert
      expect(sanitized['count'], equals(42));
      expect(sanitized['active'], equals(true));
      expect(sanitized['price'], equals(19.99));
    });

    test('should handle complex nested structures', () {
      // Arrange
      final json = {
        'data': {
          'users': [
            {'name': '<script>alert(1)</script>User1'},
            {'name': 'User2'},
          ],
          'config': {
            'title': '<b>Title</b>',
          },
        },
      };

      // Act
      final sanitized = InputValidator.sanitizeJsonMap(json);

      // Assert
      expect(sanitized['data']['users'][0]['name'], equals('User1'));
      expect(sanitized['data']['config']['title'], equals('Title'));
    });
  });

  group('SecureConfigStorage - Initialization', () {
    test('should throw StateError when not initialized', () async {
      // Arrange
      final storage = SecureConfigStorage.instance;

      // Act & Assert
      expect(
        () => storage.saveApiKey('test-key'),
        throwsA(isA<StateError>()),
      );
    });

    test('should initialize successfully', () async {
      // Arrange
      final storage = SecureConfigStorage.instance;

      // Act & Assert
      await storage.initialize();
      // Should not throw
    });

    test('should handle multiple initialization calls', () async {
      // Arrange
      final storage = SecureConfigStorage.instance;

      // Act & Assert
      await storage.initialize();
      await storage.initialize(); // Should not throw
    });
  });

  group('SecureConfigStorage - API Key Management', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll(); // Clean slate for each test
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve API key', () async {
      // Arrange
      const apiKey = 'test-api-key-12345';

      // Act
      await storage.saveApiKey(apiKey);
      final retrieved = await storage.getApiKey();

      // Assert
      expect(retrieved, equals(apiKey));
    });

    test('should return null when API key not set', () async {
      // Act
      final retrieved = await storage.getApiKey();

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete API key', () async {
      // Arrange
      await storage.saveApiKey('test-key');

      // Act
      await storage.deleteApiKey();
      final retrieved = await storage.getApiKey();

      // Assert
      expect(retrieved, isNull);
    });

    test('should check if API key exists', () async {
      // Arrange
      await storage.saveApiKey('test-key');

      // Act
      final hasKey = await storage.hasApiKey();

      // Assert
      expect(hasKey, isTrue);
    });

    test('should return false when API key does not exist', () async {
      // Act
      final hasKey = await storage.hasApiKey();

      // Assert
      expect(hasKey, isFalse);
    });

    test('should throw ArgumentError for empty API key', () async {
      // Act & Assert
      expect(
        () => storage.saveApiKey(''),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SecureConfigStorage - Authentication Tokens', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve auth token', () async {
      // Arrange
      const token = 'auth-token-xyz';

      // Act
      await storage.saveAuthToken(token);
      final retrieved = await storage.getAuthToken();

      // Assert
      expect(retrieved, equals(token));
    });

    test('should save and retrieve refresh token', () async {
      // Arrange
      const token = 'refresh-token-abc';

      // Act
      await storage.saveRefreshToken(token);
      final retrieved = await storage.getRefreshToken();

      // Assert
      expect(retrieved, equals(token));
    });

    test('should delete auth token', () async {
      // Arrange
      await storage.saveAuthToken('test-token');

      // Act
      await storage.deleteAuthToken();
      final retrieved = await storage.getAuthToken();

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete refresh token', () async {
      // Arrange
      await storage.saveRefreshToken('test-token');

      // Act
      await storage.deleteRefreshToken();
      final retrieved = await storage.getRefreshToken();

      // Assert
      expect(retrieved, isNull);
    });

    test('should clear all auth tokens', () async {
      // Arrange
      await storage.saveAuthToken('auth-token');
      await storage.saveRefreshToken('refresh-token');

      // Act
      await storage.clearAuthTokens();

      // Assert
      expect(await storage.getAuthToken(), isNull);
      expect(await storage.getRefreshToken(), isNull);
    });

    test('should throw ArgumentError for empty auth token', () async {
      // Act & Assert
      expect(
        () => storage.saveAuthToken(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError for empty refresh token', () async {
      // Act & Assert
      expect(
        () => storage.saveRefreshToken(''),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SecureConfigStorage - Supabase Configuration', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve Supabase config', () async {
      // Arrange
      final config = {
        'projectId': 'my-project',
        'apiKey': 'Supabase-api-key',
        'appId': 'app-id',
      };

      // Act
      await storage.saveSupabaseConfig(config);
      final retrieved = await storage.getSupabaseConfig();

      // Assert
      expect(retrieved, equals(config));
    });

    test('should return null when Supabase config not set', () async {
      // Act
      final retrieved = await storage.getSupabaseConfig();

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete Supabase config', () async {
      // Arrange
      await storage.saveSupabaseConfig({'projectId': 'test'});

      // Act
      await storage.deleteSupabaseConfig();
      final retrieved = await storage.getSupabaseConfig();

      // Assert
      expect(retrieved, isNull);
    });

    test('should check if Supabase config exists', () async {
      // Arrange
      await storage.saveSupabaseConfig({'projectId': 'test'});

      // Act
      final hasConfig = await storage.hasSupabaseConfig();

      // Assert
      expect(hasConfig, isTrue);
    });

    test('should return false when Supabase config does not exist', () async {
      // Act
      final hasConfig = await storage.hasSupabaseConfig();

      // Assert
      expect(hasConfig, isFalse);
    });

    test('should throw ArgumentError for empty Supabase config', () async {
      // Act & Assert
      expect(
        () => storage.saveSupabaseConfig({}),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SecureConfigStorage - Custom API Configuration', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve custom API URL', () async {
      // Arrange
      const url = 'https://api.example.com';

      // Act
      await storage.saveCustomApiUrl(url);
      final retrieved = await storage.getCustomApiUrl();

      // Assert
      expect(retrieved, equals(url));
    });

    test('should return null when custom API URL not set', () async {
      // Act
      final retrieved = await storage.getCustomApiUrl();

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete custom API URL', () async {
      // Arrange
      await storage.saveCustomApiUrl('https://api.example.com');

      // Act
      await storage.deleteCustomApiUrl();
      final retrieved = await storage.getCustomApiUrl();

      // Assert
      expect(retrieved, isNull);
    });

    test('should throw ArgumentError for empty URL', () async {
      // Act & Assert
      expect(
        () => storage.saveCustomApiUrl(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError for non-HTTPS URL', () async {
      // Act & Assert
      expect(
        () => storage.saveCustomApiUrl('http://api.example.com'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SecureConfigStorage - User Credentials', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve user credentials', () async {
      // Arrange
      const username = 'testuser';
      const password = 'testpass123';

      // Act
      await storage.saveUserCredentials(
        username: username,
        password: password,
      );
      final retrieved = await storage.getUserCredentials();

      // Assert
      expect(retrieved?['username'], equals(username));
      expect(retrieved?['password'], equals(password));
      expect(retrieved?['saved_at'], isNotNull);
    });

    test('should return null when credentials not set', () async {
      // Act
      final retrieved = await storage.getUserCredentials();

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete user credentials', () async {
      // Arrange
      await storage.saveUserCredentials(
        username: 'user',
        password: 'pass',
      );

      // Act
      await storage.deleteUserCredentials();
      final retrieved = await storage.getUserCredentials();

      // Assert
      expect(retrieved, isNull);
    });

    test('should throw ArgumentError for empty username', () async {
      // Act & Assert
      expect(
        () => storage.saveUserCredentials(
          username: '',
          password: 'pass',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError for empty password', () async {
      // Act & Assert
      expect(
        () => storage.saveUserCredentials(
          username: 'user',
          password: '',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('SecureConfigStorage - Generic Storage', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should save and retrieve generic secure value', () async {
      // Arrange
      const key = 'custom_key';
      const value = 'custom_value';

      // Act
      await storage.saveSecureValue(key, value);
      final retrieved = await storage.getSecureValue(key);

      // Assert
      expect(retrieved, equals(value));
    });

    test('should return null when generic value not set', () async {
      // Act
      final retrieved = await storage.getSecureValue('nonexistent');

      // Assert
      expect(retrieved, isNull);
    });

    test('should delete generic secure value', () async {
      // Arrange
      await storage.saveSecureValue('key', 'value');

      // Act
      await storage.deleteSecureValue('key');
      final retrieved = await storage.getSecureValue('key');

      // Assert
      expect(retrieved, isNull);
    });

    test('should throw ArgumentError for empty key', () async {
      // Act & Assert
      expect(
        () => storage.saveSecureValue('', 'value'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should check if storage contains key', () async {
      // Arrange
      await storage.saveApiKey('test-key');

      // Act
      final contains = await storage.containsKey('stac_api_key');

      // Assert
      expect(contains, isTrue);
    });

    test('should return false for non-existent key', () async {
      // Act
      final contains = await storage.containsKey('nonexistent');

      // Assert
      expect(contains, isFalse);
    });
  });

  group('SecureConfigStorage - Utility Methods', () {
    late SecureConfigStorage storage;

    setUp(() async {
      storage = SecureConfigStorage.instance;
      await storage.initialize();
      await storage.clearAll();
    });

    tearDown(() async {
      await storage.clearAll();
    });

    test('should get all stored keys', () async {
      // Arrange
      await storage.saveApiKey('api-key');
      await storage.saveAuthToken('auth-token');

      // Act
      final keys = await storage.getAllKeys();

      // Assert
      expect(keys, contains('stac_api_key'));
      expect(keys, contains('stac_auth_token'));
    });

    test('should export configuration', () async {
      // Arrange
      await storage.saveApiKey('api-key');
      await storage.saveCustomApiUrl('https://api.example.com');
      await storage.saveSupabaseConfig({'projectId': 'test'});

      // Act
      final config = await storage.exportConfig();

      // Assert
      expect(config['has_api_key'], isTrue);
      expect(config['has_Supabase_config'], isTrue);
      expect(config['custom_api_url'], equals('https://api.example.com'));
    });

    test('should get storage statistics', () async {
      // Arrange
      await storage.saveApiKey('api-key');
      await storage.saveAuthToken('auth-token');

      // Act
      final stats = await storage.getStorageStats();

      // Assert
      expect(stats['has_api_key'], isTrue);
      expect(stats['has_auth_token'], isTrue);
      expect(stats['total_items'], greaterThan(0));
    });

    test('should clear all stored data', () async {
      // Arrange
      await storage.saveApiKey('api-key');
      await storage.saveAuthToken('auth-token');
      await storage.saveSupabaseConfig({'projectId': 'test'});

      // Act
      await storage.clearAll();

      // Assert
      expect(await storage.getApiKey(), isNull);
      expect(await storage.getAuthToken(), isNull);
      expect(await storage.getSupabaseConfig(), isNull);
    });
  });
}

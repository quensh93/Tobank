import 'dart:convert';

/// Input validator for security and data integrity
///
/// Provides validation and sanitization methods to prevent injection attacks
/// and ensure data integrity.
class InputValidator {
  /// Validate JSON structure
  ///
  /// Checks if the input is valid JSON and meets basic structural requirements.
  /// Returns true if valid, throws [ValidationException] if invalid.
  static bool validateJsonStructure(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      
      // Ensure it's a Map or List
      if (decoded is! Map && decoded is! List) {
        throw ValidationException(
          'JSON must be an object or array, got ${decoded.runtimeType}',
        );
      }
      
      // Check for excessively deep nesting (potential DoS)
      if (decoded is Map) {
        _validateNestingDepth(decoded, 0, maxDepth: 50);
      } else if (decoded is List) {
        for (final item in decoded) {
          if (item is Map) {
            _validateNestingDepth(item, 0, maxDepth: 50);
          }
        }
      }
      
      return true;
    } on FormatException catch (e) {
      throw ValidationException('Invalid JSON format: ${e.message}');
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw ValidationException('JSON validation failed: $e');
    }
  }

  /// Validate nesting depth to prevent stack overflow attacks
  static void _validateNestingDepth(
    Map<dynamic, dynamic> map,
    int currentDepth, {
    required int maxDepth,
  }) {
    if (currentDepth > maxDepth) {
      throw ValidationException(
        'JSON nesting depth exceeds maximum allowed ($maxDepth levels)',
      );
    }
    
    for (final value in map.values) {
      if (value is Map) {
        _validateNestingDepth(value, currentDepth + 1, maxDepth: maxDepth);
      } else if (value is List) {
        for (final item in value) {
          if (item is Map) {
            _validateNestingDepth(item, currentDepth + 1, maxDepth: maxDepth);
          }
        }
      }
    }
  }

  /// Sanitize user input string
  ///
  /// Removes potentially dangerous characters and patterns that could be used
  /// for injection attacks.
  static String sanitizeInput(String input) {
    if (input.isEmpty) return input;
    
    String sanitized = input;
    
    // Remove HTML/XML tags
    sanitized = sanitized.replaceAll(RegExp(r'<[^>]*>'), '');
    
    // Remove script tags and content
    sanitized = sanitized.replaceAll(
      RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false),
      '',
    );
    
    // Remove javascript: protocol
    sanitized = sanitized.replaceAll(
      RegExp(r'javascript:', caseSensitive: false),
      '',
    );
    
    // Remove data: protocol (can be used for XSS)
    sanitized = sanitized.replaceAll(
      RegExp(r'data:', caseSensitive: false),
      '',
    );
    
    // Remove vbscript: protocol
    sanitized = sanitized.replaceAll(
      RegExp(r'vbscript:', caseSensitive: false),
      '',
    );
    
    // Remove on* event handlers
    sanitized = sanitized.replaceAll(
      RegExp(r'on\w+\s*=', caseSensitive: false),
      '',
    );
    
    // Trim whitespace
    sanitized = sanitized.trim();
    
    return sanitized;
  }

  /// Sanitize URL
  ///
  /// Validates and sanitizes URLs to prevent malicious redirects.
  static String? sanitizeUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    
    try {
      final uri = Uri.parse(url);
      
      // Only allow http, https, and mailto schemes
      if (!['http', 'https', 'mailto'].contains(uri.scheme.toLowerCase())) {
        return null;
      }
      
      // Remove javascript: and data: protocols
      if (url.toLowerCase().contains('javascript:') ||
          url.toLowerCase().contains('data:')) {
        return null;
      }
      
      return uri.toString();
    } catch (e) {
      // Invalid URL
      return null;
    }
  }

  /// Validate email format
  ///
  /// Checks if the input is a valid email address format.
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number format
  ///
  /// Checks if the input is a valid phone number format.
  /// Accepts various international formats.
  static bool isValidPhoneNumber(String phone) {
    if (phone.isEmpty) return false;
    
    // Remove common separators
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
    
    // Check if it contains only digits and optional + prefix
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    
    return phoneRegex.hasMatch(cleaned);
  }

  /// Validate string length
  ///
  /// Ensures string is within acceptable length bounds.
  static bool validateLength(
    String input, {
    int? minLength,
    int? maxLength,
  }) {
    if (minLength != null && input.length < minLength) {
      return false;
    }
    
    if (maxLength != null && input.length > maxLength) {
      return false;
    }
    
    return true;
  }

  /// Validate alphanumeric string
  ///
  /// Checks if string contains only letters, numbers, and optionally spaces.
  static bool isAlphanumeric(String input, {bool allowSpaces = false}) {
    if (input.isEmpty) return false;
    
    final pattern = allowSpaces ? r'^[a-zA-Z0-9\s]+$' : r'^[a-zA-Z0-9]+$';
    final regex = RegExp(pattern);
    
    return regex.hasMatch(input);
  }

  /// Validate that string doesn't contain SQL injection patterns
  ///
  /// Checks for common SQL injection patterns.
  static bool containsSqlInjection(String input) {
    if (input.isEmpty) return false;
    
    final sqlPatterns = [
      RegExp(r"('|(\\')|(--)|(/\\*)|(\\*/)|(\bOR\b)|(\bAND\b))", caseSensitive: false),
      RegExp(r'\b(SELECT|INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|EXEC|EXECUTE)\b', caseSensitive: false),
      RegExp(r'(\bUNION\b.*\bSELECT\b)', caseSensitive: false),
      RegExp(r'(\bOR\b.*=.*)', caseSensitive: false),
    ];
    
    for (final pattern in sqlPatterns) {
      if (pattern.hasMatch(input)) {
        return true;
      }
    }
    
    return false;
  }

  /// Validate that string doesn't contain XSS patterns
  ///
  /// Checks for common cross-site scripting patterns.
  static bool containsXss(String input) {
    if (input.isEmpty) return false;
    
    final xssPatterns = [
      RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'on\w+\s*=', caseSensitive: false),
      RegExp(r'<iframe[^>]*>', caseSensitive: false),
      RegExp(r'<object[^>]*>', caseSensitive: false),
      RegExp(r'<embed[^>]*>', caseSensitive: false),
    ];
    
    for (final pattern in xssPatterns) {
      if (pattern.hasMatch(input)) {
        return true;
      }
    }
    
    return false;
  }

  /// Validate JSON map structure
  ///
  /// Validates a JSON map against expected structure and constraints.
  static bool validateJsonMap(
    Map<String, dynamic> json, {
    List<String>? requiredFields,
    Map<String, Type>? fieldTypes,
    int? maxSize,
  }) {
    // Check required fields
    if (requiredFields != null) {
      for (final field in requiredFields) {
        if (!json.containsKey(field)) {
          throw ValidationException('Missing required field: $field');
        }
      }
    }
    
    // Check field types
    if (fieldTypes != null) {
      for (final entry in fieldTypes.entries) {
        final field = entry.key;
        final expectedType = entry.value;
        
        if (json.containsKey(field)) {
          final value = json[field];
          if (value != null && value.runtimeType != expectedType) {
            throw ValidationException(
              'Field "$field" has wrong type. Expected $expectedType, got ${value.runtimeType}',
            );
          }
        }
      }
    }
    
    // Check size limit
    if (maxSize != null) {
      final jsonString = jsonEncode(json);
      if (jsonString.length > maxSize) {
        throw ValidationException(
          'JSON size exceeds maximum allowed ($maxSize bytes)',
        );
      }
    }
    
    return true;
  }

  /// Escape special characters for safe display
  ///
  /// Escapes HTML special characters to prevent XSS when displaying user input.
  static String escapeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  /// Validate file path
  ///
  /// Ensures file path doesn't contain directory traversal patterns.
  static bool isValidFilePath(String path) {
    if (path.isEmpty) return false;
    
    // Check for directory traversal patterns
    if (path.contains('..') || path.contains('~')) {
      return false;
    }
    
    // Check for absolute paths (should use relative paths)
    if (path.startsWith('/') || path.contains(':\\')) {
      return false;
    }
    
    return true;
  }

  /// Validate API key format
  ///
  /// Checks if string matches expected API key format.
  static bool isValidApiKey(String apiKey) {
    if (apiKey.isEmpty) return false;
    
    // API keys should be alphanumeric with optional hyphens/underscores
    // and have a minimum length
    if (apiKey.length < 16) return false;
    
    final apiKeyRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
    return apiKeyRegex.hasMatch(apiKey);
  }

  /// Sanitize JSON map
  ///
  /// Recursively sanitizes all string values in a JSON map.
  static Map<String, dynamic> sanitizeJsonMap(Map<String, dynamic> json) {
    final sanitized = <String, dynamic>{};
    
    for (final entry in json.entries) {
      final key = entry.key;
      final value = entry.value;
      
      if (value is String) {
        sanitized[key] = sanitizeInput(value);
      } else if (value is Map<String, dynamic>) {
        sanitized[key] = sanitizeJsonMap(value);
      } else if (value is List) {
        sanitized[key] = _sanitizeList(value);
      } else {
        sanitized[key] = value;
      }
    }
    
    return sanitized;
  }

  /// Sanitize list recursively
  static List<dynamic> _sanitizeList(List<dynamic> list) {
    return list.map((item) {
      if (item is String) {
        return sanitizeInput(item);
      } else if (item is Map<String, dynamic>) {
        return sanitizeJsonMap(item);
      } else if (item is List) {
        return _sanitizeList(item);
      } else {
        return item;
      }
    }).toList();
  }
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String message;
  
  ValidationException(this.message);
  
  @override
  String toString() => 'ValidationException: $message';
}

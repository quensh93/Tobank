/// Base API exception class
///
/// All API-related exceptions should extend this class.
class ApiException implements Exception {
  /// Error message
  final String message;

  /// HTTP status code (if applicable)
  final int? statusCode;

  /// Original error that caused this exception
  final dynamic originalError;

  /// Stack trace of the original error
  final StackTrace? stackTrace;

  const ApiException(
    this.message, {
    this.statusCode,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ApiException: $message');
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (originalError != null) {
      buffer.write('\nOriginal error: $originalError');
    }
    return buffer.toString();
  }
}

/// Exception thrown when a requested screen is not found
class ScreenNotFoundException extends ApiException {
  /// The screen name that was not found
  final String screenName;

  ScreenNotFoundException(
    this.screenName, {
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          'Screen not found: $screenName',
          statusCode: 404,
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    return 'ScreenNotFoundException: Screen "$screenName" was not found';
  }
}

/// Exception thrown when there's a network-related error
class NetworkException extends ApiException {
  /// Type of network error
  final NetworkErrorType errorType;

  NetworkException(
    super.message, {
    this.errorType = NetworkErrorType.unknown,
    super.statusCode,
    super.originalError,
    super.stackTrace,
  });

  /// Create a timeout exception
  factory NetworkException.timeout({
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message ?? 'Request timed out',
      errorType: NetworkErrorType.timeout,
      statusCode: 408,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Create a connection exception
  factory NetworkException.connection({
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message ?? 'Connection failed',
      errorType: NetworkErrorType.connection,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Create a server error exception
  factory NetworkException.serverError({
    String? message,
    int? statusCode,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message ?? 'Server error',
      errorType: NetworkErrorType.serverError,
      statusCode: statusCode ?? 500,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  /// Create an unauthorized exception
  factory NetworkException.unauthorized({
    String? message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return NetworkException(
      message ?? 'Unauthorized access',
      errorType: NetworkErrorType.unauthorized,
      statusCode: 401,
      originalError: originalError,
      stackTrace: stackTrace,
    );
  }

  @override
  String toString() {
    return 'NetworkException: $message (Type: ${errorType.name})';
  }
}

/// Types of network errors
enum NetworkErrorType {
  /// Unknown error
  unknown,

  /// Connection error (no internet, DNS failure, etc.)
  connection,

  /// Request timeout
  timeout,

  /// Server error (5xx status codes)
  serverError,

  /// Unauthorized (401)
  unauthorized,

  /// Forbidden (403)
  forbidden,

  /// Bad request (400)
  badRequest,
}

/// Exception thrown when JSON validation fails
class ValidationException extends ApiException {
  /// List of validation errors
  final List<ValidationError> errors;

  ValidationException(
    this.errors, {
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          'Validation failed: ${errors.length} error(s)',
          originalError: originalError,
          stackTrace: stackTrace,
        );

  @override
  String toString() {
    final buffer = StringBuffer('ValidationException: ${errors.length} error(s)\n');
    for (final error in errors) {
      buffer.writeln('  - ${error.path}: ${error.message}');
    }
    return buffer.toString();
  }
}

/// Validation error details
class ValidationError {
  /// JSON path where the error occurred
  final String path;

  /// Error message
  final String message;

  /// The invalid value (if applicable)
  final dynamic value;

  const ValidationError({
    required this.path,
    required this.message,
    this.value,
  });

  @override
  String toString() {
    return 'ValidationError(path: $path, message: $message, value: $value)';
  }
}

/// Exception thrown when JSON parsing fails
class JsonParsingException extends ApiException {
  /// JSON path where parsing failed
  final String? jsonPath;

  JsonParsingException(
    super.message, {
    this.jsonPath,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('JsonParsingException: $message');
    if (jsonPath != null) {
      buffer.write(' at path: $jsonPath');
    }
    return buffer.toString();
  }
}

/// Exception thrown when cache operations fail
class CacheException extends ApiException {
  CacheException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() {
    return 'CacheException: $message';
  }
}

/// Base failure class for all errors in the app
abstract class Failure {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const Failure({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          statusCode == other.statusCode;

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

/// Server failure when API returns an error
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Network failure when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.originalError,
  });
}

/// Cache failure when local data operations fail
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.originalError,
  });
}

/// Validation failure when input validation fails
class ValidationFailure extends Failure {
  final Map<String, String>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
    super.originalError,
  });
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Permission failure
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.originalError,
  });
}

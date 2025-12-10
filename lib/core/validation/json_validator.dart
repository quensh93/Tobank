/// Abstract interface for JSON validation
///
/// Provides a contract for validating JSON structures against specific schemas
/// or business rules. Implementations should validate JSON data and return
/// detailed validation results including any errors found.
abstract class JsonValidator {
  /// Validates the provided JSON data
  ///
  /// Returns a [ValidationResult] containing the validation status and any
  /// errors found during validation.
  ValidationResult validate(Map<String, dynamic> json);

  /// Gets the list of validation errors from the last validation
  ///
  /// Returns an empty list if no validation has been performed or if the
  /// last validation was successful.
  List<ValidationError> getErrors();

  /// Checks if the last validation was successful
  ///
  /// Returns true if no errors were found, false otherwise.
  bool isValid();
}

/// Result of a JSON validation operation
class ValidationResult {
  /// Whether the validation was successful
  final bool isValid;

  /// List of validation errors found
  final List<ValidationError> errors;

  /// Optional warnings that don't prevent validation success
  final List<ValidationWarning> warnings;

  /// Timestamp when validation was performed
  final DateTime timestamp;

  ValidationResult({
    required this.isValid,
    required this.errors,
    this.warnings = const [],
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Creates a successful validation result
  factory ValidationResult.success({
    List<ValidationWarning> warnings = const [],
  }) {
    return ValidationResult(
      isValid: true,
      errors: const [],
      warnings: warnings,
      timestamp: DateTime.now(),
    );
  }

  /// Creates a failed validation result
  factory ValidationResult.failure({
    required List<ValidationError> errors,
    List<ValidationWarning> warnings = const [],
  }) {
    return ValidationResult(
      isValid: false,
      errors: errors,
      warnings: warnings,
      timestamp: DateTime.now(),
    );
  }

  /// Returns a summary of the validation result
  String get summary {
    if (isValid) {
      return warnings.isEmpty
          ? 'Validation successful'
          : 'Validation successful with ${warnings.length} warning(s)';
    }
    return 'Validation failed with ${errors.length} error(s)';
  }

  @override
  String toString() => summary;
}

/// Represents a validation error
class ValidationError {
  /// JSON path where the error occurred (e.g., 'root.children[0].type')
  final String path;

  /// Human-readable error message
  final String message;

  /// The actual value that caused the error (optional)
  final dynamic value;

  /// Error code for programmatic handling (optional)
  final String? code;

  /// Suggested fix for the error (optional)
  final String? suggestion;

  const ValidationError({
    required this.path,
    required this.message,
    this.value,
    this.code,
    this.suggestion,
  });

  /// Creates a formatted error message
  String get formattedMessage {
    final buffer = StringBuffer();
    buffer.write('[$path] $message');
    if (value != null) {
      buffer.write(' (value: $value)');
    }
    if (suggestion != null) {
      buffer.write('\n  Suggestion: $suggestion');
    }
    return buffer.toString();
  }

  @override
  String toString() => formattedMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationError &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          message == other.message &&
          value == other.value &&
          code == other.code;

  @override
  int get hashCode =>
      path.hashCode ^ message.hashCode ^ value.hashCode ^ code.hashCode;
}

/// Represents a validation warning (non-critical issue)
class ValidationWarning {
  /// JSON path where the warning occurred
  final String path;

  /// Human-readable warning message
  final String message;

  /// The value that triggered the warning (optional)
  final dynamic value;

  /// Warning code for programmatic handling (optional)
  final String? code;

  const ValidationWarning({
    required this.path,
    required this.message,
    this.value,
    this.code,
  });

  /// Creates a formatted warning message
  String get formattedMessage {
    final buffer = StringBuffer();
    buffer.write('[$path] $message');
    if (value != null) {
      buffer.write(' (value: $value)');
    }
    return buffer.toString();
  }

  @override
  String toString() => formattedMessage;
}

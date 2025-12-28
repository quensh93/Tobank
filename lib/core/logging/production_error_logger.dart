/// Production error logging service
///
/// This service handles error logging for production environments,
/// integrating with error monitoring services like Sentry or crash reporting services.
/// It ensures errors are logged without exposing sensitive information.
library;

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../config/environment_config.dart';
import '../config/feature_flags.dart';

/// Error severity levels
enum ErrorSeverity {
  debug,
  info,
  warning,
  error,
  fatal;

  String get name {
    switch (this) {
      case ErrorSeverity.debug:
        return 'debug';
      case ErrorSeverity.info:
        return 'info';
      case ErrorSeverity.warning:
        return 'warning';
      case ErrorSeverity.error:
        return 'error';
      case ErrorSeverity.fatal:
        return 'fatal';
    }
  }
}

/// Error context for additional information
class ErrorContext {
  final Map<String, dynamic> data;
  final String? userId;
  final String? screenName;
  final String? feature;

  const ErrorContext({
    this.data = const {},
    this.userId,
    this.screenName,
    this.feature,
  });

  /// Convert to map for logging
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      if (userId != null) 'userId': userId,
      if (screenName != null) 'screenName': screenName,
      if (feature != null) 'feature': feature,
    };
  }
}

/// Production error logger
class ProductionErrorLogger {
  /// Private constructor for singleton
  ProductionErrorLogger._();

  /// Singleton instance
  static final ProductionErrorLogger instance = ProductionErrorLogger._();

  /// Initialize error logging
  ///
  /// This should be called early in the app lifecycle, typically in main()
  static Future<void> initialize() async {
    if (!FeatureFlags.current.isCrashReportingEnabled) {
      debugPrint('Production error logging disabled');
      return;
    }

    // Initialize error monitoring service
    // Error monitoring service integration point
    debugPrint('Production error logging initialized');

    // Set up Flutter error handler
    FlutterError.onError = (FlutterErrorDetails details) {
      instance.logFlutterError(details);
    };

    // Set up platform error handler
    PlatformDispatcher.instance.onError = (error, stack) {
      instance.logError(
        error,
        stackTrace: stack,
        severity: ErrorSeverity.fatal,
      );
      return true;
    };
  }

  /// Log an error
  void logError(
    dynamic error, {
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.error,
    ErrorContext? context,
    String? message,
  }) {
    // Don't log in development unless explicitly enabled
    if (EnvironmentConfig.current.isDevelopment &&
        !FeatureFlags.current.isCrashReportingEnabled) {
      debugPrint('Error (not logged): $error');
      return;
    }

    // Sanitize error data
    final sanitizedError = _sanitizeError(error);
    final sanitizedContext = _sanitizeContext(context);

    // Log to console in debug mode
    if (kDebugMode) {
      debugPrint('=== Error Logged ===');
      debugPrint('Severity: ${severity.name}');
      debugPrint('Message: $message');
      debugPrint('Error: $sanitizedError');
      debugPrint('Stack: $stackTrace');
      debugPrint('Context: ${sanitizedContext?.toMap()}');
      debugPrint('===================');
    }

    // Send to error monitoring service
    // Example for Sentry:
    // Sentry.captureException(
    //   sanitizedError,
    //   stackTrace: stackTrace,
    //   hint: Hint.withMap({
    //     'severity': severity.name,
    //     'message': message,
    //     'context': sanitizedContext?.toMap(),
    //   }),
    // );

    // Example for crash reporting services:
    // CrashReportingService.instance.recordError(
    //   sanitizedError,
    //   stackTrace,
    //   reason: message,
    //   information: sanitizedContext?.toMap().entries.map((e) => '${e.key}: ${e.value}').toList(),
    //   fatal: severity == ErrorSeverity.fatal,
    // );
  }

  /// Log a Flutter framework error
  void logFlutterError(FlutterErrorDetails details) {
    // Log to console in debug mode
    if (kDebugMode) {
      FlutterError.presentError(details);
    }

    logError(
      details.exception,
      stackTrace: details.stack,
      severity: details.silent ? ErrorSeverity.warning : ErrorSeverity.error,
      context: ErrorContext(
        data: {
          'library': details.library ?? 'unknown',
          'context': details.context?.toString() ?? 'unknown',
        },
      ),
      message: details.summary.toString(),
    );
  }

  /// Log a message with context
  void logMessage(
    String message, {
    ErrorSeverity severity = ErrorSeverity.info,
    ErrorContext? context,
  }) {
    if (!FeatureFlags.current.isCrashReportingEnabled) {
      return;
    }

    final sanitizedContext = _sanitizeContext(context);

    if (kDebugMode) {
      debugPrint('[$severity] $message');
      if (sanitizedContext != null) {
        debugPrint('Context: ${sanitizedContext.toMap()}');
      }
    }

    // Send to error monitoring service
    // Example for Sentry:
    // Sentry.captureMessage(
    //   message,
    //   level: _mapSeverityToSentryLevel(severity),
    //   hint: Hint.withMap({
    //     'context': sanitizedContext?.toMap(),
    //   }),
    // );
  }

  /// Set user context for error logging
  void setUserContext({
    required String userId,
    String? email,
    String? username,
    Map<String, dynamic>? additionalData,
  }) {
    if (!FeatureFlags.current.isCrashReportingEnabled) {
      return;
    }

    // Sanitize user data
    final sanitizedData = _sanitizeMap(additionalData ?? {});

    if (kDebugMode) {
      debugPrint('User context set: $userId');
      debugPrint('Additional data: $sanitizedData');
    }

    // Set user context in error monitoring service
    // Example for Sentry:
    // Sentry.configureScope((scope) {
    //   scope.setUser(SentryUser(
    //     id: userId,
    //     email: email,
    //     username: username,
    //     data: sanitizedData,
    //   ));
    // });

    // Example for crash reporting services:
    // CrashReportingService.instance.setUserIdentifier(userId);
    // if (email != null) {
    //   CrashReportingService.instance.setCustomKey('email', email);
    // }
    // if (username != null) {
    //   CrashReportingService.instance.setCustomKey('username', username);
    // }
  }

  /// Clear user context
  void clearUserContext() {
    if (!FeatureFlags.current.isCrashReportingEnabled) {
      return;
    }

    // Clear user context in error monitoring service
    // Example for Sentry:
    // Sentry.configureScope((scope) {
    //   scope.setUser(null);
    // });

    // Example for crash reporting services:
    // CrashReportingService.instance.setUserIdentifier('');
  }

  /// Add breadcrumb for debugging
  void addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
  }) {
    if (!FeatureFlags.current.isCrashReportingEnabled) {
      return;
    }

    final sanitizedData = _sanitizeMap(data ?? {});

    if (kDebugMode) {
      debugPrint('Breadcrumb: [$category] $message');
      debugPrint('Data: $sanitizedData');
    }

    // Add breadcrumb to error monitoring service
    // Example for Sentry:
    // Sentry.addBreadcrumb(Breadcrumb(
    //   message: message,
    //   category: category,
    //   data: sanitizedData,
    //   timestamp: DateTime.now(),
    // ));

    // Example for crash reporting services:
    // CrashReportingService.instance.log('[$category] $message');
  }

  /// Sanitize error to remove sensitive information
  dynamic _sanitizeError(dynamic error) {
    if (error == null) return null;

    // Convert error to string and sanitize
    final errorString = error.toString();
    return _sanitizeString(errorString);
  }

  /// Sanitize context to remove sensitive information
  ErrorContext? _sanitizeContext(ErrorContext? context) {
    if (context == null) return null;

    return ErrorContext(
      data: _sanitizeMap(context.data),
      userId: context.userId != null ? _sanitizeUserId(context.userId!) : null,
      screenName: context.screenName,
      feature: context.feature,
    );
  }

  /// Sanitize a map to remove sensitive keys
  Map<String, dynamic> _sanitizeMap(Map<String, dynamic> map) {
    final sanitized = <String, dynamic>{};

    for (final entry in map.entries) {
      final key = entry.key.toLowerCase();

      // Skip sensitive keys
      if (_isSensitiveKey(key)) {
        sanitized[entry.key] = '[REDACTED]';
        continue;
      }

      // Recursively sanitize nested maps
      if (entry.value is Map<String, dynamic>) {
        sanitized[entry.key] = _sanitizeMap(
          entry.value as Map<String, dynamic>,
        );
      } else if (entry.value is String) {
        sanitized[entry.key] = _sanitizeString(entry.value as String);
      } else {
        sanitized[entry.key] = entry.value;
      }
    }

    return sanitized;
  }

  /// Check if a key is sensitive
  bool _isSensitiveKey(String key) {
    const sensitiveKeys = [
      'password',
      'token',
      'secret',
      'api_key',
      'apikey',
      'auth',
      'authorization',
      'credit_card',
      'creditcard',
      'ssn',
      'social_security',
      'pin',
      'cvv',
      'card_number',
      'account_number',
    ];

    return sensitiveKeys.any((sensitive) => key.contains(sensitive));
  }

  /// Sanitize a string to remove sensitive patterns
  String _sanitizeString(String value) {
    // Remove email addresses
    value = value.replaceAll(
      RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'),
      '[EMAIL]',
    );

    // Remove phone numbers
    value = value.replaceAll(
      RegExp(r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b'),
      '[PHONE]',
    );

    // Remove credit card numbers
    value = value.replaceAll(
      RegExp(r'\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b'),
      '[CARD]',
    );

    // Remove tokens (long alphanumeric strings)
    value = value.replaceAll(RegExp(r'\b[A-Za-z0-9]{32,}\b'), '[TOKEN]');

    return value;
  }

  /// Sanitize user ID (keep first 4 characters)
  String _sanitizeUserId(String userId) {
    if (userId.length <= 4) return userId;
    return '${userId.substring(0, 4)}***';
  }
}

/// Convenience methods for error logging
extension ErrorLogging on Object {
  /// Log this object as an error
  void logAsError({
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.error,
    ErrorContext? context,
    String? message,
  }) {
    ProductionErrorLogger.instance.logError(
      this,
      stackTrace: stackTrace,
      severity: severity,
      context: context,
      message: message,
    );
  }
}

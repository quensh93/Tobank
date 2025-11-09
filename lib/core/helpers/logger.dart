import 'package:logger/logger.dart';

/// Centralized logger for the application
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Log debug message
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log info message
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    // Handle the case where error is actually a StackTrace
    if (error is StackTrace) {
      _logger.e(message, stackTrace: error);
    } else {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log fatal message
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    // Handle the case where error is actually a StackTrace
    if (error is StackTrace) {
      _logger.f(message, stackTrace: error);
    } else {
      _logger.f(message, error: error, stackTrace: stackTrace);
    }
  }
}
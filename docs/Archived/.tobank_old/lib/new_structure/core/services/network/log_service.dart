import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// Abstract LogService interface
abstract class LogService {
  int logRequest({
    required String method,
    required String url,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
    required dynamic data,
    required bool requireBase64EncodedBody,
  });

  void logResponse({
    required int id,
    required int statusCode,
    required dynamic data,
    required Map<String, dynamic>? headers,
  });

  void logError({
    required int id,
    required String type,
    required String displayMessage,
    required int displayCode,
    required int? statusCode,
    required Map<String, dynamic>? headers,
    required dynamic data,
  });
}

// Register ApiLogService as the implementation of LogService
@LazySingleton(as: LogService)
class ApiLogService implements LogService {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // No call stack for debug logs
      errorMethodCount: 5, // Stack trace for errors
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true, // Include timestamp for clarity
      stackTraceBeginIndex: 999, // Disable stack trace for debug
      noBoxingByDefault: false,
    ),
    level: Level.debug,
  );

  @override
  int logRequest({
    required String method,
    required String url,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
    required dynamic data,
    required bool requireBase64EncodedBody,
  }) {
    final logId = DateTime.now().millisecondsSinceEpoch;
    _logger.d(
        '🌐 [$logId] REQUEST [$method] $url\n'
        '🔍 Query: $queryParameters\n'
        '📋 Headers: $headers\n'
        '📦 Data: $data\n'
        '🔐 Base64: $requireBase64EncodedBody');
    return logId;
  }

  @override
  void logResponse({
    required int id,
    required int statusCode,
    required dynamic data,
    required Map<String, dynamic>? headers,
  }) {
    _logger.i('✅ [$id] RESPONSE [$statusCode]\n'
        '📋 Headers: $headers\n'
        '📦 Data: $data');
  }

  @override
  void logError({
    required int id,
    required String type,
    required String displayMessage,
    required int displayCode,
    required int? statusCode,
    required Map<String, dynamic>? headers,
    required dynamic data,
  }) {
    _logger.e('❌ [$id] ERROR [$type]\n'
        '💬 Message: $displayMessage\n'
        '🔢 Code: $displayCode\n'
        '📡 Status: $statusCode\n'
        '📋 Headers: $headers\n'
        '📦 Data: $data');
  }
}
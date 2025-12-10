import 'package:uuid/uuid.dart';

import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/core/logging/stac_log_models.dart';

/// STAC-specific logger for tracking server-driven UI operations
///
/// This logger integrates with the existing AppLogger to provide structured
/// logging for STAC operations including screen fetching, JSON parsing,
/// component rendering, and errors.
///
/// All logs are stored in memory for display in the debug panel and also
/// forwarded to the AppLogger for console output.
class StacLogger {
  /// Singleton instance
  static final StacLogger instance = StacLogger._();

  StacLogger._();

  /// UUID generator for log entry IDs
  static const _uuid = Uuid();

  /// In-memory storage of log entries for debug panel
  final List<StacLogEntry> _logEntries = [];

  /// Maximum number of log entries to keep in memory
  static const int _maxLogEntries = 1000;

  /// Get all log entries
  List<StacLogEntry> get logEntries => List.unmodifiable(_logEntries);

  /// Get log entries filtered by operation type
  List<StacLogEntry> getLogsByType(StacOperationType type) {
    return _logEntries.where((entry) => entry.operationType == type).toList();
  }

  /// Get log entries filtered by API source
  List<StacLogEntry> getLogsBySource(ApiSource source) {
    return _logEntries
        .where((entry) => entry.source == source)
        .toList();
  }

  /// Get log entries for a specific screen
  List<StacLogEntry> getLogsByScreen(String screenName) {
    return _logEntries
        .where((entry) => entry.screenName == screenName)
        .toList();
  }

  /// Get error log entries
  List<StacLogEntry> getErrors() {
    return _logEntries
        .where((entry) => entry.isError)
        .toList();
  }

  /// Get slow operation log entries (>100ms)
  List<StacLogEntry> getSlowOperations() {
    return _logEntries
        .where((entry) => entry.isSlow)
        .toList();
  }

  /// Clear all log entries
  void clearLogs() {
    _logEntries.clear();
  }

  /// Add a log entry to the in-memory storage
  void _addLogEntry(StacLogEntry entry) {
    _logEntries.add(entry);

    // Keep only the most recent entries
    if (_logEntries.length > _maxLogEntries) {
      _logEntries.removeAt(0);
    }
  }

  /// Log a screen fetch operation
  ///
  /// [screenName] - Name of the screen being fetched
  /// [source] - Source of the data (mock, supabase, custom)
  /// [duration] - Time taken to fetch the screen
  /// [jsonSize] - Size of the JSON data in bytes
  /// [additionalMetadata] - Any additional metadata to include
  static void logScreenFetch({
    required String screenName,
    required ApiSource source,
    required Duration duration,
    required int jsonSize,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final metadata = {
      'source': source.name,
      'duration_ms': duration.inMilliseconds,
      'size_kb': (jsonSize / 1024).toStringAsFixed(2),
      ...?additionalMetadata,
    };

    final entry = StacLogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      operationType: StacOperationType.fetch,
      screenName: screenName,
      source: source,
      duration: duration,
      metadata: metadata,
    );

    instance._addLogEntry(entry);

    // Log to console via AppLogger
    AppLogger.i(
      '📱 STAC Screen Fetch: $screenName',
      metadata,
    );

    // Warn if slow
    if (duration.inMilliseconds > 1000) {
      AppLogger.w(
        'Slow screen fetch detected: $screenName took ${duration.inMilliseconds}ms',
      );
    }
  }

  /// Log JSON parsing operation
  ///
  /// [screenName] - Name of the screen being parsed
  /// [widgetTypes] - List of widget types found in the JSON
  /// [duration] - Time taken to parse the JSON
  /// [warnings] - Any validation warnings encountered
  /// [additionalMetadata] - Any additional metadata to include
  static void logJsonParsing({
    required String screenName,
    required List<String> widgetTypes,
    required Duration duration,
    List<String>? warnings,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final metadata = {
      'widgets': widgetTypes.join(', '),
      'widget_count': widgetTypes.length,
      'duration_ms': duration.inMilliseconds,
      'warnings': warnings?.join('; ') ?? 'none',
      ...?additionalMetadata,
    };

    final entry = StacLogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      operationType: StacOperationType.parse,
      screenName: screenName,
      duration: duration,
      metadata: metadata,
    );

    instance._addLogEntry(entry);

    // Log to console via AppLogger
    AppLogger.i(
      '🔄 STAC JSON Parsing: $screenName',
      metadata,
    );

    // Log warnings if any
    if (warnings != null && warnings.isNotEmpty) {
      AppLogger.w(
        'JSON parsing warnings for $screenName: ${warnings.join(", ")}',
      );
    }

    // Warn if slow
    if (duration.inMilliseconds > 100) {
      AppLogger.w(
        'Slow JSON parsing detected: $screenName took ${duration.inMilliseconds}ms',
      );
    }
  }

  /// Log component rendering operation
  ///
  /// [componentType] - Type of component being rendered
  /// [properties] - Properties of the component
  /// [duration] - Time taken to render the component
  /// [screenName] - Name of the screen containing the component
  /// [additionalMetadata] - Any additional metadata to include
  static void logComponentRender({
    required String componentType,
    required Map<String, dynamic> properties,
    required Duration duration,
    String? screenName,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final metadata = {
      'type': componentType,
      'properties': properties.keys.join(', '),
      'property_count': properties.length,
      'duration_ms': duration.inMilliseconds,
      ...?additionalMetadata,
    };

    final entry = StacLogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      operationType: StacOperationType.render,
      screenName: screenName ?? 'unknown',
      duration: duration,
      metadata: metadata,
    );

    instance._addLogEntry(entry);

    // Log to console via AppLogger (debug level for renders)
    AppLogger.d(
      '🎨 STAC Component Render: $componentType',
      metadata,
    );

    // Warn if slow (>16ms = 60fps threshold)
    if (duration.inMilliseconds > 16) {
      AppLogger.w(
        'Slow component render detected: $componentType took ${duration.inMilliseconds}ms',
      );
    }
  }

  /// Log a warning during STAC operation
  ///
  /// [operation] - Name of the operation that generated the warning
  /// [message] - Warning message
  /// [screenName] - Name of the screen where warning occurred
  /// [jsonPath] - Path in JSON where warning occurred (if applicable)
  /// [additionalMetadata] - Any additional metadata to include
  static void logWarning({
    required String operation,
    required String message,
    String? screenName,
    String? jsonPath,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final metadata = {
      'operation': operation,
      'message': message,
      'json_path': jsonPath ?? 'unknown',
      ...?additionalMetadata,
    };

    // Log to console via AppLogger
    AppLogger.w(
      '⚠️ STAC Warning: $operation - $message',
      metadata,
    );
  }

  /// Log an error during STAC operation
  ///
  /// [operation] - Name of the operation that failed
  /// [error] - Error message or exception
  /// [screenName] - Name of the screen where error occurred
  /// [jsonPath] - Path in JSON where error occurred (if applicable)
  /// [suggestion] - Suggested fix for the error
  /// [stackTrace] - Stack trace of the error
  /// [additionalMetadata] - Any additional metadata to include
  static void logError({
    required String operation,
    required dynamic error,
    String? screenName,
    String? jsonPath,
    String? suggestion,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalMetadata,
  }) {
    final errorMessage = error.toString();
    final metadata = {
      'operation': operation,
      'error': errorMessage,
      'json_path': jsonPath ?? 'unknown',
      'suggestion': suggestion ?? 'Check JSON structure and STAC documentation',
      ...?additionalMetadata,
    };

    final entry = StacLogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      operationType: StacOperationType.error,
      screenName: screenName ?? 'unknown',
      duration: Duration.zero,
      metadata: metadata,
      error: errorMessage,
      suggestion: suggestion,
    );

    instance._addLogEntry(entry);

    // Log to console via AppLogger
    AppLogger.e(
      '❌ STAC Error: $operation',
      metadata,
      stackTrace,
    );
  }

  /// Log a generic STAC operation with custom metadata
  ///
  /// This is useful for logging custom operations not covered by the
  /// specific logging methods above.
  static void logCustomOperation({
    required String screenName,
    required StacOperationType operationType,
    required Duration duration,
    ApiSource? source,
    Map<String, dynamic>? metadata,
    String? error,
    String? suggestion,
  }) {
    final entry = StacLogEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      operationType: operationType,
      screenName: screenName,
      source: source,
      duration: duration,
      metadata: metadata ?? {},
      error: error,
      suggestion: suggestion,
    );

    instance._addLogEntry(entry);

    // Log to console via AppLogger
    final level = operationType == StacOperationType.error
        ? AppLogger.e
        : AppLogger.i;

    level(
      '${entry.emoji} STAC ${entry.operationName}: $screenName',
      metadata,
    );
  }

  /// Get statistics about logged operations
  Map<String, dynamic> getStatistics() {
    final totalLogs = _logEntries.length;
    final fetchLogs = getLogsByType(StacOperationType.fetch).length;
    final parseLogs = getLogsByType(StacOperationType.parse).length;
    final renderLogs = getLogsByType(StacOperationType.render).length;
    final errorLogs = getErrors().length;
    final slowOps = getSlowOperations().length;

    final avgFetchDuration = _calculateAverageDuration(
      getLogsByType(StacOperationType.fetch),
    );
    final avgParseDuration = _calculateAverageDuration(
      getLogsByType(StacOperationType.parse),
    );
    final avgRenderDuration = _calculateAverageDuration(
      getLogsByType(StacOperationType.render),
    );

    return {
      'total_logs': totalLogs,
      'fetch_count': fetchLogs,
      'parse_count': parseLogs,
      'render_count': renderLogs,
      'error_count': errorLogs,
      'slow_operations': slowOps,
      'avg_fetch_duration_ms': avgFetchDuration,
      'avg_parse_duration_ms': avgParseDuration,
      'avg_render_duration_ms': avgRenderDuration,
    };
  }

  /// Calculate average duration for a list of log entries
  double _calculateAverageDuration(List<StacLogEntry> entries) {
    if (entries.isEmpty) return 0.0;

    final totalMs = entries.fold<int>(
      0,
      (sum, entry) => sum + entry.duration.inMilliseconds,
    );

    return totalMs / entries.length;
  }
}

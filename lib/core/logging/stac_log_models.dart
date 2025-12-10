/// STAC-specific log models for tracking server-driven UI operations
///
/// This file defines the data models used for logging STAC operations including
/// screen fetching, JSON parsing, component rendering, and errors.
library;

/// Type of STAC operation being logged
enum StacOperationType {
  /// Fetching screen JSON from API
  fetch,

  /// Parsing JSON into widget models
  parse,

  /// Rendering components to UI
  render,

  /// Error occurred during STAC operation
  error,
}

/// Source of the API data
enum ApiSource {
  /// Mock data from local assets
  mock,

  /// Data from Supabase
  supabase,

  /// Data from custom REST API
  custom,
}

/// A single log entry for a STAC operation
class StacLogEntry {
  /// Unique identifier for this log entry
  final String id;

  /// Timestamp when the operation occurred
  final DateTime timestamp;

  /// Type of operation (fetch, parse, render, error)
  final StacOperationType operationType;

  /// Name of the screen being operated on
  final String screenName;

  /// Source of the API data (mock, supabase, custom)
  final ApiSource? source;

  /// Duration of the operation
  final Duration duration;

  /// Additional metadata about the operation
  final Map<String, dynamic> metadata;

  /// Error message if operation failed
  final String? error;

  /// Suggested fix for the error
  final String? suggestion;

  const StacLogEntry({
    required this.id,
    required this.timestamp,
    required this.operationType,
    required this.screenName,
    this.source,
    required this.duration,
    this.metadata = const {},
    this.error,
    this.suggestion,
  });

  /// Whether this log entry represents an error
  bool get isError => operationType == StacOperationType.error;

  /// Whether this operation took longer than expected (>100ms)
  bool get isSlow => duration.inMilliseconds > 100;

  /// Formatted duration string (e.g., "123ms")
  String get formattedDuration => '${duration.inMilliseconds}ms';

  /// Get a color-coded emoji for the operation type
  String get emoji {
    switch (operationType) {
      case StacOperationType.fetch:
        return '📱';
      case StacOperationType.parse:
        return '🔄';
      case StacOperationType.render:
        return '🎨';
      case StacOperationType.error:
        return '❌';
    }
  }

  /// Get a human-readable operation name
  String get operationName {
    switch (operationType) {
      case StacOperationType.fetch:
        return 'Screen Fetch';
      case StacOperationType.parse:
        return 'JSON Parsing';
      case StacOperationType.render:
        return 'Component Render';
      case StacOperationType.error:
        return 'Error';
    }
  }

  /// Convert to a map for logging
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'operation_type': operationType.name,
      'screen_name': screenName,
      'source': source?.name,
      'duration_ms': duration.inMilliseconds,
      'metadata': metadata,
      'error': error,
      'suggestion': suggestion,
    };
  }

  /// Create a copy with updated fields
  StacLogEntry copyWith({
    String? id,
    DateTime? timestamp,
    StacOperationType? operationType,
    String? screenName,
    ApiSource? source,
    Duration? duration,
    Map<String, dynamic>? metadata,
    String? error,
    String? suggestion,
  }) {
    return StacLogEntry(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      operationType: operationType ?? this.operationType,
      screenName: screenName ?? this.screenName,
      source: source ?? this.source,
      duration: duration ?? this.duration,
      metadata: metadata ?? this.metadata,
      error: error ?? this.error,
      suggestion: suggestion ?? this.suggestion,
    );
  }

  @override
  String toString() {
    return 'StacLogEntry(id: $id, operation: ${operationType.name}, '
        'screen: $screenName, duration: $formattedDuration)';
  }
}

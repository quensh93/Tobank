import 'dart:async';
import 'package:flutter/foundation.dart';

/// Monitors and tracks performance metrics for STAC operations
/// 
/// Tracks:
/// - JSON parsing time
/// - API call duration
/// - Widget build time
/// - Slow operations
class PerformanceMonitor {
  PerformanceMonitor._();
  
  static final PerformanceMonitor instance = PerformanceMonitor._();
  
  final List<PerformanceMetric> _metrics = [];
  final Map<String, Stopwatch> _activeTimers = {};
  
  /// Maximum number of metrics to keep in memory
  static const int maxMetricsCount = 1000;
  
  /// Threshold for slow JSON parsing (milliseconds)
  static const int slowJsonParsingThreshold = 100;
  
  /// Threshold for slow API calls (milliseconds)
  static const int slowApiCallThreshold = 1000;
  
  /// Threshold for slow widget builds (milliseconds)
  /// 16ms = 60fps, 8ms = 120fps
  static const int slowWidgetBuildThreshold = 16;
  
  /// Start tracking an operation
  void startTracking(String operationId, PerformanceMetricType type) {
    _activeTimers[operationId] = Stopwatch()..start();
  }
  
  /// Stop tracking an operation and record the metric
  void stopTracking(
    String operationId, {
    Map<String, dynamic>? metadata,
  }) {
    final stopwatch = _activeTimers.remove(operationId);
    if (stopwatch == null) {
      debugPrint('Warning: No active timer found for $operationId');
      return;
    }
    
    stopwatch.stop();
    final duration = stopwatch.elapsed;
    
    // Determine type from operation ID or metadata
    final type = _determineType(operationId, metadata);
    
    _recordMetric(
      type: type,
      operationId: operationId,
      duration: duration,
      metadata: metadata,
    );
  }
  
  /// Track JSON parsing performance
  Future<T> trackJsonParsing<T>(
    String screenName,
    Future<T> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await operation();
      stopwatch.stop();
      
      _recordMetric(
        type: PerformanceMetricType.jsonParsing,
        operationId: 'json_parse_$screenName',
        duration: stopwatch.elapsed,
        metadata: {'screenName': screenName},
      );
      
      if (stopwatch.elapsedMilliseconds > slowJsonParsingThreshold) {
        _logSlowOperation(
          'JSON Parsing',
          screenName,
          stopwatch.elapsed,
        );
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      _recordMetric(
        type: PerformanceMetricType.jsonParsing,
        operationId: 'json_parse_$screenName',
        duration: stopwatch.elapsed,
        metadata: {'screenName': screenName, 'error': e.toString()},
        failed: true,
      );
      rethrow;
    }
  }
  
  /// Track API call performance
  Future<T> trackApiCall<T>(
    String endpoint,
    Future<T> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await operation();
      stopwatch.stop();
      
      _recordMetric(
        type: PerformanceMetricType.apiCall,
        operationId: 'api_call_$endpoint',
        duration: stopwatch.elapsed,
        metadata: {'endpoint': endpoint},
      );
      
      if (stopwatch.elapsedMilliseconds > slowApiCallThreshold) {
        _logSlowOperation(
          'API Call',
          endpoint,
          stopwatch.elapsed,
        );
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      _recordMetric(
        type: PerformanceMetricType.apiCall,
        operationId: 'api_call_$endpoint',
        duration: stopwatch.elapsed,
        metadata: {'endpoint': endpoint, 'error': e.toString()},
        failed: true,
      );
      rethrow;
    }
  }
  
  /// Track widget build performance
  T trackWidgetBuild<T>(
    String widgetType,
    T Function() operation,
  ) {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = operation();
      stopwatch.stop();
      
      _recordMetric(
        type: PerformanceMetricType.widgetBuild,
        operationId: 'widget_build_$widgetType',
        duration: stopwatch.elapsed,
        metadata: {'widgetType': widgetType},
      );
      
      if (stopwatch.elapsedMilliseconds > slowWidgetBuildThreshold) {
        _logSlowOperation(
          'Widget Build',
          widgetType,
          stopwatch.elapsed,
        );
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      _recordMetric(
        type: PerformanceMetricType.widgetBuild,
        operationId: 'widget_build_$widgetType',
        duration: stopwatch.elapsed,
        metadata: {'widgetType': widgetType, 'error': e.toString()},
        failed: true,
      );
      rethrow;
    }
  }
  
  /// Get all recorded metrics
  List<PerformanceMetric> getMetrics({
    PerformanceMetricType? type,
    Duration? minDuration,
    bool? failed,
  }) {
    var filtered = _metrics.toList();
    
    if (type != null) {
      filtered = filtered.where((m) => m.type == type).toList();
    }
    
    if (minDuration != null) {
      filtered = filtered.where((m) => m.duration >= minDuration).toList();
    }
    
    if (failed != null) {
      filtered = filtered.where((m) => m.failed == failed).toList();
    }
    
    return filtered;
  }
  
  /// Get slow operations
  List<PerformanceMetric> getSlowOperations() {
    return _metrics.where((m) {
      switch (m.type) {
        case PerformanceMetricType.jsonParsing:
          return m.duration.inMilliseconds > slowJsonParsingThreshold;
        case PerformanceMetricType.apiCall:
          return m.duration.inMilliseconds > slowApiCallThreshold;
        case PerformanceMetricType.widgetBuild:
          return m.duration.inMilliseconds > slowWidgetBuildThreshold;
        case PerformanceMetricType.other:
          return m.duration.inMilliseconds > 100;
      }
    }).toList();
  }
  
  /// Get performance statistics
  PerformanceStats getStats({PerformanceMetricType? type}) {
    final metrics = type != null
        ? _metrics.where((m) => m.type == type).toList()
        : _metrics;
    
    if (metrics.isEmpty) {
      return PerformanceStats.empty();
    }
    
    final durations = metrics.map((m) => m.duration.inMilliseconds).toList();
    durations.sort();
    
    final total = durations.reduce((a, b) => a + b);
    final average = total / durations.length;
    
    final median = durations.length.isOdd
        ? durations[durations.length ~/ 2].toDouble()
        : (durations[durations.length ~/ 2 - 1] +
                durations[durations.length ~/ 2]) /
            2;
    
    final p95Index = (durations.length * 0.95).floor();
    final p95 = durations[p95Index].toDouble();
    
    final p99Index = (durations.length * 0.99).floor();
    final p99 = durations[p99Index].toDouble();
    
    final slowCount = metrics.where((m) {
      switch (m.type) {
        case PerformanceMetricType.jsonParsing:
          return m.duration.inMilliseconds > slowJsonParsingThreshold;
        case PerformanceMetricType.apiCall:
          return m.duration.inMilliseconds > slowApiCallThreshold;
        case PerformanceMetricType.widgetBuild:
          return m.duration.inMilliseconds > slowWidgetBuildThreshold;
        case PerformanceMetricType.other:
          return m.duration.inMilliseconds > 100;
      }
    }).length;
    
    final failedCount = metrics.where((m) => m.failed).length;
    
    return PerformanceStats(
      totalOperations: metrics.length,
      averageDuration: average,
      medianDuration: median,
      minDuration: durations.first.toDouble(),
      maxDuration: durations.last.toDouble(),
      p95Duration: p95,
      p99Duration: p99,
      slowOperations: slowCount,
      failedOperations: failedCount,
    );
  }
  
  /// Clear all metrics
  void clear() {
    _metrics.clear();
    _activeTimers.clear();
  }
  
  /// Clear old metrics (keep only recent ones)
  void clearOldMetrics({Duration? olderThan}) {
    final cutoff = DateTime.now().subtract(olderThan ?? const Duration(hours: 1));
    _metrics.removeWhere((m) => m.timestamp.isBefore(cutoff));
  }
  
  void _recordMetric({
    required PerformanceMetricType type,
    required String operationId,
    required Duration duration,
    Map<String, dynamic>? metadata,
    bool failed = false,
  }) {
    // Implement circular buffer to limit memory usage
    if (_metrics.length >= maxMetricsCount) {
      _metrics.removeAt(0);
    }
    
    _metrics.add(
      PerformanceMetric(
        type: type,
        operationId: operationId,
        duration: duration,
        timestamp: DateTime.now(),
        metadata: metadata ?? {},
        failed: failed,
      ),
    );
  }
  
  PerformanceMetricType _determineType(
    String operationId,
    Map<String, dynamic>? metadata,
  ) {
    if (operationId.startsWith('json_parse_')) {
      return PerformanceMetricType.jsonParsing;
    } else if (operationId.startsWith('api_call_')) {
      return PerformanceMetricType.apiCall;
    } else if (operationId.startsWith('widget_build_')) {
      return PerformanceMetricType.widgetBuild;
    }
    return PerformanceMetricType.other;
  }
  
  void _logSlowOperation(String operation, String identifier, Duration duration) {
    debugPrint(
      '⚠️ Slow $operation: $identifier took ${duration.inMilliseconds}ms',
    );
  }
}

/// Types of performance metrics
enum PerformanceMetricType {
  jsonParsing,
  apiCall,
  widgetBuild,
  other,
}

/// Represents a single performance metric
class PerformanceMetric {
  final PerformanceMetricType type;
  final String operationId;
  final Duration duration;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;
  final bool failed;
  
  const PerformanceMetric({
    required this.type,
    required this.operationId,
    required this.duration,
    required this.timestamp,
    required this.metadata,
    this.failed = false,
  });
  
  String get formattedDuration => '${duration.inMilliseconds}ms';
  
  bool get isSlow {
    switch (type) {
      case PerformanceMetricType.jsonParsing:
        return duration.inMilliseconds > PerformanceMonitor.slowJsonParsingThreshold;
      case PerformanceMetricType.apiCall:
        return duration.inMilliseconds > PerformanceMonitor.slowApiCallThreshold;
      case PerformanceMetricType.widgetBuild:
        return duration.inMilliseconds > PerformanceMonitor.slowWidgetBuildThreshold;
      case PerformanceMetricType.other:
        return duration.inMilliseconds > 100;
    }
  }
  
  @override
  String toString() {
    return 'PerformanceMetric(type: $type, id: $operationId, duration: $formattedDuration, failed: $failed)';
  }
}

/// Performance statistics
class PerformanceStats {
  final int totalOperations;
  final double averageDuration;
  final double medianDuration;
  final double minDuration;
  final double maxDuration;
  final double p95Duration;
  final double p99Duration;
  final int slowOperations;
  final int failedOperations;
  
  const PerformanceStats({
    required this.totalOperations,
    required this.averageDuration,
    required this.medianDuration,
    required this.minDuration,
    required this.maxDuration,
    required this.p95Duration,
    required this.p99Duration,
    required this.slowOperations,
    required this.failedOperations,
  });
  
  factory PerformanceStats.empty() {
    return const PerformanceStats(
      totalOperations: 0,
      averageDuration: 0,
      medianDuration: 0,
      minDuration: 0,
      maxDuration: 0,
      p95Duration: 0,
      p99Duration: 0,
      slowOperations: 0,
      failedOperations: 0,
    );
  }
  
  double get slowOperationRate {
    if (totalOperations == 0) return 0.0;
    return slowOperations / totalOperations;
  }
  
  double get failureRate {
    if (totalOperations == 0) return 0.0;
    return failedOperations / totalOperations;
  }
  
  @override
  String toString() {
    return 'PerformanceStats(\n'
        '  Total Operations: $totalOperations\n'
        '  Average: ${averageDuration.toStringAsFixed(2)}ms\n'
        '  Median: ${medianDuration.toStringAsFixed(2)}ms\n'
        '  Min: ${minDuration.toStringAsFixed(2)}ms\n'
        '  Max: ${maxDuration.toStringAsFixed(2)}ms\n'
        '  P95: ${p95Duration.toStringAsFixed(2)}ms\n'
        '  P99: ${p99Duration.toStringAsFixed(2)}ms\n'
        '  Slow Operations: $slowOperations (${(slowOperationRate * 100).toStringAsFixed(1)}%)\n'
        '  Failed Operations: $failedOperations (${(failureRate * 100).toStringAsFixed(1)}%)\n'
        ')';
  }
}

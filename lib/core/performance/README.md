# Performance Optimization Implementation

This document describes the performance optimization features implemented for the STAC Hybrid App Framework.

## Overview

The performance optimization system provides comprehensive caching, lazy loading, and monitoring capabilities to ensure optimal application performance.

## Components

### 1. JSON Parse Cache (`lib/core/cache/json_parse_cache.dart`)

A singleton cache for parsed JSON widget models to avoid redundant parsing operations.

**Features:**
- In-memory caching with LRU eviction
- Configurable cache size (default: 100 entries)
- Optional expiry duration per entry
- Cache statistics and hit rate tracking
- Automatic cleanup of expired entries

**Usage:**
```dart
final cache = JsonParseCache.instance;

// Generate cache key from JSON
final key = cache.generateKey(jsonData);

// Check cache
final cached = cache.get(key);
if (cached != null) {
  return cached;
}

// Parse and cache
final model = parseJson(jsonData);
cache.put(key, model, expiry: Duration(minutes: 5));
```

### 2. Lazy Loading (`lib/core/widgets/lazy_stac_screen.dart`)

Implements progressive loading for STAC screens to improve perceived performance.

**Features:**
- Load critical content first (app bar, above-the-fold)
- Lazy load non-critical content (below-the-fold, heavy images)
- Visual loading indicators
- Error handling with retry capability
- Content splitting utilities

**Usage:**
```dart
LazyStacScreen(
  screenName: 'home_screen',
  loadCriticalContent: (name) async {
    return await apiService.fetchCriticalContent(name);
  },
  loadNonCriticalContent: (name) async {
    return await apiService.fetchNonCriticalContent(name);
  },
  builder: (context, data) {
    return StacWidget.fromJson(data);
  },
)
```

### 3. Cache Manager (`lib/core/cache/cache_manager.dart`)

Two-tier caching system with memory and disk storage.

**Features:**
- Memory cache for fast access
- Disk cache (SharedPreferences) for persistence
- Automatic promotion from disk to memory
- Configurable expiry per entry
- LRU eviction for memory cache
- Comprehensive statistics

**Usage:**
```dart
// Initialize (call once at app startup)
await CacheManager.instance.initialize();

// Get from cache
final data = await CacheManager.instance.get('screen_home');

// Put in cache
await CacheManager.instance.put(
  'screen_home',
  jsonData,
  expiry: Duration(minutes: 30),
);

// Get statistics
final stats = await CacheManager.instance.getStats();
print(stats); // Shows memory/disk hit rates
```

### 4. Performance Monitor (`lib/core/monitoring/performance_monitor.dart`)

Tracks and analyzes performance metrics for STAC operations.

**Features:**
- Track JSON parsing time
- Track API call duration
- Track widget build time
- Identify slow operations
- Performance statistics (avg, median, p95, p99)
- Automatic logging of slow operations

**Usage:**
```dart
final monitor = PerformanceMonitor.instance;

// Track JSON parsing
final result = await monitor.trackJsonParsing(
  'home_screen',
  () async => parseJson(jsonData),
);

// Track API call
final response = await monitor.trackApiCall(
  '/api/screens/home',
  () async => dio.get('/api/screens/home'),
);

// Track widget build
final widget = monitor.trackWidgetBuild(
  'CustomCard',
  () => CustomCard.fromJson(json),
);

// Get statistics
final stats = monitor.getStats(type: PerformanceMetricType.jsonParsing);
print(stats); // Shows avg, p95, p99, slow operations
```

### 5. Optimized Widgets (`lib/core/widgets/optimized_stac_widget.dart`)

Base classes and utilities for creating performance-optimized STAC widgets.

**Features:**
- Const constructors where possible
- Efficient shouldRebuild checks
- Selective rebuild optimization
- Cached build results
- RepaintBoundary optimization
- Deep equality checks

**Usage:**
```dart
// Use const-optimized widgets
class MyWidget extends ConstOptimizedWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const OptimizedStacText(text: 'Hello');
  }
}

// Use cached build widget
CachedBuildWidget(
  json: jsonData,
  builder: (context, json) => buildComplexWidget(json),
)

// Use selective rebuild
SelectiveRebuildWidget(
  json: jsonData,
  watchKeys: ['title', 'subtitle'], // Only rebuild when these change
  builder: (context, json) => buildWidget(json),
)
```

## Performance Thresholds

The system uses the following thresholds to identify slow operations:

- **JSON Parsing**: > 100ms
- **API Calls**: > 1000ms (1 second)
- **Widget Builds**: > 16ms (60fps threshold)

## Best Practices

### 1. Use Caching Strategically

```dart
// Cache parsed models
final key = JsonParseCache.instance.generateKey(json);
if (JsonParseCache.instance.contains(key)) {
  return JsonParseCache.instance.get(key);
}

// Cache API responses
await CacheManager.instance.put(
  'screen_$screenName',
  response,
  expiry: Duration(minutes: 30),
);
```

### 2. Implement Lazy Loading

```dart
// Split content into critical and non-critical
final split = ScreenContentSplitter.split(screenJson);

// Load critical first
final criticalWidget = buildWidget(split['critical']);

// Lazy load non-critical
Future.delayed(Duration(milliseconds: 100), () {
  loadNonCritical(split['nonCritical']);
});
```

### 3. Monitor Performance

```dart
// Track all operations
final result = await PerformanceMonitor.instance.trackApiCall(
  endpoint,
  () => apiCall(),
);

// Review slow operations
final slowOps = PerformanceMonitor.instance.getSlowOperations();
for (final op in slowOps) {
  print('Slow: ${op.operationId} took ${op.formattedDuration}');
}
```

### 4. Optimize Widget Rebuilds

```dart
// Use const constructors
const OptimizedStacText(text: 'Static text');

// Use selective rebuilds
SelectiveRebuildWidget(
  json: data,
  watchKeys: ['title'], // Only rebuild when title changes
  builder: (context, json) => Text(json['title']),
);

// Use RepaintBoundary for complex widgets
RepaintBoundary(
  child: ComplexAnimatedWidget(),
);
```

## Integration with Existing Code

### API Services

Integrate caching into API services:

```dart
class MockApiService implements StacApiService {
  @override
  Future<Map<String, dynamic>> fetchScreen(String screenName) async {
    // Check cache first
    final cached = await CacheManager.instance.get('screen_$screenName');
    if (cached != null) return cached;
    
    // Track performance
    final data = await PerformanceMonitor.instance.trackApiCall(
      'mock_api_$screenName',
      () async => _loadFromAssets(screenName),
    );
    
    // Cache result
    await CacheManager.instance.put(
      'screen_$screenName',
      data,
      expiry: Duration(minutes: 30),
    );
    
    return data;
  }
}
```

### STAC Parsers

Integrate caching into parsers:

```dart
class CustomWidgetParser extends StacParser {
  @override
  Widget parse(BuildContext context, Map<String, dynamic> json) {
    // Check parse cache
    final cache = JsonParseCache.instance;
    final key = cache.generateKey(json);
    
    final cached = cache.get(key);
    if (cached != null) {
      return cached as Widget;
    }
    
    // Track parsing performance
    final widget = PerformanceMonitor.instance.trackWidgetBuild(
      'CustomWidget',
      () => _buildWidget(context, json),
    );
    
    // Cache parsed widget
    cache.put(key, widget, expiry: Duration(minutes: 5));
    
    return widget;
  }
}
```

## Monitoring and Debugging

### View Performance Stats

```dart
// Get overall stats
final stats = PerformanceMonitor.instance.getStats();
print(stats);

// Get stats by type
final jsonStats = PerformanceMonitor.instance.getStats(
  type: PerformanceMetricType.jsonParsing,
);
print('JSON Parsing: ${jsonStats.averageDuration}ms avg');

// Get cache stats
final cacheStats = await CacheManager.instance.getStats();
print(cacheStats);
```

### Debug Panel Integration

The performance monitoring can be integrated into the debug panel:

```dart
// In debug panel
final slowOps = PerformanceMonitor.instance.getSlowOperations();
ListView.builder(
  itemCount: slowOps.length,
  itemBuilder: (context, index) {
    final op = slowOps[index];
    return ListTile(
      title: Text(op.operationId),
      subtitle: Text('${op.formattedDuration} - ${op.type}'),
      trailing: Icon(
        op.isSlow ? Icons.warning : Icons.check,
        color: op.isSlow ? Colors.orange : Colors.green,
      ),
    );
  },
);
```

## Testing

All performance components should be tested:

```dart
// Test cache
test('JsonParseCache should cache and retrieve models', () {
  final cache = JsonParseCache.instance;
  final json = {'type': 'text', 'data': 'Hello'};
  final key = cache.generateKey(json);
  
  cache.put(key, 'parsed_model');
  expect(cache.get(key), 'parsed_model');
});

// Test performance monitoring
test('PerformanceMonitor should track operations', () async {
  final monitor = PerformanceMonitor.instance;
  
  await monitor.trackJsonParsing('test', () async {
    await Future.delayed(Duration(milliseconds: 50));
  });
  
  final metrics = monitor.getMetrics(type: PerformanceMetricType.jsonParsing);
  expect(metrics.length, 1);
  expect(metrics.first.duration.inMilliseconds, greaterThan(40));
});
```

## Future Enhancements

Potential improvements:

1. **Predictive Caching**: Pre-cache likely next screens
2. **Adaptive Thresholds**: Adjust based on device performance
3. **Network-Aware Caching**: Different strategies for different network conditions
4. **Memory Pressure Handling**: Automatic cache eviction under memory pressure
5. **Performance Budgets**: Set and enforce performance budgets per screen

## Summary

The performance optimization system provides:

✅ JSON parsing cache with LRU eviction
✅ Lazy loading for progressive content display
✅ Two-tier cache manager (memory + disk)
✅ Comprehensive performance monitoring
✅ Optimized widget rendering utilities

All components are production-ready and can be integrated into existing STAC applications.

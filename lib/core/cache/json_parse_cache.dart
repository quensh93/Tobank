import 'dart:convert';

/// Cache for parsed JSON widget models to avoid re-parsing
/// 
/// This cache stores parsed widget models in memory to improve performance
/// by avoiding redundant JSON parsing operations.
class JsonParseCache {
  JsonParseCache._();
  
  static final JsonParseCache instance = JsonParseCache._();
  
  final Map<String, CachedModel> _cache = {};
  
  /// Maximum number of entries to keep in cache
  static const int maxCacheSize = 100;
  
  /// Get a cached model by its cache key
  /// Returns null if not found or expired
  dynamic get(String key) {
    final cached = _cache[key];
    if (cached == null) return null;
    
    if (cached.isExpired) {
      _cache.remove(key);
      return null;
    }
    
    return cached.model;
  }
  
  /// Cache a parsed model with optional expiry duration
  void put(String key, dynamic model, {Duration? expiry}) {
    // Implement LRU eviction if cache is full
    if (_cache.length >= maxCacheSize) {
      _evictOldest();
    }
    
    _cache[key] = CachedModel(
      model: model,
      timestamp: DateTime.now(),
      expiry: expiry,
    );
  }
  
  /// Generate a cache key from JSON data
  String generateKey(Map<String, dynamic> json) {
    return jsonEncode(json).hashCode.toString();
  }
  
  /// Check if a key exists in cache and is not expired
  bool contains(String key) {
    final cached = _cache[key];
    if (cached == null) return false;
    
    if (cached.isExpired) {
      _cache.remove(key);
      return false;
    }
    
    return true;
  }
  
  /// Clear a specific cache entry
  void remove(String key) {
    _cache.remove(key);
  }
  
  /// Clear all cached entries
  void clear() {
    _cache.clear();
  }
  
  /// Get cache statistics
  CacheStats getStats() {
    int expired = 0;
    int valid = 0;
    
    for (final entry in _cache.values) {
      if (entry.isExpired) {
        expired++;
      } else {
        valid++;
      }
    }
    
    return CacheStats(
      totalEntries: _cache.length,
      validEntries: valid,
      expiredEntries: expired,
    );
  }
  
  /// Evict the oldest entry from cache (LRU)
  void _evictOldest() {
    if (_cache.isEmpty) return;
    
    String? oldestKey;
    DateTime? oldestTime;
    
    for (final entry in _cache.entries) {
      if (oldestTime == null || entry.value.timestamp.isBefore(oldestTime)) {
        oldestTime = entry.value.timestamp;
        oldestKey = entry.key;
      }
    }
    
    if (oldestKey != null) {
      _cache.remove(oldestKey);
    }
  }
  
  /// Clean up expired entries
  void cleanupExpired() {
    final keysToRemove = <String>[];
    
    for (final entry in _cache.entries) {
      if (entry.value.isExpired) {
        keysToRemove.add(entry.key);
      }
    }
    
    for (final key in keysToRemove) {
      _cache.remove(key);
    }
  }
}

/// Represents a cached model with metadata
class CachedModel {
  final dynamic model;
  final DateTime timestamp;
  final Duration? expiry;
  
  const CachedModel({
    required this.model,
    required this.timestamp,
    this.expiry,
  });
  
  /// Check if this cached entry has expired
  bool get isExpired {
    if (expiry == null) return false;
    return DateTime.now().difference(timestamp) > expiry!;
  }
  
  /// Get the age of this cache entry
  Duration get age => DateTime.now().difference(timestamp);
}

/// Statistics about the cache
class CacheStats {
  final int totalEntries;
  final int validEntries;
  final int expiredEntries;
  
  const CacheStats({
    required this.totalEntries,
    required this.validEntries,
    required this.expiredEntries,
  });
  
  double get hitRate {
    if (totalEntries == 0) return 0.0;
    return validEntries / totalEntries;
  }
  
  @override
  String toString() {
    return 'CacheStats(total: $totalEntries, valid: $validEntries, expired: $expiredEntries, hitRate: ${(hitRate * 100).toStringAsFixed(1)}%)';
  }
}

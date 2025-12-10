import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages both memory and disk caching for STAC data
/// 
/// Provides a two-tier caching system:
/// - Memory cache for fast access
/// - Disk cache for persistence across app restarts
class CacheManager {
  CacheManager._();
  
  static final CacheManager instance = CacheManager._();
  
  final Map<String, CachedEntry> _memoryCache = {};
  SharedPreferences? _prefs;
  bool _initialized = false;
  
  /// Maximum number of entries in memory cache
  static const int maxMemoryCacheSize = 50;
  
  /// Default cache expiry duration
  static const Duration defaultExpiry = Duration(minutes: 30);
  
  /// Initialize the cache manager
  /// Must be called before using the cache
  Future<void> initialize() async {
    if (_initialized) return;
    
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
    
    // Clean up expired disk cache entries on initialization
    await _cleanupExpiredDiskCache();
  }
  
  /// Get data from cache (checks memory first, then disk)
  Future<Map<String, dynamic>?> get(String key) async {
    _ensureInitialized();
    
    // Check memory cache first
    final memoryData = _getFromMemory(key);
    if (memoryData != null) {
      return memoryData;
    }
    
    // Check disk cache
    final diskData = await _getFromDisk(key);
    if (diskData != null) {
      // Promote to memory cache
      final expiry = _getDiskExpiry(key) ?? defaultExpiry;
      _putInMemory(key, diskData, expiry);
      return diskData;
    }
    
    return null;
  }
  
  /// Put data in cache (both memory and disk)
  Future<void> put(
    String key,
    Map<String, dynamic> data, {
    Duration? expiry,
    bool memoryOnly = false,
  }) async {
    _ensureInitialized();
    
    final effectiveExpiry = expiry ?? defaultExpiry;
    
    // Always put in memory cache
    _putInMemory(key, data, effectiveExpiry);
    
    // Put in disk cache unless memoryOnly is true
    if (!memoryOnly) {
      await _putInDisk(key, data, effectiveExpiry);
    }
  }
  
  /// Remove data from cache
  Future<void> remove(String key) async {
    _ensureInitialized();
    
    _memoryCache.remove(key);
    await _removeFromDisk(key);
  }
  
  /// Clear all cache data
  Future<void> clear() async {
    _ensureInitialized();
    
    _memoryCache.clear();
    await _clearDiskCache();
  }
  
  /// Check if key exists in cache
  Future<bool> contains(String key) async {
    _ensureInitialized();
    
    // Check memory first
    if (_memoryCache.containsKey(key)) {
      final entry = _memoryCache[key]!;
      if (!entry.isExpired) {
        return true;
      }
      _memoryCache.remove(key);
    }
    
    // Check disk
    return await _containsInDisk(key);
  }
  
  /// Get cache statistics
  Future<CacheManagerStats> getStats() async {
    _ensureInitialized();
    
    int memoryValid = 0;
    int memoryExpired = 0;
    
    for (final entry in _memoryCache.values) {
      if (entry.isExpired) {
        memoryExpired++;
      } else {
        memoryValid++;
      }
    }
    
    final diskKeys = await _getDiskCacheKeys();
    int diskValid = 0;
    int diskExpired = 0;
    
    for (final key in diskKeys) {
      if (await _isDiskEntryExpired(key)) {
        diskExpired++;
      } else {
        diskValid++;
      }
    }
    
    return CacheManagerStats(
      memoryEntries: _memoryCache.length,
      memoryValidEntries: memoryValid,
      memoryExpiredEntries: memoryExpired,
      diskEntries: diskKeys.length,
      diskValidEntries: diskValid,
      diskExpiredEntries: diskExpired,
    );
  }
  
  /// Clean up expired entries from both memory and disk
  Future<void> cleanup() async {
    _ensureInitialized();
    
    // Clean memory cache
    final keysToRemove = <String>[];
    for (final entry in _memoryCache.entries) {
      if (entry.value.isExpired) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _memoryCache.remove(key);
    }
    
    // Clean disk cache
    await _cleanupExpiredDiskCache();
  }
  
  // Memory cache operations
  
  Map<String, dynamic>? _getFromMemory(String key) {
    final entry = _memoryCache[key];
    if (entry == null) return null;
    
    if (entry.isExpired) {
      _memoryCache.remove(key);
      return null;
    }
    
    return entry.data;
  }
  
  void _putInMemory(String key, Map<String, dynamic> data, Duration expiry) {
    // Implement LRU eviction if cache is full
    if (_memoryCache.length >= maxMemoryCacheSize) {
      _evictOldestFromMemory();
    }
    
    _memoryCache[key] = CachedEntry(
      data: data,
      timestamp: DateTime.now(),
      expiry: expiry,
    );
  }
  
  void _evictOldestFromMemory() {
    if (_memoryCache.isEmpty) return;
    
    String? oldestKey;
    DateTime? oldestTime;
    
    for (final entry in _memoryCache.entries) {
      if (oldestTime == null || entry.value.timestamp.isBefore(oldestTime)) {
        oldestTime = entry.value.timestamp;
        oldestKey = entry.key;
      }
    }
    
    if (oldestKey != null) {
      _memoryCache.remove(oldestKey);
    }
  }
  
  // Disk cache operations
  
  Future<Map<String, dynamic>?> _getFromDisk(String key) async {
    final dataKey = _getDiskDataKey(key);
    final expiryKey = _getDiskExpiryKey(key);
    
    final jsonString = _prefs!.getString(dataKey);
    final expiryMillis = _prefs!.getInt(expiryKey);
    
    if (jsonString == null || expiryMillis == null) {
      return null;
    }
    
    // Check if expired
    final expiry = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
    if (DateTime.now().isAfter(expiry)) {
      await _removeFromDisk(key);
      return null;
    }
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Invalid JSON, remove from cache
      await _removeFromDisk(key);
      return null;
    }
  }
  
  Future<void> _putInDisk(
    String key,
    Map<String, dynamic> data,
    Duration expiry,
  ) async {
    final dataKey = _getDiskDataKey(key);
    final expiryKey = _getDiskExpiryKey(key);
    
    final jsonString = jsonEncode(data);
    final expiryTime = DateTime.now().add(expiry);
    
    await _prefs!.setString(dataKey, jsonString);
    await _prefs!.setInt(expiryKey, expiryTime.millisecondsSinceEpoch);
  }
  
  Future<void> _removeFromDisk(String key) async {
    final dataKey = _getDiskDataKey(key);
    final expiryKey = _getDiskExpiryKey(key);
    
    await _prefs!.remove(dataKey);
    await _prefs!.remove(expiryKey);
  }
  
  Future<bool> _containsInDisk(String key) async {
    final dataKey = _getDiskDataKey(key);
    final expiryKey = _getDiskExpiryKey(key);
    
    if (!_prefs!.containsKey(dataKey) || !_prefs!.containsKey(expiryKey)) {
      return false;
    }
    
    // Check if expired
    final expiryMillis = _prefs!.getInt(expiryKey);
    if (expiryMillis == null) return false;
    
    final expiry = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
    if (DateTime.now().isAfter(expiry)) {
      await _removeFromDisk(key);
      return false;
    }
    
    return true;
  }
  
  Future<List<String>> _getDiskCacheKeys() async {
    final keys = <String>[];
    final allKeys = _prefs!.getKeys();
    
    for (final key in allKeys) {
      if (key.startsWith('cache_data_')) {
        final cacheKey = key.substring('cache_data_'.length);
        keys.add(cacheKey);
      }
    }
    
    return keys;
  }
  
  Future<bool> _isDiskEntryExpired(String key) async {
    final expiryKey = _getDiskExpiryKey(key);
    final expiryMillis = _prefs!.getInt(expiryKey);
    
    if (expiryMillis == null) return true;
    
    final expiry = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
    return DateTime.now().isAfter(expiry);
  }
  
  Duration? _getDiskExpiry(String key) {
    final expiryKey = _getDiskExpiryKey(key);
    final expiryMillis = _prefs!.getInt(expiryKey);
    
    if (expiryMillis == null) return null;
    
    final expiry = DateTime.fromMillisecondsSinceEpoch(expiryMillis);
    final remaining = expiry.difference(DateTime.now());
    
    return remaining.isNegative ? null : remaining;
  }
  
  Future<void> _clearDiskCache() async {
    final keys = await _getDiskCacheKeys();
    for (final key in keys) {
      await _removeFromDisk(key);
    }
  }
  
  Future<void> _cleanupExpiredDiskCache() async {
    final keys = await _getDiskCacheKeys();
    for (final key in keys) {
      if (await _isDiskEntryExpired(key)) {
        await _removeFromDisk(key);
      }
    }
  }
  
  String _getDiskDataKey(String key) => 'cache_data_$key';
  String _getDiskExpiryKey(String key) => 'cache_expiry_$key';
  
  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'CacheManager not initialized. Call initialize() first.',
      );
    }
  }
}

/// Represents a cached entry with metadata
class CachedEntry {
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final Duration expiry;
  
  const CachedEntry({
    required this.data,
    required this.timestamp,
    required this.expiry,
  });
  
  bool get isExpired {
    return DateTime.now().difference(timestamp) > expiry;
  }
  
  Duration get age => DateTime.now().difference(timestamp);
  
  Duration get remainingTime {
    final remaining = expiry - age;
    return remaining.isNegative ? Duration.zero : remaining;
  }
}

/// Statistics about the cache manager
class CacheManagerStats {
  final int memoryEntries;
  final int memoryValidEntries;
  final int memoryExpiredEntries;
  final int diskEntries;
  final int diskValidEntries;
  final int diskExpiredEntries;
  
  const CacheManagerStats({
    required this.memoryEntries,
    required this.memoryValidEntries,
    required this.memoryExpiredEntries,
    required this.diskEntries,
    required this.diskValidEntries,
    required this.diskExpiredEntries,
  });
  
  int get totalEntries => memoryEntries + diskEntries;
  int get totalValidEntries => memoryValidEntries + diskValidEntries;
  int get totalExpiredEntries => memoryExpiredEntries + diskExpiredEntries;
  
  double get memoryHitRate {
    if (memoryEntries == 0) return 0.0;
    return memoryValidEntries / memoryEntries;
  }
  
  double get diskHitRate {
    if (diskEntries == 0) return 0.0;
    return diskValidEntries / diskEntries;
  }
  
  double get overallHitRate {
    if (totalEntries == 0) return 0.0;
    return totalValidEntries / totalEntries;
  }
  
  @override
  String toString() {
    return 'CacheManagerStats(\n'
        '  Memory: $memoryValidEntries/$memoryEntries (${(memoryHitRate * 100).toStringAsFixed(1)}%)\n'
        '  Disk: $diskValidEntries/$diskEntries (${(diskHitRate * 100).toStringAsFixed(1)}%)\n'
        '  Overall: $totalValidEntries/$totalEntries (${(overallHitRate * 100).toStringAsFixed(1)}%)\n'
        ')';
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/cached_data.dart';
import '../exceptions/api_exceptions.dart';

/// Disk cache manager for persistent storage
///
/// Stores JSON data to disk for offline access.
/// Uses the application's cache directory for storage.
class DiskCacheManager {
  /// Singleton instance
  static final DiskCacheManager instance = DiskCacheManager._();

  DiskCacheManager._();

  /// Cache directory
  Directory? _cacheDir;

  /// Initialize the cache manager
  Future<void> initialize() async {
    if (_cacheDir != null) return;

    try {
      final appDir = await getApplicationCacheDirectory();
      _cacheDir = Directory('${appDir.path}/stac_cache');

      // Create cache directory if it doesn't exist
      if (!await _cacheDir!.exists()) {
        await _cacheDir!.create(recursive: true);
      }
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to initialize disk cache',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Save data to disk cache
  Future<void> save(String key, Map<String, dynamic> data, {Duration? expiry}) async {
    await _ensureInitialized();

    try {
      final cachedData = CachedData(
        data: data,
        timestamp: DateTime.now(),
        expiry: expiry ?? const Duration(hours: 24),
      );

      final file = File('${_cacheDir!.path}/${_sanitizeKey(key)}.json');
      await file.writeAsString(jsonEncode(cachedData.toJson()));
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to save to disk cache: $key',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Load data from disk cache
  Future<Map<String, dynamic>?> load(String key) async {
    await _ensureInitialized();

    try {
      final file = File('${_cacheDir!.path}/${_sanitizeKey(key)}.json');

      if (!await file.exists()) {
        return null;
      }

      final jsonString = await file.readAsString();
      final cachedData = CachedData.fromJson(jsonDecode(jsonString));

      // Check if cache is expired
      if (cachedData.isExpired) {
        // Delete expired cache
        await file.delete();
        return null;
      }

      return cachedData.data;
    } catch (e, stackTrace) {
      // If there's an error reading the cache, delete it
      try {
        final file = File('${_cacheDir!.path}/${_sanitizeKey(key)}.json');
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Ignore deletion errors
      }

      throw CacheException(
        'Failed to load from disk cache: $key',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Check if data exists in cache
  Future<bool> exists(String key) async {
    await _ensureInitialized();

    try {
      final file = File('${_cacheDir!.path}/${_sanitizeKey(key)}.json');
      return await file.exists();
    } catch (_) {
      return false;
    }
  }

  /// Delete cached data
  Future<void> delete(String key) async {
    await _ensureInitialized();

    try {
      final file = File('${_cacheDir!.path}/${_sanitizeKey(key)}.json');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to delete from disk cache: $key',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Clear all cached data
  Future<void> clear() async {
    await _ensureInitialized();

    try {
      if (await _cacheDir!.exists()) {
        await _cacheDir!.delete(recursive: true);
        await _cacheDir!.create(recursive: true);
      }
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to clear disk cache',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Get cache size in bytes
  Future<int> getCacheSize() async {
    await _ensureInitialized();

    try {
      int totalSize = 0;
      final files = await _cacheDir!.list().toList();

      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          totalSize += stat.size;
        }
      }

      return totalSize;
    } catch (_) {
      return 0;
    }
  }

  /// Get number of cached items
  Future<int> getCacheCount() async {
    await _ensureInitialized();

    try {
      final files = await _cacheDir!.list().toList();
      return files.whereType<File>().length;
    } catch (_) {
      return 0;
    }
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStats() async {
    final size = await getCacheSize();
    final count = await getCacheCount();

    return {
      'size_bytes': size,
      'size_mb': (size / (1024 * 1024)).toStringAsFixed(2),
      'count': count,
      'cache_dir': _cacheDir?.path,
    };
  }

  /// Clean up expired cache entries
  Future<int> cleanExpired() async {
    await _ensureInitialized();

    int deletedCount = 0;

    try {
      final files = await _cacheDir!.list().toList();

      for (final file in files) {
        if (file is File) {
          try {
            final jsonString = await file.readAsString();
            final cachedData = CachedData.fromJson(jsonDecode(jsonString));

            if (cachedData.isExpired) {
              await file.delete();
              deletedCount++;
            }
          } catch (_) {
            // If we can't read the file, delete it
            await file.delete();
            deletedCount++;
          }
        }
      }
    } catch (_) {
      // Ignore errors during cleanup
    }

    return deletedCount;
  }

  /// Ensure cache is initialized
  Future<void> _ensureInitialized() async {
    if (_cacheDir == null) {
      await initialize();
    }
  }

  /// Sanitize cache key to be filesystem-safe
  String _sanitizeKey(String key) {
    return key
        .replaceAll(RegExp(r'[^\w\-]'), '_')
        .replaceAll(RegExp(r'_+'), '_');
  }
}

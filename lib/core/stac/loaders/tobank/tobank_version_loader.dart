import 'package:package_info_plus/package_info_plus.dart';
import 'package:stac/stac.dart';

/// Loads app version information from pubspec.yaml using package_info_plus
/// and stores it in StacRegistry for access in STAC widgets.
///
/// Usage in STAC widgets:
/// - `{{appData.version}}` - App version (e.g., "1.0.0")
/// - `{{appData.buildNumber}}` - Build number (e.g., "1")
/// - `{{appData.appName}}` - App name
/// - `{{appData.packageName}}` - Package name
class TobankVersionLoader {
  static bool _isLoaded = false;
  static PackageInfo? _cachedPackageInfo;

  /// Loads version information from pubspec.yaml and stores in StacRegistry.
  /// Should be called during app initialization after WidgetsFlutterBinding.ensureInitialized().
  static Future<void> loadVersion() async {
    if (_isLoaded) return;

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _cachedPackageInfo = packageInfo;

      // Store version info in StacRegistry for STAC widget access
      StacRegistry.instance.setValue('appData.version', packageInfo.version);
      StacRegistry.instance.setValue(
        'appData.buildNumber',
        packageInfo.buildNumber,
      );
      StacRegistry.instance.setValue('appData.appName', packageInfo.appName);
      StacRegistry.instance.setValue(
        'appData.packageName',
        packageInfo.packageName,
      );

      _isLoaded = true;
    } catch (e) {
      // Fallback to default values if loading fails
      StacRegistry.instance.setValue('appData.version', '1.0.0');
      StacRegistry.instance.setValue('appData.buildNumber', '1');
      StacRegistry.instance.setValue('appData.appName', 'Tobank');
      StacRegistry.instance.setValue('appData.packageName', 'com.tobank.app');
    }
  }

  /// Gets the cached package info (available after loadVersion is called)
  static PackageInfo? get packageInfo => _cachedPackageInfo;

  /// Clears the cache to force reload on next call
  static void clearCache() {
    _isLoaded = false;
    _cachedPackageInfo = null;
  }
}

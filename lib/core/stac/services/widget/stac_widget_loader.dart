import '../../../../stac/tobank/login/dart/tobank_login.dart' as login_dart;
import '../../../../stac/tobank/login/dart/verify_otp.dart' as verify_otp_dart;

/// Service for loading STAC widgets from Dart files.
/// 
/// Follows Single Responsibility Principle - only responsible for loading
/// widget JSON from Dart widget definitions.
/// 
/// Follows Open/Closed Principle - new widget types can be registered
/// without modifying this class.
class StacWidgetLoader {
  StacWidgetLoader._();

  /// Registry of widget type to loader function mappings.
  /// Extensible - new widget types can be registered without modifying this class.
  static final Map<String, Map<String, dynamic> Function()> _widgetLoaders = {
    'tobank_login_dart': () => login_dart.tobankLoginDart().toJson(),
    'tobank_verify_otp_dart': () => verify_otp_dart.tobankVerifyOtpDart().toJson(),
  };

  /// Registers a widget loader for a specific widget type.
  /// Allows extension without modification (Open/Closed Principle).
  static void registerWidgetLoader(
    String widgetType,
    Map<String, dynamic> Function() loader,
  ) {
    _widgetLoaders[widgetType] = loader;
  }

  /// Loads widget JSON from Dart file based on widgetType.
  /// Returns null if widgetType is not registered or loading fails.
  static Map<String, dynamic>? loadWidgetJson(String? widgetType) {
    if (widgetType == null || widgetType.isEmpty) {
      print('⚠️ StacWidgetLoader: widgetType is null or empty');
      return null;
    }

    final loader = _widgetLoaders[widgetType];
    if (loader == null) {
      print('⚠️ StacWidgetLoader: No loader found for widgetType: $widgetType');
      print('📋 Available widgetTypes: ${_widgetLoaders.keys.toList()}');
      return null;
    }

    try {
      print('✅ StacWidgetLoader: Loading widget JSON for: $widgetType');
      final json = loader();
      print('✅ StacWidgetLoader: Successfully loaded JSON for: $widgetType');
      print('📋 JSON keys: ${json.keys.toList()}');
      return json;
    } catch (e, stackTrace) {
      // Log error but don't throw - allows fallback to other navigation methods
      print('❌ StacWidgetLoader: Error loading widget JSON for $widgetType: $e');
      print('📋 Stack trace: $stackTrace');
      return null;
    }
  }
}

import '../../../../stac/tobank/login/dart/tobank_login.dart' as login_dart;
import '../../../../stac/tobank/login/dart/verify_otp.dart' as verify_otp_dart;
import '../../../../stac/tobank/splash/dart/tobank_splash.dart' as splash_dart;
import '../../../../stac/tobank/menu/dart/tobank_menu.dart' as tobank_menu_dart;
import '../../../../stac/tobank/home/dart/home.dart' as home_dart;
import '../../../../stac/tobank/account/dart/account_overview.dart'
    as account_dart;
import '../../../../stac/tobank/profile/dart/profile.dart' as profile_dart;
import '../../../../stac/tobank/transactions/dart/transaction_history.dart'
    as transactions_dart;
import '../../../../stac/tobank/transfer/dart/transfer_form.dart'
    as transfer_dart;
import '../../../../stac/tobank/onboarding/dart/tobank_onboarding.dart'
    as onboarding_dart;
import '../../../../stac/tobank/sum_test/dart/sum_test.dart' as sum_test_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_splash.dart'
    as linear_splash_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_onboarding.dart'
    as linear_onboarding_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_login.dart'
    as linear_login_dart;
import '../../../../stac/tobank/flows/login_flow_linear/dart/login_flow_linear_verify_otp.dart'
    as linear_verify_otp_dart;
import '../../../../stac/tobank/stateful_example/dart/tobank_stateful_example_dart.dart'
    as stateful_example_dart;

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
    'tobank_verify_otp_dart': () =>
        verify_otp_dart.tobankVerifyOtpDart().toJson(),
    'tobank_splash_dart': () => splash_dart.tobankSplashDart().toJson(),
    'tobank_menu_dart': () => tobank_menu_dart.tobankMenuDart().toJson(),
    'tobank_home': () => home_dart.tobankHome().toJson(),
    'tobank_account_overview': () =>
        account_dart.tobankAccountOverview().toJson(),
    'tobank_profile': () => profile_dart.tobankProfile().toJson(),
    'tobank_transaction_history': () =>
        transactions_dart.tobankTransactionHistory().toJson(),
    'tobank_transfer_form': () => transfer_dart.tobankTransferForm().toJson(),
    'tobank_onboarding': () => onboarding_dart.tobankOnboarding().toJson(),
    'tobank_sum_test': () => sum_test_dart.tobankSumTestDart().toJson(),
    // Flow widgets - all use FlowManager via loginFlowOverview
    'tobank_login_flow_dart': () => {
      'type': 'loginFlowOverview',
      'configPath':
          'lib/stac/tobank/flows/login_flow/dart/login_flow_config_dart.json',
      'useApiPath': false,
    },
    // Config-driven flow screens - uses LoginFlowOverview widget
    'login_flow_config': () => {
      '_flowWidgetType': 'login_flow_config',
      'configPath':
          'lib/stac/tobank/flows/login_flow/json/login_flow_config.json',
    },
    'login_flow_config_api': () => {
      '_flowWidgetType': 'login_flow_config_api',
      'configPath':
          'lib/stac/tobank/flows/login_flow/api/GET_login_flow_config.json',
    },
    // Linear flow widgets - each page handles navigation internally
    // Splash: Uses onMountAction to auto-navigate after 2 seconds (handled in Dart file)
    'tobank_login_flow_linear_splash': () =>
        linear_splash_dart.tobankLoginFlowLinearSplash().toJson(),
    'tobank_login_flow_linear_onboarding': () =>
        linear_onboarding_dart.tobankLoginFlowLinearOnboarding().toJson(),
    'tobank_login_flow_linear_login': () =>
        linear_login_dart.tobankLoginFlowLinearLogin().toJson(),
    'tobank_login_flow_linear_verify_otp': () =>
        linear_verify_otp_dart.tobankLoginFlowLinearVerifyOtp().toJson(),
    'tobank_stateful_example_dart': () =>
        stateful_example_dart.tobankStatefulExampleDart().toJson(),
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
      print(
        '❌ StacWidgetLoader: Error loading widget JSON for $widgetType: $e',
      );
      print('📋 Stack trace: $stackTrace');
      return null;
    }
  }
}

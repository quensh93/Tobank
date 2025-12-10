import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/debug_panel/state/debug_panel_settings_state.dart';

part 'api_config_provider.g.dart';

/// API configuration provider
///
/// Manages the current API configuration for the application.
/// Supports runtime configuration switching between mock, Supabase, and custom APIs.
///
/// Example usage:
/// ```dart
/// // Read the current configuration
/// final config = ref.watch(apiConfigProvider);
///
/// // Switch to mock mode
/// ref.read(apiConfigProvider.notifier).setConfig(ApiConfig.mock());
///
/// // Switch to Supabase mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.supabase('https://project.supabase.co', 'public-anon-key'),
/// );
///
/// // Switch to custom API mode
///
/// // Switch to custom API mode
/// ref.read(apiConfigProvider.notifier).setConfig(
///   ApiConfig.custom('https://api.example.com'),
/// );
/// ```
@Riverpod(keepAlive: true)
class ApiConfigNotifier extends _$ApiConfigNotifier {
  @override
  ApiConfig build() {
    // Watch debug panel settings to react to changes
    final debugSettings = ref.watch(debugPanelSettingsProvider);

    // Get Supabase credentials from compile-time environment variables
    const envSupabaseUrl = String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: '',
    );
    const envSupabaseAnonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );

    AppLogger.d(
      '🔧 API Config - Supabase enabled: ${debugSettings.supabaseEnabled}',
    );
    AppLogger.d(
      '🔧 API Config - Env URL: ${envSupabaseUrl.isNotEmpty ? "SET (${envSupabaseUrl.substring(0, 20)}...)" : "NOT SET"}',
    );
    AppLogger.d(
      '🔧 API Config - Env Key: ${envSupabaseAnonKey.isNotEmpty ? "SET" : "NOT SET"}',
    );

    // If Supabase is enabled in debug settings, use environment variables
    if (debugSettings.supabaseEnabled) {
      if (envSupabaseUrl.isNotEmpty && envSupabaseAnonKey.isNotEmpty) {
        AppLogger.i('✅ Using Supabase API with environment credentials');
        return ApiConfig.supabase(envSupabaseUrl, envSupabaseAnonKey);
      }
      // If enabled but credentials missing, fallback to mock and warn
      AppLogger.w(
        '⚠️ Supabase enabled but credentials not found in --dart-define flags. Falling back to Mock API.',
      );
      AppLogger.w(
        '💡 To use Supabase, run with: flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key',
      );
      return ApiConfig.mock();
    }

    // Default configuration based on environment
    const environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    );

    switch (environment) {
      case 'production':
        // In production, use custom API
        const apiUrl = String.fromEnvironment('API_URL', defaultValue: '');
        if (apiUrl.isNotEmpty) {
          return ApiConfig.custom(apiUrl);
        }
        // Fallback to mock if no API URL is provided
        return ApiConfig.mock();

      case 'staging':
        // In staging, use Supabase
        const supabaseUrl = String.fromEnvironment(
          'SUPABASE_URL',
          defaultValue: '',
        );
        const supabaseAnonKey = String.fromEnvironment(
          'SUPABASE_ANON_KEY',
          defaultValue: '',
        );
        if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
          return ApiConfig.supabase(supabaseUrl, supabaseAnonKey);
        }
        // Fallback to mock if no Supabase credentials are provided
        return ApiConfig.mock();

      case 'development':
      default:
        // In development, use mock API by default
        return ApiConfig.mock();
    }
  }

  /// Set a new API configuration
  ///
  /// This will trigger a rebuild of all widgets that depend on this provider.
  void setConfig(ApiConfig config) {
    state = config;
  }

  /// Switch to mock API mode
  void useMockApi() {
    state = ApiConfig.mock(
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
    );
  }

  /// Switch to Supabase API mode
  void useSupabaseApi({required String url, required String anonKey}) {
    state = ApiConfig.supabase(
      url,
      anonKey,
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
    );
  }

  /// Switch to custom API mode
  void useCustomApi(
    String apiUrl, {
    Map<String, String>? headers,
    String? authToken,
  }) {
    state = ApiConfig.custom(
      apiUrl,
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
      headers: headers ?? state.headers,
      authToken: authToken ?? state.authToken,
    );
  }

  /// Update caching settings
  void updateCachingSettings({bool? enableCaching, Duration? cacheExpiry}) {
    state = state.copyWith(
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  /// Update authentication token for custom API
  void updateAuthToken(String? token) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(authToken: token);
    }
  }

  /// Update custom headers for custom API
  void updateHeaders(Map<String, String> headers) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(headers: headers);
    }
  }
}

/// Provider for checking if mock API is enabled
@riverpod
bool isMockApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.mock;
}

/// Provider for checking if Supabase API is enabled
@riverpod
bool isSupabaseApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.supabase;
}

/// Provider for checking if custom API is enabled
@riverpod
bool isCustomApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.custom;
}

/// Provider for getting the current API mode
@riverpod
ApiMode currentApiMode(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode;
}

/// Provider for checking if caching is enabled
@riverpod
bool isCachingEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.enableCaching;
}

/// API mode enumeration
///
/// Defines the different API sources that can be used for fetching STAC configurations.
enum ApiMode {
  /// Mock API - loads JSON from local assets
  mock,

  /// Supabase API - fetches JSON from Supabase/PostgREST
  supabase,

  /// Custom API - fetches JSON from a custom REST API
  custom,
}

/// API configuration class
///
/// Holds configuration settings for the STAC API layer.
/// Use factory constructors to create configurations for different modes.
class ApiConfig {
  /// The API mode to use
  final ApiMode mode;

  /// Supabase project URL (required for Supabase mode)
  final String? supabaseUrl;

  /// Supabase anonymous key (required for Supabase mode)
  final String? supabaseAnonKey;

  /// Custom API base URL (required for custom mode)
  final String? customApiUrl;

  /// Whether to enable response caching
  final bool enableCaching;

  /// Cache expiration duration
  final Duration cacheExpiry;

  /// Additional HTTP headers for custom API
  final Map<String, String> headers;

  /// Authentication token for custom API
  final String? authToken;

  const ApiConfig({
    required this.mode,
    this.supabaseUrl,
    this.supabaseAnonKey,
    this.customApiUrl,
    this.enableCaching = true,
    this.cacheExpiry = const Duration(minutes: 5),
    this.headers = const {},
    this.authToken,
  });

  /// Create a mock API configuration
  ///
  /// This configuration loads JSON from local assets.
  /// Ideal for development and testing without backend dependencies.
  factory ApiConfig.mock({
    bool enableCaching = true,
    Duration cacheExpiry = const Duration(minutes: 5),
  }) {
    return ApiConfig(
      mode: ApiMode.mock,
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  /// Create a Supabase API configuration
  ///
  /// This configuration fetches JSON from Supabase.
  /// Requires a Supabase project URL and anon key.
  factory ApiConfig.supabase(
    String url,
    String anonKey, {
    bool enableCaching = true,
    Duration cacheExpiry = const Duration(minutes: 5),
  }) {
    return ApiConfig(
      mode: ApiMode.supabase,
      supabaseUrl: url,
      supabaseAnonKey: anonKey,
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  /// Create a custom API configuration
  ///
  /// This configuration fetches JSON from a custom REST API.
  /// Requires a valid API base URL.
  factory ApiConfig.custom(
    String apiUrl, {
    bool enableCaching = true,
    Duration cacheExpiry = const Duration(minutes: 5),
    Map<String, String> headers = const {},
    String? authToken,
  }) {
    return ApiConfig(
      mode: ApiMode.custom,
      customApiUrl: apiUrl,
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
      headers: headers,
      authToken: authToken,
    );
  }

  /// Copy with method for creating modified configurations
  ApiConfig copyWith({
    ApiMode? mode,
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? customApiUrl,
    bool? enableCaching,
    Duration? cacheExpiry,
    Map<String, String>? headers,
    String? authToken,
  }) {
    return ApiConfig(
      mode: mode ?? this.mode,
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseAnonKey: supabaseAnonKey ?? this.supabaseAnonKey,
      customApiUrl: customApiUrl ?? this.customApiUrl,
      enableCaching: enableCaching ?? this.enableCaching,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
      headers: headers ?? this.headers,
      authToken: authToken ?? this.authToken,
    );
  }

  @override
  String toString() {
    return 'ApiConfig(mode: $mode, supabaseUrl: $supabaseUrl, '
        'supabaseAnonKey: ${supabaseAnonKey != null ? "***" : "null"}, '
        'customApiUrl: $customApiUrl, enableCaching: $enableCaching, '
        'cacheExpiry: $cacheExpiry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiConfig &&
        other.mode == mode &&
        other.supabaseUrl == supabaseUrl &&
        other.supabaseAnonKey == supabaseAnonKey &&
        other.customApiUrl == customApiUrl &&
        other.enableCaching == enableCaching &&
        other.cacheExpiry == cacheExpiry &&
        other.authToken == authToken;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        supabaseUrl.hashCode ^
        supabaseAnonKey.hashCode ^
        customApiUrl.hashCode ^
        enableCaching.hashCode ^
        cacheExpiry.hashCode ^
        authToken.hashCode;
  }
}

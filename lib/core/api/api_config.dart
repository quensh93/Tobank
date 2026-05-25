enum ApiMode {
  mock,
  custom,
}

class ApiConfig {
  final ApiMode mode;
  final String? customApiUrl;
  final bool enableCaching;
  final Duration cacheExpiry;
  final Map<String, String> headers;
  final String? authToken;

  const ApiConfig({
    required this.mode,
    this.customApiUrl,
    this.enableCaching = true,
    this.cacheExpiry = const Duration(minutes: 5),
    this.headers = const {},
    this.authToken,
  });

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

  ApiConfig copyWith({
    ApiMode? mode,
    String? customApiUrl,
    bool? enableCaching,
    Duration? cacheExpiry,
    Map<String, String>? headers,
    String? authToken,
  }) {
    return ApiConfig(
      mode: mode ?? this.mode,
      customApiUrl: customApiUrl ?? this.customApiUrl,
      enableCaching: enableCaching ?? this.enableCaching,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
      headers: headers ?? this.headers,
      authToken: authToken ?? this.authToken,
    );
  }

  @override
  String toString() {
    return 'ApiConfig(mode: $mode, customApiUrl: $customApiUrl, '
        'enableCaching: $enableCaching, cacheExpiry: $cacheExpiry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiConfig &&
        other.mode == mode &&
        other.customApiUrl == customApiUrl &&
        other.enableCaching == enableCaching &&
        other.cacheExpiry == cacheExpiry &&
        other.authToken == authToken;
  }

  @override
  int get hashCode {
    return mode.hashCode ^
        customApiUrl.hashCode ^
        enableCaching.hashCode ^
        cacheExpiry.hashCode ^
        authToken.hashCode;
  }
}

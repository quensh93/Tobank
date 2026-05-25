import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tobank_sdui/core/api/api_config.dart';

part 'api_config_provider.g.dart';

@Riverpod(keepAlive: true)
class ApiConfigNotifier extends _$ApiConfigNotifier {
  @override
  ApiConfig build() {
    const environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: 'development',
    );

    switch (environment) {
      case 'production':
        const apiUrl = String.fromEnvironment('API_URL', defaultValue: '');
        if (apiUrl.isNotEmpty) {
          return ApiConfig.custom(apiUrl);
        }
        return ApiConfig.mock();

      case 'development':
      default:
        return ApiConfig.mock();
    }
  }

  void setConfig(ApiConfig config) {
    state = config;
  }

  void useMockApi() {
    state = ApiConfig.mock(
      enableCaching: state.enableCaching,
      cacheExpiry: state.cacheExpiry,
    );
  }

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

  void updateCachingSettings({bool? enableCaching, Duration? cacheExpiry}) {
    state = state.copyWith(
      enableCaching: enableCaching,
      cacheExpiry: cacheExpiry,
    );
  }

  void updateAuthToken(String? token) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(authToken: token);
    }
  }

  void updateHeaders(Map<String, String> headers) {
    if (state.mode == ApiMode.custom) {
      state = state.copyWith(headers: headers);
    }
  }
}

@riverpod
bool isMockApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.mock;
}

@riverpod
bool isCustomApiEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode == ApiMode.custom;
}

@riverpod
ApiMode currentApiMode(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.mode;
}

@riverpod
bool isCachingEnabled(Ref ref) {
  final config = ref.watch(apiConfigProvider);
  return config.enableCaching;
}

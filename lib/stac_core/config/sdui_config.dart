import 'package:stac/stac.dart';

/// Central configuration for the Server-Driven UI (SDUI) backend.
///
/// Single source of truth for the real config-server connection details and
/// every backend pathKey the app resolves. Avoids hardcoding these values
/// across loaders, services and screens.
///
/// All values are overridable per environment at build time via
/// `--dart-define`, e.g.:
/// ```
/// flutter run \
///   --dart-define=SDUI_CONFIG_BASE_URL=http://staging.host:8101 \
///   --dart-define=SDUI_CONFIG_BUILD=2
/// ```
class SduiConfig {
  const SduiConfig._();

  // --- Screen cache (Stac's built-in cache; SCREENS only, not the 3 tokens) ---

  /// Cache strategy for Stac network screens.
  static const StacCacheStrategy cacheStrategy = StacCacheStrategy.networkFirst;

  /// Max age for cached screens. `null` = no expiry.
  static const Duration? cacheMaxAge = null;

  /// Ready-to-use cache config for `Stac.initialize`.
  static const StacCacheConfig cacheConfig = StacCacheConfig(
    strategy: cacheStrategy,
    maxAge: cacheMaxAge,
  );

  /// Base URL of the real configuration server.
  static const String configBaseUrl = String.fromEnvironment(
    'SDUI_CONFIG_BASE_URL',
    defaultValue: 'http://192.168.179.21:8101',
  );

  /// Base URL of the local mock host (intercepted by [setupStacMockDio]).
  static const String mockBaseUrl = String.fromEnvironment(
    'SDUI_MOCK_BASE_URL',
    defaultValue: 'https://api.tobank.com',
  );

  /// Build/version number sent with every config resolve request.
  static const int configBuild = int.fromEnvironment(
    'SDUI_CONFIG_BUILD',
    defaultValue: 1,
  );

  /// Base URL of the digitalbanking business API (promissory, login, etc.).
  /// Includes the `/api/digitalbanking` path segment.
  static const String bizBaseUrl = String.fromEnvironment(
    'SDUI_BIZ_BASE_URL',
    defaultValue: 'http://192.168.107.22:8280/api/digitalbanking',
  );

  /// Build a full digitalbanking URL from a relative [path].
  static String bizUrl(String path) =>
      '$bizBaseUrl/${path.startsWith('/') ? path.substring(1) : path}';

  /// Common namespace prefix shared by all SDUI pathKeys.
  static const String pathKeyPrefix = String.fromEnvironment(
    'SDUI_PATHKEY_PREFIX',
    defaultValue: 'ipaam.builder.form.form',
  );

  /// Build a fully-qualified pathKey from a leaf [name].
  static String pathKey(String name) => '$pathKeyPrefix.$name';

  /// Endpoint path for resolving a config by [fullPathKey] + [build].
  /// Mirrors `ConfigApiRequest.endpoint`.
  static String resolveEndpoint(String fullPathKey, [int? build]) =>
      '/api/configurations/v1.0/configs/resolve/$fullPathKey/${build ?? configBuild}';

  /// Full real-backend resolve URL for a leaf config [name].
  /// Use in Stac navigate-action `request.url` for per-flow API buttons.
  static String resolveUrl(String name) =>
      '$configBaseUrl${resolveEndpoint(pathKey(name))}';

  /// Full mock URL for a given [path] (e.g. `strings`, `colors`, `assets`).
  static String mockUrl(String path) => '$mockBaseUrl/$path';

  // --- The 3 design configs (loaded into StacRegistry as tokens) ---

  /// pathKey for the strings config (`{{appStrings.*}}`).
  static String get strings => pathKey('strings');

  /// pathKey for the colors config (`{{appColors.*}}`).
  static String get colors => pathKey('colors');

  /// pathKey for the assets config (`{{appAssets.*}}`).
  static String get assets => pathKey('assets');

  // --- Feature flags ---

  /// When true, app starts from the real promissory API flow instead of PreLaunchScreen.
  ///
  /// Usage: flutter run --dart-define=START_APP_FROM_PROMISSORY_REAL_FLOW=true
  static const bool startFromPromissoryRealFlow = bool.fromEnvironment(
    'START_APP_FROM_PROMISSORY_REAL_FLOW',
    defaultValue: false,
  );

  // --- Screens ---

  /// pathKey for the main API-flow splash screen.
  static String get loginRealSplash => pathKey('login_real_splash');
}

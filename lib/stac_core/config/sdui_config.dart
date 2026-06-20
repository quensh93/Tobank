import 'package:flutter/foundation.dart';
import 'package:stac/stac.dart';
import '../navigation/flow_registry.dart';

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
    //defaultValue: 'http://192.168.107.22:8280/api/digitalbanking',
    defaultValue: 'https://stage-esb.arshamnovin.ir/api/digitalbanking',
  );

  /// Build a full digitalbanking URL from a relative [path].
  /// Collapses double slashes that arise when template variables resolve to empty strings.
  static String bizUrl(String path) {
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    final raw = '$bizBaseUrl/$normalizedPath';
    // Replace double slashes except the protocol separator (e.g. https://)
    return raw.replaceAll(RegExp(r'(?<!:)//+'), '/');
  }

  /// Common namespace prefix shared by all SDUI pathKeys.
  ///
  /// The flow segment is inserted between this prefix and the leaf [name] by
  /// [pathKey], e.g. `ipaam.form.mobile` + `home_page` + `tobank_facilities_page`.
  static const String pathKeyPrefix = String.fromEnvironment(
    'SDUI_PATHKEY_PREFIX',
    defaultValue: 'ipaam.form.mobile',
  );

  /// Build a fully-qualified pathKey from a leaf [name].
  ///
  /// Flow-aware: derives the owning flow via [FlowRegistry.flowOf] so the
  /// result matches the backend layout `<prefix>.<flow>.<name>` (same
  /// convention as localJson asset paths). Falls back to `<prefix>.<name>`
  /// when no flow matches.
  static String pathKey(String name) {
    final flow = FlowRegistry.flowOf(name);
    return flow != null
        ? '$pathKeyPrefix.$flow.$name'
        : '$pathKeyPrefix.$name';
  }

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
  static String get strings => 'ipaam.form.mobile.config.strings';

  /// pathKey for the colors config (`{{appColors.*}}`).
  static String get colors => 'ipaam.form.mobile.config.colors';

  /// pathKey for the assets config (`{{appAssets.*}}`).
  static String get assets => 'ipaam.form.mobile.config.assets';

  // --- Feature flags ---

  /// When true, app starts from the server-driven API flow (fetches the
  /// `login_real_splash` screen from the real backend) instead of PreLaunchScreen.
  ///
  /// Defaults to [kReleaseMode]: release builds (end-user APK) start from the API
  /// flow automatically; debug builds open PreLaunchScreen (dev menu). Override
  /// either way with `--dart-define=START_APP_FROM_API=true|false`.
  static const bool startFromApi = bool.fromEnvironment(
    'START_APP_FROM_API',
    defaultValue: kReleaseMode,
  );

  // --- Screens ---

  /// pathKey for the main API-flow splash screen.
  static String get loginRealSplash => pathKey('login_real_splash');

  /// pathKey for the dashboard shell screen.
  static String get dashboardShell => 'ipaam.form.mobile.dashboard.dashboard_shell';
}

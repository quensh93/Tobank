import 'package:flutter/foundation.dart';
import 'package:stac/stac.dart';

import 'sdui_build_config.dart';

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
  static const String configBaseUrl = SduiBuildConfig.configBaseUrl;

  /// Base URL of the local mock host (intercepted by [setupStacMockDio]).
  static const String mockBaseUrl = SduiBuildConfig.mockBaseUrl;

  /// Build/version number sent with every config resolve request.
  static const int configBuild = SduiBuildConfig.configBuild;

  /// Base URL of the digitalbanking business API (promissory, login, etc.).
  /// Includes the `/api/digitalbanking` path segment.
  static const String bizBaseUrl = SduiBuildConfig.bizBaseUrl;

  /// Build a full digitalbanking URL from a relative [path].
  /// Collapses double slashes that arise when template variables resolve to empty strings.
  static String bizUrl(String path) => SduiBuildConfig.bizUrl(path);

  /// Common namespace prefix shared by all SDUI pathKeys.
  ///
  /// The flow segment is inserted between this prefix and the leaf [name] by
  /// [pathKey], e.g. `ipaam.form.mobile` + `home_page` + `tobank_facilities_page`.
  static const String pathKeyPrefix = SduiBuildConfig.pathKeyPrefix;

  /// Build a fully-qualified pathKey from a leaf [name].
  ///
  /// Flow-aware: derives the owning flow via [FlowRegistry.flowOf] so the
  /// result matches the backend layout `<prefix>.<flow>.<name>` (same
  /// convention as localJson asset paths). Falls back to `<prefix>.<name>`
  /// when no flow matches.
  static String pathKey(String name) => SduiBuildConfig.pathKey(name);

  /// Endpoint path for resolving a config by [fullPathKey] + [build].
  /// Mirrors `ConfigApiRequest.endpoint`.
  static String resolveEndpoint(String fullPathKey, [int? build]) =>
      SduiBuildConfig.resolveEndpoint(fullPathKey, build);

  /// Full real-backend resolve URL for a leaf config [name].
  /// Use in Stac navigate-action `request.url` for per-flow API buttons.
  static String resolveUrl(String name) => SduiBuildConfig.resolveUrl(name);

  /// Full mock URL for a given [path] (e.g. `strings`, `colors`, `assets`).
  static String mockUrl(String path) => SduiBuildConfig.mockUrl(path);

  // --- The 3 design configs (loaded into StacRegistry as tokens) ---

  /// pathKey for the strings config (`{{appStrings.*}}`).
  static String get strings => SduiBuildConfig.strings;

  /// pathKey for the colors config (`{{appColors.*}}`).
  static String get colors => SduiBuildConfig.colors;

  /// pathKey for the assets config (`{{appAssets.*}}`).
  static String get assets => SduiBuildConfig.assets;

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
  static String get loginRealSplash => SduiBuildConfig.loginRealSplash;

  /// pathKey for the dashboard shell screen.
  static String get dashboardShell => SduiBuildConfig.dashboardShell;
}

import '../navigation/flow_registry.dart';

/// Pure Dart SDUI configuration that is safe to import from STAC DSL files.
///
/// Keep this file free of Flutter and `package:stac/stac.dart` imports so
/// `stac build` can execute annotated screens in its Dart-only environment.
class SduiBuildConfig {
  const SduiBuildConfig._();

  /// Base URL of the real configuration server.
  static const String configBaseUrl = String.fromEnvironment(
    'SDUI_CONFIG_BASE_URL',
    defaultValue: 'http://192.168.179.21:8101',
  );

  /// Base URL of the local mock host (intercepted by setupStacMockDio).
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
    defaultValue: 'https://stage-esb.arshamnovin.ir/api/digitalbanking',
  );

  /// Build a full digitalbanking URL from a relative [path].
  /// Collapses double slashes that arise when template variables resolve to
  /// empty strings.
  static String bizUrl(String path) {
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    final raw = '$bizBaseUrl/$normalizedPath';
    return raw.replaceAll(RegExp(r'(?<!:)//+'), '/');
  }

  /// Common namespace prefix shared by all SDUI pathKeys.
  static const String pathKeyPrefix = String.fromEnvironment(
    'SDUI_PATHKEY_PREFIX',
    defaultValue: 'ipaam.form.mobile',
  );

  /// Build a fully-qualified pathKey from a leaf [name].
  static String pathKey(String name) {
    final flow = FlowRegistry.flowOf(name);
    return flow != null
        ? '$pathKeyPrefix.$flow.$name'
        : '$pathKeyPrefix.$name';
  }

  /// Endpoint path for resolving a config by [fullPathKey] + [build].
  static String resolveEndpoint(String fullPathKey, [int? build]) =>
      '/api/configurations/v1.0/configs/resolve/$fullPathKey/${build ?? configBuild}';

  /// Full real-backend resolve URL for a leaf config [name].
  static String resolveUrl(String name) =>
      '$configBaseUrl${resolveEndpoint(pathKey(name))}';

  /// Full mock URL for a given [path] (e.g. `strings`, `colors`, `assets`).
  static String mockUrl(String path) => '$mockBaseUrl/$path';

  /// pathKey for the strings config (`{{appStrings.*}}`).
  static String get strings => 'ipaam.form.mobile.config.strings';

  /// pathKey for the colors config (`{{appColors.*}}`).
  static String get colors => 'ipaam.form.mobile.config.colors';

  /// pathKey for the assets config (`{{appAssets.*}}`).
  static String get assets => 'ipaam.form.mobile.config.assets';

  /// pathKey for the main API-flow splash screen.
  static String get loginRealSplash => pathKey('login_real_splash');

  /// pathKey for the dashboard shell screen.
  static String get dashboardShell =>
      'ipaam.form.mobile.dashboard.dashboard_shell';
}

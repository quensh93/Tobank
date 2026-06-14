import 'package:dio/dio.dart';
import 'stac_mock_interceptor.dart';

/// Sets up Dio instance with custom mock interceptor for STAC dynamicView
///
/// This allows STAC's dynamicView to use mocked API responses from JSON files
/// stored in `stac/tobank/{feature}/api/` directories.
///
/// **Usage:**
/// ```dart
/// final dio = setupStacMockDio();
/// await Stac.initialize(options: defaultStacOptions, dio: dio);
/// ```
///
/// **Mock File Structure:**
/// - `stac/tobank/flows/login/api/GET_login_splash.json` - Flow screen JSONs
/// - `stac/tobank/menu/api/GET_menu-items.json` - Data APIs organized by feature
///
/// **File Naming Convention:**
/// - Format: `{METHOD}_{name}.json`
/// - Example: `GET_login_splash.json` for screen JSONs
/// - Example: `GET_menu-items.json` for data APIs
///
/// **URL Mapping:**
/// - Flow URLs like `https://api.tobank.com/flows/login/login_splash` map to
///   `stac/tobank/flows/login/api/GET_login_splash.json` (returns JSON directly, not wrapped)
/// - Data URLs like `https://api.tobank.com/menu-items` map to
///   `stac/tobank/menu/api/GET_menu-items.json` (returns wrapped in {"data": {...}})
Dio setupStacMockDio() {
  final dio = Dio();
  dio.interceptors.add(StacMockInterceptor());
  return dio;
}

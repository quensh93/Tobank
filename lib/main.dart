import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';
import 'core/stac/registry/register_custom_parsers.dart';
import 'core/stac/mock/stac_mock_dio_setup.dart';
import 'core/stac/loaders/tobank/tobank_strings_loader.dart';
import 'core/stac/loaders/tobank/tobank_styles_loader.dart';
import 'core/stac/loaders/tobank/tobank_colors_loader.dart';
import 'core/stac/loaders/tobank/tobank_assets_loader.dart';
import 'core/stac/utils/variable_resolver_debug.dart';
import 'core/bootstrap/bootstrap.dart';
import 'stac/default_stac_options.dart';

void main() async {
  // CRITICAL: Initialize Flutter bindings FIRST
  // Required for rootBundle.loadString() in mock interceptor
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Dio with MockInterceptor for STAC dynamicView
  // This allows dynamicView to use mocked API responses from stac/tobank/{feature}/api/
  final stacDio = setupStacMockDio();

  // Initialize STAC framework with options and mocked Dio
  await Stac.initialize(options: defaultStacOptions, dio: stacDio);

  // Register custom STAC parsers
  await registerCustomParsers();

  // Load localization strings ONCE at app startup
  // Strings are stored in StacRegistry and accessible via {{appStrings.*}} syntax
  await TobankStringsLoader.loadStrings(stacDio);

  // Load color schema ONCE at app startup
  // Colors are stored in StacRegistry and accessible via {{appColors.*}} syntax
  await TobankColorsLoader.loadColors(stacDio);

  // Load component styles ONCE at app startup
  // Styles are stored in StacRegistry and accessible via {{appStyles.*}} syntax
  // NOTE: Styles should be loaded AFTER colors since styles reference colors
  await TobankStylesLoader.loadStyles(stacDio);

  // Load assets configuration ONCE at app startup
  // Assets are stored in StacRegistry and accessible via {{appAssets.*}} syntax
  await TobankAssetsLoader.loadAssets(stacDio);

  // Debug: Test variable resolution after strings are loaded
  if (kDebugMode) {
    VariableResolverDebug.testCommonVariables();
  }

  // Use bootstrap for app initialization
  await bootstrap();
}

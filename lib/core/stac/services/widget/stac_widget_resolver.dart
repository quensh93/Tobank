import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../mock/stac_mock_dio_setup.dart' as mock_setup;
import '../path/stac_path_normalizer.dart';
import '../theme/stac_theme_wrapper.dart';

/// Service for resolving widgets from different sources (JSON, network, assets).
/// 
/// Follows Single Responsibility Principle - only responsible for widget resolution.
/// 
/// Follows Dependency Inversion Principle - depends on abstractions (services)
/// rather than concrete implementations.
class StacWidgetResolver {
  StacWidgetResolver._();

  /// Resolves a widget from widgetJson.
  /// Returns the widget wrapped with theme, or null if parsing fails.
  static Widget? resolveFromJson(
    BuildContext context,
    Map<String, dynamic>? widgetJson,
  ) {
    if (widgetJson == null) {
      return null;
    }

    final parsedWidget = Stac.fromJson(widgetJson, context);
    return parsedWidget != null
        ? StacThemeWrapper.wrapWithTheme(context, parsedWidget)
        : null;
  }

  /// Resolves a widget from a network request.
  /// Returns the widget wrapped with theme.
  static Widget resolveFromNetwork(
    BuildContext context,
    StacNetworkRequest request,
  ) {
    final parsedWidget = Stac.fromNetwork(context: context, request: request);
    return StacThemeWrapper.wrapWithTheme(context, parsedWidget);
  }

  /// Resolves a widget from an asset path.
  /// Handles both API files and regular JSON files.
  /// Returns the widget wrapped with theme.
  static Future<Widget> resolveFromAssetPath(
    BuildContext context,
    String assetPath,
  ) async {
    final normalizedPath = StacPathNormalizer.normalizeAssetPath(assetPath);

    // Check if this is an API file
    if (StacPathNormalizer.isApiFile(normalizedPath)) {
      final url = StacPathNormalizer.convertAssetPathToApiUrl(normalizedPath);
      if (url != null) {
        final parsedWidget = Stac.fromNetwork(
          context: context,
          request: StacNetworkRequest(url: url, method: Method.get),
        );
        return StacThemeWrapper.wrapWithTheme(context, parsedWidget);
      }
    }

    // Regular JSON file - load from assets and resolve variables before parsing
    try {
      final jsonString = await DefaultAssetBundle.of(context)
          .loadString(normalizedPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      // Resolve variables preserving types (especially for numeric values)
      final resolvedJson = mock_setup.resolveVariablesPreservingTypes(
        jsonData,
        StacRegistry.instance,
      );

      // Parse the resolved JSON
      final parsedWidget = Stac.fromJson(resolvedJson, context);
      return StacThemeWrapper.wrapWithTheme(
        context,
        parsedWidget ?? const SizedBox(),
      );
    } catch (e) {
      // If manual loading fails, fallback to Stac.fromAssets
      final parsedWidget = Stac.fromAssets(normalizedPath);
      return StacThemeWrapper.wrapWithTheme(context, parsedWidget);
    }
  }

  /// Resolves a widget from a route name.
  /// Returns the widget wrapped with theme.
  static Widget resolveFromRouteName(BuildContext context, String routeName) {
    return StacThemeWrapper.wrapWithTheme(
      context,
      Stac(routeName: routeName),
    );
  }
}

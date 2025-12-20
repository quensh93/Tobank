import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../features/pre_launch/providers/theme_controller_provider.dart';
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
  /// Returns the widget wrapped with theme-awareness (rebuilds on theme change).
  static Widget? resolveFromJson(
    BuildContext context,
    Map<String, dynamic>? widgetJson,
  ) {
    if (widgetJson == null) {
      return null;
    }

    // Wrap in theme-reactive builder that rebuilds when theme changes
    return _ThemeReactiveStacWidget(
      builder: (ctx) {
        final parsedWidget = Stac.fromJson(widgetJson, ctx);
        return parsedWidget != null
            ? StacThemeWrapper.wrapWithTheme(ctx, parsedWidget)
            : const SizedBox.shrink();
      },
    );
  }

  /// Resolves a widget from a network request.
  /// Returns the widget wrapped with theme-awareness.
  static Widget resolveFromNetwork(
    BuildContext context,
    StacNetworkRequest request,
  ) {
    return _ThemeReactiveStacWidget(
      builder: (ctx) {
        final parsedWidget = Stac.fromNetwork(context: ctx, request: request);
        return StacThemeWrapper.wrapWithTheme(ctx, parsedWidget);
      },
    );
  }

  /// Resolves a widget from an asset path.
  /// Handles both API files and regular JSON files.
  /// Returns the widget wrapped with theme-awareness.
  static Future<Widget> resolveFromAssetPath(
    BuildContext context,
    String assetPath,
  ) async {
    final normalizedPath = StacPathNormalizer.normalizeAssetPath(assetPath);

    // Check if this is an API file
    if (StacPathNormalizer.isApiFile(normalizedPath)) {
      final url = StacPathNormalizer.convertAssetPathToApiUrl(normalizedPath);
      if (url != null) {
        return _ThemeReactiveStacWidget(
          builder: (ctx) {
            final parsedWidget = Stac.fromNetwork(
              context: ctx,
              request: StacNetworkRequest(url: url, method: Method.get),
            );
            return StacThemeWrapper.wrapWithTheme(ctx, parsedWidget);
          },
        );
      }
    }

    // Regular JSON file - load from assets and resolve variables before parsing
    // For asset files, we need to load the content first
    try {
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString(normalizedPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      return _ThemeReactiveStacWidget(
        builder: (ctx) {
          // Resolve variables preserving types (especially for numeric values)
          final resolvedJson = mock_setup.resolveVariablesPreservingTypes(
            jsonData,
            StacRegistry.instance,
          );

          // Parse the resolved JSON
          final parsedWidget = Stac.fromJson(resolvedJson, ctx);
          return StacThemeWrapper.wrapWithTheme(
            ctx,
            parsedWidget ?? const SizedBox(),
          );
        },
      );
    } catch (e) {
      // If manual loading fails, fallback to Stac.fromAssets
      return _ThemeReactiveStacWidget(
        builder: (ctx) {
          final parsedWidget = Stac.fromAssets(normalizedPath);
          return StacThemeWrapper.wrapWithTheme(ctx, parsedWidget);
        },
      );
    }
  }

  /// Resolves a widget from a route name.
  /// Returns the widget wrapped with theme-awareness.
  static Widget resolveFromRouteName(BuildContext context, String routeName) {
    return _ThemeReactiveStacWidget(
      builder: (ctx) {
        return StacThemeWrapper.wrapWithTheme(ctx, Stac(routeName: routeName));
      },
    );
  }
}

/// Internal widget that rebuilds STAC content when theme changes.
///
/// Watches [themeControllerProvider] and triggers a rebuild when theme toggles,
/// causing the STAC JSON to be re-parsed with updated registry color values.
class _ThemeReactiveStacWidget extends ConsumerWidget {
  const _ThemeReactiveStacWidget({required this.builder});

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme controller - this triggers rebuild when theme changes
    final themeState = ref.watch(themeControllerProvider);

    // Log for debugging (only in debug mode)
    final themeMode = themeState.maybeWhen(
      data: (mode) => mode,
      orElse: () => ThemeMode.system,
    );
    debugPrint(
      '🎨 _ThemeReactiveStacWidget rebuilding for theme: ${themeMode.name}',
    );

    return builder(context);
  }
}

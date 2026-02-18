import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../features/pre_launch/providers/theme_controller_provider.dart';
import '../../mock/stac_mock_dio_setup.dart' as mock_setup;
import '../path/stac_path_normalizer.dart';
import '../theme/stac_theme_wrapper.dart';
import '../../utils/reactive_button_action_tunneler.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

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

    final tunneledJson = Map<String, dynamic>.from(
      tunnelReactiveButtonActions(widgetJson) as Map,
    );

    // Wrap in theme-reactive builder that rebuilds when theme changes
    return _ThemeReactiveStacWidget(
      builder: (ctx) {
        final parsedWidget = Stac.fromJson(tunneledJson, ctx);
        return parsedWidget != null
            ? StacThemeWrapper.wrapWithTheme(ctx, parsedWidget)
            : const SizedBox.shrink();
      },
    );
  }

  /// Resolves a widget from a network request.
  /// Returns the widget wrapped with theme-awareness.
  /// Resolves a widget from a network request.
  /// Returns the widget wrapped with theme-awareness.
  static Widget resolveFromNetwork(
    BuildContext context,
    StacNetworkRequest request,
  ) {
    return _ThemeReactiveStacWidget(
      builder: (ctx) {
        // Use FutureBuilder to handle manual request and extraction
        // This is necessary because some APIs return nested JSON (e.g. data.content[0].value)
        // and Stac.fromNetwork expects the widget definition at the root.
        return FutureBuilder<dynamic>(
          future: StacNetworkService.request(ctx, request),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              AppLogger.e('StacWidgetResolver: Network error', snapshot.error);
              return Scaffold(
                appBar: AppBar(title: const Text('Error')),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Scaffold(body: SizedBox.shrink());
            }

            final response = snapshot.data;
            final data = response.data;

            // Extract the actual widget JSON from nested structure if needed
            final widgetJson = _extractWidgetJson(data);

            if (widgetJson == null || widgetJson.isEmpty) {
              AppLogger.w(
                'StacWidgetResolver: No widget data found in response',
              );
              return const Center(child: Text('No widget data found'));
            }

            // Tunnel reactive button actions before any variable resolution.
            final tunneledJson = tunnelReactiveButtonActions(widgetJson);

            // Resolve variables preserving types
            final resolvedJson = mock_setup.resolveVariablesPreservingTypes(
              tunneledJson,
              StacRegistry.instance,
            );

            // Parse the widget
            final parsedWidget = Stac.fromJson(resolvedJson, ctx);
            return StacThemeWrapper.wrapWithTheme(
              ctx,
              parsedWidget ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  /// Extracts widget JSON from various nested structures
  static Map<String, dynamic>? _extractWidgetJson(dynamic data) {
    if (data is! Map<String, dynamic>) {
      return null;
    }

    // Check for IPAAM/Builder structure: data -> content -> [0] -> value
    if (data.containsKey('data') && data['data'] is Map) {
      final innerData = data['data'];
      if (innerData.containsKey('content') && innerData['content'] is List) {
        final content = innerData['content'] as List;
        if (content.isNotEmpty && content.first is Map) {
          final item = content.first as Map;
          if (item.containsKey('value') && item['value'] is Map) {
            return item['value'] as Map<String, dynamic>;
          }
        }
      }
    }

    // Default: Check if the root has "type" (standard STAC)
    if (data.containsKey('type')) {
      return data;
    }

    // Default 2: Check standard API wrapper: data -> (widget)
    if (data.containsKey('data') &&
        data['data'] is Map &&
        (data['data'] as Map).containsKey('type')) {
      return data['data'] as Map<String, dynamic>;
    }

    // If we have a map but no type, return it anyway (Stac.fromJson might handle it or fail gracefully)
    return data;
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
      AppLogger.dc(
        LogCategory.stacNavigation,
        'StacWidgetResolver: Attempting to load asset: $normalizedPath',
      );
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString(normalizedPath);
      AppLogger.dc(
        LogCategory.stacNavigation,
        'StacWidgetResolver: Successfully loaded asset: $normalizedPath',
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      return _ThemeReactiveStacWidget(
        builder: (ctx) {
          // Tunnel reactive button actions before any variable resolution.
          final tunneledJson = tunnelReactiveButtonActions(jsonData);

          // Resolve variables preserving types (especially for numeric values)
          final resolvedJson = mock_setup.resolveVariablesPreservingTypes(
            tunneledJson,
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
      AppLogger.e(
        'StacWidgetResolver: Failed to load asset: $normalizedPath',
        e,
      );
      // If manual loading fails, fallback to Stac.fromAssets
      AppLogger.ic(
        LogCategory.stacNavigation,
        'StacWidgetResolver: Falling back to Stac.fromAssets for: $normalizedPath',
      );
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
    AppLogger.dc(
      LogCategory.stacTheme,
      'ThemeReactiveStacWidget rebuilding for theme: ${themeMode.name}',
    );

    return builder(context);
  }
}

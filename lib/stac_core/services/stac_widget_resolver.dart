import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stac/stac.dart';
import 'theme/theme_controller_provider.dart';
import '../utils/variable_resolver.dart' as variable_resolver;
import 'path/stac_path_normalizer.dart';
import 'theme/stac_theme_wrapper.dart';
import '../utils/reactive_button_action_tunneler.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

/// Service for resolving widgets from different sources (JSON, network, assets).
///
/// Follows Single Responsibility Principle - only responsible for widget resolution.
///
/// Follows Dependency Inversion Principle - depends on abstractions (services)
/// rather than concrete implementations.
class StacWidgetResolver {
  StacWidgetResolver._();

  static const String _dashboardShellJsonPath =
      'lib/stac/tobank/flows/dashboard/json/dashboard_shell.json';
  static const String _dashboardShellKey = 'dashboard_shell';
  static const String _depositTurnoverIntroJsonPath =
      'lib/stac/tobank/flows/deposit_turnover/json/deposit_turnover_intro.json';
  static const String _depositMoreIntroJsonPath =
      'lib/stac/tobank/flows/deposit_more/json/deposit_more_intro.json';

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
    if (_shouldSingleParseNetworkRequest(request)) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        'StacWidgetResolver: Using single-fetch cache for network request: ${request.url}',
      );
      return _SingleParseStacNetworkWidget(request: request);
    }

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
            final resolvedJson = variable_resolver.resolveVariablesPreservingTypes(
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

  static bool _isDashboardShellNetworkRequest(StacNetworkRequest request) {
    final url = request.url.toLowerCase();
    return url.contains(_dashboardShellKey);
  }

  static bool _isDepositMoreIntroNetworkRequest(StacNetworkRequest request) {
    final url = request.url.toLowerCase();
    return url.contains('ipaam.builder.form.form.deposit_more_intro');
  }

  static bool _isDepositTurnoverIntroNetworkRequest(StacNetworkRequest request) {
    final url = request.url.toLowerCase();
    return url.contains('ipaam.builder.form.form.deposit_turnover_intro');
  }

  static bool _shouldSingleParseNetworkRequest(StacNetworkRequest request) {
    return _isDashboardShellNetworkRequest(request) ||
        _isDepositMoreIntroNetworkRequest(request) ||
        _isDepositTurnoverIntroNetworkRequest(request);
  }

  static bool _shouldSingleParseAssetPath(String normalizedPath) {
    return normalizedPath == _dashboardShellJsonPath ||
        normalizedPath == _depositMoreIntroJsonPath ||
        normalizedPath == _depositTurnoverIntroJsonPath;
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
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString(normalizedPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      // Dashboard shell must remain stable while navigating to child pages.
      // Parse it once and reuse the same widget tree to avoid bottom-nav resets
      // when returning with back navigation.
      if (_shouldSingleParseAssetPath(normalizedPath)) {
        return _SingleParseStacAssetWidget(
          assetPath: normalizedPath,
          rawJson: jsonData,
        );
      }

      return _ThemeReactiveStacWidget(
        builder: (ctx) {
          // Tunnel reactive button actions before any variable resolution.
          final tunneledJson = tunnelReactiveButtonActions(jsonData);

          // Resolve variables preserving types (especially for numeric values)
          final resolvedJson = variable_resolver.resolveVariablesPreservingTypes(
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

/// Keeps a parsed STAC asset widget alive for the lifetime of this route.
///
/// This is intentionally used for dashboard shell JSON so back navigation
/// from pushed pages does not recreate the shell widget tree.
class _SingleParseStacAssetWidget extends StatefulWidget {
  const _SingleParseStacAssetWidget({
    required this.assetPath,
    required this.rawJson,
  });

  final String assetPath;
  final Map<String, dynamic> rawJson;

  @override
  State<_SingleParseStacAssetWidget> createState() =>
      _SingleParseStacAssetWidgetState();
}

class _SingleParseStacAssetWidgetState
    extends State<_SingleParseStacAssetWidget> {
  Widget? _parsedWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_parsedWidget != null) return;

    try {
      final tunneledJson = tunnelReactiveButtonActions(widget.rawJson);
      final resolvedJson = variable_resolver.resolveVariablesPreservingTypes(
        tunneledJson,
        StacRegistry.instance,
      );

      _parsedWidget = Stac.fromJson(resolvedJson, context) ?? const SizedBox();
    } catch (e) {
      AppLogger.e(
        'StacWidgetResolver: Failed to initialize single-parse cache for ${widget.assetPath}',
        e,
      );
      _parsedWidget = const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StacThemeWrapper.wrapWithTheme(
      context,
      _parsedWidget ?? const SizedBox(),
    );
  }
}

/// Keeps a fetched STAC network widget alive for the lifetime of this route.
///
/// Used for dashboard shell network loading to avoid re-fetch and re-parse
/// when returning from pushed pages via back navigation.
class _SingleParseStacNetworkWidget extends StatefulWidget {
  const _SingleParseStacNetworkWidget({required this.request});

  final StacNetworkRequest request;

  @override
  State<_SingleParseStacNetworkWidget> createState() =>
      _SingleParseStacNetworkWidgetState();
}

class _SingleParseStacNetworkWidgetState
    extends State<_SingleParseStacNetworkWidget> {
  Future<Map<String, dynamic>?>? _resolvedJsonFuture;
  Widget? _parsedWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolvedJsonFuture ??= _loadResolvedJson();
  }

  Future<Map<String, dynamic>?> _loadResolvedJson() async {
    final response = await StacNetworkService.request(context, widget.request);
    final data = response?.data;

    final widgetJson = StacWidgetResolver._extractWidgetJson(data);
    if (widgetJson == null || widgetJson.isEmpty) {
      AppLogger.w('StacWidgetResolver: No widget data found in response');
      return null;
    }

    final tunneledJson = tunnelReactiveButtonActions(widgetJson);
    final resolvedJson = variable_resolver.resolveVariablesPreservingTypes(
      tunneledJson,
      StacRegistry.instance,
    );

    if (resolvedJson is Map<String, dynamic>) {
      return resolvedJson;
    }
    if (resolvedJson is Map) {
      return Map<String, dynamic>.from(resolvedJson);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _resolvedJsonFuture,
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

        final resolvedJson = snapshot.data;
        if (resolvedJson == null || resolvedJson.isEmpty) {
          return const Scaffold(body: SizedBox.shrink());
        }

        _parsedWidget ??=
            Stac.fromJson(resolvedJson, context) ?? const SizedBox.shrink();
        return StacThemeWrapper.wrapWithTheme(
          context,
          _parsedWidget ?? const SizedBox.shrink(),
        );
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

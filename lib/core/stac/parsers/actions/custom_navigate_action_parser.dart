import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
// import 'package:stac_framework/stac_framework.dart';
import '../../services/widget/stac_widget_loader.dart';
import '../../services/widget/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';
import '../../../helpers/logger.dart';

/// Custom navigation action parser with enhanced functionality.
///
/// This parser extends the default navigation behavior with:
/// 1. **Theme wrapping**: Wraps all navigated widgets with a custom theme
/// 2. **Dart widget support**: Handles navigation to Dart STAC screens
/// 3. **Flow config support**: Handles navigation to config-driven flow screens
///
/// **SOLID Principles Applied:**
/// - **Single Responsibility**: Only responsible for parsing navigation actions
///   and orchestrating widget resolution and navigation
/// - **Open/Closed**: Extensible through service registration (widget loaders, themes)
/// - **Dependency Inversion**: Depends on service abstractions, not concrete implementations
class CustomNavigateActionParser extends StacActionParser<StacNavigateAction> {
  const CustomNavigateActionParser();

  @override
  String get actionType => ActionType.navigate.name;

  @override
  StacNavigateAction getModel(Map<String, dynamic> json) {
    // Prefer assetPath/apiPath over widgetType when both are present
    // This ensures API JSON files (with onChanged actions) are used instead of Dart-generated JSON
    final assetPathValue = json['assetPath'];
    final hasAssetPath =
        assetPathValue != null &&
        assetPathValue.toString().isNotEmpty &&
        assetPathValue.toString() != 'null';

    final widgetType = json['widgetType'];
    final routeName = json['routeName'];
    final navigationStyleValue = json['navigationStyle']?.toString();
    final isPushStyleRoute =
        navigationStyleValue == null ||
        navigationStyleValue == NavigationStyle.push.name ||
        navigationStyleValue == NavigationStyle.pushReplacement.name ||
        navigationStyleValue == NavigationStyle.pushAndRemoveAll.name;
    final canUseRouteAsWidgetType =
        routeName is String &&
        routeName.isNotEmpty &&
        !routeName.startsWith('/') &&
        isPushStyleRoute;

    AppLogger.dc(
      LogCategory.stacNavigation,
      '🔍 Navigation getModel: widgetType=$widgetType, assetPath=$assetPathValue, hasAssetPath=$hasAssetPath',
    );

    // If assetPath exists (even if it's a variable like {{apiPath}}), prefer it over widgetType
    // Keep both in the JSON so we can resolve the variable in onCall
    if (hasAssetPath && widgetType is String) {
      // Don't remove widgetType yet - we'll check assetPath first in onCall
      // But mark that we prefer assetPath by keeping it
      AppLogger.dc(
        LogCategory.stacNavigation,
        '✅ Navigation: Preferring assetPath over widgetType. assetPath=$assetPathValue (may be variable)',
      );
    } else if (widgetType is String && !hasAssetPath) {
      // Only use widgetType if assetPath is not available
      // Special handling for flow config widgets - don't remove widgetType

      final widgetJson = StacWidgetLoader.loadWidgetJson(widgetType);
      if (widgetJson != null) {
        json = Map<String, dynamic>.from(json);
        json['widgetJson'] = widgetJson;
        // Store widgetType in widgetJson so we can use it in onCall to construct API path
        json['widgetJson']!['_originalWidgetType'] = widgetType;
        // Don't remove widgetType yet - we might need it in onCall
        AppLogger.dc(
          LogCategory.stacNavigation,
          '✅ Navigation: Loaded widget from widgetType: $widgetType',
        );
      }
    } else if (canUseRouteAsWidgetType && !hasAssetPath) {
      // Support typed StacNavigateAction(routeName: 'stac_screen_name')
      // by treating routeName as a Dart STAC widget key when possible.
      final routeWidgetJson = StacWidgetLoader.loadWidgetJson(routeName);
      if (routeWidgetJson != null) {
        json = Map<String, dynamic>.from(json);
        json['widgetJson'] = routeWidgetJson;
        json['widgetJson']!['_originalWidgetType'] = routeName;
        AppLogger.dc(
          LogCategory.stacNavigation,
          'Navigation: Loaded widget from routeName: $routeName',
        );
      }
    }
    return StacNavigateAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    Widget? widget;

    AppLogger.dc(
      LogCategory.stacNavigation,
      '🔍 Navigation onCall: widgetJson=${model.widgetJson != null}, request=${model.request != null}, assetPath=${model.assetPath}',
    );

    // Resolve assetPath if it's a variable (e.g., {{apiPath}})
    // Note: {{apiPath}} comes from menu item data context, not StacRegistry
    // The variable should be resolved by the dynamic view before the action is created
    // But if it's not resolved, we'll construct it from widgetType as a fallback
    String? resolvedAssetPath = model.assetPath;

    // Keep local JSON asset paths as-is in offline/local mode.
    // Do not auto-convert `/json/*.json` to `/api/GET_*.json`.
    if (resolvedAssetPath != null &&
        resolvedAssetPath.isNotEmpty &&
        resolvedAssetPath != 'null' &&
        !resolvedAssetPath.contains('{{')) {
      if (resolvedAssetPath.contains('/json/')) {
        AppLogger.dc(
          LogCategory.stacNavigation,
          '✅ Navigation: Keeping local JSON assetPath (no API conversion): $resolvedAssetPath',
        );
      }
    }

    // Check if assetPath is null or empty
    final hasWidgetJson = model.widgetJson != null;
    final widgetTypeForLog = hasWidgetJson
        ? (model.widgetJson!['_originalWidgetType'] as String?)
        : null;

    if (resolvedAssetPath == null ||
        resolvedAssetPath.isEmpty ||
        resolvedAssetPath == 'null') {
      if (hasWidgetJson) {
        // We already have the Dart widget JSON, no need to construct assetPath
        AppLogger.dc(
          LogCategory.stacNavigation,
          '✅ Navigation: Using Dart widget JSON (widgetType=$widgetTypeForLog). No assetPath needed.',
        );
      } else {
        AppLogger.wc(
          LogCategory.stacNavigation,
          '⚠️ Navigation: assetPath is null/empty and no widgetJson. Attempting to construct from widgetType...',
        );

        String? widgetType = model.routeName;

        if (widgetType == null) {
          AppLogger.wc(
            LogCategory.stacNavigation,
            '⚠️ Navigation: widgetType not found, cannot construct API path',
          );
        } else if (widgetType.startsWith('tobank_')) {
          final withoutPrefix = widgetType.substring(7);

          if (withoutPrefix.contains('_flow_')) {
            final parts = withoutPrefix.split('_');
            final flowIndex = parts.indexOf('flow');
            if (flowIndex >= 0 && flowIndex + 1 < parts.length) {
              final flowNameParts = parts.sublist(0, flowIndex + 2);
              final flowName = flowNameParts.join('_');
              final screenName = withoutPrefix;
              resolvedAssetPath =
                  'lib/stac/tobank/flows/$flowName/api/GET_$screenName.json';
            } else {
              resolvedAssetPath =
                  'lib/stac/tobank/flows/$withoutPrefix/api/GET_$withoutPrefix.json';
            }
          } else {
            resolvedAssetPath =
                'lib/stac/tobank/$withoutPrefix/api/GET_tobank_$withoutPrefix.json';
          }
          AppLogger.dc(
            LogCategory.stacNavigation,
            '✅ Navigation: Constructed assetPath from widgetType: $resolvedAssetPath',
          );
        }

        if (resolvedAssetPath == null) {
          AppLogger.wc(
            LogCategory.stacNavigation,
            '⚠️ Navigation: Could not construct assetPath',
          );
        }
      }
    } else if (resolvedAssetPath.contains('{{')) {
      AppLogger.wc(
        LogCategory.stacNavigation,
        '⚠️ Navigation: assetPath is still a variable: $resolvedAssetPath',
      );
      AppLogger.wc(
        LogCategory.stacNavigation,
        '⚠️ Navigation: Cannot resolve {{apiPath}} from menu item data in onCall',
      );
      resolvedAssetPath = null;
    } else {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '✅ Navigation: assetPath is resolved: $resolvedAssetPath',
      );
    }

    // Resolve widget from different sources using the resolver service
    // Priority: widgetJson (Dart) > assetPath (JSON/API) > network > routeName
    if (model.widgetJson != null) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '✅ Navigation: Using pre-loaded widgetJson (Dart builder) for widgetType=$widgetTypeForLog',
      );
      widget = StacWidgetResolver.resolveFromJson(context, model.widgetJson);
    } else if (resolvedAssetPath != null &&
        resolvedAssetPath.isNotEmpty &&
        resolvedAssetPath != 'null') {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '✅ Navigation: Using assetPath: $resolvedAssetPath',
      );
      widget = await StacWidgetResolver.resolveFromAssetPath(
        context,
        resolvedAssetPath,
      );
    } else if (model.request != null) {
      widget = StacWidgetResolver.resolveFromNetwork(context, model.request!);
    } else if (model.routeName != null &&
        (model.navigationStyle == null ||
            model.navigationStyle == NavigationStyle.push ||
            model.navigationStyle == NavigationStyle.pushReplacement ||
            model.navigationStyle == NavigationStyle.pushAndRemoveAll)) {
      widget = StacWidgetResolver.resolveFromRouteName(
        context,
        model.routeName!,
      );
    }

    // Check for mounted context to avoid usage across async gaps
    if (!context.mounted) return;

    // Navigate using the navigation service
    return StacNavigationService.navigate(
      context: context,
      navigationStyle: model.navigationStyle ?? NavigationStyle.push,
      routeName: model.routeName,
      result: model.result,
      arguments: model.arguments,
      widget: widget,
    );
  }
}

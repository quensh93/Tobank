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

    AppLogger.d(
      '🔍 Navigation getModel: widgetType=$widgetType, assetPath=$assetPathValue, hasAssetPath=$hasAssetPath',
    );

    // If assetPath exists (even if it's a variable like {{apiPath}}), prefer it over widgetType
    // Keep both in the JSON so we can resolve the variable in onCall
    if (hasAssetPath && widgetType is String) {
      // Don't remove widgetType yet - we'll check assetPath first in onCall
      // But mark that we prefer assetPath by keeping it
      AppLogger.d(
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
        AppLogger.d('✅ Navigation: Loaded widget from widgetType: $widgetType');
      }
    }
    return StacNavigateAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    Widget? widget;

    AppLogger.d(
      '🔍 Navigation onCall: widgetJson=${model.widgetJson != null}, request=${model.request != null}, assetPath=${model.assetPath}',
    );

    // Resolve assetPath if it's a variable (e.g., {{apiPath}})
    // Note: {{apiPath}} comes from menu item data context, not StacRegistry
    // The variable should be resolved by the dynamic view before the action is created
    // But if it's not resolved, we'll construct it from widgetType as a fallback
    String? resolvedAssetPath = model.assetPath;

    // CRITICAL FIX: If assetPath points to a JSON file (not API), convert it to API path
    // This handles the case where {{apiPath}} was incorrectly resolved to jsonPath
    if (resolvedAssetPath != null &&
        resolvedAssetPath.isNotEmpty &&
        resolvedAssetPath != 'null' &&
        !resolvedAssetPath.contains('{{')) {
      // Check if this is a JSON path (contains /json/) instead of API path
      if (resolvedAssetPath.contains('/json/')) {
        AppLogger.w(
          '⚠️ Navigation: assetPath points to JSON file, converting to API path',
        );
        // Convert: lib/stac/tobank/sum_test/json/tobank_sum_test.json
        // To:      lib/stac/tobank/sum_test/api/GET_tobank_sum_test.json
        final jsonMatch = RegExp(
          r'lib/stac/tobank/([^/]+)/json/([^/]+)\.json$',
        ).firstMatch(resolvedAssetPath);
        if (jsonMatch != null) {
          final feature = jsonMatch.group(1)!;
          final filename = jsonMatch.group(2)!;
          resolvedAssetPath = 'lib/stac/tobank/$feature/api/GET_$filename.json';
          AppLogger.d(
            '✅ Navigation: Converted JSON path to API path: $resolvedAssetPath',
          );
        } else {
          AppLogger.w(
            '⚠️ Navigation: Could not parse JSON path pattern, trying alternative method',
          );
          // Fallback: simple string replacement
          if (resolvedAssetPath.contains('/json/')) {
            resolvedAssetPath = resolvedAssetPath.replaceAll(
              '/json/',
              '/api/GET_',
            );
            AppLogger.d(
              '✅ Navigation: Converted using string replacement: $resolvedAssetPath',
            );
          }
        }
      }
    }

    // Check if assetPath is null or empty - if so, construct it from widgetType
    if (resolvedAssetPath == null ||
        resolvedAssetPath.isEmpty ||
        resolvedAssetPath == 'null') {
      AppLogger.w(
        '⚠️ Navigation: assetPath is null/empty. Constructing from widgetType...',
      );

      // Try to construct API path from widgetType stored in widgetJson
      // Pattern: tobank_sum_test -> lib/stac/tobank/sum_test/api/GET_tobank_sum_test.json
      String? widgetType;
      if (model.widgetJson != null) {
        widgetType = model.widgetJson!['_originalWidgetType'] as String?;
      }

      // If we don't have widgetType from widgetJson, try to extract it from the original navigation action
      // We need to check if we can get it from the model somehow
      // For now, let's try to construct it from common patterns
      if (widgetType == null) {
        // Try to infer from the screen structure or use a fallback
        // Since we're in onCall, we don't have direct access to the original widgetType
        // But we can try to construct API path for known patterns
        AppLogger.w(
          '⚠️ Navigation: widgetType not found in widgetJson, cannot construct API path',
        );
      } else if (widgetType.startsWith('tobank_')) {
        final withoutPrefix = widgetType.substring(
          7,
        ); // Remove 'tobank_' prefix

        // Special handling for flow widgets (e.g., tobank_login_flow_linear_splash)
        if (withoutPrefix.contains('_flow_')) {
          // Pattern: {feature}_flow_{flowType}_{screenName}
          // Example: login_flow_linear_splash -> flowName = login_flow_linear, screenName = login_flow_linear_splash
          // Example: login_flow_linear_verify_otp -> flowName = login_flow_linear, screenName = login_flow_linear_verify_otp
          final parts = withoutPrefix.split('_');
          final flowIndex = parts.indexOf('flow');
          if (flowIndex >= 0 && flowIndex + 1 < parts.length) {
            // Flow name is: {feature}_flow_{flowType} (everything up to and including flow + next segment)
            final flowNameParts = parts.sublist(
              0,
              flowIndex + 2,
            ); // e.g., ['login', 'flow', 'linear']
            final flowName = flowNameParts.join(
              '_',
            ); // e.g., 'login_flow_linear'
            final screenName = withoutPrefix; // Full widgetType without prefix
            resolvedAssetPath =
                'lib/stac/tobank/flows/$flowName/api/GET_$screenName.json';
          } else {
            // Fallback: assume the whole thing after 'tobank_' is the flow path
            resolvedAssetPath =
                'lib/stac/tobank/flows/$withoutPrefix/api/GET_$withoutPrefix.json';
          }
        } else {
          // Regular feature widget (e.g., tobank_login_dart)
          resolvedAssetPath =
              'lib/stac/tobank/$withoutPrefix/api/GET_tobank_$withoutPrefix.json';
        }
        AppLogger.d(
          '✅ Navigation: Constructed assetPath from widgetType: $resolvedAssetPath',
        );
      }

      if (resolvedAssetPath == null) {
        AppLogger.w(
          '⚠️ Navigation: Could not construct assetPath, falling back to widgetJson',
        );
      }
    } else if (resolvedAssetPath.contains('{{')) {
      // Still a variable string - cannot resolve from menu item data in onCall
      AppLogger.w(
        '⚠️ Navigation: assetPath is still a variable: $resolvedAssetPath',
      );
      AppLogger.w(
        '⚠️ Navigation: Cannot resolve {{apiPath}} from menu item data in onCall',
      );
      resolvedAssetPath = null;
    } else {
      AppLogger.d('✅ Navigation: assetPath is resolved: $resolvedAssetPath');
    }

    // Check for special flow config widget types first
    // This is a workaround since StacNavigateAction doesn't expose widgetType directly
    // We store it in the action's result field temporarily (a bit hacky but works)

    // IMPORTANT: Prefer assetPath over widgetJson to ensure API JSON (with onChanged) is used
    // ALWAYS try to construct API path from widgetType if we have widgetJson but no assetPath
    // This ensures we load API JSON (with onChanged) instead of Dart JSON (without onChanged)
    if (resolvedAssetPath == null && model.widgetJson != null) {
      final widgetType = model.widgetJson!['_originalWidgetType'] as String?;
      if (widgetType != null && widgetType.startsWith('tobank_')) {
        final withoutPrefix = widgetType.substring(
          7,
        ); // Remove 'tobank_' prefix

        // Special handling for flow widgets (e.g., tobank_login_flow_linear_splash)
        if (withoutPrefix.contains('_flow_')) {
          // Pattern: {feature}_flow_{flowType}_{screenName}
          // Example: login_flow_linear_splash -> flowName = login_flow_linear, screenName = login_flow_linear_splash
          // Example: login_flow_linear_verify_otp -> flowName = login_flow_linear, screenName = login_flow_linear_verify_otp
          final parts = withoutPrefix.split('_');
          final flowIndex = parts.indexOf('flow');
          if (flowIndex >= 0 && flowIndex + 1 < parts.length) {
            // Flow name is: {feature}_flow_{flowType} (everything up to and including flow + next segment)
            final flowNameParts = parts.sublist(
              0,
              flowIndex + 2,
            ); // e.g., ['login', 'flow', 'linear']
            final flowName = flowNameParts.join(
              '_',
            ); // e.g., 'login_flow_linear'
            final screenName = withoutPrefix; // Full widgetType without prefix
            resolvedAssetPath =
                'lib/stac/tobank/flows/$flowName/api/GET_$screenName.json';
          } else {
            // Fallback: assume the whole thing after 'tobank_' is the flow path
            resolvedAssetPath =
                'lib/stac/tobank/flows/$withoutPrefix/api/GET_$withoutPrefix.json';
          }
        } else {
          // Regular feature widget (e.g., tobank_login_dart)
          resolvedAssetPath =
              'lib/stac/tobank/$withoutPrefix/api/GET_tobank_$withoutPrefix.json';
        }
        AppLogger.d(
          '✅ Navigation: Constructed API path from widgetType in onCall: $resolvedAssetPath',
        );
      }
    }

    // Resolve widget from different sources using the resolver service
    if (model.widgetJson != null) {
      // Check if this is a flow config type by examining the widgetJson
      AppLogger.d('✅ Navigation: Using pre-loaded widgetJson (Dart builder)');
      widget = StacWidgetResolver.resolveFromJson(context, model.widgetJson);
    } else if (resolvedAssetPath != null &&
        resolvedAssetPath.isNotEmpty &&
        resolvedAssetPath != 'null') {
      AppLogger.d('✅ Navigation: Using assetPath: $resolvedAssetPath');
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

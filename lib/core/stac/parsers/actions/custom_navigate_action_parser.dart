import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import 'package:stac_framework/stac_framework.dart';
import '../../services/widget/stac_widget_loader.dart';
import '../../services/widget/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';
import '../../../../stac/tobank/flows/login_flow/dart/login_flow_screen.dart';

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
    // Check for widgetType and inject widgetJson from Dart file if needed
    final widgetType = json['widgetType'];
    if (widgetType is String) {
      // Special handling for flow config widgets - don't remove widgetType
      if (widgetType == 'login_flow_config' ||
          widgetType == 'login_flow_config_api') {
        // Keep widgetType for special handling in onCall
        return StacNavigateAction.fromJson(json);
      }

      final widgetJson = StacWidgetLoader.loadWidgetJson(widgetType);
      if (widgetJson != null) {
        json = Map<String, dynamic>.from(json);
        json['widgetJson'] = widgetJson;
        // Remove widgetType since we've resolved it to widgetJson
        json.remove('widgetType');
      }
    }
    return StacNavigateAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    Widget? widget;

    // Check for special flow config widget types first
    // This is a workaround since StacNavigateAction doesn't expose widgetType directly
    // We store it in the action's result field temporarily (a bit hacky but works)

    // Resolve widget from different sources using the resolver service
    if (model.widgetJson != null) {
      // Check if this is a flow config type by examining the widgetJson
      final widgetType = model.widgetJson?['_flowWidgetType'] as String?;
      if (widgetType == 'login_flow_config') {
        widget = const LoginFlowScreen(useApiPath: false);
      } else if (widgetType == 'login_flow_config_api') {
        widget = const LoginFlowScreen(useApiPath: true);
      } else {
        widget = StacWidgetResolver.resolveFromJson(context, model.widgetJson);
      }
    } else if (model.request != null) {
      widget = StacWidgetResolver.resolveFromNetwork(context, model.request!);
    } else if (model.assetPath != null) {
      widget = await StacWidgetResolver.resolveFromAssetPath(
        context,
        model.assetPath!,
      );
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

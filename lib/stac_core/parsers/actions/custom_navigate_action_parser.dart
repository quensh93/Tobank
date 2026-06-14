import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../services/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';
import '../../navigation/nav_modes.dart';
import '../../navigation/flow_source_resolver.dart';
import '../../../core/helpers/logger.dart';

class CustomNavigateActionParser extends StacActionParser<StacNavigateAction> {
  const CustomNavigateActionParser();

  @override
  String get actionType => ActionType.navigate.name;

  @override
  StacNavigateAction getModel(Map<String, dynamic> json) {
    final fileNameRaw = json['fileName'] as String?;
    final fileName =
        (fileNameRaw != null && fileNameRaw.isNotEmpty) ? fileNameRaw : null;
    final navMode = NavModes.fromJson(json['navMode']);
    final pathOverrideRaw = json['pathOverride'] as String?;
    final pathOverride =
        (pathOverrideRaw != null && pathOverrideRaw.isNotEmpty)
            ? pathOverrideRaw
            : null;

    if (navMode != null && (fileName != null || pathOverride != null)) {
      final resolution = FlowSourceResolver.resolve(
        fileName: fileName,
        navMode: navMode,
        pathOverride: pathOverride,
      );
      json = Map<String, dynamic>.from(json);
      switch (resolution) {
        case NavDart(:final widgetJson):
          json['widgetJson'] = Map<String, dynamic>.from(widgetJson)
            ..['_originalWidgetType'] = fileName ?? pathOverride ?? '';
        case NavAsset(:final assetPath):
          json['assetPath'] = assetPath;
        case NavNetwork(:final request):
          json['request'] = request;
        case NavError(:final message):
          AppLogger.wc(
            LogCategory.stacNavigation,
            '⚠️ Navigation resolve failed ($navMode/$fileName): $message',
          );
      }
    }

    return StacNavigateAction.fromJson(json);
  }

  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    Widget? widget;

    final widgetTypeForLog = model.widgetJson != null
        ? (model.widgetJson!['_originalWidgetType'] as String?)
        : null;

    if (model.widgetJson != null) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ nav → dart:$widgetTypeForLog',
      );
      widget = StacWidgetResolver.resolveFromJson(context, model.widgetJson);
    } else if (model.assetPath != null &&
        model.assetPath!.isNotEmpty &&
        model.assetPath != 'null') {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ nav → asset:${model.assetPath}',
      );
      widget = await StacWidgetResolver.resolveFromAssetPath(
        context,
        model.assetPath!,
      );
    } else if (model.request != null) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ nav → network',
      );
      widget = StacWidgetResolver.resolveFromNetwork(context, model.request!);
    } else if (model.routeName != null &&
        (model.navigationStyle == null ||
            model.navigationStyle == NavigationStyle.push ||
            model.navigationStyle == NavigationStyle.pushReplacement ||
            model.navigationStyle == NavigationStyle.pushAndRemoveAll)) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ nav → route:${model.routeName}',
      );
      widget = StacWidgetResolver.resolveFromRouteName(
        context,
        model.routeName!,
      );
    }

    if (!context.mounted) return;

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

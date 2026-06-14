import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../services/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';
import '../../navigation/nav_modes.dart';
import '../../navigation/flow_source_resolver.dart';
import '../../../core/helpers/logger.dart';

/// Tracks navigation stack so logs show meaningful source and destination.
class NavLogger {
  static final List<String> _stack = ['/'];

  static String get current => _stack.last;

  static void logNav(String style, String navMode, String dest) {
    final from = _stack.last;
    if (style == 'pop' || style == 'popAll') {
      final to = _stack.length > 1 ? _stack[_stack.length - 2] : '/';
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ [$style - $navMode] $from → (page) $to',
      );
      if (_stack.length > 1) _stack.removeLast();
    } else if (style == 'pushReplacement' || style == 'pushReplacementNamed') {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ [$style - $navMode] $from → (page) $dest',
      );
      if (_stack.isNotEmpty) _stack.removeLast();
      _stack.add(dest);
    } else if (style == 'pushAndRemoveAll' || style == 'pushNamedAndRemoveAll') {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ [$style - $navMode] $from → (page) $dest',
      );
      _stack.clear();
      _stack.add(dest);
    } else {
      AppLogger.dc(
        LogCategory.stacNavigation,
        '🗺️ [$style - $navMode] $from → (page) $dest',
      );
      _stack.add(dest);
    }
  }

  static void logOverlay(String action, String type, String name) {
    AppLogger.dc(
      LogCategory.stacNavigation,
      '🗺️ [$action] ${_stack.last} → ($type) $name',
    );
  }

  static void logClose(String type, [String? name]) {
    final label = name != null ? '($type) $name' : '($type)';
    AppLogger.dc(
      LogCategory.stacNavigation,
      '🗺️ [close] $label',
    );
  }
}

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
    final navStyle = json['navigationStyle']?.toString() ?? 'push';

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
            '🗺️ [$navStyle] ${navMode.name} → ${fileName ?? pathOverride} ✗ $message',
          );
      }
    }

    return StacNavigateAction.fromJson(json);
  }

  String _destination(StacNavigateAction model) {
    if (model.widgetJson != null) {
      return model.widgetJson!['_originalWidgetType'] as String? ?? 'dart';
    } else if (model.assetPath != null && model.assetPath!.isNotEmpty) {
      return model.assetPath!.split('/').last;
    } else if (model.request != null) {
      return model.request!.url;
    } else if (model.routeName != null) {
      return model.routeName!;
    }
    return 'unknown';
  }

  @override
  FutureOr onCall(BuildContext context, StacNavigateAction model) async {
    Widget? widget;

    final style = (model.navigationStyle ?? NavigationStyle.push).name;
    final dest = _destination(model);
    final resolvedNavMode = model.widgetJson != null
        ? 'dart'
        : model.assetPath != null && model.assetPath!.isNotEmpty
            ? 'localJson'
            : model.request != null
                ? 'apiJson'
                : 'route';
    NavLogger.logNav(style, resolvedNavMode, dest);

    if (model.widgetJson != null) {
      widget = StacWidgetResolver.resolveFromJson(context, model.widgetJson);
    } else if (model.assetPath != null &&
        model.assetPath!.isNotEmpty &&
        model.assetPath != 'null') {
      widget = await StacWidgetResolver.resolveFromAssetPath(
        context,
        model.assetPath!,
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

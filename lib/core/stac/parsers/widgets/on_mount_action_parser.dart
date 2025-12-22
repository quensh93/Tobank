import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../services/widget/stac_widget_loader.dart';

/// Model for onMountAction configuration.
///
/// This widget executes an action when it mounts (initializes),
/// then renders its child widget.
class OnMountActionModel {
  /// The action to execute when the widget mounts.
  /// This can be any STAC action (navigate, delay, setValue, etc.).
  final Map<String, dynamic>? action;

  /// Optional: The child widget to display after action execution.
  final Map<String, dynamic>? child;

  /// Optional: Delay in milliseconds before executing the action.
  /// Defaults to 0 (executes immediately after first frame).
  final int delay;

  /// Optional: If true, the action will only execute once even if the widget rebuilds.
  /// Defaults to true (recommended for safety).
  final bool executeOnce;

  /// Optional: Widget type to load child from widget loader when child is missing.
  /// Used when API JSON doesn't include child property.
  final String? loadChildFromWidgetType;

  const OnMountActionModel({
    this.action,
    this.child,
    this.delay = 0,
    this.executeOnce = true,
    this.loadChildFromWidgetType,
  });

  factory OnMountActionModel.fromJson(Map<String, dynamic> json) {
    return OnMountActionModel(
      action: json['action'] as Map<String, dynamic>?,
      child: json['child'] as Map<String, dynamic>?,
      delay: json['delay'] as int? ?? 0,
      executeOnce: json['executeOnce'] as bool? ?? true,
      loadChildFromWidgetType: json['_loadChildFromWidgetType'] as String?,
    );
  }
}

/// Custom widget parser for executing actions on mount.
///
/// This parser wraps a child widget and automatically executes
/// a specified action when the widget is mounted (initialized).
///
/// Use cases:
/// - Auto-navigation after a delay
/// - Auto-fetch data on screen load
/// - Auto-trigger analytics events
/// - Auto-show dialogs/toasts
///
/// JSON Example:
/// ```json
/// {
///   "type": "onMountAction",
///   "action": {
///     "actionType": "delay",
///     "milliseconds": 2000,
///     "onComplete": {
///       "actionType": "navigate",
///       "widgetType": "onboarding_screen"
///     }
///   },
///   "child": { ... child widget ... }
/// }
/// ```
///
/// Simple navigation example:
/// ```json
/// {
///   "type": "onMountAction",
///   "delay": 2000,
///   "action": {
///     "actionType": "navigate",
///     "widgetType": "next_screen"
///   },
///   "child": { ... splash screen content ... }
/// }
/// ```
class OnMountActionParser extends StacParser<OnMountActionModel> {
  const OnMountActionParser();

  @override
  String get type => 'onMountAction';

  @override
  OnMountActionModel getModel(Map<String, dynamic> json) =>
      OnMountActionModel.fromJson(json);

  @override
  Widget parse(BuildContext context, OnMountActionModel model) {
    return OnMountActionWidget(model: model);
  }
}

/// Stateful widget that handles the action execution on mount.
class OnMountActionWidget extends StatefulWidget {
  final OnMountActionModel model;

  const OnMountActionWidget({super.key, required this.model});

  @override
  State<OnMountActionWidget> createState() => _OnMountActionWidgetState();
}

class _OnMountActionWidgetState extends State<OnMountActionWidget> {
  bool _hasExecuted = false;

  @override
  void initState() {
    super.initState();

    // Execute action after first frame to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.model.action != null) {
        _executeAction();
      }
    });
  }

  void _executeAction() {
    // Check if already executed (if executeOnce is true)
    if (widget.model.executeOnce && _hasExecuted) {
      debugPrint('⚠️ OnMountAction: Action already executed, skipping...');
      return;
    }

    // Double-check mounted state
    if (!mounted || !context.mounted) {
      debugPrint('⚠️ OnMountAction: Widget not mounted, skipping action');
      return;
    }

    // Mark as executed before async operation
    _hasExecuted = true;

    // Apply delay if specified
    if (widget.model.delay > 0) {
      Future.delayed(Duration(milliseconds: widget.model.delay), () {
        if (mounted && context.mounted) {
          _executeActionInternal();
        } else {
          debugPrint(
            '⚠️ OnMountAction: Widget unmounted during delay, cancelling action',
          );
        }
      });
    } else {
      // Execute immediately (still after first frame)
      _executeActionInternal();
    }
  }

  void _executeActionInternal() {
    // Final mounted check before execution
    if (!mounted || !context.mounted) {
      debugPrint('⚠️ OnMountAction: Widget not mounted, skipping action');
      return;
    }

    try {
      // Execute the action using STAC's action execution mechanism
      Stac.onCallFromJson(widget.model.action, context);
    } catch (e, stackTrace) {
      debugPrint('❌ OnMountAction error: $e');
      debugPrint('Stack trace: $stackTrace');
      // Don't crash - gracefully fail
      // The action error is logged but doesn't prevent the widget from rendering
    }
  }

  @override
  Widget build(BuildContext context) {
    // If child is provided, use it directly
    if (widget.model.child != null) {
      // Resolve variables in child JSON before parsing
      final resolvedJson = _resolveVariablesInJson(
        widget.model.child!,
        StacRegistry.instance,
      );

      // Parse and render the child widget
      final childWidget = Stac.fromJson(resolvedJson, context);
      if (childWidget != null) {
        return childWidget;
      }
    }

    // If child is missing and we have a loadChildFromWidgetType, try to load it
    // This handles cases where API JSON doesn't include the child property
    final loadChildFromWidgetType = widget.model.loadChildFromWidgetType;
    if (loadChildFromWidgetType != null) {
      final loaderJson = StacWidgetLoader.loadWidgetJson(loadChildFromWidgetType);
      if (loaderJson != null) {
        // Check if the loaded JSON is itself an onMountAction to prevent recursion
        if (loaderJson['type'] == 'onMountAction') {
          final childFromLoader = loaderJson['child'] as Map<String, dynamic>?;
          if (childFromLoader != null) {
            debugPrint(
              '✅ OnMountAction: Loaded child from widget loader for $loadChildFromWidgetType',
            );
            final childWidget = Stac.fromJson(childFromLoader, context);
            if (childWidget != null) {
              return childWidget;
            }
          }
        } else {
          // The loaded JSON is the child itself (not wrapped in onMountAction)
          final childWidget = Stac.fromJson(loaderJson, context);
          if (childWidget != null) {
            return childWidget;
          }
        }
      }
    }

    // Fallback: Show a simple loading indicator
    debugPrint(
      '⚠️ OnMountAction: child property is missing and could not be loaded from widget loader',
    );
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  /// Resolve variables in JSON using the STAC registry.
  ///
  /// This is a simplified version that handles basic variable resolution.
  /// For complex cases, the parent StacWidgetResolver already handles this,
  /// but we do it here for safety when rendering child widgets.
  dynamic _resolveVariablesInJson(dynamic json, StacRegistry registry) {
    if (json is String) {
      // Replace all {{variable_name}} with their values from registry
      return json.replaceAllMapped(RegExp(r'{{(.*?)}}'), (match) {
        final variableName = match.group(1)?.trim();
        final value = registry.getValue(variableName ?? '');
        return value != null ? value.toString() : match.group(0) ?? '';
      });
    } else if (json is Map<String, dynamic>) {
      return json.map(
        (key, value) =>
            MapEntry(key, _resolveVariablesInJson(value, registry)),
      );
    } else if (json is List) {
      return json
          .map((item) => _resolveVariablesInJson(item, registry))
          .toList();
    }
    return json;
  }
}


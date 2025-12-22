import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../services/widget/stac_widget_loader.dart';
import '../../services/widget/stac_widget_resolver.dart';
import '../../services/navigation/stac_navigation_service.dart';

/// Model for timed splash configuration.
class TimedSplashModel {
  /// Duration in milliseconds before navigating to next screen.
  final int duration;

  /// The widget type to navigate to after the delay.
  final String nextWidgetType;

  /// Optional: If provided, loads this widget type as the splash content.
  final String? splashWidgetType;

  /// Optional: The child widget to display as splash content.
  final Map<String, dynamic>? child;

  /// Optional: Widget type to load child from widget loader when child is missing.
  /// Used when API JSON doesn't include child property.
  final String? loadChildFromWidgetType;

  const TimedSplashModel({
    this.duration = 2000,
    required this.nextWidgetType,
    this.splashWidgetType,
    this.child,
    this.loadChildFromWidgetType,
  });

  factory TimedSplashModel.fromJson(Map<String, dynamic> json) {
    return TimedSplashModel(
      duration: json['duration'] as int? ?? 2000,
      nextWidgetType: json['nextWidgetType'] as String,
      splashWidgetType: json['splashWidgetType'] as String?,
      child: json['child'] as Map<String, dynamic>?,
      loadChildFromWidgetType: json['_loadChildFromWidgetType'] as String?,
    );
  }
}

/// Custom widget parser for timed splash screens.
///
/// This parser wraps a splash screen and automatically navigates
/// to the next screen after a specified delay.
///
/// JSON Example:
/// ```json
/// {
///   "type": "timedSplash",
///   "duration": 2000,
///   "nextWidgetType": "tobank_onboarding",
///   "child": { ... splash content ... }
/// }
/// ```
///
/// Or with a widgetType reference:
/// ```json
/// {
///   "type": "timedSplash",
///   "duration": 2000,
///   "nextWidgetType": "tobank_onboarding",
///   "splashWidgetType": "tobank_splash_dart"
/// }
/// ```
class TimedSplashParser extends StacParser<TimedSplashModel> {
  const TimedSplashParser();

  @override
  String get type => 'timedSplash';

  @override
  TimedSplashModel getModel(Map<String, dynamic> json) =>
      TimedSplashModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TimedSplashModel model) {
    return TimedSplashWidget(model: model);
  }
}

/// Stateful widget that handles the timer logic.
class TimedSplashWidget extends StatefulWidget {
  final TimedSplashModel model;

  const TimedSplashWidget({super.key, required this.model});

  @override
  State<TimedSplashWidget> createState() => _TimedSplashWidgetState();
}

class _TimedSplashWidgetState extends State<TimedSplashWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(Duration(milliseconds: widget.model.duration), () {
      if (mounted) {
        _navigateToNext();
      }
    });
  }

  void _navigateToNext() {
    final nextWidgetType = widget.model.nextWidgetType;

    // Try to load the next widget from Dart
    final widgetJson = StacWidgetLoader.loadWidgetJson(nextWidgetType);

    if (widgetJson != null) {
      // Get the widget using StacWidgetResolver
      final nextWidget = StacWidgetResolver.resolveFromJson(
        context,
        widgetJson,
      );

      if (nextWidget != null) {
        // Navigate using our navigation service with pushReplacement
        StacNavigationService.navigate(
          context: context,
          navigationStyle: NavigationStyle.pushReplacement,
          widget: nextWidget,
        );
      }
    } else {
      // Fallback: Log warning
      debugPrint('⚠️ TimedSplash: Could not load widget $nextWidgetType');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If splashWidgetType is provided, load that widget
    // IMPORTANT: Check for circular reference to prevent infinite recursion
    if (widget.model.splashWidgetType != null) {
      final splashJson = StacWidgetLoader.loadWidgetJson(
        widget.model.splashWidgetType!,
      );
      if (splashJson != null) {
        // Check if the loaded JSON is itself a timedSplash to prevent recursion
        if (splashJson['type'] == 'timedSplash') {
          debugPrint(
            '⚠️ TimedSplash: Detected circular reference with splashWidgetType="${widget.model.splashWidgetType}", showing loading indicator instead',
          );
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Use Stac.fromJson directly to avoid double-wrapping with Theme
        // The parent StacWidgetResolver already wraps with Theme
        final splashWidget = Stac.fromJson(splashJson, context);
        if (splashWidget != null) {
          return splashWidget;
        }
      }
    }

    // If child is provided, build it using Stac.fromJson
    if (widget.model.child != null) {
      final childWidget = Stac.fromJson(widget.model.child!, context);
      if (childWidget != null) {
        return childWidget;
      }
    }

    // If child is missing, try to load it from widget loader
    // This handles cases where API JSON doesn't include the child property
    if (widget.model.loadChildFromWidgetType != null) {
      final loaderJson = StacWidgetLoader.loadWidgetJson(
        widget.model.loadChildFromWidgetType!,
      );
      if (loaderJson != null && loaderJson['type'] == 'timedSplash') {
        final childFromLoader = loaderJson['child'] as Map<String, dynamic>?;
        if (childFromLoader != null) {
          debugPrint(
            '✅ TimedSplash: Loaded child from widget loader for ${widget.model.loadChildFromWidgetType}',
          );
          final childWidget = Stac.fromJson(childFromLoader, context);
          if (childWidget != null) {
            return childWidget;
          }
        }
      }
    }

    // Fallback: Show a simple loading indicator
    debugPrint(
      '⚠️ TimedSplash: child property is missing and could not be loaded from widget loader',
    );
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

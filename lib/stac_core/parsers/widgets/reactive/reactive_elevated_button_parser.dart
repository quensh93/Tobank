import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../registry/registry_notifier.dart';

class ReactiveElevatedButtonModel {
  final String? enabledKey;
  final String? loadingKey;
  final bool? enabled;
  final Map<String, dynamic>? onPressed;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? loadingChild;
  final Map<String, dynamic>? style;
  final Map<String, dynamic>? disabledStyle;

  const ReactiveElevatedButtonModel({
    this.enabledKey,
    this.loadingKey,
    this.enabled,
    this.onPressed,
    this.child,
    this.loadingChild,
    this.style,
    this.disabledStyle,
  });

  factory ReactiveElevatedButtonModel.fromJson(Map<String, dynamic> json) {
    var onPressed = json['onPressed'] as Map<String, dynamic>?;

    // Handle legacy rawOnPressed (stringified JSON)
    if (json['rawOnPressed'] is String) {
      try {
        final raw = json['rawOnPressed'] as String;
        final unescaped = raw.replaceAll('__STAC_OPEN__', '{{');
        final decoded = jsonDecode(unescaped);
        if (decoded is Map<String, dynamic>) {
          onPressed = decoded;
        }
      } catch (_) {}
    } else if (onPressed != null) {
      // Handle modern onPressed (Map with escaped templates)
      onPressed = _unescapeTemplatesRecursive(onPressed);
    }

    return ReactiveElevatedButtonModel(
      enabledKey: json['enabledKey'] as String?,
      loadingKey: json['loadingKey'] as String?,
      enabled: json['enabled'] as bool?,
      onPressed: onPressed,
      child: json['child'] as Map<String, dynamic>?,
      loadingChild: json['loadingChild'] as Map<String, dynamic>?,
      style: json['style'] as Map<String, dynamic>?,
      disabledStyle: json['disabledStyle'] as Map<String, dynamic>?,
    );
  }

  static dynamic _unescapeTemplatesRecursive(dynamic value) {
    if (value is String) {
      return value.replaceAll('__STAC_OPEN__', '{{');
    }
    if (value is List) {
      return value.map(_unescapeTemplatesRecursive).toList();
    }
    if (value is Map) {
      return value.map(
        (k, v) => MapEntry(k as String, _unescapeTemplatesRecursive(v)),
      );
    }
    return value;
  }
}

class ReactiveElevatedButtonParser
    extends StacParser<ReactiveElevatedButtonModel> {
  const ReactiveElevatedButtonParser();

  @override
  String get type => 'reactiveElevatedButton';

  @override
  ReactiveElevatedButtonModel getModel(Map<String, dynamic> json) {
    return ReactiveElevatedButtonModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, ReactiveElevatedButtonModel model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, __) {
        final enabled = _resolveEnabled(model);
        final isLoading = _resolveLoading(model);

        // When loading, show a loading indicator instead of normal child
        Map<String, dynamic>? childWidget;
        if (isLoading) {
          childWidget =
              model.loadingChild ??
              {
                'type': 'sizedBox',
                'width': 24,
                'height': 24,
                'child': {
                  'type': 'circularProgressIndicator',
                  'strokeWidth': 2.5,
                  'color': '#FFFFFF',
                },
              };
        } else {
          childWidget = model.child;
        }

        // Build the button WITHOUT onPressed — we handle the tap ourselves
        // to ensure templates like {{selectedDeposit.depositNumber}} are
        // resolved from current registry values at PRESS TIME, not build time.
        // If we pass onPressed through the standard elevatedButton parser,
        // Stac.fromJson → StacElevatedButton.fromJson → StacAction.fromJson
        // would bake the template-resolved values into a StacAction object
        // at BUILD time, causing stale data when the user changes selection.
        final buttonJson = <String, dynamic>{
          'type': 'elevatedButton',
          if (childWidget != null) 'child': childWidget,
          // Always pass a no-op onPressed so the button looks enabled
          // (null onPressed makes ElevatedButton appear disabled/grayed out)
          if (enabled && !isLoading)
            'onPressed': {'actionType': 'sequence', 'actions': []},
          if ((enabled && !isLoading) && model.style != null)
            'style': model.style,
          if ((!enabled || isLoading) && model.disabledStyle != null)
            'style': model.disabledStyle,
          if ((!enabled || isLoading) &&
              model.disabledStyle == null &&
              model.style != null)
            'style': model.style,
        };
        final buttonWidget =
            Stac.fromJson(buttonJson, context) ?? const SizedBox.shrink();

        // Wrap with GestureDetector to handle the tap with deferred
        // template resolution via Stac.onCallFromJson
        if (enabled && !isLoading && model.onPressed != null) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Stac.onCallFromJson(model.onPressed, context),
            child: AbsorbPointer(child: buttonWidget),
          );
        }

        return buttonWidget;
      },
    );
  }

  bool _resolveEnabled(ReactiveElevatedButtonModel model) {
    if (model.enabledKey == null || model.enabledKey!.isEmpty) {
      return model.enabled ?? true;
    }
    final value = StacRegistry.instance.getValue(model.enabledKey!);
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    return model.enabled ?? false;
  }

  bool _resolveLoading(ReactiveElevatedButtonModel model) {
    if (model.loadingKey == null || model.loadingKey!.isEmpty) {
      return false;
    }
    final value = StacRegistry.instance.getValue(model.loadingKey!);
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    return false;
  }
}

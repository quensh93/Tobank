import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../utils/registry_notifier.dart';

class ReactiveElevatedButtonModel {
  final String? enabledKey;
  final bool? enabled;
  final Map<String, dynamic>? onPressed;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? style;
  final Map<String, dynamic>? disabledStyle;

  const ReactiveElevatedButtonModel({
    this.enabledKey,
    this.enabled,
    this.onPressed,
    this.child,
    this.style,
    this.disabledStyle,
  });

  factory ReactiveElevatedButtonModel.fromJson(Map<String, dynamic> json) {
    return ReactiveElevatedButtonModel(
      enabledKey: json['enabledKey'] as String?,
      enabled: json['enabled'] as bool?,
      onPressed: json['onPressed'] as Map<String, dynamic>?,
      child: json['child'] as Map<String, dynamic>?,
      style: json['style'] as Map<String, dynamic>?,
      disabledStyle: json['disabledStyle'] as Map<String, dynamic>?,
    );
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
        final buttonJson = <String, dynamic>{
          'type': 'elevatedButton',
          if (model.child != null) 'child': model.child,
          if (enabled) 'onPressed': model.onPressed,
          if (enabled && model.style != null) 'style': model.style,
          if (!enabled && model.disabledStyle != null)
            'style': model.disabledStyle,
          if (!enabled && model.disabledStyle == null && model.style != null)
            'style': model.style,
        };
        return Stac.fromJson(buttonJson, context) ?? const SizedBox.shrink();
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
}

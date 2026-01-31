import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../utils/registry_notifier.dart';

class ReactiveSwitchModel {
  final String valueKey;
  final bool? initialValue;
  final Map<String, dynamic>? onChanged;
  final String? activeColor;
  final String? inactiveTrackColor;
  final String? inactiveThumbColor;

  const ReactiveSwitchModel({
    required this.valueKey,
    this.initialValue,
    this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  });

  factory ReactiveSwitchModel.fromJson(Map<String, dynamic> json) {
    return ReactiveSwitchModel(
      valueKey: json['valueKey'] as String,
      initialValue: json['initialValue'] as bool?,
      onChanged: json['onChanged'] as Map<String, dynamic>?,
      activeColor: json['activeColor'] as String?,
      inactiveTrackColor: json['inactiveTrackColor'] as String?,
      inactiveThumbColor: json['inactiveThumbColor'] as String?,
    );
  }
}

class ReactiveSwitchParser extends StacParser<ReactiveSwitchModel> {
  const ReactiveSwitchParser();

  @override
  String get type => 'reactiveSwitch';

  @override
  ReactiveSwitchModel getModel(Map<String, dynamic> json) {
    return ReactiveSwitchModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, ReactiveSwitchModel model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, _) {
        final currentValue = _resolveValue(model);

        return Switch.adaptive(
          value: currentValue,
          activeColor: model.activeColor != null
              ? _parseColor(context, model.activeColor!)
              : Theme.of(context).colorScheme.primary,
          inactiveTrackColor: model.inactiveTrackColor != null
              ? _parseColor(context, model.inactiveTrackColor!)
              : null,
          inactiveThumbColor: model.inactiveThumbColor != null
              ? _parseColor(context, model.inactiveThumbColor!)
              : null,
          onChanged: (newValue) {
            // Update the registry value
            StacRegistry.instance.setValue(model.valueKey, newValue);
            RegistryNotifier.instance.notify();

            // Execute the onChanged action if provided
            // Use post-frame callback to ensure registry value is fully processed
            if (model.onChanged != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  Stac.onCallFromJson(model.onChanged!, context);
                }
              });
            }
          },
        );
      },
    );
  }

  bool _resolveValue(ReactiveSwitchModel model) {
    final value = StacRegistry.instance.getValue(model.valueKey);
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    return model.initialValue ?? false;
  }

  Color? _parseColor(BuildContext context, String colorString) {
    // Handle template expressions like {{appColors.current.primary.color}}
    if (colorString.startsWith('{{') && colorString.endsWith('}}')) {
      final key = colorString.substring(2, colorString.length - 2);
      final value = StacRegistry.instance.getValue(key);
      if (value is String) {
        return _hexToColor(value);
      }
      if (value is Color) {
        return value;
      }
    }
    // Direct hex color
    return _hexToColor(colorString);
  }

  Color? _hexToColor(String hex) {
    if (hex.isEmpty) return null;
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}

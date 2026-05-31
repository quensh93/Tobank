import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../registry/registry_notifier.dart';

class CustomVisibilityModel {
  final dynamic visible;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? replacement;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;

  const CustomVisibilityModel({
    this.visible,
    this.child,
    this.replacement,
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
  });

  factory CustomVisibilityModel.fromJson(Map<String, dynamic> json) {
    return CustomVisibilityModel(
      visible: json['visible'],
      child: json['child'],
      replacement: json['replacement'],
      maintainState: json['maintainState'] ?? false,
      maintainAnimation: json['maintainAnimation'] ?? false,
      maintainSize: json['maintainSize'] ?? false,
      maintainSemantics: json['maintainSemantics'] ?? false,
      maintainInteractivity: json['maintainInteractivity'] ?? false,
    );
  }
}

class CustomVisibilityParser extends StacParser<CustomVisibilityModel> {
  const CustomVisibilityParser();

  @override
  String get type => 'visibility';

  @override
  CustomVisibilityModel getModel(Map<String, dynamic> json) =>
      CustomVisibilityModel.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomVisibilityModel model) {
    return ValueListenableBuilder(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, child) {
        bool isVisible = true;

        if (model.visible is bool) {
          isVisible = model.visible;
        } else if (model.visible is String) {
          final value = _resolveValue(model.visible);
          if (value == null) {
            // Treat null as false or true? Stac usually defaults to true for visibility if not specified?
            // But if specified and null, usually false?
            // Documentation says "Defaults to true".
            // If the variable is missing, what should happen?
            isVisible = false;
          } else {
            isVisible = _toBool(value);
          }
        } else if (model.visible == null) {
          isVisible = true; // Default
        }

        return Visibility(
          visible: isVisible,
          replacement: model.replacement != null
              ? Stac.fromJson(model.replacement!, context) ??
                    const SizedBox.shrink()
              : const SizedBox.shrink(),
          maintainState: model.maintainState,
          maintainAnimation: model.maintainAnimation,
          maintainSize: model.maintainSize,
          maintainSemantics: model.maintainSemantics,
          maintainInteractivity: model.maintainInteractivity,
          child: model.child != null
              ? Stac.fromJson(model.child!, context) ?? const SizedBox.shrink()
              : const SizedBox.shrink(),
        );
      },
    );
  }

  dynamic _resolveValue(String value) {
    String? key;
    bool negate = false;

    // Check for template syntax {{key}}
    if (value.startsWith('{{') && value.endsWith('}}')) {
      key = value.substring(2, value.length - 2).trim();
    }
    // Check for custom escape syntax [[key]] to bypass Stac resolution
    else if (value.startsWith('[[') && value.endsWith(']]')) {
      key = value.substring(2, value.length - 2).trim();
    }

    if (key != null) {
      // Handle negation
      if (key.startsWith('!')) {
        negate = true;
        key = key.substring(1).trim();
      }

      final registryValue = StacRegistry.instance.getValue(key);

      if (negate) {
        return !_toBool(registryValue);
      }

      return registryValue;
    }

    // Simple fallback for boolean strings
    if (value.toLowerCase() == 'true') return true;
    if (value.toLowerCase() == 'false') return false;

    return value;
  }

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    return false;
  }
}

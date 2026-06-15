import 'package:flutter/material.dart';
import '../../../registry/registry_notifier.dart';
import 'package:stac/stac.dart';

class RegistryReactiveWidgetModel {
  final String? registryKey;
  final Map<String, dynamic>? child;

  const RegistryReactiveWidgetModel({this.registryKey, this.child});

  factory RegistryReactiveWidgetModel.fromJson(Map<String, dynamic> json) {
    return RegistryReactiveWidgetModel(
      registryKey: json['registryKey'] as String?,
      child: json['child'] as Map<String, dynamic>?,
    );
  }
}

class RegistryReactiveWidgetParser
    extends StacParser<RegistryReactiveWidgetModel> {
  const RegistryReactiveWidgetParser();

  @override
  String get type => 'registryReactive';

  @override
  RegistryReactiveWidgetModel getModel(Map<String, dynamic> json) {
    return RegistryReactiveWidgetModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, RegistryReactiveWidgetModel model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, child) {
        final resolvedChild = model.child != null
            ? _resolveExpressionsInJson(model.child!)
            : const SizedBox.shrink();
        final boundChild = resolvedChild is Map<String, dynamic>
            ? _bindRegistryValue(
                resolvedChild,
                registryKey: model.registryKey,
              )
            : resolvedChild;
        final childWidget = boundChild is Map<String, dynamic>
            ? Stac.fromJson(boundChild, context)
            : const SizedBox.shrink();
        return childWidget ?? const SizedBox.shrink();
      },
    );
  }

  dynamic _resolveExpressionsInJson(dynamic json) {
    if (json is String) {
      return _resolveTemplateString(json);
    }

    if (json is Map<String, dynamic>) {
      return json.map(
        (key, value) => MapEntry(key, _resolveExpressionsInJson(value)),
      );
    }

    if (json is Map) {
      final typed = Map<String, dynamic>.from(json);
      return typed.map(
        (key, value) => MapEntry(key, _resolveExpressionsInJson(value)),
      );
    }

    if (json is List) {
      return json.map(_resolveExpressionsInJson).toList();
    }

    return json;
  }

  dynamic _resolveTemplateString(String text) {
    if (!text.contains('{{') || !text.contains('}}')) return text;

    final matches = RegExp(r'\{\{([^}]+)\}\}').allMatches(text).toList();
    if (matches.isEmpty) return text;

    if (matches.length == 1 && matches.first.group(0) == text) {
      final expr = matches.first.group(1)?.trim();
      if (expr == null || expr.isEmpty) return text;
      return _evalExpression(expr) ?? text;
    }

    return text.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';
      final value = _evalExpression(expr);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }

  dynamic _evalExpression(String expr) {
    if (expr.startsWith('!')) {
      final varName = expr.substring(1).trim();
      final value = StacRegistry.instance.getValue(varName);
      return !_toBool(value);
    }

    return StacRegistry.instance.getValue(expr);
  }

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    if (value is num) return value != 0;
    return false;
  }

  Map<String, dynamic> _bindRegistryValue(
    Map<String, dynamic> json, {
    required String? registryKey,
  }) {
    if (registryKey == null || registryKey.isEmpty) return json;

    final registryValue = StacRegistry.instance.getValue(registryKey);
    if (registryValue == null) return json;

    if (json['type'] == 'text') {
      return {
        ...json,
        'data': registryValue.toString(),
      };
    }

    return json;
  }
}

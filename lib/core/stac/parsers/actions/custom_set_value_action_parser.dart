import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';
import '../../utils/text_form_field_controller_registry.dart';

/// Custom SetValueAction parser that resolves StacGetFormValue actions
/// before storing values in the registry.
///
/// This allows form values to be stored in the registry with the "form." prefix
/// so they can be accessed in dialog widgets using {{form.fieldName}} syntax.
class CustomSetValueActionModel {
  final List<Map<String, dynamic>> entries;
  final Map<String, dynamic>? action;

  const CustomSetValueActionModel({
    required this.entries,
    required this.action,
  });

  factory CustomSetValueActionModel.fromJson(Map<String, dynamic> json) {
    final entries = <Map<String, dynamic>>[];

    final rawValues = json['values'];
    if (rawValues is List) {
      for (final item in rawValues) {
        if (item is Map<String, dynamic>) {
          entries.add(item);
        } else if (item is Map) {
          entries.add(Map<String, dynamic>.from(item));
        }
      }
    } else {
      final key = json['key'];
      if (key is String && key.isNotEmpty) {
        entries.add({'key': key, 'value': json['value']});
      }
    }

    final action = json['action'];
    return CustomSetValueActionModel(
      entries: entries,
      action: action is Map<String, dynamic>
          ? action
          : action is Map
          ? Map<String, dynamic>.from(action)
          : null,
    );
  }
}

class CustomSetValueActionParser
    extends StacActionParser<CustomSetValueActionModel> {
  const CustomSetValueActionParser();

  @override
  String get actionType => ActionType.setValue.name;

  @override
  CustomSetValueActionModel getModel(Map<String, dynamic> json) =>
      CustomSetValueActionModel.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    CustomSetValueActionModel model,
  ) async {
    var didUpdate = false;
    // Resolve StacGetFormValue actions in values before storing
    for (final entry in model.entries) {
      final key = entry['key'] as String?;
      if (key == null || key.isEmpty) continue;

      dynamic valueToStore = entry['value'];

      // Resolve {{ }} templates inside plain strings (e.g. "{{now()}}")
      if (valueToStore is String) {
        valueToStore = _resolveTemplates(valueToStore);
      }

      // Check if the value is a StacGetFormValue action JSON
      if (valueToStore is Map<String, dynamic> &&
          valueToStore['actionType'] == ActionType.getFormValue.name) {
        final formScope = _tryGetFormScope(context);

        // Resolve the form value
        final formValueId = valueToStore['id'] as String?;
        if (formValueId != null && formScope != null) {
          final formValue = formScope.formData[formValueId]?.toString();
          if (formValue != null) {
            valueToStore = formValue;
            AppLogger.d('Resolved form value for $key: $formValue');
          } else {
            AppLogger.w('Form value not found for id: $formValueId');
            valueToStore = '';
          }
        } else {
          AppLogger.w('Cannot resolve form value: formScope or id is null');
          valueToStore = '';
        }
      }

      // Store the resolved value in registry
      AppLogger.dc(
        LogCategory.action,
        'CustomSetValueAction: storing key="$key" value="$valueToStore"',
      );
      StacRegistry.instance.setValue(key, valueToStore);
      didUpdate = true;

      // If a TextFormField controller is registered for this key, update it too.
      if (valueToStore != null) {
        TextFormFieldControllerRegistry.instance.updateValue(
          key,
          valueToStore.toString(),
        );
      }
    }
    if (didUpdate) {
      RegistryNotifier.instance.notify();
    }

    // Execute the chained action (e.g., network request)
    if (model.action != null) {
      final result = Stac.onCallFromJson(model.action!, context);
      if (result is Future) {
        return await result;
      }
      return result;
    }

    return null;
  }

  dynamic _resolveTemplates(String message) {
    if (!message.contains('{{') || !message.contains('}}')) return message;

    final matches = RegExp(r'\{\{([^}]+)\}\}').allMatches(message).toList();
    if (matches.isEmpty) return message;

    // If the entire string is a single {{expr}}, return the evaluated value
    if (matches.length == 1 && matches.first.group(0) == message) {
      final expr = matches.first.group(1)?.trim();
      if (expr == null || expr.isEmpty) return message;
      return _evalExpression(expr) ?? message;
    }

    // Otherwise, do string interpolation
    return message.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';
      final value = _evalExpression(expr);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }

  dynamic _evalExpression(String expr) {
    if (expr == 'now()') {
      return DateTime.now().millisecondsSinceEpoch;
    }

    // Handle ternary expression: "condition ? trueValue : falseValue"
    final ternaryMatch = RegExp(
      r'^(.+?)\s*\?\s*(.+?)\s*:\s*(.+)$',
    ).firstMatch(expr);
    if (ternaryMatch != null) {
      final conditionExpr = ternaryMatch.group(1)!.trim();
      final trueValue = ternaryMatch.group(2)!.trim();
      final falseValue = ternaryMatch.group(3)!.trim();

      final conditionResult = _evalCondition(conditionExpr);
      final resultExpr = conditionResult ? trueValue : falseValue;

      // Parse the result value
      return _parseValue(resultExpr);
    }

    // Handle negation: "!variableName"
    if (expr.startsWith('!')) {
      final varName = expr.substring(1).trim();
      final value = _getNestedValue(varName);
      return !_toBool(value);
    }

    // Handle nested paths like "data.data.nationalCode"
    return _getNestedValue(expr);
  }

  /// Gets a value from registry, supporting nested paths like "data.data.nationalCode"
  dynamic _getNestedValue(String path) {
    final parts = path.split('.');
    if (parts.isEmpty) return null;

    // Get the root value from registry
    dynamic value = StacRegistry.instance.getValue(parts[0]);
    if (value == null) return null;

    // Navigate through nested structure
    for (int i = 1; i < parts.length; i++) {
      if (value is Map) {
        value = value[parts[i]];
      } else if (value is List && int.tryParse(parts[i]) != null) {
        final index = int.parse(parts[i]);
        if (index >= 0 && index < value.length) {
          value = value[index];
        } else {
          return null;
        }
      } else {
        return null;
      }
      if (value == null) return null;
    }

    return value;
  }

  /// Evaluates a condition expression and returns a boolean
  bool _evalCondition(String conditionExpr) {
    // Handle negation in condition
    if (conditionExpr.startsWith('!')) {
      final varName = conditionExpr.substring(1).trim();
      final value = StacRegistry.instance.getValue(varName);
      return !_toBool(value);
    }

    // Simple variable lookup
    final value = StacRegistry.instance.getValue(conditionExpr);
    return _toBool(value);
  }

  /// Converts a value to boolean
  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    if (value is num) return value != 0;
    return false;
  }

  /// Parses a string value to its appropriate type
  dynamic _parseValue(String value) {
    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == 'null') return null;

    // Try parsing as number
    final intVal = int.tryParse(value);
    if (intVal != null) return intVal;

    final doubleVal = double.tryParse(value);
    if (doubleVal != null) return doubleVal;

    // Check if it's a registry variable
    if (!value.contains(' ') &&
        !value.startsWith('"') &&
        !value.startsWith("'")) {
      final registryValue = StacRegistry.instance.getValue(value);
      if (registryValue != null) return registryValue;
    }

    // Return as string (strip quotes if present)
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      return value.substring(1, value.length - 1);
    }

    return value;
  }

  StacFormScope? _tryGetFormScope(BuildContext context) {
    try {
      return StacFormScope.of(context);
    } catch (_) {
      return null;
    }
  }
}

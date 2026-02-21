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
      // Check condition if present
      if (entry['condition'] != null) {
        final conditionExpr = entry['condition'] as String;
        if (!_evalCondition(conditionExpr)) {
          continue;
        }
      }

      final key = entry['key'] as String?;
      if (key == null || key.isEmpty) continue;

      dynamic valueToStore = entry['value'];

      // CRITICAL FIX: For certain keys that depend on network response data,
      // always fetch fresh value from registry instead of using pre-resolved value.
      // This is necessary because STAC framework pre-processes templates at parse time,
      // which can result in stale values being used for keys like deposits.rawData.
      if (_shouldFetchFreshFromRegistry(key, valueToStore)) {
        final freshValue = StacRegistry.instance.getValue('data_payload');
        if (freshValue != null) {
          AppLogger.dc(
            LogCategory.stacAction,
            '🔄 Fetching fresh data_payload for key="$key" (${freshValue.runtimeType})',
          );
          valueToStore = freshValue;
        } else {
          AppLogger.wc(
            LogCategory.stacAction,
            '⚠️ data_payload is null when trying to set "$key"',
          );
        }
      }
      // Resolve {{ }} templates inside plain strings (e.g. "{{now()}}")
      else if (valueToStore is String) {
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
      final existingValue = StacRegistry.instance.getValue(key);
      if (existingValue != valueToStore) {
        AppLogger.dc(
          LogCategory.stacAction,
          'CustomSetValueAction: storing key="$key" value="$valueToStore"',
        );
        StacRegistry.instance.setValue(key, valueToStore);
        didUpdate = true;
      }

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

  /// Determines if we should fetch fresh value from registry instead of using
  /// the pre-resolved value from STAC framework.
  ///
  /// This is necessary because STAC pre-processes templates at JSON parse time,
  /// which can result in stale values being used when the registry was updated
  /// between parse time and execution time (e.g., after a network response).
  bool _shouldFetchFreshFromRegistry(String key, dynamic currentValue) {
    // Keys that store network response data and depend on data_payload
    const keysNeedingFreshData = ['deposits.rawData'];

    // Check if this key needs fresh data
    if (!keysNeedingFreshData.contains(key)) {
      return false;
    }

    // If the current value is a Map with identity-related fields,
    // it's likely stale data from a previous API call
    if (currentValue is Map) {
      // These fields indicate identity verification data, not deposit data
      if (currentValue.containsKey('birthDate') ||
          currentValue.containsKey('nationalId') ||
          currentValue.containsKey('fatherName')) {
        AppLogger.dc(
          LogCategory.stacAction,
          '⚠️ Detected stale identity data in "$key", will fetch fresh data_payload',
        );
        return true;
      }
    }

    // Also fetch fresh if data_payload exists and is a List (deposit data)
    final freshPayload = StacRegistry.instance.getValue('data_payload');
    if (freshPayload is List && freshPayload.isNotEmpty) {
      // Check if the fresh data is different from current
      if (currentValue is! List) {
        return true;
      }
    }

    return false;
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

    // removeLeadingZero(value)
    // Examples:
    //   {{removeLeadingZero(userData.mobile)}} -> "912..."
    final removeLeadingZeroMatch = RegExp(
      r"^removeLeadingZero\(\s*(.+)\s*\)$",
    ).firstMatch(expr);
    if (removeLeadingZeroMatch != null) {
      final valueExpr = removeLeadingZeroMatch.group(1)!.trim();
      final value = _evalExpression(valueExpr)?.toString();
      if (value == null) return null;
      if (value.startsWith('0')) {
        return value.substring(1);
      }
      return value;
    }

    // replace(value, from, to)
    // Examples:
    //   {{replace(form.receiver_birthdate,'/','')}} -> "13610629"
    final replaceMatch = RegExp(
      r"^replace\(\s*([^,]+)\s*,\s*'([^']*)'\s*,\s*'([^']*)'\s*\)$",
    ).firstMatch(expr);
    if (replaceMatch != null) {
      final valueExpr = replaceMatch.group(1)!.trim();
      final from = replaceMatch.group(2)!;
      final to = replaceMatch.group(3)!;

      final value = _evalExpression(valueExpr);
      if (value == null) return null;
      return value.toString().replaceAll(from, to);
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
    // First try the exact key as-is (supports dotted keys stored flat)
    final directValue = StacRegistry.instance.getValue(path);

    // Debug: log when resolving data_payload
    if (path == 'data_payload' || path.startsWith('data_payload.')) {
      final preview = directValue?.toString() ?? 'null';
      AppLogger.dc(
        LogCategory.stacAction,
        '📖 Resolving $path: ${directValue?.runtimeType ?? 'null'} = ${preview.length > 80 ? '${preview.substring(0, 80)}...' : preview}',
      );
    }

    if (directValue != null) return directValue;

    final parts = path.split('.');
    if (parts.isEmpty) return null;

    // Try longest dotted-key prefix first.
    // Example:
    //   responses.fetchCustomerInfo.payload.nationalCode
    // with flat registry key:
    //   responses.fetchCustomerInfo.payload (Map)
    for (int i = parts.length - 1; i > 0; i--) {
      final prefix = parts.sublist(0, i).join('.');
      final prefixValue = StacRegistry.instance.getValue(prefix);
      if (prefixValue != null) {
        return _walkNestedValue(prefixValue, parts.sublist(i));
      }
    }

    // Get the root value from registry
    dynamic value = StacRegistry.instance.getValue(parts[0]);
    if (value == null) return null;

    // Navigate through nested structure
    return _walkNestedValue(value, parts.sublist(1));
  }

  dynamic _walkNestedValue(dynamic value, List<String> remainingParts) {
    dynamic current = value;
    for (final part in remainingParts) {
      if (current is Map) {
        current = current[part];
      } else if (current is List && int.tryParse(part) != null) {
        final index = int.parse(part);
        if (index >= 0 && index < current.length) {
          current = current[index];
        } else {
          return null;
        }
      } else {
        return null;
      }
      if (current == null) return null;
    }
    return current;
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

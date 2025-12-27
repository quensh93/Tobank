import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/src/parsers/widgets/stac_form/stac_form_scope.dart';
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
class _CustomSetValueActionModel {
  final List<Map<String, dynamic>> entries;
  final Map<String, dynamic>? action;

  const _CustomSetValueActionModel({
    required this.entries,
    required this.action,
  });

  factory _CustomSetValueActionModel.fromJson(Map<String, dynamic> json) {
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
    return _CustomSetValueActionModel(
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
    extends StacActionParser<_CustomSetValueActionModel> {
  const CustomSetValueActionParser();

  @override
  String get actionType => ActionType.setValue.name;

  @override
  _CustomSetValueActionModel getModel(Map<String, dynamic> json) =>
      _CustomSetValueActionModel.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    _CustomSetValueActionModel model,
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
      StacRegistry.instance.setValue(key, valueToStore);
      didUpdate = true;

      // If a TextFormField controller is registered for this key, update it too.
      if (valueToStore != null) {
        TextFormFieldControllerRegistry.instance
            .updateValue(key, valueToStore.toString());
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

    return StacRegistry.instance.getValue(expr);
  }

  StacFormScope? _tryGetFormScope(BuildContext context) {
    try {
      return StacFormScope.of(context);
    } catch (_) {
      return null;
    }
  }
}

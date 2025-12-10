import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/src/parsers/core/stac_action_parser.dart';
import 'package:stac/src/parsers/widgets/stac_form/stac_form_scope.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../helpers/logger.dart';

/// Custom SetValueAction parser that resolves StacGetFormValue actions
/// before storing values in the registry.
///
/// This allows form values to be stored in the registry with the "form." prefix
/// so they can be accessed in dialog widgets using {{form.fieldName}} syntax.
class CustomSetValueActionParser extends StacActionParser<StacSetValueAction> {
  const CustomSetValueActionParser();

  @override
  String get actionType => ActionType.setValue.name;

  @override
  StacSetValueAction getModel(Map<String, dynamic> json) =>
      StacSetValueAction.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    StacSetValueAction model,
  ) async {
    final formScope = StacFormScope.of(context);
    
    // Resolve StacGetFormValue actions in values before storing
    for (final value in model.values ?? []) {
      final key = value['key'] as String;
      dynamic valueToStore = value['value'];
      
      // Check if the value is a StacGetFormValue action JSON
      if (valueToStore is Map<String, dynamic> &&
          valueToStore['actionType'] == ActionType.getFormValue.name) {
        // Resolve the form value
        final formValueId = valueToStore['id'] as String?;
        if (formValueId != null && formScope != null) {
          final formValue = formScope.formData[formValueId]?.toString();
          if (formValue != null) {
            valueToStore = formValue;
            AppLogger.d('Resolved form value for $key: $formValue');
          } else {
            AppLogger.w('Form value not found for id: $formValueId');
            valueToStore = ''; // Store empty string if form value not found
          }
        } else {
          AppLogger.w('Cannot resolve form value: formScope or id is null');
          valueToStore = ''; // Store empty string if cannot resolve
        }
      }
      
      // Store the resolved value in registry
      StacRegistry.instance.setValue(key, valueToStore);
    }
    
    // Execute the chained action (e.g., network request)
    return model.action?.parse(context);
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
// import 'package:stac/src/parsers/widgets/stac_form/stac_form_scope.dart';
import '../../registry/custom_component_registry.dart';
import '../../utils/text_form_field_controller_registry.dart';
import '../../../helpers/logger.dart';

/// Calculate Sum Action Model
///
/// A custom STAC action that calculates the sum of two form fields and updates a third field.
///
/// Example JSON:
/// ```json
/// {
///   "actionType": "calculateSum",
///   "fieldA": "input_a",
///   "fieldB": "input_b",
///   "resultField": "input_c"
/// }
/// ```
class CalculateSumActionModel {
  /// The form field ID for input A
  final String fieldA;

  /// The form field ID for input B
  final String fieldB;

  /// The form field ID for result (C = A + B)
  final String resultField;

  const CalculateSumActionModel({
    required this.fieldA,
    required this.fieldB,
    required this.resultField,
  });

  factory CalculateSumActionModel.fromJson(Map<String, dynamic> json) {
    return CalculateSumActionModel(
      fieldA: json['fieldA'] as String,
      fieldB: json['fieldB'] as String,
      resultField: json['resultField'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'calculateSum',
      'fieldA': fieldA,
      'fieldB': fieldB,
      'resultField': resultField,
    };
  }
}

/// Calculate Sum Action Parser
///
/// Calculates the sum of two form fields and updates the result field in real-time.
class CalculateSumActionParser
    extends StacActionParser<CalculateSumActionModel> {
  const CalculateSumActionParser();

  @override
  String get actionType => 'calculateSum';

  @override
  CalculateSumActionModel getModel(Map<String, dynamic> json) =>
      CalculateSumActionModel.fromJson(json);

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    CalculateSumActionModel model,
  ) async {
    try {
      AppLogger.i(
        '🧮 Calculate sum action triggered: ${model.fieldA} + ${model.fieldB} = ${model.resultField}',
      );

      final formScope = StacFormScope.of(context);
      if (formScope == null) {
        AppLogger.e('❌ Form scope not found, cannot calculate sum');
        return null;
      }

      AppLogger.d(
        '📊 Form scope found, formData keys: ${formScope.formData.keys.toList()}',
      );

      // Get values from form fields
      final valueAStr =
          formScope.formData[model.fieldA]?.toString().trim() ?? '';
      final valueBStr =
          formScope.formData[model.fieldB]?.toString().trim() ?? '';

      AppLogger.i(
        '📥 Value A (${model.fieldA}): "$valueAStr", Value B (${model.fieldB}): "$valueBStr"',
      );

      // Parse values as numbers - use 0 if empty or invalid
      final valueA = valueAStr.isEmpty ? 0 : (num.tryParse(valueAStr) ?? 0);
      final valueB = valueBStr.isEmpty ? 0 : (num.tryParse(valueBStr) ?? 0);

      // Calculate sum
      final sum = valueA + valueB;
      final sumStr = sum.toString();

      AppLogger.i('🧮 Calculated sum: $valueA + $valueB = $sum');

      // Update form data
      formScope.formData[model.resultField] = sumStr;
      AppLogger.d('📝 Updated formData[${model.resultField}] = $sumStr');

      // Update registry
      StacRegistry.instance.setValue('form.${model.resultField}', sumStr);
      AppLogger.d('💾 Updated registry: form.${model.resultField} = $sumStr');

      // Update TextFormField controller if registered
      final registry = TextFormFieldControllerRegistry.instance;
      final updated = registry.updateValue(model.resultField, sumStr);
      if (updated) {
        AppLogger.i(
          '✅ Updated TextFormField controller for ${model.resultField} = $sumStr',
        );
      } else {
        AppLogger.w(
          '⚠️ Controller not found in registry for ${model.resultField}',
        );
      }

      // Use setValue action to ensure the form field updates
      final setValueActionJson = {
        'actionType': 'setValue',
        'values': [
          {'key': 'form.${model.resultField}', 'value': sumStr},
        ],
      };
      AppLogger.d('🔄 Calling setValue action to update form field');
      await Stac.onCallFromJson(setValueActionJson, context);

      AppLogger.i(
        '✅ Successfully updated result field ${model.resultField} with sum: $sumStr',
      );
    } catch (e, stackTrace) {
      AppLogger.e('❌ Error calculating sum: $e\n$stackTrace');
    }
  }
}

/// Register the calculate sum action parser
void registerCalculateSumActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const CalculateSumActionParser(),
  );
}

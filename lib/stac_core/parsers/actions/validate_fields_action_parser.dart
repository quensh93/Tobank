import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../core/helpers/logger.dart';
import '../../registry/registry_notifier.dart';
import '../../registry/text_form_field_controller_registry.dart';

class ValidateFieldsActionModel {
  final String resultKey;
  final List<ValidateFieldRule> fields;

  const ValidateFieldsActionModel({
    required this.resultKey,
    required this.fields,
  });

  factory ValidateFieldsActionModel.fromJson(Map<String, dynamic> json) {
    final resultKey = json['resultKey'] as String? ?? 'formValid';
    final rawFields = json['fields'] as List? ?? const [];
    final fields = <ValidateFieldRule>[];

    for (final item in rawFields) {
      if (item is Map<String, dynamic>) {
        fields.add(ValidateFieldRule.fromJson(item));
      } else if (item is Map) {
        fields.add(ValidateFieldRule.fromJson(Map<String, dynamic>.from(item)));
      }
    }

    return ValidateFieldsActionModel(resultKey: resultKey, fields: fields);
  }
}

class ValidateFieldRule {
  final String id;
  final String? rule;
  final String? optional;

  const ValidateFieldRule({required this.id, this.rule, this.optional});

  factory ValidateFieldRule.fromJson(Map<String, dynamic> json) {
    return ValidateFieldRule(
      id: json['id'] as String,
      rule: json['rule'] as String?,
      optional: json['optional'] as String?,
    );
  }
}

class ValidateFieldsActionParser
    extends StacActionParser<ValidateFieldsActionModel> {
  const ValidateFieldsActionParser();

  @override
  String get actionType => 'validateFields';

  @override
  ValidateFieldsActionModel getModel(Map<String, dynamic> json) =>
      ValidateFieldsActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, ValidateFieldsActionModel model) {
    final formScope = _tryGetFormScope(context);
    if (formScope == null) {
      AppLogger.wc(
        LogCategory.action,
        'validateFields: no form scope found, using controller/registry fallback',
      );
    }

    var isValid = true;
    for (final field in model.fields) {
      // Check if field is optional based on condition
      if (field.optional != null) {
        final isOptional =
            StacRegistry.instance.getValue(field.optional!) == true;
        if (isOptional) continue;
      }

      final value = _resolveFieldValue(formScope, field.id);
      if (value.isEmpty) {
        isValid = false;
        break;
      }
      if (field.rule != null && field.rule!.isNotEmpty) {
        final regex = RegExp(field.rule!);
        final normalized = _normalizeDigits(value);
        if (!regex.hasMatch(normalized)) {
          isValid = false;
          break;
        }
      }
    }

    StacRegistry.instance.setValue(model.resultKey, isValid);
    RegistryNotifier.instance.notify();
    return null;
  }

  StacFormScope? _tryGetFormScope(BuildContext context) {
    try {
      return StacFormScope.of(context);
    } catch (_) {
      return null;
    }
  }

  String _resolveFieldValue(StacFormScope? formScope, String fieldId) {
    final fromForm = formScope?.formData[fieldId]?.toString().trim() ?? '';
    if (fromForm.isNotEmpty) return fromForm;

    final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
    final fromController = controller?.text.trim() ?? '';
    if (fromController.isNotEmpty) return fromController;

    final fromFormRegistry =
        StacRegistry.instance.getValue('form.$fieldId')?.toString().trim() ??
        '';
    if (fromFormRegistry.isNotEmpty) return fromFormRegistry;

    final fromDirectRegistry =
        StacRegistry.instance.getValue(fieldId)?.toString().trim() ?? '';
    return fromDirectRegistry;
  }

  String _normalizeDigits(String input) {
    var output = input;
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(fa[i], '$i');
      output = output.replaceAll(ar[i], '$i');
    }
    return output;
  }
}

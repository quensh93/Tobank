import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';

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

  const ValidateFieldRule({required this.id, this.rule});

  factory ValidateFieldRule.fromJson(Map<String, dynamic> json) {
    return ValidateFieldRule(
      id: json['id'] as String,
      rule: json['rule'] as String?,
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
      AppLogger.wc(LogCategory.action, 'validateFields: no form scope found');
      return null;
    }

    var isValid = true;
    for (final field in model.fields) {
      final value = formScope.formData[field.id]?.toString() ?? '';
      if (value.isEmpty) {
        isValid = false;
        break;
      }
      if (field.rule != null && field.rule!.isNotEmpty) {
        final regex = RegExp(field.rule!);
        if (!regex.hasMatch(value)) {
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
}

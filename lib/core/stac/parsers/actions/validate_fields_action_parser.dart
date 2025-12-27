import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/src/parsers/widgets/stac_form/stac_form_scope.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';

class _ValidateFieldsActionModel {
  final String resultKey;
  final List<_ValidateFieldRule> fields;

  const _ValidateFieldsActionModel({
    required this.resultKey,
    required this.fields,
  });

  factory _ValidateFieldsActionModel.fromJson(Map<String, dynamic> json) {
    final resultKey = json['resultKey'] as String? ?? 'formValid';
    final rawFields = json['fields'] as List? ?? const [];
    final fields = <_ValidateFieldRule>[];

    for (final item in rawFields) {
      if (item is Map<String, dynamic>) {
        fields.add(_ValidateFieldRule.fromJson(item));
      } else if (item is Map) {
        fields.add(
          _ValidateFieldRule.fromJson(Map<String, dynamic>.from(item)),
        );
      }
    }

    return _ValidateFieldsActionModel(resultKey: resultKey, fields: fields);
  }
}

class _ValidateFieldRule {
  final String id;
  final String? rule;

  const _ValidateFieldRule({required this.id, this.rule});

  factory _ValidateFieldRule.fromJson(Map<String, dynamic> json) {
    return _ValidateFieldRule(
      id: json['id'] as String,
      rule: json['rule'] as String?,
    );
  }
}

class ValidateFieldsActionParser
    extends StacActionParser<_ValidateFieldsActionModel> {
  const ValidateFieldsActionParser();

  @override
  String get actionType => 'validateFields';

  @override
  _ValidateFieldsActionModel getModel(Map<String, dynamic> json) =>
      _ValidateFieldsActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, _ValidateFieldsActionModel model) {
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

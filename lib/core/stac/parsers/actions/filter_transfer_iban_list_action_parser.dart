import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';
import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';
import '../../utils/text_form_field_controller_registry.dart';

class FilterTransferIbanListActionModel {
  final String fieldId;
  final List<String> ibanValues;
  final List<String> visibleKeys;
  final String? continueEnabledKey;
  final String? isSearchingKey;

  const FilterTransferIbanListActionModel({
    required this.fieldId,
    required this.ibanValues,
    required this.visibleKeys,
    this.continueEnabledKey,
    this.isSearchingKey,
  });

  factory FilterTransferIbanListActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final fieldId = json['fieldId'] as String? ?? '';
    final ibanValues =
        (json['ibanValues'] as List?)?.map((e) => e.toString()).toList() ??
        const <String>[];
    final visibleKeys =
        (json['visibleKeys'] as List?)?.map((e) => e.toString()).toList() ??
        const <String>[];

    return FilterTransferIbanListActionModel(
      fieldId: fieldId,
      ibanValues: ibanValues,
      visibleKeys: visibleKeys,
      continueEnabledKey: json['continueEnabledKey'] as String?,
      isSearchingKey: json['isSearchingKey'] as String?,
    );
  }
}

class FilterTransferIbanListActionParser
    extends StacActionParser<FilterTransferIbanListActionModel> {
  const FilterTransferIbanListActionParser();

  @override
  String get actionType => 'filterTransferIbanList';

  @override
  FilterTransferIbanListActionModel getModel(Map<String, dynamic> json) {
    return FilterTransferIbanListActionModel.fromJson(json);
  }

  @override
  FutureOr onCall(
    BuildContext context,
    FilterTransferIbanListActionModel model,
  ) {
    if (model.fieldId.isEmpty ||
        model.ibanValues.isEmpty ||
        model.visibleKeys.isEmpty ||
        model.ibanValues.length != model.visibleKeys.length) {
      AppLogger.wc(
        LogCategory.action,
        'filterTransferIbanList: invalid config',
      );
      return null;
    }

    final inputRaw = _readFieldValue(model.fieldId);
    final normalizedInput = _normalize(inputRaw);

    var didUpdate = false;

    for (var i = 0; i < model.ibanValues.length; i++) {
      final iban = _normalize(model.ibanValues[i]);
      final isVisible =
          normalizedInput.isEmpty || iban.startsWith(normalizedInput);
      final key = model.visibleKeys[i];
      final existing = StacRegistry.instance.getValue(key);
      if (existing != isVisible) {
        StacRegistry.instance.setValue(key, isVisible);
        didUpdate = true;
      }
    }

    if (model.continueEnabledKey != null &&
        model.continueEnabledKey!.isNotEmpty) {
      final canContinue = RegExp(r'^[0-9]{24}$').hasMatch(normalizedInput);
      final existing = StacRegistry.instance.getValue(
        model.continueEnabledKey!,
      );
      if (existing != canContinue) {
        StacRegistry.instance.setValue(model.continueEnabledKey!, canContinue);
        didUpdate = true;
      }
    }

    if (model.isSearchingKey != null && model.isSearchingKey!.isNotEmpty) {
      final isSearching = normalizedInput.isNotEmpty;
      final existing = StacRegistry.instance.getValue(model.isSearchingKey!);
      if (existing != isSearching) {
        StacRegistry.instance.setValue(model.isSearchingKey!, isSearching);
        didUpdate = true;
      }
    }

    if (didUpdate) {
      RegistryNotifier.instance.notify();
    }

    return null;
  }

  String _readFieldValue(String fieldId) {
    final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
    // If a controller exists, trust it even when empty.
    // Falling back to registry on empty text keeps stale previous selections
    // and prevents restoring the full list after clear.
    if (controller != null) {
      return controller.text;
    }

    final fromRegistry = StacRegistry.instance.getValue(fieldId)?.toString();
    return fromRegistry ?? '';
  }

  String _normalize(String value) {
    var result = value.trim();

    if (result.toUpperCase().startsWith('IR')) {
      result = result.substring(2);
    }

    result = result.replaceAll(' ', '').replaceAll('-', '');
    result = _toEnglishDigits(result);

    return result;
  }

  String _toEnglishDigits(String input) {
    const fa = '۰۱۲۳۴۵۶۷۸۹';
    const ar = '٠١٢٣٤٥٦٧٨٩';

    final buffer = StringBuffer();
    for (final rune in input.runes) {
      final char = String.fromCharCode(rune);
      final faIdx = fa.indexOf(char);
      if (faIdx >= 0) {
        buffer.write(faIdx);
        continue;
      }
      final arIdx = ar.indexOf(char);
      if (arIdx >= 0) {
        buffer.write(arIdx);
        continue;
      }
      buffer.write(char);
    }
    return buffer.toString();
  }
}

void registerFilterTransferIbanListActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const FilterTransferIbanListActionParser(),
  );
}

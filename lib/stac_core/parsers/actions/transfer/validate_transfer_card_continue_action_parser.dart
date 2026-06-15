import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../../../registry/text_form_field_controller_registry.dart';

class ValidateTransferCardContinueActionModel {
  final String fieldId;
  final int requiredLength;
  final String? destinationCardKey;
  final String? destinationDisplayNumberKey;
  final String? destinationNameKey;
  final String? destinationIconKey;
  final List<String> cardValues;
  final List<String> cardDisplayValues;
  final List<String> cardNames;
  final List<String> cardIcons;
  final Map<String, dynamic>? validAction;
  final Map<String, dynamic>? invalidAction;

  const ValidateTransferCardContinueActionModel({
    required this.fieldId,
    required this.requiredLength,
    this.destinationCardKey,
    this.destinationDisplayNumberKey,
    this.destinationNameKey,
    this.destinationIconKey,
    this.cardValues = const <String>[],
    this.cardDisplayValues = const <String>[],
    this.cardNames = const <String>[],
    this.cardIcons = const <String>[],
    this.validAction,
    this.invalidAction,
  });

  factory ValidateTransferCardContinueActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawValidAction = json['validAction'];
    final rawInvalidAction = json['invalidAction'];

    return ValidateTransferCardContinueActionModel(
      fieldId: json['fieldId'] as String? ?? 'transferApiCardInput',
      requiredLength: json['requiredLength'] as int? ?? 16,
      destinationCardKey: json['destinationCardKey'] as String?,
      destinationDisplayNumberKey:
          json['destinationDisplayNumberKey'] as String?,
      destinationNameKey: json['destinationNameKey'] as String?,
      destinationIconKey: json['destinationIconKey'] as String?,
      cardValues:
          (json['cardValues'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      cardDisplayValues:
          (json['cardDisplayValues'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      cardNames:
          (json['cardNames'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      cardIcons:
          (json['cardIcons'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const <String>[],
      validAction: rawValidAction is Map<String, dynamic>
          ? rawValidAction
          : rawValidAction is Map
              ? Map<String, dynamic>.from(rawValidAction)
              : null,
      invalidAction: rawInvalidAction is Map<String, dynamic>
          ? rawInvalidAction
          : rawInvalidAction is Map
              ? Map<String, dynamic>.from(rawInvalidAction)
              : null,
    );
  }
}

class ValidateTransferCardContinueActionParser
    extends StacActionParser<ValidateTransferCardContinueActionModel> {
  const ValidateTransferCardContinueActionParser();

  @override
  String get actionType => 'validateTransferCardContinue';

  @override
  ValidateTransferCardContinueActionModel getModel(Map<String, dynamic> json) {
    return ValidateTransferCardContinueActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ValidateTransferCardContinueActionModel model,
  ) {
    final rawInput = _readFieldValue(model.fieldId);
    final normalized = _normalizeCard(rawInput);
    final isValid = normalized.length == model.requiredLength;

    if (isValid) {
      var didUpdate = false;

      final destinationKey = model.destinationCardKey?.trim();
      if (destinationKey != null && destinationKey.isNotEmpty) {
        didUpdate = _setIfChanged(destinationKey, normalized) || didUpdate;
      }

      final matchedIndex = model.cardValues.indexWhere(
        (value) => _normalizeCard(value) == normalized,
      );
      if (matchedIndex >= 0) {
        didUpdate =
            _setListValueByIndex(
              key: model.destinationDisplayNumberKey,
              values: model.cardDisplayValues,
              index: matchedIndex,
            ) ||
            didUpdate;
        didUpdate =
            _setListValueByIndex(
              key: model.destinationNameKey,
              values: model.cardNames,
              index: matchedIndex,
            ) ||
            didUpdate;
        didUpdate =
            _setListValueByIndex(
              key: model.destinationIconKey,
              values: model.cardIcons,
              index: matchedIndex,
            ) ||
            didUpdate;
      }

      if (didUpdate) {
        RegistryNotifier.instance.notify();
      }

      if (model.validAction != null && context.mounted) {
        Stac.onCallFromJson(model.validAction!, context);
      }
      return null;
    }

    if (model.invalidAction != null && context.mounted) {
      Stac.onCallFromJson(model.invalidAction!, context);
    }
    return null;
  }

  bool _setIfChanged(String key, dynamic nextValue) {
    final previous = StacRegistry.instance.getValue(key);
    if (previous == nextValue) return false;
    StacRegistry.instance.setValue(key, nextValue);
    return true;
  }

  bool _setListValueByIndex({
    required String? key,
    required List<String> values,
    required int index,
  }) {
    if (key == null || key.trim().isEmpty) return false;
    if (index < 0 || index >= values.length) return false;
    return _setIfChanged(key, values[index]);
  }

  String _readFieldValue(String fieldId) {
    final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
    final fromController = controller?.text ?? '';
    if (fromController.isNotEmpty) return fromController;
    final fromRegistry = StacRegistry.instance.getValue(fieldId)?.toString();
    return fromRegistry ?? '';
  }

  String _normalizeCard(String input) {
    final english = _toEnglishDigits(input);
    return english.replaceAll(RegExp(r'[^0-9]'), '');
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

void registerValidateTransferCardContinueActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ValidateTransferCardContinueActionParser(),
  );
}

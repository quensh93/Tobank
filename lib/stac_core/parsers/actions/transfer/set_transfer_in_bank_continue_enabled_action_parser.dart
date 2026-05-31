import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../../../registry/text_form_field_controller_registry.dart';

class SetTransferInBankContinueEnabledActionModel {
  final String fieldId;
  final String rawValueKey;
  final String continueEnabledKey;
  final String hasTextKey;
  final String destinationIbanKey;
  final int minLengthExclusive;
  final int maxLength;

  const SetTransferInBankContinueEnabledActionModel({
    required this.fieldId,
    required this.rawValueKey,
    required this.continueEnabledKey,
    required this.hasTextKey,
    required this.destinationIbanKey,
    required this.minLengthExclusive,
    required this.maxLength,
  });

  factory SetTransferInBankContinueEnabledActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SetTransferInBankContinueEnabledActionModel(
      fieldId: json['fieldId'] as String? ?? 'transferApiInBankAccountInput',
      rawValueKey:
          json['rawValueKey'] as String? ?? 'transferApiInBankAccountRaw',
      continueEnabledKey:
          json['continueEnabledKey'] as String? ?? 'transferApiContinueEnabled',
      hasTextKey: json['hasTextKey'] as String? ?? 'transferApiInBankHasText',
      destinationIbanKey:
          json['destinationIbanKey'] as String? ?? 'transferApiDestinationIban',
      minLengthExclusive: json['minLengthExclusive'] as int? ?? 15,
      maxLength: json['maxLength'] as int? ?? 18,
    );
  }
}

class SetTransferInBankContinueEnabledActionParser
    extends StacActionParser<SetTransferInBankContinueEnabledActionModel> {
  const SetTransferInBankContinueEnabledActionParser();

  @override
  String get actionType => 'setTransferInBankContinueEnabled';

  @override
  SetTransferInBankContinueEnabledActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return SetTransferInBankContinueEnabledActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    SetTransferInBankContinueEnabledActionModel model,
  ) {
    final rawInput = _readFieldValue(model.fieldId);
    final normalized = _normalizeForLength(rawInput);

    final hasText = normalized.isNotEmpty;
    final canContinue =
        normalized.length > model.minLengthExclusive &&
        normalized.length <= model.maxLength;

    var didUpdate = false;
    didUpdate = _setIfChanged(model.rawValueKey, normalized) || didUpdate;
    didUpdate = _setIfChanged(model.hasTextKey, hasText) || didUpdate;
    didUpdate = _setIfChanged(model.continueEnabledKey, canContinue) || didUpdate;

    if (model.destinationIbanKey.trim().isNotEmpty) {
      didUpdate =
          _setIfChanged(model.destinationIbanKey, normalized) || didUpdate;
    }

    if (didUpdate) {
      RegistryNotifier.instance.notify();
    }
  }

  bool _setIfChanged(String key, dynamic value) {
    final existing = StacRegistry.instance.getValue(key);
    if (existing == value) return false;
    StacRegistry.instance.setValue(key, value);
    return true;
  }

  String _readFieldValue(String fieldId) {
    final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
    final fromController = controller?.text ?? '';
    if (fromController.isNotEmpty) return fromController;

    final fromRegistry = StacRegistry.instance.getValue(fieldId)?.toString();
    return fromRegistry ?? '';
  }

  String _normalizeForLength(String value) {
    final english = _toEnglishDigits(value);
    return english.replaceAll(RegExp(r'[^0-9.]'), '');
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

void registerSetTransferInBankContinueEnabledActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const SetTransferInBankContinueEnabledActionParser(),
  );
}

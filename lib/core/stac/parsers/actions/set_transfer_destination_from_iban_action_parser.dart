import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';
import '../../utils/text_form_field_controller_registry.dart';

class SetTransferDestinationFromIbanActionModel {
  final String fieldId;
  final List<String> ibanValues;
  final List<String> destinationNames;
  final String destinationIbanKey;
  final String destinationNameKey;

  const SetTransferDestinationFromIbanActionModel({
    required this.fieldId,
    required this.ibanValues,
    required this.destinationNames,
    required this.destinationIbanKey,
    required this.destinationNameKey,
  });

  factory SetTransferDestinationFromIbanActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final ibans =
        (json['ibanValues'] as List?)?.map((e) => e.toString()).toList() ??
        const <String>[];
    final names =
        (json['destinationNames'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        const <String>[];

    return SetTransferDestinationFromIbanActionModel(
      fieldId: json['fieldId'] as String? ?? 'transferApiIbanInput',
      ibanValues: ibans,
      destinationNames: names,
      destinationIbanKey:
          json['destinationIbanKey'] as String? ?? 'transferApiDestinationIban',
      destinationNameKey:
          json['destinationNameKey'] as String? ?? 'transferApiDestinationName',
    );
  }
}

class SetTransferDestinationFromIbanActionParser
    extends StacActionParser<SetTransferDestinationFromIbanActionModel> {
  const SetTransferDestinationFromIbanActionParser();

  @override
  String get actionType => 'setTransferDestinationFromIban';

  @override
  SetTransferDestinationFromIbanActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return SetTransferDestinationFromIbanActionModel.fromJson(json);
  }

  @override
  FutureOr onCall(
    BuildContext context,
    SetTransferDestinationFromIbanActionModel model,
  ) {
    final inputRaw = _readFieldValue(model.fieldId);
    final normalizedInput = _normalize(inputRaw);

    if (normalizedInput.isEmpty) {
      return null;
    }

    var matchedName = '';
    var matchedIban = normalizedInput;

    final safeLength = model.ibanValues.length < model.destinationNames.length
        ? model.ibanValues.length
        : model.destinationNames.length;

    for (var i = 0; i < safeLength; i++) {
      final iban = _normalize(model.ibanValues[i]);
      if (iban == normalizedInput) {
        matchedIban = iban;
        matchedName = model.destinationNames[i].trim();
        break;
      }
    }

    StacRegistry.instance.setValue(model.destinationIbanKey, matchedIban);
    StacRegistry.instance.setValue(model.destinationNameKey, matchedName);
    RegistryNotifier.instance.notify();
    return null;
  }

  String _readFieldValue(String fieldId) {
    final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
    final fromController = controller?.text ?? '';
    if (fromController.isNotEmpty) return fromController;

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

void registerSetTransferDestinationFromIbanActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const SetTransferDestinationFromIbanActionParser(),
  );
}

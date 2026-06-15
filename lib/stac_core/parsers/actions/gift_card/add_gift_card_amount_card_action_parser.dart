import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';

class AddGiftCardAmountCardActionModel {
  final String secondCardVisibleKey;
  final String thirdCardVisibleKey;

  const AddGiftCardAmountCardActionModel({
    required this.secondCardVisibleKey,
    required this.thirdCardVisibleKey,
  });

  factory AddGiftCardAmountCardActionModel.fromJson(Map<String, dynamic> json) {
    return AddGiftCardAmountCardActionModel(
      secondCardVisibleKey:
          json['secondCardVisibleKey'] as String? ??
          'giftCardRealShowSecondAmountCard',
      thirdCardVisibleKey:
          json['thirdCardVisibleKey'] as String? ??
          'giftCardRealShowThirdAmountCard',
    );
  }
}

class AddGiftCardAmountCardActionParser
    extends StacActionParser<AddGiftCardAmountCardActionModel> {
  const AddGiftCardAmountCardActionParser();

  @override
  String get actionType => 'addGiftCardAmountCard';

  @override
  AddGiftCardAmountCardActionModel getModel(Map<String, dynamic> json) {
    return AddGiftCardAmountCardActionModel.fromJson(json);
  }

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    AddGiftCardAmountCardActionModel model,
  ) {
    final showSecond = _toBool(
      StacRegistry.instance.getValue(model.secondCardVisibleKey),
    );
    final showThird = _toBool(
      StacRegistry.instance.getValue(model.thirdCardVisibleKey),
    );

    if (!showSecond) {
      StacRegistry.instance.setValue(model.secondCardVisibleKey, true);
      RegistryNotifier.instance.notify();
      return null;
    }

    if (!showThird) {
      StacRegistry.instance.setValue(model.thirdCardVisibleKey, true);
      RegistryNotifier.instance.notify();
      return null;
    }

    return null;
  }

  bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1' || normalized == 'yes';
    }
    return false;
  }
}

void registerAddGiftCardAmountCardActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const AddGiftCardAmountCardActionParser(),
  );
}

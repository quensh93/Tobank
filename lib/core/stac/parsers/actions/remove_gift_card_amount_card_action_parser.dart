import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';

class RemoveGiftCardAmountCardActionModel {
  final int cardIndex;
  final String secondCardVisibleKey;
  final String thirdCardVisibleKey;

  const RemoveGiftCardAmountCardActionModel({
    required this.cardIndex,
    required this.secondCardVisibleKey,
    required this.thirdCardVisibleKey,
  });

  factory RemoveGiftCardAmountCardActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RemoveGiftCardAmountCardActionModel(
      cardIndex: (json['cardIndex'] as num?)?.toInt() ?? 2,
      secondCardVisibleKey:
          json['secondCardVisibleKey'] as String? ??
          'giftCardRealShowSecondAmountCard',
      thirdCardVisibleKey:
          json['thirdCardVisibleKey'] as String? ??
          'giftCardRealShowThirdAmountCard',
    );
  }
}

class RemoveGiftCardAmountCardActionParser
    extends StacActionParser<RemoveGiftCardAmountCardActionModel> {
  const RemoveGiftCardAmountCardActionParser();

  @override
  String get actionType => 'removeGiftCardAmountCard';

  @override
  RemoveGiftCardAmountCardActionModel getModel(Map<String, dynamic> json) {
    return RemoveGiftCardAmountCardActionModel.fromJson(json);
  }

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    RemoveGiftCardAmountCardActionModel model,
  ) {
    final showSecond = _toBool(
      StacRegistry.instance.getValue(model.secondCardVisibleKey),
    );
    final showThird = _toBool(
      StacRegistry.instance.getValue(model.thirdCardVisibleKey),
    );

    if (model.cardIndex == 3) {
      if (showThird) {
        StacRegistry.instance.setValue(model.thirdCardVisibleKey, false);
        RegistryNotifier.instance.notify();
      }
      return null;
    }

    if (model.cardIndex == 2) {
      if (showThird) {
        // Remove second card and shift third card into second slot visually.
        StacRegistry.instance.setValue(model.thirdCardVisibleKey, false);
        RegistryNotifier.instance.notify();
        return null;
      }
      if (showSecond) {
        StacRegistry.instance.setValue(model.secondCardVisibleKey, false);
        RegistryNotifier.instance.notify();
      }
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

void registerRemoveGiftCardAmountCardActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const RemoveGiftCardAmountCardActionParser(),
  );
}

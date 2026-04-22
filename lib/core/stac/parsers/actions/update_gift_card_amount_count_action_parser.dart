import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';

class UpdateGiftCardAmountCountActionModel {
  final String countKey;
  final int delta;
  final int min;
  final int max;

  const UpdateGiftCardAmountCountActionModel({
    required this.countKey,
    required this.delta,
    required this.min,
    required this.max,
  });

  factory UpdateGiftCardAmountCountActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateGiftCardAmountCountActionModel(
      countKey: json['countKey'] as String? ?? 'giftCardRealCardCount1',
      delta: (json['delta'] as num?)?.toInt() ?? 1,
      min: (json['min'] as num?)?.toInt() ?? 1,
      max: (json['max'] as num?)?.toInt() ?? 5,
    );
  }
}

class UpdateGiftCardAmountCountActionParser
    extends StacActionParser<UpdateGiftCardAmountCountActionModel> {
  const UpdateGiftCardAmountCountActionParser();

  @override
  String get actionType => 'updateGiftCardAmountCount';

  @override
  UpdateGiftCardAmountCountActionModel getModel(Map<String, dynamic> json) {
    return UpdateGiftCardAmountCountActionModel.fromJson(json);
  }

  @override
  FutureOr<dynamic> onCall(
    BuildContext context,
    UpdateGiftCardAmountCountActionModel model,
  ) {
    final current = _parseCount(StacRegistry.instance.getValue(model.countKey));
    final min = model.min <= model.max ? model.min : model.max;
    final max = model.max >= model.min ? model.max : model.min;
    final next = (current + model.delta).clamp(min, max).toInt();

    if (next == current) return null;

    StacRegistry.instance.setValue(model.countKey, _toPersianDigit(next));
    RegistryNotifier.instance.notify();
    return null;
  }

  int _parseCount(dynamic value) {
    if (value == null) return 1;
    if (value is num) return value.toInt();

    final input = value.toString();
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    var normalized = input;
    for (var i = 0; i < 10; i++) {
      normalized = normalized.replaceAll(persian[i], '$i');
      normalized = normalized.replaceAll(arabic[i], '$i');
    }

    final parsed = int.tryParse(normalized.replaceAll(RegExp(r'[^0-9]'), ''));
    return parsed ?? 1;
  }

  String _toPersianDigit(int value) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    var output = value.toString();
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(english[i], persian[i]);
    }
    return output;
  }
}

void registerUpdateGiftCardAmountCountActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const UpdateGiftCardAmountCountActionParser(),
  );
}

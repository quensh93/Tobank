import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/widgets.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';

class SetTransferDetailsContinueEnabledActionModel {
  static const int minAmountRial = 10000;

  final String amountRawKey;
  final String reasonSelectedKey;
  final String continueEnabledKey;

  const SetTransferDetailsContinueEnabledActionModel({
    required this.amountRawKey,
    required this.reasonSelectedKey,
    required this.continueEnabledKey,
  });

  factory SetTransferDetailsContinueEnabledActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SetTransferDetailsContinueEnabledActionModel(
      amountRawKey: json['amountRawKey'] as String? ?? 'transferApiAmountRaw',
      reasonSelectedKey:
          json['reasonSelectedKey'] as String? ?? 'transferApiHasReason',
      continueEnabledKey:
          json['continueEnabledKey'] as String? ??
          'transferApiDetailsContinueEnabled',
    );
  }
}

class SetTransferDetailsContinueEnabledActionParser
    extends StacActionParser<SetTransferDetailsContinueEnabledActionModel> {
  const SetTransferDetailsContinueEnabledActionParser();

  @override
  String get actionType => 'setTransferDetailsContinueEnabled';

  @override
  SetTransferDetailsContinueEnabledActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return SetTransferDetailsContinueEnabledActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    SetTransferDetailsContinueEnabledActionModel model,
  ) {
    final hasReason =
        StacRegistry.instance.getValue(model.reasonSelectedKey) == true;
    final rawAmount = StacRegistry.instance.getValue(model.amountRawKey);
    final hasAmount =
        _parseAmount(rawAmount) >=
        SetTransferDetailsContinueEnabledActionModel.minAmountRial;

    StacRegistry.instance.setValue(
      model.continueEnabledKey,
      hasReason && hasAmount,
    );
    RegistryNotifier.instance.notify();
  }
}

int _parseAmount(dynamic input) {
  if (input == null) return 0;
  final normalized = _toEnglishDigits(
    input.toString(),
  ).replaceAll(RegExp(r'[^0-9]'), '');
  if (normalized.isEmpty) return 0;
  return int.tryParse(normalized) ?? 0;
}

String _toEnglishDigits(String value) {
  const fa = '۰۱۲۳۴۵۶۷۸۹';
  const ar = '٠١٢٣٤٥٦٧٨٩';
  var output = value;
  for (var i = 0; i < 10; i++) {
    output = output.replaceAll(fa[i], '$i').replaceAll(ar[i], '$i');
  }
  return output;
}

void registerSetTransferDetailsContinueEnabledActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const SetTransferDetailsContinueEnabledActionParser(),
  );
}

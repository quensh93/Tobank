import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/core/storage/secure_storage_service.dart';
import 'package:tobank_sdui/core/storage/secure_storage_keys.dart';
import '../../registry/registry_notifier.dart';
import 'package:stac/stac.dart';

/// Action parser that checks KYC (identity verification) completion status
/// from secure storage and updates the registry key accordingly.
///
/// Usage in SDUI:
/// ```json
/// { "actionType": "kyc_check", "targetKey": "homePage.authenticated" }
/// ```
class KycCheckActionModel {
  final String targetKey;

  const KycCheckActionModel({required this.targetKey});

  factory KycCheckActionModel.fromJson(Map<String, dynamic> json) {
    return KycCheckActionModel(
      targetKey: json['targetKey'] as String? ?? 'homePage.authenticated',
    );
  }
}

class KycCheckActionParser extends StacActionParser<KycCheckActionModel> {
  const KycCheckActionParser();

  @override
  String get actionType => 'kyc_check';

  @override
  KycCheckActionModel getModel(Map<String, dynamic> json) =>
      KycCheckActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, KycCheckActionModel model) async {
    final storedValue = await SecureStorageService.read(
      SecureStorageKeys.kycCompleted,
    );

    final isCompleted = storedValue == 'true';
    // do this for make ehraz true
    // final isCompleted = storedValue == null ? true : storedValue == 'true';

    StacRegistry.instance.setValue(model.targetKey, isCompleted);
    RegistryNotifier.instance.notify();

    AppLogger.ic(
      LogCategory.network,
      'KycCheck: Read kycCompleted=$isCompleted, set ${model.targetKey}=$isCompleted',
    );

    return null;
  }
}

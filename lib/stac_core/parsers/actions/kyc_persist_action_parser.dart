import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/core/storage/secure_storage_service.dart';
import 'package:tobank_sdui/core/storage/secure_storage_keys.dart';
import '../../registry/registry_notifier.dart';

/// Action parser that persists KYC (identity verification) completion status
/// to secure storage and updates the registry.
///
/// Usage in SDUI:
/// ```json
/// { "actionType": "kyc_persist", "completed": true }
/// ```
class KycPersistActionModel {
  final bool completed;

  const KycPersistActionModel({required this.completed});

  factory KycPersistActionModel.fromJson(Map<String, dynamic> json) {
    return KycPersistActionModel(
      completed: json['completed'] == true,
    );
  }
}

class KycPersistActionParser
    extends StacActionParser<KycPersistActionModel> {
  const KycPersistActionParser();

  @override
  String get actionType => 'kyc_persist';

  @override
  KycPersistActionModel getModel(Map<String, dynamic> json) =>
      KycPersistActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, KycPersistActionModel model) async {
    await SecureStorageService.write(
      SecureStorageKeys.kycCompleted,
      model.completed.toString(),
    );

    // Update registry so the UI reflects the change immediately
    StacRegistry.instance.setValue('homePage.authenticated', model.completed);
    RegistryNotifier.instance.notify();

    AppLogger.ic(
      LogCategory.network,
      'KycPersist: KYC completed=${model.completed} saved to secure storage.',
    );

    return null;
  }
}

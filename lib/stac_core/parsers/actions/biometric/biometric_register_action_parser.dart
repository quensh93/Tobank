import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../../core/helpers/logger.dart';
import '../../../../core/services/biometric/biometric_service.dart';
import 'biometric_register_action_model.dart';

class BiometricRegisterActionParser
    extends StacActionParser<BiometricRegisterActionModel> {
  const BiometricRegisterActionParser();

  @override
  String get actionType => 'biometricRegister';

  @override
  BiometricRegisterActionModel getModel(Map<String, dynamic> json) {
    return BiometricRegisterActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    BiometricRegisterActionModel model,
  ) async {
    final userId = model.userId?.trim();
    if (userId == null || userId.isEmpty) {
      AppLogger.wc(
        LogCategory.stacAction,
        '[biometricRegister] missing userId -> onFailure',
      );
      if (context.mounted && model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, context);
      }
      return;
    }

    if (!context.mounted) {
      return;
    }

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fingerprint, size: 64, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                model.title ?? 'Biometric Registration',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                model.description ??
                    'Create biometric/passkey credential for this user.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    AppLogger.ic(
                      LogCategory.stacAction,
                      '[biometricRegister] start userId=$userId passkeyOnly=${model.passkeyOnly}',
                    );
                    final registered = await BiometricService.register(
                      userId: userId,
                      passkeyOnly: model.passkeyOnly,
                    );
                    AppLogger.ic(
                      LogCategory.stacAction,
                      '[biometricRegister] result=$registered',
                    );

                    if (!sheetContext.mounted) {
                      return;
                    }
                    Navigator.pop(sheetContext);

                    if (registered) {
                      if (model.onSuccess != null) {
                        Stac.onCallFromJson(model.onSuccess!, sheetContext);
                      }
                    } else {
                      if (model.onFailure != null) {
                        Stac.onCallFromJson(model.onFailure!, sheetContext);
                      }
                    }
                  },
                  child: const Text('Create Credential'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

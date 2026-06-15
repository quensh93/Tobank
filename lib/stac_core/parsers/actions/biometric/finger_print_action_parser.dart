import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../../core/helpers/logger.dart';
import '../../../../core/services/biometric/biometric_service.dart';
import 'finger_print_action_model.dart';

class FingerPrintActionParser extends StacActionParser<FingerPrintActionModel> {
  const FingerPrintActionParser();

  @override
  String get actionType => 'fingerPrint';

  @override
  FingerPrintActionModel getModel(Map<String, dynamic> json) =>
      FingerPrintActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(
    BuildContext context,
    FingerPrintActionModel model,
  ) async {
    final hostContext = context;
    AppLogger.ic(
      LogCategory.stacAction,
      '[fingerPrint] start userIdProvided=${model.userId != null && model.userId!.isNotEmpty} authenticateOnly=true',
    );

    final isAvailable = await BiometricService.isAvailable();
    AppLogger.ic(
      LogCategory.stacAction,
      '[fingerPrint] availability=$isAvailable',
    );
    if (!isAvailable) {
      AppLogger.wc(
        LogCategory.stacAction,
        '[fingerPrint] unavailable -> onFailure',
      );
      if (context.mounted && model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, context);
      }
      return;
    }

    if (!context.mounted) {
      return;
    }

    final authenticated = await showModalBottomSheet<bool>(
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
                model.title ?? 'احراز هویت',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                model.description ??
                    'لطفا برای ادامه از اثر انگشت استفاده کنید',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    AppLogger.ic(
                      LogCategory.stacAction,
                      '[fingerPrint] authenticate requested',
                    );
                    final authenticated = await BiometricService.authenticate(
                      reason: model.description ?? 'لطفا احراز هویت کنید',
                      userId: model.userId,
                    );
                    AppLogger.ic(
                      LogCategory.stacAction,
                      '[fingerPrint] authenticate result=$authenticated',
                    );

                    if (!sheetContext.mounted) {
                      return;
                    }
                    Navigator.pop(sheetContext, authenticated);
                  },
                  child: const Text('تایید'),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (!hostContext.mounted) {
      return;
    }

    if (authenticated == true) {
      AppLogger.ic(
        LogCategory.stacAction,
        '[fingerPrint] success callback',
      );
      if (model.onSuccess != null) {
        Stac.onCallFromJson(model.onSuccess!, hostContext);
      }
    } else {
      AppLogger.wc(
        LogCategory.stacAction,
        '[fingerPrint] failure callback',
      );
      if (model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, hostContext);
      }
    }
  }
}

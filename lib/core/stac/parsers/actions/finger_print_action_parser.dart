import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../../services/biometric/biometric_service.dart';
import 'finger_print_action_model.dart';

class FingerPrintActionParser extends StacActionParser<FingerPrintActionModel> {
  const FingerPrintActionParser();

  @override
  String get actionType => 'fingerPrint';

  @override
  FingerPrintActionModel getModel(Map<String, dynamic> json) =>
      FingerPrintActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, FingerPrintActionModel model) async {
    // 1. Check availability
    bool isAvailable = await BiometricService.isAvailable();
    if (!isAvailable) {
      if (context.mounted && model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, context);
      }
      return;
    }

    // 2. Show BottomSheet explanation (optional) before triggering system auth
    // OR trigger directly. The user requirement said:
    // "show buttonsheet that says get finger print after that it should get that"

    if (!context.mounted) return;

    // Show a bottom sheet instructing the user
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                    // 3. Trigger Authentication
                    bool authenticated = await BiometricService.authenticate(
                      reason: model.description ?? 'لطفا احراز هویت کنید',
                      userId: model.userId,
                    );

                    if (!context.mounted) return;
                    Navigator.pop(context); // Close sheet

                    if (authenticated) {
                      if (model.onSuccess != null) {
                        Stac.onCallFromJson(model.onSuccess!, context);
                      }
                    } else {
                      if (model.onFailure != null) {
                        Stac.onCallFromJson(model.onFailure!, context);
                      }
                    }
                  },
                  child: const Text('تایید'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

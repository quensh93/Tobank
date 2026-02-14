import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';
import '../../../services/biometric/biometric_service.dart';
import '../../builders/stac_promissory_sign_action.dart';
import '../../../../model/common/sign_document_data.dart';
// import '../../../../stac/tobank/flows/promissory_real/utils/promissory_sign_util.dart'; // Deprecated
import '../../../../features/signing/signing_service.dart';
import '../../../../core/storage/storage_util.dart';
import '../../../../model/common/auth_info_data.dart';

class PromissorySignActionParser
    extends StacActionParser<StacPromissorySignAction> {
  const PromissorySignActionParser();

  @override
  String get actionType => 'promissorySign';

  @override
  StacPromissorySignAction getModel(Map<String, dynamic> json) =>
      StacPromissorySignAction(
        unsignedContract: json['unsignedContract'],
        signLocation: json['signLocation'],
        promissoryTitle: json['promissoryTitle'],
        onSuccess: json['onSuccess'],
        onFailure: json['onFailure'],
      );

  @override
  FutureOr onCall(BuildContext context, StacPromissorySignAction model) async {
    AppLogger.i('PromissorySignActionParser: onCall started');

    // 1. Check Biometric Availability & Authenticate
    bool isAvailable = await BiometricService.isAvailable();
    AppLogger.i(
      'PromissorySignActionParser: Biometric available: $isAvailable',
    );

    if (!isAvailable) {
      if (context.mounted && model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, context);
      }
      return;
    }

    // Show BottomSheet explanation
    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        // Use StatefulBuilder to manage local loading state
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            // Helper to update state safely
            void setLoading(bool value) {
              setState(() {
                isLoading = value;
              });
            }

            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.fingerprint, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    'تایید امضا',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'لطفا برای ثبت امضا از اثر انگشت استفاده کنید',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setLoading(true);
                              AppLogger.i(
                                'PromissorySignActionParser: Fingerprint confirm button pressed',
                              );
                              debugPrint(
                                'PromissorySignActionParser: Fingerprint confirm button pressed',
                              );

                              try {
                                // 1. Trigger Authentication
                                AppLogger.i(
                                  'PromissorySignActionParser: Triggering biometric auth',
                                );
                                debugPrint(
                                  'PromissorySignActionParser: Triggering biometric auth',
                                );

                                bool authenticated =
                                    await BiometricService.authenticate(
                                      reason: 'تایید امضای سفته',
                                    );
                                AppLogger.i(
                                  'PromissorySignActionParser: Biometric auth result: $authenticated',
                                );
                                debugPrint(
                                  'PromissorySignActionParser: Biometric auth result: $authenticated',
                                );

                                if (!authenticated) {
                                  // Auth Failed
                                  if (sheetContext.mounted)
                                    Navigator.pop(sheetContext);

                                  AppLogger.w(
                                    'PromissorySignActionParser: Biometric auth failed',
                                  );
                                  debugPrint(
                                    'PromissorySignActionParser: Biometric auth failed',
                                  );

                                  // Show Error on Parent Context
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('احراز هویت انجام نشد'),
                                      ),
                                    );
                                  }
                                  return;
                                }

                                // 2. Perform Signing (if auth success)
                                if (sheetContext.mounted) {
                                  // We use sheetContext for the action.
                                  // If it returns false (failure), we will close the sheet here.
                                  // If it returns true (success), it might have already navigated,
                                  // or we close the sheet.
                                  await _performSigningAndSuccess(
                                    sheetContext,
                                    model,
                                  );

                                  if (sheetContext.mounted) {
                                    Navigator.pop(sheetContext);
                                  }
                                }
                              } catch (e, s) {
                                // Exception in Flow
                                if (sheetContext.mounted)
                                  Navigator.pop(sheetContext);

                                AppLogger.e(
                                  'PromissorySignActionParser: Error during flow: $e\n$s',
                                );
                                debugPrint(
                                  'PromissorySignActionParser: Error during flow: $e',
                                );

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('خطا: $e')),
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('تایید'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Returns true if signing and onSuccess were successful/executed.
  Future<bool> _performSigningAndSuccess(
    BuildContext context,
    StacPromissorySignAction model,
  ) async {
    AppLogger.i('PromissorySignActionParser: Starting _performSigning');
    debugPrint('PromissorySignActionParser: Starting _performSigning');

    try {
      // Parse Sign Location
      final List<SignLocation> signLocations = [];

      if (model.signLocation != null) {
        final map = model.signLocation!;
        final double x = (map['x'] as num?)?.toDouble() ?? 450;
        final double y = (map['y'] as num?)?.toDouble() ?? 450;
        final double w = (map['width'] as num?)?.toDouble() ?? 150;
        final double h = (map['height'] as num?)?.toDouble() ?? 50;

        // Add ios/others if needed, keeping simple for now based on previous code
        final double xIos = (map['x_ios'] as num?)?.toDouble() ?? 450;
        final double yIos = (map['y_ios'] as num?)?.toDouble() ?? 450;
        final double wIos = (map['width_ios'] as num?)?.toDouble() ?? 150;
        final double hIos = (map['height_ios'] as num?)?.toDouble() ?? 50;
        final int page = (map['page'] as num?)?.toInt() ?? 0;

        signLocations.add(
          SignLocation(
            android: SignRect(x: x, y: y, width: w, height: h),
            ios: SignRect(x: xIos, y: yIos, width: wIos, height: hIos),
            signPageIndex: page,
            digitalSignatureRequired: false, // Visual signature only
          ),
        );
      } else {
        signLocations.add(
          SignLocation(
            android: SignRect(x: 450, y: 450, width: 150, height: 50),
            ios: SignRect(x: 450, y: 450, width: 150, height: 50),
            signPageIndex: 0,
            digitalSignatureRequired: false, // Visual signature only
          ),
        );
      }

      final String? unsignedContract =
          model.unsignedContract ?? "MOCK_PDF_BASE64";

      AppLogger.i(
        'PromissorySignActionParser: Calling SigningService.signDocument',
      );
      debugPrint(
        'PromissorySignActionParser: Calling SigningService.signDocument',
      );

      // Gather prerequisites
      final String? signatureBase64 =
          await StorageUtil.getBase64UserSignatureImage();
      final AuthInfoData? authInfo =
          await StorageUtil.getAuthInfoDataSecureStorage();
      final String? userCertificate = await StorageUtil.getUserCertificate();
      final String mobile = authInfo?.mobile ?? '09120000000'; // Fallback

      // Prepare Data
      final SignDocumentData signDocumentData = SignDocumentData(
        documentBase64: unsignedContract!,
        reason: '${model.promissoryTitle ?? "سفته"}_request',
        signLocations: signLocations,
      );

      // Call Signing Service
      final String? result = await SigningService.signDocument(
        data: signDocumentData,
        signatureImageBase64: signatureBase64,
        userCertificate: userCertificate,
        keyAlias: mobile,
        fullName: 'User Name', // TODO: Fetch from profile
        dateString: DateTime.now().toString(), // Use appropriate formatter
      );

      if (result != null) {
        AppLogger.i(
          'PromissorySignActionParser: Signing successful, executing onSuccess',
        );
        debugPrint(
          'PromissorySignActionParser: Signing successful, executing onSuccess',
        );

        // Store signed PDF in registry/form (Hardcoded to ensure access)
        await _storeSignedPdf(context, result);

        if (context.mounted && model.onSuccess != null) {
          await Stac.onCallFromJson(model.onSuccess!, context);
          return true;
        }
        return true;
      } else {
        AppLogger.w(
          'PromissorySignActionParser: Signing failed (result is null)',
        );
        debugPrint(
          'PromissorySignActionParser: Signing failed (result is null)',
        );

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('خطا در امضای دیجیتال')));
          if (model.onFailure != null) {
            Stac.onCallFromJson(model.onFailure!, context);
          }
        }
        return false;
      }
    } catch (e, stack) {
      AppLogger.e('Error in PromissorySignActionParser: $e');
      debugPrint('Error in PromissorySignActionParser: $e\n$stack');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطا: $e')));
        if (model.onFailure != null) {
          Stac.onCallFromJson(model.onFailure!, context);
        }
      }
      return false;
    }
  }

  Future<void> _storeSignedPdf(
    BuildContext context,
    String signedPdfBase64,
  ) async {
    const key = 'form.signed_pdf';

    // 1. Update Global Registry
    StacRegistry.instance.setValue(key, signedPdfBase64);

    // 2. Update Form Scope (if available) - this allows immediate {{form.x}} access
    final formScope = StacFormScope.of(context);
    // ignore: unnecessary_null_comparison
    if (formScope != null) {
      // Basic support for form.key - strip 'form.' prefix if present
      final formKey = key.startsWith('form.') ? key.substring(5) : key;
      formScope.formData[formKey] = signedPdfBase64;
    }
  }
}

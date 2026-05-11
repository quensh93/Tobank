import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';
import '../../builders/stac_promissory_sign_action.dart';
import '../../../../model/common/sign_document_data.dart';
// import '../../../../stac/tobank/flows/promissory_real/utils/promissory_sign_util.dart'; // Deprecated
import '../../../../features/signing/signing_service.dart';
import 'package:secure_plugin/secure_plugin.dart' as secure;
import '../../../../core/storage/storage_util.dart';
import '../../../../model/common/auth_info_data.dart';
import '../../../bootstrap/app_root.dart';

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

    if (!context.mounted) return;

    try {
      // Directly perform signing — the user has already confirmed via the dialog
      final success = await _performSigningAndSuccess(context, model);

      if (!success && context.mounted && model.onFailure != null) {
        Stac.onCallFromJson(model.onFailure!, context);
      }
    } catch (e, s) {
      AppLogger.e('PromissorySignActionParser: Error during flow: $e\n$s');
      debugPrint('PromissorySignActionParser: Error during flow: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطا: $e')));
        if (model.onFailure != null) {
          Stac.onCallFromJson(model.onFailure!, context);
        }
      }
    }
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
            digitalSignatureRequired: true, // Both visual + digital signature
          ),
        );
      } else {
        signLocations.add(
          SignLocation(
            android: SignRect(x: 450, y: 450, width: 150, height: 50),
            ios: SignRect(x: 450, y: 450, width: 150, height: 50),
            signPageIndex: 0,
            digitalSignatureRequired: true, // Both visual + digital signature
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

      // Ensure RSA key pair exists in Android KeyStore
      final String keyAlias = mobile;
      final enrollResult = await secure.SecurePlugin.isEnroll(
        phoneNumber: keyAlias,
      );
      AppLogger.i(
        'PromissorySignActionParser: isEnroll result: ${enrollResult.isSuccess}, message: ${enrollResult.message}',
      );
      debugPrint(
        'PromissorySignActionParser: isEnroll result: ${enrollResult.isSuccess}',
      );

      if (enrollResult.isSuccess != true) {
        // Key does not exist, generate it
        AppLogger.i(
          'PromissorySignActionParser: Key not found, generating new key pair...',
        );
        debugPrint(
          'PromissorySignActionParser: Key not found, generating new key pair...',
        );
        final genResult = await secure.SecurePlugin.generateKeys(
          phoneNumber: keyAlias,
          nameEnglish: 'User',
        );
        AppLogger.i(
          'PromissorySignActionParser: generateKeys result: ${genResult.isSuccess}, message: ${genResult.message}',
        );
        debugPrint(
          'PromissorySignActionParser: generateKeys result: ${genResult.isSuccess}',
        );
        if (genResult.isSuccess != true) {
          throw Exception(
            'Failed to generate signing key: ${genResult.message}',
          );
        }
      }

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

        // Store signed PDF in registry/form
        await _storeSignedPdf(context, result);

        final activeContext = _resolveActiveContext(context);
        if (activeContext != null && model.onSuccess != null) {
          await Stac.onCallFromJson(model.onSuccess!, activeContext);
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
          final activeContext = _resolveActiveContext(context);
          if (model.onFailure != null && activeContext != null) {
            Stac.onCallFromJson(model.onFailure!, activeContext);
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
        final activeContext = _resolveActiveContext(context);
        if (model.onFailure != null && activeContext != null) {
          Stac.onCallFromJson(model.onFailure!, activeContext);
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
    final activeContext = _resolveActiveContext(context);
    if (activeContext == null) return;

    try {
      final formScope = StacFormScope.of(activeContext);
      if (formScope == null) return;
      final formKey = key.startsWith('form.') ? key.substring(5) : key;
      formScope.formData[formKey] = signedPdfBase64;
    } catch (_) {
      // Safe fallback: registry already holds the value.
    }
  }

  BuildContext? _resolveActiveContext(BuildContext context) {
    if (context.mounted) return context;
    final fallback = AppRoot.mainAppNavigatorKey.currentContext;
    if (fallback != null && fallback.mounted) return fallback;
    return null;
  }
}

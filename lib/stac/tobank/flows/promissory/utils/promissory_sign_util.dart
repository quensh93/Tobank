import 'package:flutter/material.dart';
import '../../../../../core/helpers/logger.dart';
import '../../../../../core/storage/storage_util.dart';
import '../../../../../core/utils/app_util.dart';
import '../../../../../model/common/sign_document_data.dart';
import '../../../../../model/plugins/secure_response_data.dart';

class PromissorySignUtil {
  static Future<String?> signDocument({
    required String unsignedContract,
    required List<SignLocation> signLocation,
    required String promissoryTitle,
  }) async {
    // Check if signLocation list is empty
    if (signLocation.isEmpty) {
      AppLogger.w('PromissorySignUtil: signLocation list is empty');
      debugPrint('PromissorySignUtil: signLocation list is empty');
      return null;
    }

    // Check if signature image exists
    final String? signatureBase64 =
        await StorageUtil.getBase64UserSignatureImage();

    if (signatureBase64 == null) {
      AppLogger.w('PromissorySignUtil: signatureBase64 is null');
      debugPrint('PromissorySignUtil: signatureBase64 is null');
      throw Exception(
        'تصویر امضا یافت نشد. لطفا ابتدا نمونه امضای خود را ثبت کنید.',
      );
    }

    debugPrint(
      'PromissorySignUtil: signatureBase64 found (length: ${signatureBase64.length})',
    );

    final SignDocumentData signDocumentData = SignDocumentData(
      documentBase64: unsignedContract,
      reason: '${promissoryTitle}_request',
      signLocations: signLocation,
    );

    debugPrint('PromissorySignUtil: Calling AppUtil.signPdf...');
    final SecureResponseData signResponse = await AppUtil.signPdf(
      signDocumentData: signDocumentData,
    );
    AppLogger.i('PromissorySignUtil: AppUtil.signPdf returned');
    debugPrint(
      'PromissorySignUtil: AppUtil.signPdf returned. Success: ${signResponse.isSuccess}',
    );

    if (signResponse.isSuccess != null && signResponse.isSuccess!) {
      final String? signedDocumentBase64 = signResponse.data;
      return signedDocumentBase64;
    } else {
      AppLogger.w('sign pdf error: ${signResponse.message}');
      debugPrint('PromissorySignUtil: sign pdf error: ${signResponse.message}');
      return null;
    }
  }
}

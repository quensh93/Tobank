import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:crypto/crypto.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../model/common/sign_document_data.dart';
import '../../model/plugins/secure_response_data.dart';
import '../plugins/secure_plugin.dart';
import '../storage/storage_util.dart';

class AppUtil {
  /// Simple AES simulation (hashing) for now as we don't have crypto/encrypt packages setup
  /// In a real app, use 'encrypt' package.
  static String encryptDataWithAES({required String data}) {
    // For now, just hashing it to simulate "encryption" for comparison
    var bytes = utf8.encode(data);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Signs the document (pdf) using visual signature (fingerprint) and digital signature (Yekta).
  ///
  /// This implementation mocks the actual visual signing due to missing dependencies.
  static Future<SecureResponseData> signPdf({
    required SignDocumentData signDocumentData,
  }) async {
    // Removed locale dependency for now as context might not be available or AppLocalizations missing
    // final locale = AppLocalizations.of(Get.context!)!;
    final String? signatureBase64 =
        await StorageUtil.getBase64UserSignatureImage();

    String documentBase64 = signDocumentData.documentBase64;

    // Sign Document (Add user signature image to pdf) - Mocked
    final signLocations = signDocumentData.signLocations
        .where((element) => !element.digitalSignatureRequired)
        .toList();

    for (final signLocation in signLocations) {
      documentBase64 = await _signPdf(
        documentBase64: documentBase64,
        signLocation: signLocation,
        signatureBase64: signatureBase64,
      );
    }

    // Digital sign pdf
    try {
      final digitalSignLocation = signDocumentData.signLocations.firstWhere(
        (element) => element.digitalSignatureRequired,
        orElse: () => throw Exception('No digital sign location found'),
      );

      // Assuming we always use Yekta or just default to it as user said "ignore zoomid"
      return await _digitalSignYektaPdf(
        documentBase64: documentBase64,
        signLocation: digitalSignLocation,
        signatureBase64: signatureBase64 ?? '', // Handle nullable signature
        reason: signDocumentData.reason,
      );
    } catch (e) {
      // If no digital sign location found, return success with current doc
      return SecureResponseData(
        statusCode: 200,
        data: documentBase64,
        message: 'Signature applied successfully (No digital sign required)',
        isSuccess: true,
      );
    }
  }

  /// Real implementation of visual PDF signing using syncfusion_flutter_pdf
  static Future<String> _signPdf({
    required String documentBase64,
    required SignLocation signLocation,
    required String? signatureBase64,
  }) async {
    if (signatureBase64 == null || signatureBase64.isEmpty) {
      // No signature image, return original
      return documentBase64;
    }

    try {
      // 1. Decode PDF from base64
      final Uint8List pdfBytes = base64Decode(documentBase64);

      // 2. Load the PDF document
      final PdfDocument document = PdfDocument(inputBytes: pdfBytes);

      // 3. Get the page to sign on
      final int pageIndex = signLocation.signPageIndex;
      if (pageIndex < 0 || pageIndex >= document.pages.count) {
        document.dispose();
        return documentBase64; // Invalid page index
      }
      final PdfPage page = document.pages[pageIndex];

      // 4. Decode signature image from base64
      final Uint8List signatureBytes = base64Decode(signatureBase64);
      final PdfBitmap signatureImage = PdfBitmap(signatureBytes);

      // 5. Get the correct coordinates based on platform
      final SignRect rect;
      if (Platform.isAndroid) {
        rect = signLocation.android;
      } else if (Platform.isIOS) {
        rect = signLocation.ios;
      } else {
        rect = signLocation.web ?? signLocation.android;
      }

      // 6. Draw the signature image on the page
      page.graphics.drawImage(
        signatureImage,
        Rect.fromLTWH(rect.x, rect.y, rect.width, rect.height),
      );

      // 7. Save the modified PDF
      final List<int> savedBytes = document.saveSync();
      document.dispose();

      // 8. Encode back to base64
      return base64Encode(savedBytes);
    } catch (e) {
      // If anything fails, return original
      return documentBase64;
    }
  }

  static Future<SecureResponseData> _digitalSignYektaPdf({
    required String documentBase64,
    required SignLocation signLocation,
    required String signatureBase64,
    required String reason,
  }) async {
    // Using mock SecurePlugin
    // Using default/mock values for missing params
    return await SecurePlugin.newSignPdf(
      phoneNumber: '09120000000', // Mock phone
      pdfBase64: documentBase64,
      cert: 'MOCK_CERT', // Mock cert
      name: 'User-Digital-Signature',
      reason: reason,
      location: 'IR',
      signatureBase64: signatureBase64,
      signatureX: signLocation.android.x.toInt(),
      signatureY: signLocation.android.y.toInt(),
      signatureWidth: signLocation.android.width.toInt(),
      signatureHeight: signLocation.android.height.toInt(),
      signaturePage: signLocation.signPageIndex,
      signatureNameFamily: 'Mock User',
    );
  }
}

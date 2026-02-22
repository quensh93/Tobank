import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:collection/collection.dart'; // For firstWhereOrNull

// Local imports
import 'package:secure_plugin/secure_plugin.dart';
// import '../../core/plugins/secure_web_plugin.dart'; // Uncomment if web needed and file exists

import '../../model/common/sign_document_data.dart';
import 'model/external_signer.dart';

class SigningService {
  /// Main entry point to sign a document
  static Future<String?> signDocument({
    required SignDocumentData data,
    required String? signatureImageBase64, // User's visual signature
    required String? userCertificate, // Required for digital sign (Yekta)
    required String keyAlias, // Key alias for SecurePlugin (Mobile)
    required String fullName, // User's full name for visual text
    required String dateString, // Date string for visual text
  }) async {
    String currentDocBase64 = data.documentBase64;

    // 1. Visual Signing (No digital signature required)
    final visualLocations = data.signLocations
        .where((e) => !e.digitalSignatureRequired)
        .toList();
    for (final loc in visualLocations) {
      currentDocBase64 = await _applyVisualSignature(
        documentBase64: currentDocBase64,
        location: loc,
        signatureImageBase64: signatureImageBase64,
        fullName: fullName,
        dateString: dateString,
      );
    }

    // 2. Digital Signing (Required)
    final digitalLocation = data.signLocations.firstWhereOrNull(
      (e) => e.digitalSignatureRequired,
    );

    if (digitalLocation != null) {
      // Assuming Yekta provider for now
      return await _digitalSignYekta(
        documentBase64: currentDocBase64,
        location: digitalLocation,
        signatureImageBase64: signatureImageBase64,
        reason: data.reason,
        certificate: userCertificate,
        keyAlias: keyAlias,
      );
    }

    return currentDocBase64;
  }

  /// Applies purely visual signature using Syncfusion
  static Future<String> _applyVisualSignature({
    required String documentBase64,
    required SignLocation location,
    required String? signatureImageBase64,
    required String fullName,
    required String dateString,
  }) async {
    if (signatureImageBase64 == null || signatureImageBase64.isEmpty) {
      return documentBase64;
    }

    try {
      final Uint8List bytes = base64Decode(documentBase64);
      final PdfDocument document = PdfDocument(inputBytes: bytes);

      // Check page index validity
      if (location.signPageIndex < 0 ||
          location.signPageIndex >= document.pages.count) {
        document.dispose();
        return documentBase64;
      }

      final PdfPage page = document.pages[location.signPageIndex];

      final SignRect rectData = Platform.isAndroid
          ? location.android
          : location.ios;
      // If web, handle appropriately (e.g. location.web ?? location.android)

      final Rect signatureRect = Rect.fromLTWH(
        rectData.x,
        rectData.y,
        rectData.width,
        rectData.height,
      );

      // Decode signature image
      final Uint8List signatureBytes = base64Decode(signatureImageBase64);
      final PdfBitmap signatureImage = PdfBitmap(signatureBytes);

      // Draw image
      page.graphics.drawImage(signatureImage, signatureRect);

      // Save
      final List<int> signedBytes = await document.save();
      document.dispose();
      return base64Encode(signedBytes);
    } catch (e) {
      debugPrint('Visual signing failed: $e');
      return documentBase64;
    }
  }

  static Future<String?> _digitalSignYekta({
    required String documentBase64,
    required SignLocation location,
    required String? signatureImageBase64,
    required String reason,
    required String? certificate,
    required String keyAlias,
  }) async {
    if (kIsWeb) {
      // Helper for Web implementation
      // return await _digitalSignYektaWeb(...);
      throw UnimplementedError("Web signing needs SecureWebPlugin");
    } else if (Platform.isAndroid) {
      // Android Native Plugin call via MethodChannel
      final result = await SecurePlugin.newSignPdf(
        phoneNumber: keyAlias,
        pdfBase64: documentBase64,
        cert: certificate ?? 'MOCK_CERT',
        name: 'User-Digital-Signature',
        reason: reason,
        location: 'IR',
        signatureBase64: signatureImageBase64 ?? '',
        signatureX: location.android.x.toInt(),
        signatureY: location.android.y.toInt(),
        signatureWidth: location.android.width.toInt(),
        signatureHeight: location.android.height.toInt(),
        signaturePage: location.signPageIndex,
        signatureNameFamily:
            'mahdi jamshidpour', // Pass user english name if available
      );
      return result.isSuccess == true ? result.data : null;
    } else {
      // iOS implementation would go here
      return null;
    }
  }
}

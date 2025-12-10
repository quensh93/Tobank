import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

// Conditional import for web-specific signing logic
import 'js_interop_web.dart' if (dart.library.io) 'js_interop_stub.dart';

// Sign function: Signs PDF with signature image and triggers download
Future<String> signPdfWithSignatureImg({
  required String pdfBase64,
  required String sigBase64,
  required double x,
  required double y,
  required double width,
  required double height,
  required int pageIndex,
}) async {
  if (kIsWeb) {
    // Web: Use JavaScript to sign and download
    return await signPdfOnWeb(
      pdfBase64: pdfBase64,
      sigBase64: sigBase64,
      x: x,
      y: y,
      width: width,
      height: height,
      pageIndex: pageIndex,
    );
  } else {
    // Android/iOS: Save the original PDF to device storage as a fallback
    try {
      final bytes = base64Decode(pdfBase64);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/document.pdf');
      await file.writeAsBytes(bytes);
      print('PDF saved to ${file.path}');
      return pdfBase64; // Return original PDF base64
    } catch (e) {
      print('Error saving PDF on mobile: $e');
      return '';
    }
  }
}
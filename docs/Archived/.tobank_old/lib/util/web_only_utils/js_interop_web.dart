import 'dart:convert';
import 'dart:js_interop';
import 'package:universal_html/html.dart' as html;

// Declare the JavaScript function 'signPdfWithImage' for web
@JS('signPdfWithImage')
external JSPromise<JSString> signPdfWithImage(
    JSString pdfBase64,
    JSString sigBase64,
    JSNumber x,
    JSNumber y,
    JSNumber width,
    JSNumber height,
    JSNumber pageIndex,
    );

// Web-specific function to sign PDF using JavaScript
Future<String> signPdfOnWeb({
  required String pdfBase64,
  required String sigBase64,
  required double x,
  required double y,
  required double width,
  required double height,
  required int pageIndex,
}) async {
  try {
    // Call the JavaScript function 'signPdfWithImage'
    final signedPdfBase64 = await signPdfWithImage(
      pdfBase64.toJS,
      sigBase64.toJS,
      x.toJS,
      y.toJS,
      width.toJS,
      height.toJS,
      pageIndex.toJS,
    ).toDart;

    final result = signedPdfBase64.toDart;

    // Download the signed PDF
    final bytes = base64Decode(result);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '') // blank for browser default
      ..click();
    html.Url.revokeObjectUrl(url);

    return result;
  } catch (e) {
    print('Error signing PDF on web: $e');
    return '';
  }
}
// Stub for dart:js_interop on non-web platforms
// Provides a no-op implementation to avoid import errors

// Dummy class to satisfy the @JS annotation
class JS {
  const JS(String name);
}

// No-op signPdfOnWeb function for non-web platforms
Future<String> signPdfOnWeb({
  required String pdfBase64,
  required String sigBase64,
  required double x,
  required double y,
  required double width,
  required double height,
  required int pageIndex,
}) async {
  // This function is never called (guarded by kIsWeb)
  return '';
}
import '../../model/plugins/secure_response_data.dart';

class SecurePlugin {
  static Future<SecureResponseData> newSignPdf({
    required String phoneNumber,
    required String pdfBase64,
    required String cert,
    required String name,
    required String reason,
    required String location,
    required String signatureBase64,
    required int signatureX,
    required int signatureY,
    required int signatureWidth,
    required int signatureHeight,
    required int signaturePage,
    required String signatureNameFamily,
  }) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 2));
    return SecureResponseData(
      isSuccess: true,
      statusCode: 200,
      data: pdfBase64, // Return original PDF for now (mock)
      message: 'Signed successfully (MOCK)',
    );
  }

  static Future<SecureResponseData> signText({
    required String plainText,
    required String phoneNumber,
  }) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return SecureResponseData(
      isSuccess: true,
      statusCode: 200,
      data: 'MOCK_SIGNATURE',
      message: 'Signed text successfully (MOCK)',
    );
  }
}

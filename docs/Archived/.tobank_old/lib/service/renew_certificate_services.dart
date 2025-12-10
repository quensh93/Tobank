import '../model/renew_certificate/request/renew_certificate_request_data.dart';
import '../model/renew_certificate/response/renew_certificate_response_data.dart';
import 'core/api_core.dart';

class RenewCertificateServices {
  RenewCertificateServices._();

  static Future<ApiResult<(RenewCertificateResponseData, int), ApiException>> renewCertificateRequest({
    required RenewCertificateRequestData renewCertificateRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.renewCertificate,
        data: renewCertificateRequestData,
        modelFromJson: (responseBody, statusCode) => RenewCertificateResponseData.fromJson(responseBody));
  }
}

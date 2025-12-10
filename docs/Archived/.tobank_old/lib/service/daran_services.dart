import '../model/daran/response/daran_response_data.dart';
import 'core/api_core.dart';

class DaranServices {
  DaranServices._();

  static Future<ApiResult<(DaranResponseData, int), ApiException>> getDaranRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.daranLogin,
        modelFromJson: (responseBody, statusCode) => DaranResponseData.fromJson(responseBody));
  }
}

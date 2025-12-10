import 'dart:async';

import '../model/profile/request/delete_account_request_data.dart';
import '../model/profile/response/delete_account_otp_response_data.dart';
import '../model/profile/response/delete_account_response_data.dart';
import 'core/api_core.dart';

class DeleteAccountServices {
  DeleteAccountServices._();

  static Future<ApiResult<(DeleteAccountOtpResponseData, int), ApiException>> deleteOtpRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deleteAccountOTPRequest,
        modelFromJson: (responseBody, statusCode) => DeleteAccountOtpResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(DeleteAccountResponseData, int), ApiException>> deleteRequest({
    required DeleteAccountRequestData deleteAccountRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deleteAccount,
        data: deleteAccountRequestData,
        modelFromJson: (responseBody, statusCode) => DeleteAccountResponseData.fromJson(responseBody));
  }
}

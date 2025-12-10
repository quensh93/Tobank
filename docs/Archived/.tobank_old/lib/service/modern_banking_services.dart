import 'dart:async';

import '../model/modern_banking/request/modern_banking_change_password_request.dart';
import '../model/modern_banking/response/modern_banking_change_password_response.dart';
import 'core/api_core.dart';

class ModernBankingServices {
  ModernBankingServices._();

  static Future<ApiResult<(ModernBankingChangePasswordResponse, int), ApiException>> modernBankingPasswordChange({
    required ModernBankingChangePasswordRequest modernBankingChangePasswordRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.changeModernBankingPassword,
        data: modernBankingChangePasswordRequest,
        modelFromJson: (responseBody, statusCode) => ModernBankingChangePasswordResponse.fromJson(responseBody));
  }
}

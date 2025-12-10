import '../model/add_deposit/request/delete_deposit_request.dart';
import '../model/add_deposit/request/save_deposit_request.dart';
import '../model/add_deposit/request/update_deposit_request.dart';
import '../model/add_deposit/response/delete_deposit_data_response.dart';
import '../model/add_deposit/response/deposit_list_data_response.dart';
import '../model/add_deposit/response/save_deposit_data_response.dart';
import '../model/add_deposit/response/update_deposit_data_response.dart';
import 'core/api_core.dart';

class DepositNotebookServices {
  DepositNotebookServices._();

  static Future<ApiResult<(SaveDepositDataResponse, int), ApiException>> saveDeposit({
    required SaveDepositRequest saveDepositRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.saveDepositInNotebook,
        data: saveDepositRequest,
        modelFromJson: (responseBody, statusCode) => SaveDepositDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(DepositListDataResponse, int), ApiException>> getDepositList() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getDepositNotebook,
        modelFromJson: (responseBody, statusCode) => DepositListDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(UpdateDepositDataResponse, int), ApiException>> updateDeposit({
    required UpdateDepositRequest updateDepositRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateDepositNotebook,
        data: updateDepositRequest,
        modelFromJson: (responseBody, statusCode) => UpdateDepositDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(DeleteDepositDataResponse, int), ApiException>> deleteDeposit({
    required DeleteDepositRequest deleteDepositRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deleteDepositNotebook,
        data: deleteDepositRequest,
        modelFromJson: (responseBody, statusCode) => DeleteDepositDataResponse.fromJson(responseBody));
  }
}

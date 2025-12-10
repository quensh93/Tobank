import 'dart:async';

import '../model/register/request/authorized_api_token_request_data.dart';
import '../model/register/request/customer_info_request_data.dart';
import '../model/register/request/get_public_key_request_data.dart';
import '../model/register/request/registration_request_data.dart';
import '../model/register/request/upload_customer_public_key_request_data.dart';
import '../model/register/response/authorized_api_token_response_data.dart';
import '../model/register/response/customer_info_response_data.dart';
import '../model/register/response/get_jobs_list_response_data.dart';
import '../model/register/response/get_public_key_response_data.dart';
import '../model/register/response/registration_response_data.dart';
import '../model/register/response/upload_customer_public_key_response_data.dart';
import 'core/api_core.dart';

class AuthorizationServices {
  AuthorizationServices._();

  static Future<ApiResult<(AuthorizedApiTokenResponse, int), ApiException>> getAuthorizedApiToken(
      {required AuthorizedApiTokenRequest authorizedApiTokenRequest}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.authorizedApiToken,
      data: authorizedApiTokenRequest,
      modelFromJson: (responseBody, statusCode) => AuthorizedApiTokenResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(RegistrationResponse, int), ApiException>> registerCustomer(
      {required RegistrationRequest registrationRequest}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.registerCustomer,
      data: registrationRequest,
      modelFromJson: (responseBody, statusCode) => RegistrationResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(CustomerInfoResponse, int), ApiException>> getCustomerInfo(
      {required CustomerInfoRequest customerInfoRequest}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.customerInfo,
      data: customerInfoRequest,
      modelFromJson: (responseBody, statusCode) => CustomerInfoResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadCustomerPublicKeyResponse, int), ApiException>> uploadCustomerPublicKey(
      {required UploadCustomerPublicKeyRequest uploadCustomerPublicKeyRequest}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadCustomerPublicKey,
      data: uploadCustomerPublicKeyRequest,
      modelFromJson: (responseBody, statusCode) => UploadCustomerPublicKeyResponse.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetPublicKeyResponseData, int), ApiException>> getDibalitePublicKeyRequest(
      {required GetPublicKeyRequestData getPublicKeyRequestData}) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getDibalitePublicKey,
      data: getPublicKeyRequestData,
      modelFromJson: (responseBody, statusCode) => GetPublicKeyResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetJobsListResponse, int), ApiException>> getJobsList() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getJobsList,
      modelFromJson: (responseBody, statusCode) => GetJobsListResponse.fromJson(responseBody),
    );
  }
}

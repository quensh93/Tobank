import 'dart:async';

import '../model/other/app_version_data.dart';
import '../model/other/request/firebase_token_data.dart';
import '../model/profile/request/check_user_request_data.dart';
import '../model/profile/request/get_verification_code_request_data.dart';
import '../model/profile/request/sign_up_data.dart';
import '../model/profile/request/update_avatar_by_id_request_data.dart';
import '../model/profile/request/update_avatar_with_file_request_data.dart';
import '../model/profile/request/update_goftino_id_request_data.dart';
import '../model/profile/response/avatar_list_response_data.dart';
import '../model/profile/response/check_user_response_data.dart';
import '../model/profile/response/error_fcm_token_response_data.dart';
import '../model/profile/response/firebase_token_response.dart';
import '../model/profile/response/log_out_response_data.dart';
import '../model/profile/response/profile_data.dart';
import '../model/profile/response/token_data.dart';
import '../model/profile/response/verify_code_data.dart';
import 'core/api_core.dart';

class ProfileServices {
  ProfileServices._();

  static Future<ApiResult<(Object, int), ApiException>> getVerificationCodeRequest({
    required GetVerificationCodeRequestData getVerificationCodeRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getVerificationCode,
      data: getVerificationCodeRequestData,
      modelFromJson: (responseBody, statusCode) {
        switch (statusCode) {
          case 420:
            return AppVersionData.fromJson(responseBody);
          default: // Only 200
            return VerifyCodeData.fromJson(responseBody);
        }
      },
    );
  }

  static Future<ApiResult<(TokenData, int), ApiException>> verifyCodeRequest({
    required SignUpData signUpData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.verifyCode,
        data: signUpData,
        modelFromJson: (responseBody, statusCode) => TokenData.fromJson(responseBody));
  }

  static Future<ApiResult<(ProfileData, int), ApiException>> getProfileRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserProfile,
        modelFromJson: (responseBody, statusCode) => ProfileData.fromJson(responseBody));
  }

  static Future<ApiResult<(ProfileData, int), ApiException>> updateGoftinoIdRequest({
    required UpdateGoftinoIdRequest updateGoftinoIdRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateUserProfile,
        data: updateGoftinoIdRequest,
        modelFromJson: (responseBody, statusCode) => ProfileData.fromJson(responseBody));
  }

  static Future<ApiResult<(ProfileData, int), ApiException>> updateAvatarByIdRequest({
    required UpdateAvatarByIdRequest updateAvatarByIdRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateUserProfile,
        data: updateAvatarByIdRequest,
        modelFromJson: (responseBody, statusCode) => ProfileData.fromJson(responseBody));
  }

  static Future<ApiResult<(ProfileData, int), ApiException>> updateAvatarWithFileRequest({
    required UpdateAvatarWithFileRequest updateAvatarWithFileRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateUserProfile,
        data: updateAvatarWithFileRequest,
        modelFromJson: (responseBody, statusCode) => ProfileData.fromJson(responseBody));
  }

  static Future<ApiResult<(FirebaseTokenResponse, int), ApiException>> submitFirebaseTokenRequest({
    required FirebaseTokenData firebaseTokenData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.submitUserFirebaseToken,
        data: firebaseTokenData,
        modelFromJson: (responseBody, statusCode) => FirebaseTokenResponse.fromJson(responseBody),
        errorModelFromJson: (responseBody, statusCode) => ErrorFcmTokenResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(LogOutResponse, int), ApiException>> logOutUser() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.logOutUser,
        modelFromJson: (responseBody, statusCode) => LogOutResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(AvatarListResponseData, int), ApiException>> getAvatarList() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserAvatars,
        modelFromJson: (responseBody, statusCode) => AvatarListResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(CheckUserResponseData, int), ApiException>> checkUserIdentityRequest({
    required CheckUserRequestData checkUserRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.checkUserIdentityInfo,
        data: checkUserRequestData,
        modelFromJson: (responseBody, statusCode) => CheckUserResponseData.fromJson(responseBody));
  }
}

import '../../model/authentication/kyc/request/get_active_certificate_request_data.dart';
import '../../model/authentication/kyc/request/get_address_info_request_data.dart';
import '../../model/authentication/kyc/request/get_ekyc_status_request_data.dart';
import '../../model/authentication/kyc/request/get_otp_request_data.dart';
import '../../model/authentication/kyc/request/issue_certificate_request_data.dart';
import '../../model/authentication/kyc/request/register_signature_image_request_data.dart';
import '../../model/authentication/kyc/request/renew_certificate_request_data.dart';
import '../../model/authentication/kyc/request/upload_birth_certificate_comments_image_request_data.dart';
import '../../model/authentication/kyc/request/upload_birth_certificate_main_image_request_data.dart';
import '../../model/authentication/kyc/request/upload_national_id_back_image_request_data.dart';
import '../../model/authentication/kyc/request/upload_national_id_front_image_request_data.dart';
import '../../model/authentication/kyc/request/validate_otp_request_data.dart';
import '../../model/authentication/kyc/request/verify_person_image_request_data.dart';
import '../../model/authentication/kyc/response/get_active_certificate_response_data.dart';
import '../../model/authentication/kyc/response/get_address_info_response_data.dart';
import '../../model/authentication/kyc/response/get_ekyc_status_response_data.dart';
import '../../model/authentication/kyc/response/get_otp_response_data.dart';
import '../../model/authentication/kyc/response/issue_certificate_response_data.dart';
import '../../model/authentication/kyc/response/register_signature_image_response_data.dart';
import '../../model/authentication/kyc/response/renew_certificate_response_data.dart';
import '../../model/authentication/kyc/response/upload_birth_certificate_comments_image_response_data.dart';
import '../../model/authentication/kyc/response/upload_birth_certificate_main_image_response_data.dart';
import '../../model/authentication/kyc/response/upload_national_id_back_image_response_data.dart';
import '../../model/authentication/kyc/response/upload_national_id_front_image_response_data.dart';
import '../../model/authentication/kyc/response/validate_otp_response_data.dart';
import '../../model/authentication/kyc/response/verify_person_image_response_data.dart';
import '../core/api_core.dart';

class KycServices {
  KycServices._();

  static Future<ApiResult<(GetEkycStatusResponseData, int), ApiException>> getEkycStatus({
    required GetEkycStatusRequestData getEkycStatusRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.inquiryEkycStatus,
      data: getEkycStatusRequestData,
      modelFromJson: (responseBody, statusCode) => GetEkycStatusResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetOtpResponseData, int), ApiException>> getOtp({
    required GetOtpRequestData getOtpRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getEkycOTP,
      data: getOtpRequestData,
      modelFromJson: (responseBody, statusCode) => GetOtpResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(ValidateOtpResponseData, int), ApiException>> validateOtp({
    required ValidateOtpRequestData validateOtpRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.validateEkycOTP,
      data: validateOtpRequestData,
      modelFromJson: (responseBody, statusCode) => ValidateOtpResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadNationalIdFrontImageResponseData, int), ApiException>> uploadNationalCodeFront({
    required UploadNationalIdFrontImageRequestData uploadNationalIdFrontImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadNationalCardFrontImage,
      data: uploadNationalIdFrontImageRequestData,
      modelFromJson: (responseBody, statusCode) => UploadNationalIdFrontImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadNationalIdBackImageResponseData, int), ApiException>> uploadNationalCodeBack({
    required UploadNationalIdBackImageRequestData uploadNationalIdBackImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadNationalCardRearImage,
      data: uploadNationalIdBackImageRequestData,
      modelFromJson: (responseBody, statusCode) => UploadNationalIdBackImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(VerifyPersonImageResponseData, int), ApiException>> verifyPersonImage({
    required VerifyPersonImageRequestData verifyPersonImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.verifyPersonImage,
      data: verifyPersonImageRequestData,
      modelFromJson: (responseBody, statusCode) => VerifyPersonImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadBirthCertificateMainImageResponseData, int), ApiException>>
      uploadBirthCertificateMainImage({
    required UploadBirthCertificateMainImageRequestData uploadBirthCertificateMainImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadBirthCertificateMainPage,
      data: uploadBirthCertificateMainImageRequestData,
      modelFromJson: (responseBody, statusCode) => UploadBirthCertificateMainImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(RegisterSignatureImageResponseData, int), ApiException>> registerSignatureImage({
    required RegisterSignatureImageRequestData registerSignatureImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.submitSignatureImage,
      data: registerSignatureImageRequestData,
      modelFromJson: (responseBody, statusCode) => RegisterSignatureImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(UploadBirthCertificateCommentsImageResponseData, int), ApiException>>
      uploadBirthCertificateCommentsImage({
    required UploadBirthCertificateCommentsImageRequestData uploadBirthCertificateCommentsImageRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.uploadBirthCertificateCommentsPage,
      data: uploadBirthCertificateCommentsImageRequestData,
      modelFromJson: (responseBody, statusCode) =>
          UploadBirthCertificateCommentsImageResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetAddressInfoResponseData, int), ApiException>> getAddressInfo({
    required GetAddressInfoRequestData getAddressInfoRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getEkycAddressInquiry,
      data: getAddressInfoRequestData,
      modelFromJson: (responseBody, statusCode) => GetAddressInfoResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(IssueCertificateResponseData, int), ApiException>> issueCertificate({
    required IssueCertificateRequestData issueCertificateRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.issueCertificate,
      data: issueCertificateRequestData,
      modelFromJson: (responseBody, statusCode) => IssueCertificateResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(RenewCertificateResponseData, int), ApiException>> renewCertificate({
    required RenewCertificateRequestData renewCertificateRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.renewCertificate,
      data: renewCertificateRequestData,
      modelFromJson: (responseBody, statusCode) => RenewCertificateResponseData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(GetActiveCertificateResponseData, int), ApiException>> getActiveCertificate({
    required GetActiveCertificateRequestData getActiveCertificateRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getActiveCertificate,
      data: getActiveCertificateRequestData,
      modelFromJson: (responseBody, statusCode) => GetActiveCertificateResponseData.fromJson(responseBody),
    );
  }
}

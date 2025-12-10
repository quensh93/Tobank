import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
///Pichak
import 'package:pichak_plugin/pichak_plugin.dart';
import '../controller/main/main_controller.dart';
import '../model/pichak/error_response_pichak_data.dart';
import '../model/pichak/main_pichak_request.dart';
import '../model/pichak/main_pichak_response.dart';
import '../model/pichak/request/confirmation_request.dart';
import '../model/pichak/request/credit_inquiry_request.dart';
import '../model/pichak/request/dynamic_info_inquiry_request.dart';
import '../model/pichak/request/receiver_inquiry_request.dart';
import '../model/pichak/request/registration_request.dart';
import '../model/pichak/request/static_info_inquiry_request.dart';
import '../model/pichak/request/tracking_inquiry_request.dart';
import '../model/pichak/request/transfer_request.dart';
import '../model/pichak/request/transfer_status_inquiry_request.dart';
import '../model/pichak/response/confirmation_response.dart';
import '../model/pichak/response/credit_inquiry_response.dart';
import '../model/pichak/response/dynamic_info_inquiry_response.dart';
import '../model/pichak/response/pichak_reason_type_list_response.dart';
import '../model/pichak/response/receiver_inquiry_response.dart';
import '../model/pichak/response/registration_response.dart';
import '../model/pichak/response/static_info_inquiry_response.dart';
import '../model/pichak/response/tracking_inquiry_response.dart';
import '../model/pichak/response/transfer_status_inquiry_response.dart';
import '../model/pichak/store_shaparak_payment_model.dart';
import '../model/shaparak_hub/shaparak_public_key_model.dart';
import '../util/app_util.dart';
import '../util/constants.dart';
import '../util/date_converter_util.dart';
import '../util/shared_preferences_util.dart';
import '../util/storage_util.dart';
import 'core/api_core.dart';
import 'core/api_request_model.dart';

class PichakServices {
  PichakServices._();

  static Future<ApiResult<(CreditInquiryResponse, int), ApiException<ErrorResponsePichakData>>> creditInquiry({
    required CreditInquiryRequest creditInquiryRequest,
  }) async {
    print('mjp is here');
    print('----------------------------');
    print(creditInquiryRequest.toJson().toString());
    print('----------------------------');
    final result = await _pichakRequest(ApiProviderEnum.chequeCreditInquiry, creditInquiryRequest);

    switch (result) {
      case Success(value: (final response, _)):
        return Success((CreditInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(StaticInfoInquiryResponse, int), ApiException<ErrorResponsePichakData>>> staticInfoInquiry({
    required StaticInfoInquiryRequest staticInfoInquiryRequest,
  }) async {
    print('mjp is here');
    print('----------------------------');
    print(staticInfoInquiryRequest.toJson().toString());
    print('----------------------------');
    final result = await _pichakRequest(ApiProviderEnum.chequeStaticInfoInquiry, staticInfoInquiryRequest);

    print("⭕ result");
    print(result.toString());
    switch (result) {
      case Success(value: (final response, _)):
        return Success((StaticInfoInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(ReceiverInquiryResponse, int), ApiException<ErrorResponsePichakData>>> receiverInquiry({
    required ReceiverInquiryRequest receiverInquiryRequest,
  }) async {
    print('mjp is here - receiverInquiryRequest');
    print('----------------------------');
    print(receiverInquiryRequest.toJson().toString());
    print('----------------------------');
    final result = await _pichakRequest(ApiProviderEnum.chequeReceiverInquiry, receiverInquiryRequest);


    switch (result) {
      case Success(value: (final response, _)):
        return Success((ReceiverInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(RegistrationResponse, int), ApiException<ErrorResponsePichakData>>> registration({
    required RegistrationRequest registrationRequest,
  }) async {
    final result = await _pichakRequest(ApiProviderEnum.chequeRegistration, registrationRequest);

    switch (result) {
      case Success(value: (final response, _)):
        return Success((RegistrationResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(DynamicInfoInquiryResponse, int), ApiException<ErrorResponsePichakData>>>
      dynamicInfoInquiry({
    required DynamicInfoInquiryRequest dynamicInfoInquiryRequest,
  }) async {
    print("⭕⭕");
    final result = await _pichakRequest(ApiProviderEnum.chequeDynamicInfoInquiry, dynamicInfoInquiryRequest);
    print("⭕⭕");
    switch (result) {
      case Success(value: (final response, _)):
        return Success((DynamicInfoInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(ConfirmationResponse, int), ApiException<ErrorResponsePichakData>>> confirmation({
    required ConfirmationRequest confirmationRequest,
  }) async {
    final result = await _pichakRequest(ApiProviderEnum.chequeConfirmation, confirmationRequest);

    print("⭕");

    switch (result) {
      case Success(value: (final response, _)):
        return Success((ConfirmationResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(ConfirmationResponse, int), ApiException<ErrorResponsePichakData>>> transfer({
    required TransferRequest transferRequest,
  }) async {
    final result = await _pichakRequest(ApiProviderEnum.chequeTransfer, transferRequest);

    switch (result) {
      case Success(value: (final response, _)):
        return Success((ConfirmationResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(TransferStatusInquiryResponse, int), ApiException<ErrorResponsePichakData>>>
      transferStatusInquiry({
    required TransferStatusInquiryRequest transferStatusInquiryRequest,
  }) async {
    final result = await _pichakRequest(ApiProviderEnum.chequeTransferStatusInquiry, transferStatusInquiryRequest);

    switch (result) {
      case Success(value: (final response, _)):
        return Success((TransferStatusInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(TrackingInquiryResponse, int), ApiException<ErrorResponsePichakData>>> trackingInquiry({
    required TrackingInquiryRequest trackingInquiryRequest,
  }) async {
    final result = await _pichakRequest(ApiProviderEnum.chequeTrackingInquiry, trackingInquiryRequest);

    switch (result) {
      case Success(value: (final response, _)):
        return Success((TrackingInquiryResponse.fromJson(response), 200));
      case Failure(exception: final ApiException<ErrorResponsePichakData> apiException):
        return Failure(apiException);
    }
  }

  static Future<ApiResult<(PichakReasonTypeListResponse, int), ApiException<ErrorResponsePichakData>>>
      getPichakReasonTypeList() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getChequeRegisterReasonTypes,
        modelFromJson: (responseBody, statusCode) => PichakReasonTypeListResponse.fromJson(responseBody));
  }

  static Future<MainPichakRequest> _createMainRequestPichak({
    required String plainText,
    required String keyString,
    required String ivString,
  }) async {
    final key = Key.fromUtf8(keyString);
    final iv = IV.fromUtf8(ivString);

    final String? shaparakHubString = await StorageUtil.getShaparakHubSecureStorage();
    final ShaparakPublicKeyModel shaparakPublicKeyModel =
        ShaparakPublicKeyModel.fromJson(jsonDecode(shaparakHubString!));

    ///Pichak
    // Encrypt Key RSA
    final String encryptedKey = await PichakPlugin.encryptRSA(
      plainText: keyString,
      publicKeyString: shaparakPublicKeyModel.publicKey!,
    );

    // Encrypt Data AES CBC
    final encrypter = Encrypter(AES(
      key,
      mode: AESMode.cbc,
    ));
    final String encryptedData = encrypter.encrypt(plainText, iv: iv).base64;

    final mainController = Get.find<MainController>();

    final encodedIV = iv.base64.replaceAll('=', '\u{003d}');
    final requestSecureEnvelope = RequestSecureEnvelope(
      iv: encodedIV,
      encryptedData: encryptedData,
      encryptedKey: encryptedKey,
      keyEncryptionCipherSet: Platform.isAndroid ? 0 : 1, // Encryption algorithm changes based on platform
    );

    final StoreShaparakPaymentModel? storeShaparakPaymentModel =
        await SharedPreferencesUtil().getStoreShaparakPayment();

    final MainPichakRequest request = MainPichakRequest(
      manaId: storeShaparakPaymentModel?.manaId,
      trackingNumber: DateTime.now().millisecondsSinceEpoch.toString(),
      cardId: mainController.customerCardPichak!.hubCardData!.hubCardId!,
      expiryDate:
          DateConverterUtil.getExpireDateFromTimestamp(mainController.customerCardPichak!.hubCardData!.hubRefExpDate!),
      authenticationMethod: Constants.authenticationMethod,
      requestSecureEnvelope: requestSecureEnvelope,
    );

    return request;
  }

  static Map<String, dynamic> _readResponsePichak({
    required String keyString,
    required Map<String, dynamic> response,
  }) {
    final key = Key.fromUtf8(keyString);
    MainPichakResponse mainPichakResponse = MainPichakResponse();
    mainPichakResponse = MainPichakResponse.fromJson(response);
    String requetsId = mainPichakResponse.data?.requestId ?? "";
    Map<String,dynamic> hold = {};
    if(mainPichakResponse.data!.responseSecureEnvelope != null ){
      final iv = IV.fromBase64(mainPichakResponse.data!.responseSecureEnvelope!.iv!);
      final encrypter = Encrypter(AES(
        key,
        mode: AESMode.cbc,
      ));
      final String decryptedString = encrypter.decrypt64(
        mainPichakResponse.data!.responseSecureEnvelope!.encryptedData!,
        iv: iv,
      );
       hold = jsonDecode(decryptedString);
      hold.addAll({"requestId" : requetsId});
    }
    else{
      hold.addAll(response);
    }
    return hold;
  }

  static Future<ApiResult<(Map<String, dynamic>, int), ApiException<ErrorResponsePichakData>>> _pichakRequest(
      ApiProviderEnum apiProviderEnum, ApiRequestModel data) async {
    final key = AppUtil.getRandomString(16);
    final iv = AppUtil.getRandomString(16);

    final MainPichakRequest mainRequest = await _createMainRequestPichak(
      plainText: jsonEncode(data.toJson()),
      keyString: key,
      ivString: iv,
    );

    return await ApiClient.instance.requestJson(
      apiProviderEnum: apiProviderEnum,
      data: mainRequest,
      modelFromJson: (responseBody, statusCode) {
        //
        final decrypted = _readResponsePichak(keyString: key, response: responseBody);
        return decrypted;
      },
      errorModelFromJson: (responseBody, statusCode) {
        var hold = ErrorResponsePichakData.fromJson(responseBody);
        return hold;
      } ,
    );
  }
}

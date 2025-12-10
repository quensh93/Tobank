import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../model/automatic_dynamic_pin/request/automatic_dynamic_pin_pre_register_request_data.dart';
import '../model/automatic_dynamic_pin/request/automatic_dynamic_pin_register_request_data.dart';
import '../model/automatic_dynamic_pin/request/automatic_dynamic_pin_transfer_request_data.dart';
import '../model/automatic_dynamic_pin/response/automatic_dynamic_pin_pre_register_response_data.dart';
import '../model/automatic_dynamic_pin/response/automatic_dynamic_pin_register_response_data.dart';
import '../model/automatic_dynamic_pin/response/automatic_dynamic_pin_transfer_response_data.dart';
import '../model/common/error_response_data.dart';
import '../util/app_util.dart';
import '../util/dio_util.dart';
import '../util/log_util.dart';

class AutomaticDynamicPinServices {
  AutomaticDynamicPinServices._();

  static Future<AutomaticDynamicPinPreRegisterResponse> preRegisterRequest({
    required AutomaticDynamicPinPreRegisterRequest automaticDynamicPinPreRegisterRequest,
  }) async {
    final headers = AppUtil.getHTTPHeaderWithoutToken();
    AutomaticDynamicPinPreRegisterResponse automaticDynamicPinPreRegisterResponse =
        AutomaticDynamicPinPreRegisterResponse();
    try {
      final Dio dio = DioUtil.getDio(headers: headers, baseUrl: AppUtil.pardakhtsaziBaseUrl());
      final String encodedData = jsonEncode(
        automaticDynamicPinPreRegisterRequest.toJson(),
      );
      final logId = AutomaticDynamicPinLogHelper.logRequest(
        dio: dio,
        apiTitle: 'AutomaticDynamicPin preRegister',
        path: 'v1/directotp/preRegister',
        queryParameters: null,
        data: encodedData,
      );
      final response = await dio.post(
        'v1/directotp/preRegister',
        data: encodedData,
      );
      AutomaticDynamicPinLogHelper.logResponse(logId: logId, response: response); // TODO: test api
      final String decoded = response.toString();
      if (response.statusCode == 200) {
        automaticDynamicPinPreRegisterResponse = automaticDynamicPinPreRegisterResponseFromJson(decoded);
        automaticDynamicPinPreRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinPreRegisterResponse;
      } else if (response.statusCode == 400) {
        automaticDynamicPinPreRegisterResponse.errorResponseData = errorResponseDataFromJson(decoded);
        automaticDynamicPinPreRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinPreRegisterResponse;
      } else {
        automaticDynamicPinPreRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinPreRegisterResponse;
      }
    } on DioException catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinPreRegisterResponse.statusCode = DioUtil.getErrorStatusCode(error);
      return automaticDynamicPinPreRegisterResponse;
    } on Exception catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinPreRegisterResponse.statusCode = 500;
      return automaticDynamicPinPreRegisterResponse;
    }
  }

  static Future<AutomaticDynamicPinRegisterResponse> registerRequest({
    required AutomaticDynamicPinRegisterRequest automaticDynamicPinRegisterRequest,
  }) async {
    final headers = AppUtil.getHTTPHeaderWithoutToken();
    AutomaticDynamicPinRegisterResponse automaticDynamicPinRegisterResponse = AutomaticDynamicPinRegisterResponse();
    try {
      final Dio dio = DioUtil.getDio(headers: headers, baseUrl: AppUtil.pardakhtsaziBaseUrl());
      final String encodedData = jsonEncode(
        automaticDynamicPinRegisterRequest.toJson(),
      );
      final logId = AutomaticDynamicPinLogHelper.logRequest(
        dio: dio,
        apiTitle: 'AutomaticDynamicPin register',
        path: 'v1/directotp/register',
        queryParameters: null,
        data: encodedData,
      );
      final response = await dio.post(
        'v1/directotp/register',
        data: encodedData,
      );
      AutomaticDynamicPinLogHelper.logResponse(logId: logId, response: response); // TODO: test api
      final String decoded = response.toString();
      if (response.statusCode == 200) {
        automaticDynamicPinRegisterResponse = automaticDynamicPinRegisterResponseFromJson(decoded);
        automaticDynamicPinRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinRegisterResponse;
      } else if (response.statusCode == 400) {
        automaticDynamicPinRegisterResponse.errorResponseData = errorResponseDataFromJson(decoded);
        automaticDynamicPinRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinRegisterResponse;
      } else {
        automaticDynamicPinRegisterResponse.statusCode = response.statusCode;
        return automaticDynamicPinRegisterResponse;
      }
    } on DioException catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinRegisterResponse.statusCode = DioUtil.getErrorStatusCode(error);
      return automaticDynamicPinRegisterResponse;
    } on Exception catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinRegisterResponse.statusCode = 500;
      return automaticDynamicPinRegisterResponse;
    }
  }

  static Future<AutomaticDynamicPinTransferResponse> getTransferDynamicPinRequest({
    required AutomaticDynamicPinTransferRequest automaticDynamicPinTransferRequest,
    required String privateKeyPem,
  }) async {
    final headers = AppUtil.getHTTPHeaderWithoutToken();
    AutomaticDynamicPinTransferResponse automaticDynamicPinTransferResponse = AutomaticDynamicPinTransferResponse();
    try {
      final String encodedRequestBody = jsonEncode(automaticDynamicPinTransferRequest.toJson());
      final dynamic privateKey = encrypt.RSAKeyParser().parse(privateKeyPem);
      final signer = encrypt.RSASigner(encrypt.RSASignDigest.SHA256, privateKey: privateKey);
      final String signature = signer
          .sign(Uint8List.fromList(utf8.encode(base64Encode(
            utf8.encode(encodedRequestBody),
          ))))
          .base64;
      headers['signature'] = signature;
      final Dio dio = DioUtil.getDio(headers: headers, baseUrl: AppUtil.pardakhtsaziBaseUrl());
      final String encodedData = encodedRequestBody;
      final logId = AutomaticDynamicPinLogHelper.logRequest(
        dio: dio,
        apiTitle: 'AutomaticDynamicPin transfer',
        path: 'v1/directotp/transfer',
        queryParameters: null,
        data: encodedData,
      );
      final response = await dio.post(
        'v1/directotp/transfer',
        data: encodedData,
      );
      AutomaticDynamicPinLogHelper.logResponse(logId: logId, response: response); // TODO: test api
      final String decoded = response.toString();
      if (response.statusCode == 200) {
        automaticDynamicPinTransferResponse = automaticDynamicPinTransferResponseFromJson(decoded);
        automaticDynamicPinTransferResponse.statusCode = response.statusCode;
        final decrypter = encrypt.RSA(privateKey: privateKey);
        final decodedData = jsonDecode(decoded)['data'];
        final encrypt.Encrypted encrypted = encrypt.Encrypted.fromBase64(decodedData);
        final String decryptedData = utf8.decode(decrypter.decrypt(encrypted).toList());
        automaticDynamicPinTransferResponse.data = TransferData.fromJson(jsonDecode(decryptedData));
        return automaticDynamicPinTransferResponse;
      } else if (response.statusCode == 400) {
        automaticDynamicPinTransferResponse.errorResponseData = errorResponseDataFromJson(decoded);
        automaticDynamicPinTransferResponse.statusCode = response.statusCode;
        return automaticDynamicPinTransferResponse;
      } else {
        automaticDynamicPinTransferResponse.statusCode = response.statusCode;
        return automaticDynamicPinTransferResponse;
      }
    } on DioException catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinTransferResponse.statusCode = DioUtil.getErrorStatusCode(error);
      return automaticDynamicPinTransferResponse;
    } on Exception catch (error, stack) {
      await Sentry.captureException(
        error,
        stackTrace: stack,
      );
      automaticDynamicPinTransferResponse.statusCode = 500;
      return automaticDynamicPinTransferResponse;
    }
  }
}

class AutomaticDynamicPinLogHelper {
  AutomaticDynamicPinLogHelper._();

  static final ApiLogService _logService = getx.Get.find<ApiLogService>();

  static int logRequest({
    required Dio dio,
    required String apiTitle,
    required String path,
    required Map<String, dynamic>? queryParameters,
    required String? data,
  }) {
    if (!kDebugMode) return 0;

    final url = dio.options.baseUrl + path;

    final logId = _logService.logRequest(
      title: apiTitle,
      method: dio.options.method,
      url: url,
      queryParameters: queryParameters,
      headers: dio.options.headers,
      data: data,
      requireBase64EncodedBody: false,
    );
    return logId;
  }

  static void logResponse({
    required int logId,
    required Response response,
  }) {
    if (!kDebugMode) return;

    _logService.logResponse(
      id: logId,
      statusCode: response.statusCode!,
      data: response.data,
      headers: response.headers.map,
    );
  }
}

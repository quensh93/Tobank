import 'dart:convert';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:universal_io/io.dart';
import 'dart:math';
import 'package:flutter/foundation.dart' as foundation;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../model/common/error_response_data.dart';
import '../../model/sign_model.dart';
import '../../new_structure/core/injection/injection.dart';
import '../../new_structure/core/services/logger_service/talker/talker.dart';
import '../../new_structure/core/services/network/dio/curl_loggin_interceptor.dart'
    show CurlLoggingInterceptor;
import '../../util/app_util.dart';
import '../../util/log_util.dart';
import '../../util/string_constants.dart';
import 'api_error_response_model.dart';
import 'api_exception.dart';
import 'api_exception_type.dart';
import 'api_provider.dart';
import 'api_request_model.dart';
import 'api_result_model.dart';

class ApiClient {
  ApiClient._();

  // TODO: Use DI

  static const bool isTalkerLoggingEnabled = true;

  static final ApiClient instance = ApiClient._();

  final String _baseUrl = AppUtil.baseUrl();

  //todo: mjp ssl fingerprint
  final String _sslFingerprint = AppUtil.baseUrlSSLFingerprint();

  ErrorResponseData _parseErrorResponse(Map<String, dynamic> response) {
    return ErrorResponseData.fromJson(response);
  }

  Future<bool> _isConnected() async => await AppUtil.isNetworkConnect();

  Future<bool> _isVpnConnected() async => await AppUtil.isVpnConnected();

  Future<bool> _isDeviceSecured() async => await AppUtil.checkDeviceIsSecure();

  Future<SignModel?> _ekycSignText(String requestDataString) async =>
      await AppUtil.signRequestBody(requestDataString);

  Map<String, String> _headers() {
    final Map<String, String> headers = {};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.cacheControlHeader] = 'no-store';
    headers.addAll(AppUtil.getAppAndDeviceDetailHTTPHeaders());
    return headers;
  }

  final ApiLogService _logService = Get.find<ApiLogService>();

  ApiException<R>
      _convertDioExceptionToApiException<R extends ApiErrorResponseModel>(
          DioException dioException) {
    ApiExceptionType type = ApiExceptionType.unknown;
    String message = '';
    int code = 0;
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        type = ApiExceptionType.connectionTimeout;
        message = StringConstants.timeoutMessage;
        code = 2000;
      case DioExceptionType.receiveTimeout:
        type = ApiExceptionType.connectionTimeout;
        message = StringConstants.timeoutMessage;
        code = 2001;
      case DioExceptionType.sendTimeout:
        type = ApiExceptionType.connectionTimeout;
        message = StringConstants.timeoutMessage;
        code = 2002;
        break;
      case DioExceptionType.connectionError:
        type = ApiExceptionType.noConnection;
        message = StringConstants.noInternetMessage;
        code = 2003;
        break;
      case DioExceptionType.badResponse:
        type = ApiExceptionType.unhandledStatusCode;
        message = StringConstants.exceptionMessage;
        code = 3000 + (dioException.response?.statusCode ?? 0);
        break;
      case DioExceptionType.unknown:
        type = ApiExceptionType.responseDecryping;
        message = StringConstants.exceptionMessage;
        code = 2006;
        break;
      default:
        break;
    }

    return ApiException(
      type: type,
      statusCode: dioException.response?.statusCode,
      displayMessage: message,
      displayCode: code,
    );
  }

  Future<ApiResult<(T responseModel, int statusCode), ApiException<R>>>
      requestJson<T, R extends ApiErrorResponseModel>({
    required ApiProviderEnum apiProviderEnum,
    required T Function(Map<String, dynamic> responseBody, int statusCode)
        modelFromJson,
    String? slug,
    ApiRequestModel? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? additionalHeaders,
    R Function(Map<String, dynamic> responseBody, int statusCode)?
        errorModelFromJson,
  }) async {
    if (await _isVpnConnected()) {
      return Failure(
        ApiException(
            type: ApiExceptionType.vpnConnected,
            statusCode: null,
            displayMessage: StringConstants.vpnForbiddenMessage,
            displayCode: 2007),
      );
    }

    if (!(await _isConnected())) {
      return Failure(
        ApiException(
            type: ApiExceptionType.noConnection,
            statusCode: null,
            displayMessage: StringConstants.noInternetMessage,
            displayCode: 2004),
      );
    }

    if (apiProviderEnum.requireEkycSign) {
      if (!(await _isDeviceSecured())) {
        return Failure(
          ApiException(
              type: ApiExceptionType.deviceIsNotSecured,
              statusCode: null,
              displayMessage: StringConstants.deviceIsNotSecured,
              displayCode: 2010),
        );
      }
    }

    final Dio dio = Dio();
    dio.options.baseUrl = _baseUrl;

    dio.options.baseUrl += apiProviderEnum.apiVersion.version;

    dio.options.method = apiProviderEnum.method.methodName;
    dio.options.connectTimeout = apiProviderEnum.connectTimeout;
    dio.options.receiveTimeout = apiProviderEnum.receiveTimeout;
    dio.options.sendTimeout = apiProviderEnum.sendTimeout;
    dio.options.queryParameters = queryParameters ?? {};

    ///TODO -TEPMP -HESAM
    //dio.options.headers['Request-type'] = 'Secure';
    //dio.options.headers['Response-type'] =  'Secure';
    // allow self-signed certificate
    //check bad certificate
    /*dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );*/

    final List<int> acceptedStatusCodes = [400, 403];
    acceptedStatusCodes.addAll(apiProviderEnum.successStatusCodes);
    dio.options.validateStatus =
        (statusCode) => acceptedStatusCodes.contains(statusCode);

    dio.options.responseType = ResponseType.json;

    dio.transformer = ApiTransformer();
    dio.options.extra['requireEncrypt'] = apiProviderEnum.requireEncryption;
    dio.options.extra['requireDecrypt'] = apiProviderEnum.requireDecryption;

    String? encodedData;
    if (data != null) {
      dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      encodedData = jsonEncode(data.toJson());

      if (apiProviderEnum.requireEkycSign) {
        final SignModel? signData = await _ekycSignText(encodedData);
        if (signData != null) {
          dio.options.headers['Digital-Signature-Provider'] = signData.provider;
          dio.options.headers['Digital-Signature'] = signData.sign;
          dio.options.headers['Trace-ID'] = signData.traceID;
        } else {
          return Failure(
            ApiException(
                type: ApiExceptionType.signIsNotValid,
                statusCode: null,
                displayMessage: StringConstants.signIsNotValid,
                displayCode: 2011),
          );
        }
      }

      if (apiProviderEnum.requireBase64EncodedBody) {
        final List<int> encodedBytes = utf8.encode(encodedData);
        final String encodedDataBase64 = base64Encode(encodedBytes);
        final Map<String, dynamic> body = {
          'data': encodedDataBase64,
        };
        encodedData = jsonEncode(body);
      }
    }

    dio.options.headers.addAll(_headers());

    if (apiProviderEnum.requireToken) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          'GPAY ${AppUtil.getToken()}';
    }

    if (additionalHeaders != null) {
      dio.options.headers.addAll(additionalHeaders);
    }

    String path = apiProviderEnum.path;
    if (slug != null) {
      if (!path.endsWith('/')) {
        path += '/';
      }
      path += slug;
    }

    //todo: mjp for ssl pinning
    // SSL Pinning
    // if(foundation.kReleaseMode){
    //   dio.httpClientAdapter = IOHttpClientAdapter(
    //     createHttpClient: () {
    //       // Don't trust any certificate just because their root cert is trusted.
    //       final HttpClient client = HttpClient(context: SecurityContext());
    //       // You can test the intermediate / root cert here. We just ignore it.
    //       client.badCertificateCallback = (cert, host, port) => true;
    //       return client;
    //     },
    //     validateCertificate: (cert, host, port) {
    //
    //       // Check that the cert fingerprint matches the one we expect.
    //       // We definitely require _some_ certificate.
    //       if (cert == null) {
    //         return false;
    //       }
    //       // Validate it any way you want. Here we only check that
    //       // the fingerprint matches the OpenSSL SHA256.
    //       // TODO: check pem or sha256 fingerprint performance
    //       return _sslFingerprint == sha256.convert(cert.der).toString();
    //     },
    //   );
    // }

    // === Add TalkerDioLogger interceptor if enabled ===
    if (isTalkerLoggingEnabled) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: getIt<TalkerService>().talker,
          settings: const TalkerDioLoggerSettings(
            printRequestData: true,
            printResponseData: true,
            printResponseMessage: true,
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
      //
      dio.interceptors.add(CurlLoggingInterceptor());
    }

    dio.addSentry();

    ///Add Curl to Dio
    //dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

    final logId = _logRequest(
      dio: dio,
      apiProviderEnum: apiProviderEnum,
      path: path,
      queryParameters: queryParameters,
      data: encodedData,
    );

    try {
      final response = await dio.request(path, data: encodedData);

      switch (response.statusCode) {
        case null:
          final apiException = ApiException<R>(
              type: ApiExceptionType.unknown,
              statusCode: response.statusCode,
              displayMessage: StringConstants.exceptionMessage,
              displayCode: 3000);
          _logException(
              logId: logId, apiException: apiException, response: response);
          return Failure(apiException);
        case 400:
          final Function(Map<String, dynamic> response, int statusCode)
              parseErrorResponseFunction = errorModelFromJson ??
                  (Map<String, dynamic> response, int statusCode) =>
                      _parseErrorResponse(response);

          final errorResponse =
              parseErrorResponseFunction(response.data, response.statusCode!);

          final apiException = ApiException<R>(
              type: ApiExceptionType.badRequest,
              statusCode: response.statusCode,
              displayMessage:
                  response.data['message'] ?? StringConstants.nullErrorMessage,
              displayCode: 3400,
              errorResponse: errorResponse);
          _logException(
              logId: logId, apiException: apiException, response: response);

          return Failure(apiException);
        case 403:
          final apiException = ApiException<R>(
              type: ApiExceptionType.vpnConnected,
              statusCode: response.statusCode,
              displayMessage: StringConstants.vpnForbiddenMessage,
              displayCode: 2008);
          _logException(
              logId: logId, apiException: apiException, response: response);

          return Failure(apiException);
        default:
          _logResponse(logId: logId, response: response);
          final responseModel =
              modelFromJson(response.data, response.statusCode!);

          return Success((responseModel, response.statusCode!));
      }
      // ignore: avoid_catching_errors
    } on TypeError catch (error, stacktrace) {
      final apiException = ApiException<R>(
          type: ApiExceptionType.responseDecoding,
          statusCode: null,
          displayMessage: StringConstants.exceptionMessage,
          displayCode: 2005);
      _logException(logId: logId, apiException: apiException, response: null);

      await Sentry.captureException(error, stackTrace: stacktrace);

      return Failure(apiException);
    } on DioException catch (error, stacktrace) {
      final apiException = _convertDioExceptionToApiException<R>(error);
      _logException(
          logId: logId, apiException: apiException, response: error.response);

      await Sentry.captureException(error, stackTrace: stacktrace);

      return Failure(apiException);
    } on ApiException<R> catch (error) {
      _logException(logId: logId, apiException: error, response: null);
      return Failure(error);
    } on Exception catch (error, stacktrace) {
      final apiException = ApiException<R>(
          type: ApiExceptionType.unknown,
          statusCode: null,
          displayMessage: StringConstants.exceptionMessage,
          displayCode: 2010);
      _logException(logId: logId, apiException: apiException, response: null);

      await Sentry.captureException(error, stackTrace: stacktrace);

      return Failure(apiException);
    }
  }

  int _logRequest({
    required Dio dio,
    required ApiProviderEnum apiProviderEnum,
    required String path,
    required Map<String, dynamic>? queryParameters,
    required String? data,
  }) {
    if (!kDebugMode) return 0;

    final url = dio.options.baseUrl + path;

    final logId = _logService.logRequest(
      title: apiProviderEnum.title,
      method: dio.options.method,
      url: url,
      queryParameters: queryParameters,
      headers: dio.options.headers,
      data: data,
      requireBase64EncodedBody: apiProviderEnum.requireBase64EncodedBody,
    );
    return logId;
  }

  void _logResponse({
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

  void _logException(
      {required int logId,
      required ApiException apiException,
      required Response? response}) {
    if (!kDebugMode) return;

    _logService.logError(
      id: logId,
      type: apiException.type.name,
      displayMessage: apiException.displayMessage,
      displayCode: apiException.displayCode,
      statusCode: apiException.statusCode,
      headers: response?.headers.map,
      data: response?.data is String
          ? response?.data
          : jsonEncode(response?.data),
    );
  }
}

class ApiTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    if (options.extra['requireEncrypt'] == true && options.data is String) {
      options.data = AppUtil.encodeString(options.data);
    }

    return super.transformRequest(options);
  }

  @override
  Future transformResponse(
    RequestOptions options,
    ResponseBody responseBody,
  ) async {
    dynamic transformedResponse =
        await super.transformResponse(options, responseBody);

    final responseContentType = responseBody.headers['content-type']?.first;

    if (responseContentType != null &&
        responseContentType.contains('application/json')) {
      if (options.extra['requireDecrypt'] == true) {
        try {
          transformedResponse = jsonDecode(
              AppUtil.getDecodedStringApiCall(transformedResponse['data']));
        } on Exception catch (error, stacktrace) {
          await Sentry.captureException(
            error,
            stackTrace: stacktrace,
            hint: Hint.withMap({
              'type': 'decryptError',
              'data': transformedResponse,
              'path': options.path
            }),
          );

          throw DioException(
              requestOptions: options,
              response: Response(
                data: transformedResponse,
                requestOptions: options,
                statusCode: responseBody.statusCode,
                statusMessage: responseBody.statusMessage,
                extra: responseBody.extra,
              ),
              message: 'Json decrypt error');
        }
      }
    } else {
      final responseError = transformedResponse.toString();
      await Sentry.captureMessage(
        'Html Content received',
        level: SentryLevel.error,
        params: [
          {
            'data': responseError.substring(0, min(responseError.length, 150)),
            'path': options.path
          }
        ],
      );

      throw DioException(
          requestOptions: options,
          response: Response(
            data: transformedResponse,
            requestOptions: options,
            statusCode: responseBody.statusCode,
            statusMessage: responseBody.statusMessage,
            extra: responseBody.extra,
          ),
          message: 'Received HTML content');
    }

    return transformedResponse;
  }
}

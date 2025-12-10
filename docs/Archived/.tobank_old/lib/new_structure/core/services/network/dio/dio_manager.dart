import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../util/app_util.dart';
import '../../../constants/addresses/url_addresses.dart';
import '../api_middleware/api_middleware.dart';
import '../failures/app_failure/app_failure.dart';
import '../failures/app_failure/app_failure_factory.dart';
import 'dio_config.dart';
import 'dio_interceptors.dart';
import 'dio_transformer.dart';


class DioManager {
  final DioConfig dioConfig;
  final DioInterceptors dioInterceptors;
  final DioTransformer dioTransformer;
  final AppFailureFactory appFailureFactory;
  final ApiMiddleware apiMiddleware;
  final UrlAddresses addresses;

  DioManager(
      this.dioConfig,
      this.dioInterceptors,
      this.dioTransformer,
      this.appFailureFactory,
      this.apiMiddleware,
      this.addresses,
      );

  Map<String, dynamic> _getDefaultHeaders({required bool requireToken}) {
    final headers = {
      'Response-type': 'Secure',
      'Request-type': 'Secure',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.cacheControlHeader: 'no-store',
      ...AppUtil.getAppAndDeviceDetailHTTPHeaders(),
    };

    if (requireToken) {
      headers[HttpHeaders.authorizationHeader] = 'GPAY ${AppUtil.getToken()}';
    }

    return headers;
  }

  Future<Either<AppFailure, Unit>> _performPreRequestChecks({
    required bool requireEkycSign,
    required bool checkVpn,
  }) async {
    if (checkVpn && await AppUtil.isVpnConnected()) {
      return const Left(AppFailure.vpnConnectedFailure());
    }

    if (!(await AppUtil.isNetworkConnect())) {
      return const Left(AppFailure.noConnectionFailure());
    }

    if (requireEkycSign && !(await AppUtil.checkDeviceIsSecure())) {
      return const Left(AppFailure.deviceNotSecuredFailure());
    }

    return const Right(unit);
  }

  Future<Either<AppFailure, Map<String, String>>> _signRequestIfNeeded({
    required bool requireEkycSign,
    required String requestData,
  }) async {
    if (!requireEkycSign) {
      return const Right({});
    }

    final signData = await AppUtil.signRequestBody(requestData);
    if (signData == null ||
        signData.provider == null ||
        signData.sign == null ||
        signData.traceID == null) {
      return const Left(AppFailure.signNotValidFailure());
    }

    return Right({
      'Digital-Signature-Provider': signData.provider!,
      'Digital-Signature': signData.sign!,
      'Trace-ID': signData.traceID!,
    });
  }

  Future<Either<AppFailure, Map<String, dynamic>>> _makeRequest({
    required String endpoint,
    required dynamic data,
    required String method,
    required List<int> successStatusCodes,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requireToken = false,
    bool requireEkycSign = false,
    bool requireEncryption = false,
    bool requireDecryption = false,
    bool requireBase64EncodedBody = false,
    bool checkVpn = true,
    Map<String, dynamic> Function(Map<String, dynamic> response, int statusCode)? errorModelFromJson,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 90),
  }) async {
    final preCheckResult = await _performPreRequestChecks(
      requireEkycSign: requireEkycSign,
      checkVpn: checkVpn,
    );
    if (preCheckResult.isLeft()) {
      return preCheckResult as Left<AppFailure, Map<String, dynamic>>;
    }

    Dio? dio;
    try {
      dio = dioConfig.configureDio(
        method: method,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        queryParameters: queryParameters,
        successStatusCodes: successStatusCodes,
      );
    } catch (e) {
      print('⭕ Error configuring Dio: $e'); // Keep this for critical failures
      return Left(AppFailure.unexpectedFailure(error: e));
    }

    dioInterceptors.addInterceptors(dio);
    dio.transformer = dioTransformer;

    dio.options.extra['requireEncrypt'] = requireEncryption;
    dio.options.extra['requireDecrypt'] = requireDecryption;
    dio.options.extra['requireBase64EncodedBody'] = requireBase64EncodedBody;

    final Map<String, dynamic> finalHeaders = {
      ..._getDefaultHeaders(requireToken: requireToken),
      ...?headers,
    };

    dynamic finalData = data;
    if (data != null) {
      dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      finalData = jsonEncode(data is Map ? data : data.toJson());
      final signResult = await _signRequestIfNeeded(
        requireEkycSign: requireEkycSign,
        requestData: finalData,
      );
      if (signResult.isLeft()) {
        return signResult as Left<AppFailure, Map<String, dynamic>>;
      }
      finalHeaders.addAll(signResult.getOrElse((failure) => {}));
    }

    try {
      final response = await dio.request<Map<String, dynamic>>(
        endpoint,
        data: finalData,
        options: Options(headers: finalHeaders),
      );
      return apiMiddleware.handleResponse(
        response,
        errorModelFromJson: errorModelFromJson,
      );
    } on DioException catch (dioError) {
      return Left(appFailureFactory.createFromDioException(dioError));
    } on Exception catch (error, stacktrace) {
      if (error.toString().contains('type') || error is FormatException) {
        return const Left(AppFailure.responseDecodingFailure());
      }
      return Left(AppFailure.unexpectedFailure(error: error));
    }
  }

  Future<Either<AppFailure, Map<String, dynamic>>> getRequest({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requireToken = false,
    bool requireEkycSign = false,
    bool requireEncryption = false,
    bool requireDecryption = false,
    bool requireBase64EncodedBody = false,
    bool checkVpn = true,
    List<int> successStatusCodes = const [200],
    Map<String, dynamic> Function(Map<String, dynamic> response, int statusCode)? errorModelFromJson,
  }) async {
    return _makeRequest(
      endpoint: endpoint,
      data: data,
      method: 'GET',
      successStatusCodes: successStatusCodes,
      headers: headers,
      queryParameters: queryParameters,
      requireToken: requireToken,
      requireEkycSign: requireEkycSign,
      requireEncryption: requireEncryption,
      requireDecryption: requireDecryption,
      requireBase64EncodedBody: requireBase64EncodedBody,
      checkVpn: checkVpn,
      errorModelFromJson: errorModelFromJson,
    );
  }

  Future<Either<AppFailure, Map<String, dynamic>>> postRequest({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requireToken = false,
    bool requireEkycSign = false,
    bool requireEncryption = false,
    bool requireDecryption = false,
    bool requireBase64EncodedBody = false,
    bool checkVpn = true,
    List<int> successStatusCodes = const [200],
    Map<String, dynamic> Function(Map<String, dynamic> response, int statusCode)? errorModelFromJson,
  }) async {
    return _makeRequest(
      endpoint: endpoint,
      data: data,
      method: 'POST',
      successStatusCodes: successStatusCodes,
      headers: headers,
      queryParameters: queryParameters,
      requireToken: requireToken,
      requireEkycSign: requireEkycSign,
      requireEncryption: requireEncryption,
      requireDecryption: requireDecryption,
      requireBase64EncodedBody: requireBase64EncodedBody,
      checkVpn: checkVpn,
      errorModelFromJson: errorModelFromJson,
    );
  }

  Future<Either<AppFailure, Map<String, dynamic>>> putRequest({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool requireToken = false,
    bool requireEkycSign = false,
    bool requireEncryption = false,
    bool requireDecryption = false,
    bool requireBase64EncodedBody = false,
    bool checkVpn = true,
    List<int> successStatusCodes = const [200],
    Map<String, dynamic> Function(Map<String, dynamic> response, int statusCode)? errorModelFromJson,
  }) async {
    return _makeRequest(
      endpoint: endpoint,
      data: data,
      method: 'PUT',
      successStatusCodes: successStatusCodes,
      headers: headers,
      queryParameters: queryParameters,
      requireToken: requireToken,
      requireEkycSign: requireEkycSign,
      requireEncryption: requireEncryption,
      requireDecryption: requireDecryption,
      requireBase64EncodedBody: requireBase64EncodedBody,
      checkVpn: checkVpn,
      errorModelFromJson: errorModelFromJson,
    );
  }
}
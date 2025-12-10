// For sha256
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:injectable/injectable.dart';

import '../../../../../util/app_util.dart';
import '../../logger_service/logger_service.dart';

@lazySingleton
class DioConfig {
  DioConfig();

  Dio configureDio({
    required String method,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? queryParameters,
    List<int>? successStatusCodes,
  }) {
    final dio = Dio();
    dio.options.baseUrl = AppUtil.baseUrl();
    dio.options.method = method;
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    dio.options.sendTimeout = sendTimeout;
    dio.options.queryParameters = queryParameters ?? {};

    final acceptedStatusCodes = [400, 403, ...?successStatusCodes];
    dio.options.validateStatus = (statusCode) =>
    statusCode != null && acceptedStatusCodes.contains(statusCode);

    dio.options.responseType = ResponseType.json;

    // Add SSL Pinning (non-web platforms only)
    if (!kIsWeb) {
    //   if(foundation.kReleaseMode)
    // {
    //   ///TODO => need to check with DevOps
    //   final String sslFingerprint = AppUtil.baseUrlSSLFingerprint();
    //   dio.httpClientAdapter = IOHttpClientAdapter(
    //     createHttpClient: () {
    //       // final HttpClient client = HttpClient();
    //       final HttpClient client = HttpClient(context: SecurityContext());
    //       client.badCertificateCallback = (cert, host, port) => true;
    //       return client;
    //     },
    //     validateCertificate: (cert, host, port) {
    //       if (cert == null) {
    //         return false; // Fail if the certificate is null
    //       }
    //
    //       return sslFingerprint == sha256.convert(cert.der).toString();
    //     },
    //   );
    // }
    } else {
      // Log a warning for web platform
      Logger.warnLog(
        'SSL pinning is not supported on the web platform. '
            'Falling back to browser’s default certificate validation. '
            'Consider using a server-side proxy for enhanced security.',
      );
    }

    return dio;
  }
}
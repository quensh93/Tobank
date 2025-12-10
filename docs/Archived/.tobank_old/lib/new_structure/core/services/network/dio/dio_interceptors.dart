import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';


import '../../logger_service/talker/talker.dart';
import '../log_service.dart';
import 'curl_loggin_interceptor.dart';

@lazySingleton
class DioInterceptors {
  final LogService logService;
  final TalkerService talker;

  DioInterceptors(this.logService,this.talker);

  void addInterceptors(Dio dio) {
    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker:talker.talker,
          settings:  TalkerDioLoggerSettings(
            enabled: kDebugMode,
            printRequestHeaders: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            printErrorData: true,
            errorPen: AnsiPen()..red(),
            printErrorHeaders: true,
            printErrorMessage: true,
            printRequestData: true,
            printResponseData: true,
            printResponseRedirects: true,
          ),
        ),
      );

      // Add the custom CurlLoggingInterceptor for cURL logging
      dio.interceptors.add(CurlLoggingInterceptor());
      /*dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          try {
            final convertedHeaders = options.headers.map((key, value) =>
                MapEntry(key, value is List ? value.join(', ') : value));

            final logId = logService.logRequest(
              //title: options.path,
              method: options.method,
              url: options.uri.toString(),
              queryParameters: options.queryParameters,
              headers: convertedHeaders,
              data: options.data,
              requireBase64EncodedBody: options.extra['requireBase64EncodedBody'] ?? false,
            );

            options.extra['logId'] = logId;
          } catch (e, stackTrace) {
            logService.logError(
              id: DateTime.now().millisecondsSinceEpoch,
              type: 'RequestInterceptorError',
              displayMessage: 'Failed to log request: $e',
              displayCode: 0,
              statusCode: null,
              headers: null,
              data: stackTrace.toString(),
            );
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          try {
            final logId = response.requestOptions.extra['logId'] as int? ?? 0;
            final convertedHeaders = response.headers.map.map((key, value) =>
                MapEntry(key, value is List ? value.join(', ') : value));

            logService.logResponse(
              id: logId,
              statusCode: response.statusCode ?? 0,
              data: response.data,
              headers: convertedHeaders,
            );
          } catch (e, stackTrace) {
            logService.logError(
              id: response.requestOptions.extra['logId'] as int? ?? 0,
              type: 'ResponseInterceptorError',
              displayMessage: 'Failed to log response: $e',
              displayCode: 0,
              statusCode: response.statusCode,
              headers: null,
              data: stackTrace.toString(),
            );
          }
          handler.next(response);
        },
        onError: (error, handler) {
          try {
            final logId = error.requestOptions.extra['logId'] as int? ?? 0;
            final convertedHeaders = error.response?.headers.map.map((key, value) =>
                MapEntry(key, value is List ? value.join(', ') : value));

            logService.logError(
              id: logId,
              type: error.type.toString(),
              displayMessage: error.message ?? 'Unknown error',
              displayCode: error.response?.statusCode ?? 0,
              statusCode: error.response?.statusCode,
              headers: convertedHeaders,
              data: error.response?.data,
            );
          } catch (e, stackTrace) {
            logService.logError(
              id: error.requestOptions.extra['logId'] as int? ?? 0,
              type: 'ErrorInterceptorError',
              displayMessage: 'Failed to log error: $e',
              displayCode: 0,
              statusCode: error.response?.statusCode,
              headers: null,
              data: stackTrace.toString(),
            );
          }
          handler.next(error);
        },
      ));*/
    }

    if (!kDebugMode) {
      dio.addSentry();
    }
  }
}
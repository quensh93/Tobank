import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../../util/app_util.dart';

@lazySingleton
class DioTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    if (options.extra['requireEncrypt'] == true && options.data is String) {
      options.data = AppUtil.encodeString(options.data);
    }

    if (options.extra['requireBase64EncodedBody'] == true && options.data is String) {
      final List<int> encodedBytes = utf8.encode(options.data);
      final String encodedDataBase64 = base64Encode(encodedBytes);
      final Map<String, dynamic> body = {'data': encodedDataBase64};
      options.data = jsonEncode(body);
    }

    return super.transformRequest(options);
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody responseBody) async {
    dynamic transformedResponse = await super.transformResponse(options, responseBody);

    final responseContentType = responseBody.headers['content-type']?.first;

    if (responseContentType != null && responseContentType.contains('application/json')) {
      if (options.extra['requireDecrypt'] == true) {
        try {
          transformedResponse = jsonDecode(AppUtil.getDecodedStringApiCall(transformedResponse['data']));
        } on Exception catch (error, stacktrace) {
          await Sentry.captureException(
            error,
            stackTrace: stacktrace,
            hint: Hint.withMap({'type': 'decryptError', 'data': transformedResponse, 'path': options.path}),
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
            message: 'Json decrypt error',
          );
        }
      }
    } else {
      final responseError = transformedResponse.toString();
      await Sentry.captureMessage(
        'Html Content received',
        level: SentryLevel.error,
        params: [
          {
            'data': responseError.substring(0, responseError.length < 150 ? responseError.length : 150),
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
        message: 'Received HTML content',
      );
    }

    return transformedResponse;
  }
}
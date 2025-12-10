import 'package:dio/dio.dart';

class DioUtil {
  DioUtil._();

  static Dio getDio({required String baseUrl, var headers, int? connectTimeoutMinutes, int? receiveTimeoutMinutes}) {
    final Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = Duration(milliseconds: (connectTimeoutMinutes ?? 1) * 60 * 1000);
    dio.options.receiveTimeout = Duration(milliseconds: (receiveTimeoutMinutes ?? 1) * 60 * 1000);
    dio.options.headers = headers;
    dio.options.validateStatus = (status) {
      if (status != null) {
        return status < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  static int? getErrorStatusCode(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 408;
    } else {
      if (error.response != null) {
        return error.response!.statusCode;
      } else {
        return 500;
      }
    }
  }
}

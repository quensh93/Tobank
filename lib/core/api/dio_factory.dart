import 'package:dio/dio.dart';
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import 'package:tobank_sdui/core/api/interceptors/auth_interceptor.dart';
import 'package:tobank_sdui/core/config/ispect_config.dart';

import 'package:tobank_sdui/core/helpers/logger.dart';

class DioFactory {
  const DioFactory._();

  /// Creates a plain Dio (no auth header) — for config/public APIs and STAC runtime
  static Dio plain({
    Duration timeout = const Duration(seconds: 30),
  }) {
    final dio = Dio();
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    dio.options.sendTimeout = timeout;
    _addISpect(dio);
    return dio;
  }

  /// Creates an authenticated Dio — adds AuthInterceptor for auto Bearer token
  static Dio authenticated({
    Duration timeout = const Duration(seconds: 30),
  }) {
    final dio = plain(timeout: timeout);
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }

  static void _addISpect(Dio dio) {
    if (ISpectConfig.shouldInitialize) {
      try {
        dio.interceptors.add(
          ISpectDioInterceptor(
            logger: ISpect.logger,
            settings: const ISpectDioInterceptorSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printRequestData: true,
              printResponseData: true,
            ),
          ),
        );
      } catch (e) {
        // ISpect not ready — safe to ignore, interceptor simply won't be added
        AppLogger.wc(LogCategory.network, 'ISpect interceptor init failed', e);
      }
    }
  }
}

import 'package:dio/dio.dart';
import 'package:slow_net_simulator/slow_net_simulator.dart';
import '../../core/helpers/logger.dart';

/// Dio interceptor for network simulator
/// 
/// This interceptor marks requests when the simulator is enabled.
/// The actual simulation wrapping is done by NetworkSimulatorAdapter.
class NetworkSimulatorInterceptor extends Interceptor {
  final bool Function() isEnabled;
  
  NetworkSimulatorInterceptor({
    required this.isEnabled,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Mark request with simulator flag for debugging
    if (isEnabled()) {
      options.extra['network_simulator_enabled'] = true;
      AppLogger.d('🌐 Network simulator enabled for request: ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

/// Helper service to wrap Dio requests with network simulator
class NetworkSimulatorService {
  /// Wraps a Dio request with SlowNetSimulator if enabled
  /// 
  /// Use this to wrap any async operation (including Dio requests):
  /// ```dart
  /// final response = await NetworkSimulatorService.simulateIfEnabled(
  ///   isEnabled: () => true,
  ///   request: () => dio.get(url),
  /// );
  /// ```
  /// 
  /// Note: When SlowNetSimulator is configured (via NetworkSimulatorController),
  /// it automatically applies to all calls wrapped with SlowNetSimulator.simulate().
  /// This helper just provides a convenient way to conditionally wrap operations.
  static Future<T> simulateIfEnabled<T>({
    required bool Function() isEnabled,
    required Future<T> Function() request,
  }) async {
    if (isEnabled()) {
      try {
        return await SlowNetSimulator.simulate(request);
      } catch (e) {
        AppLogger.d('Network simulator error: $e');
        rethrow;
      }
    } else {
      // Bypass simulation - execute directly
      return await request();
    }
  }
}


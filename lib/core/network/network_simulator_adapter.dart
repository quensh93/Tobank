import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:slow_net_simulator/slow_net_simulator.dart';
import '../../core/helpers/logger.dart';

/// Dio HttpClientAdapter that wraps requests with SlowNetSimulator
/// 
/// This adapter wraps all HTTP requests with SlowNetSimulator.simulate()
/// to apply network speed simulation and failure probability.
class NetworkSimulatorAdapter implements HttpClientAdapter {
  final HttpClientAdapter _adapter;
  final bool Function() isEnabled;

  NetworkSimulatorAdapter({
    required HttpClientAdapter adapter,
    required this.isEnabled,
  }) : _adapter = adapter;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (isEnabled()) {
      AppLogger.d('🌐 Wrapping request with network simulator: ${options.uri}');
      
      // Wrap the request with SlowNetSimulator.simulate()
      return await SlowNetSimulator.simulate(() async {
        try {
          return await _adapter.fetch(options, requestStream, cancelFuture);
        } catch (e) {
          // Re-throw errors so SlowNetSimulator can handle failures
          AppLogger.d('🌐 Network request error (may be simulated): $e');
          rethrow;
        }
      });
    } else {
      // Bypass simulation - execute directly without any SlowNetSimulator wrapping
      // This ensures no delays are applied when the simulator is disabled
      // (Logging removed to reduce verbosity when disabled)
      return await _adapter.fetch(options, requestStream, cancelFuture);
    }
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }
}


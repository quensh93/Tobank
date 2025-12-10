import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ISpect imports - will be tree-shaken if not used
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/config/ispect_config.dart';
import '../../core/network/network_simulator_interceptor.dart';
import '../../core/network/network_simulator_adapter.dart';
import '../../debug_panel/state/network_simulator_state.dart';
import '../datasources/api_service.dart';
import '../repositories/user_repository.dart';

part 'api_providers.g.dart';

/// Dio provider
@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.apiConnectTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Watch network simulator state to react to changes
  final networkSimulatorState = ref.watch(networkSimulatorProvider);

  // Wrap the HTTP client adapter with NetworkSimulatorAdapter
  // This wraps all requests with SlowNetSimulator.simulate() when enabled
  final existingAdapter = dio.httpClientAdapter;
  final defaultAdapter = existingAdapter is IOHttpClientAdapter 
      ? existingAdapter 
      : IOHttpClientAdapter();
  dio.httpClientAdapter = NetworkSimulatorAdapter(
    adapter: defaultAdapter,
    isEnabled: () => networkSimulatorState.isEnabled,
  );

  // Add network simulator interceptor (for marking requests, actual wrapping is in adapter)
  // Add this BEFORE ISpect so ISpect can monitor simulated requests
  dio.interceptors.insert(
    0,
    NetworkSimulatorInterceptor(
      isEnabled: () => networkSimulatorState.isEnabled,
    ),
  );

  // Add ISpect Dio interceptor if enabled (for network monitoring)
  // IMPORTANT: Add ISpect interceptor AFTER network simulator
  if (ISpectConfig.shouldInitialize) {
    try {
      // ISpect.logger is available globally after ISpect.run() is called
      // Insert after network simulator
      final insertIndex = dio.interceptors.isNotEmpty ? 1 : 0;
      dio.interceptors.insert(
        insertIndex,
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
      // If ISpect is not initialized yet, continue without interceptor
      // This can happen during provider initialization
      // The interceptor will be added when provider is recreated after ISpect init
    }
  }

  // Add standard logging interceptor (always present)
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
    ),
  );

  return dio;
}

/// API Service provider
@riverpod
ApiService apiService(Ref ref) {
  return ApiService(ref.read(dioProvider));
}

/// User Repository provider
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(ref.read(apiServiceProvider));
}

/// Get data provider
@riverpod
Future<Map<String, dynamic>> getData(
  Ref ref,
  Map<String, dynamic> queries,
) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getData(queries).run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

/// Post data provider
@riverpod
Future<Map<String, dynamic>> postData(
  Ref ref,
  Map<String, dynamic> data,
) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.postData(data).run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

/// Put data provider
@riverpod
Future<Map<String, dynamic>> putData(
  Ref ref,
  Map<String, dynamic> data,
) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.putData(data).run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

/// Delete data provider
@riverpod
Future<Map<String, dynamic>> deleteData(Ref ref) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.deleteData().run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

/// Get headers provider
@riverpod
Future<Map<String, dynamic>> getHeaders(Ref ref) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getHeaders().run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

/// Get user agent provider
@riverpod
Future<Map<String, dynamic>> getUserAgent(Ref ref) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.getUserAgent().run();
  
  return result.fold(
    (error) => throw Exception(error.message),
    (data) => data,
  );
}

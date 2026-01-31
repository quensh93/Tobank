import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/config/ispect_config.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

class PromissoryRealService {
  final Dio _dio = Dio();
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  PromissoryRealService() {
    if (ISpectConfig.shouldInitialize) {
      try {
        _dio.interceptors.add(
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
        // Ignore if ISpect not ready
      }
    }
  }

  // Constants
  static const String _baseUrl =
      'http://192.168.107.22:8280/api/digitalbanking';

  // Headers
  static const Map<String, String> _defaultHeaders = {
    // Match login headers (some gateways are picky about names/casing)
    'accept': '*/*',
    'app-platform': 'android',
    'app-store': 'application/json',
    'app-version': '456',
    'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
    'serviceauthorization':
        'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
    // Authorization header will be added dynamically.
  };

  /// Fetch deposits list for the customer
  Future<List<Map<String, String>>?> getDeposits(BuildContext context) async {
    await _authManager.initialize();
    final token = await _authManager.getAccessToken();
    if (token == null) {
      AppLogger.ec(LogCategory.network, 'No access token found');
      return null;
    }

    final nationalCode = await _authManager.getNationalCode();
    if (nationalCode == null || nationalCode.isEmpty) {
      AppLogger.ec(LogCategory.network, 'No national code found');
      return null;
    }

    final url = '$_baseUrl/deposits/v1.0/customer/$nationalCode';

    try {
      String authHeader = token;
      if (!token.toLowerCase().startsWith('bearer ')) {
        authHeader = 'Bearer $token';
      }

      final options = Options(
        headers: {..._defaultHeaders, 'authorization': authHeader},
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      _logCurl(url, options);

      final response = await _dio.get(url, options: options);

      AppLogger.ic(
        LogCategory.network,
        'Get Deposits Response: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['data'] is List) {
          final List<dynamic> depositsList = data['data'];

          // Map API response to the format expected by the UI
          return depositsList.map<Map<String, String>>((item) {
            return {
              'id':
                  item['depositNumber']?.toString() ??
                  '', // Use depositNumber as ID
              'title': item['depositTitle']?.toString() ?? 'سپرده',
              'depositNumber': item['depositNumber']?.toString() ?? '',
              'shabaNumber': item['depositIban']?.toString() ?? '',
            };
          }).toList();
        }
      }

      return null;
    } catch (e) {
      AppLogger.ec(LogCategory.network, 'Get Deposits Exception', e);
      return null;
    }
  }

  /// Fetch customer information by national code
  Future<Map<String, dynamic>?> getCustomerInfo(
    BuildContext context,
    String nationalCode,
  ) async {
    await _authManager.initialize();
    final token = await _authManager.getAccessToken();
    if (token == null) {
      AppLogger.ec(LogCategory.network, 'No access token found');
      return null;
    }

    final url = '$_baseUrl/customers/v1.0/info/$nationalCode';

    try {
      String authHeader = token;
      if (!token.toLowerCase().startsWith('bearer ')) {
        authHeader = 'Bearer $token';
      }

      final options = Options(
        headers: {..._defaultHeaders, 'authorization': authHeader},
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      _logCurl(url, options);

      final response = await _dio.get(url, options: options);

      AppLogger.ic(
        LogCategory.network,
        'Get Customer Info Response: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['status']?['code'] == 'esb-200') {
          return data['data'] as Map<String, dynamic>?;
        }
      }

      return null;
    } catch (e) {
      AppLogger.ec(LogCategory.network, 'Get Customer Info Exception', e);
      return null;
    }
  }

  void _logCurl(String url, Options options) {
    String curl = 'curl --request GET';
    curl += ' --url $url';
    options.headers?.forEach((key, value) {
      curl += ' --header \'$key: $value\'';
    });
    AppLogger.d('🐛 CURL: $curl');
  }
}

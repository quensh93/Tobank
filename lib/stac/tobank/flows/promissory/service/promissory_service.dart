import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/api/device_headers.dart';
import 'package:tobank_sdui/core/api/dio_factory.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';

class PromissoryRealService {
  final Dio _dio = DioFactory.authenticated();
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  // Constants
  static const String _baseUrl = SduiConfig.bizBaseUrl;

  // Headers — shared device headers; authorization is added dynamically.

  /// Fetch deposits list for the customer
  Future<List<Map<String, String>>?> getDeposits(BuildContext context) async {
    await _authManager.initialize();
    final nationalCode = await _authManager.getNationalCode();
    if (nationalCode == null || nationalCode.isEmpty) {
      AppLogger.ec(LogCategory.network, 'No national code found');
      return null;
    }

    final url = '$_baseUrl/deposits/v1.0/customer/$nationalCode';

    try {
      final options = Options(
        headers: {...DeviceHeaders.all},
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
    final url = '$_baseUrl/customers/v1.0/info/$nationalCode';

    try {
      final options = Options(
        headers: {...DeviceHeaders.all},
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

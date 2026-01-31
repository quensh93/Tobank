import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ispect/ispect.dart';
import 'package:ispectify_dio/ispectify_dio.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/config/ispect_config.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

class PromissoryRealAuthService {
  static const String _url =
      'http://192.168.107.22:8280/api/digitalbanking/logins/v1.0/tobank/users';
  static const Map<String, String> _headers = {
    'accept': '*/*',
    'app-platform': 'android',
    'app-store': 'application/json',
    'app-version': '456',
    'authorization': 'Bearer null',
    'content-type': 'application/json',
    'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
    'serviceauthorization':
        'Basic QzFVb3ZyYUVSQ0NRYm9ZcUhhcFVqZk9McWZNYTpXU1N4WUFWUThPUFVjS0FTZHJNaUhIX2NmWE10UmNCWW5wNGdoT2ZKQTdRYQ==',
  };

  final Dio _dio = Dio();
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  PromissoryRealAuthService() {
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

  Future<bool> login(BuildContext context, Map<String, dynamic> body) async {
    AppLogger.ic(LogCategory.network, 'Initiating Real Login...');

    try {
      final options = Options(
        headers: _headers,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      _logCurl(_url, options, data: body);

      final response = await _dio.post(_url, options: options, data: body);

      AppLogger.ic(
        LogCategory.network,
        'Login Response: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        AppLogger.d('Login Response Data: $data');

        String? token;
        if (data is Map) {
          token =
              data['access_token']?.toString() ??
              data['token']?.toString() ??
              data['accessToken']?.toString();

          if (token == null && data['result'] is Map) {
            final result = data['result'];
            token =
                result['access_token']?.toString() ??
                result['token']?.toString();

            // Check deeper nesting: result -> data -> access_token
            if (token == null && result['data'] is Map) {
              token =
                  result['data']['access_token']?.toString() ??
                  result['data']['token']?.toString();
            }
          }
        }

        if (token != null && token.isNotEmpty) {
          await _authManager.saveTokens(accessToken: token);
          AppLogger.ic(LogCategory.network, 'Token Saved successfully.');

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ورود موفقیت‌آمیز بود (Token Saved)'),
                backgroundColor: Colors.green,
              ),
            );
          }
          return true;
        } else {
          AppLogger.wc(
            LogCategory.network,
            'No token found in successful login response',
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login OK but no token found. Data: $data'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return false;
        }
      } else {
        AppLogger.wc(
          LogCategory.network,
          'Login Failed: ${response.statusCode}',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Failed: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return false;
      }
    } catch (e) {
      AppLogger.ec(LogCategory.network, 'Login Exception', e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }

  void _logCurl(String url, Options options, {dynamic data}) {
    String curl = 'curl --request POST';
    curl += ' --url $url';
    options.headers?.forEach((key, value) {
      curl += ' --header \'$key: $value\'';
    });
    if (data != null) {
      curl += ' --data \'${jsonEncode(data)}\'';
    }
    AppLogger.d('🐛 CURL: $curl');
  }
}

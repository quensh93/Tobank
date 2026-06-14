import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/api/device_headers.dart';
import 'package:tobank_sdui/core/api/dio_factory.dart';
import 'package:tobank_sdui/core/api/utils/curl_logger.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';

class PromissoryRealAuthService {
  static final String _url = SduiConfig.bizUrl('logins/v1.0/tobank/users');
  static final Map<String, String> _headers = {
    ...DeviceHeaders.all,
    'authorization': 'Bearer null',
    'content-type': 'application/json',
  };

  final Dio _dio = DioFactory.plain();
  final AuthManager _authManager = AuthManager(
    storage: const FlutterSecureStorage(),
  );

  Future<bool> login(BuildContext context, Map<String, dynamic> body) async {
    AppLogger.ic(LogCategory.network, 'Initiating Real Login...');

    try {
      final options = Options(
        headers: _headers,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      CurlLogger.log(
        method: 'POST',
        url: _url,
        headers: options.headers?.map((k, v) => MapEntry(k.toString(), v)),
        body: body,
      );

      final response = await _dio.post(_url, options: options, data: body);

      AppLogger.dc(
        LogCategory.network,
        'RESPONSE ${response.statusCode} $_url',
      );

      // Log response body - let AppLogger handle truncation based on LogConfig
      final responseStr = response.data?.toString() ?? '';
      AppLogger.dc(LogCategory.network, '   Body: $responseStr');

      if (response.statusCode == 200) {
        final data = response.data;

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
          final cleanedToken = token.trim();
          final normalizedToken =
              cleanedToken.toLowerCase().startsWith('bearer ')
              ? cleanedToken.substring(7).trim()
              : cleanedToken;
          await _authManager.saveTokens(accessToken: normalizedToken);
          AppLogger.ic(LogCategory.network, 'Token Saved successfully.');

          final resolvedNationalId =
              _extractNationalIdFromResponse(data) ??
              _extractNationalIdFromToken(normalizedToken) ??
              body['nationalId']?.toString();
          if (resolvedNationalId != null && resolvedNationalId.isNotEmpty) {
            await _authManager.saveNationalCode(resolvedNationalId);
            AppLogger.ic(
              LogCategory.network,
              'National code saved successfully.',
            );
          }

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

  String? _extractNationalIdFromResponse(dynamic data) {
    if (data is! Map) return null;

    Map? result = data['result'] is Map ? data['result'] as Map : null;
    Map? resultData = result != null && result['data'] is Map
        ? result['data'] as Map
        : null;

    final candidates = <dynamic>[
      data,
      result,
      resultData,
    ].where((item) => item != null).cast<Map>();

    for (final map in candidates) {
      final value =
          map['nationalId'] ??
          map['national_id'] ??
          map['nationalCode'] ??
          map['national_code'] ??
          map['natCode'] ??
          map['nat_code'];
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }

    return null;
  }

  String? _extractNationalIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length < 2) return null;

    try {
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final json = jsonDecode(decoded);
      if (json is! Map) return null;

      final value =
          json['nationalId'] ??
          json['national_id'] ??
          json['nationalCode'] ??
          json['national_code'] ??
          json['natCode'] ??
          json['nat_code'];
      return value?.toString();
    } catch (_) {
      return null;
    }
  }

}

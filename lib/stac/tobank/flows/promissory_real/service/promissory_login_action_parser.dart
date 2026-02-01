import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';
import 'promissory_real_auth_service.dart';

class PromissoryLoginActionParser
    extends StacActionParser<Map<String, dynamic>> {
  const PromissoryLoginActionParser();

  @override
  String get actionType => 'promissory_real_login';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  FutureOr onCall(BuildContext context, Map<String, dynamic> model) async {
    AppLogger.ic(
      LogCategory.network,
      'Initiating Nooshin Call (Static Login)...',
    );

    // Show a snackbar to indicate processing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('در حال دریافت توکن ثابت...'),
        duration: Duration(seconds: 1),
      ),
    );

    final service = PromissoryRealAuthService();

    // Static data for "Nooshin" login
    final staticData = {
      "nationalId": "0063192373",
      "mobileNumber": "09121877519",
      "gpayToken": "1234",
      "birthDate": "13610629",
      "cif": "123",
    };

    final loginSuccess = await service.login(context, staticData);

    // After successful login, save national code and access token to STAC registry
    // so they can be used in networkRequest actions
    if (loginSuccess) {
      final authManager = AuthManager();
      await authManager.initialize();
      
      final nationalCode = await authManager.getNationalCode();
      if (nationalCode != null && nationalCode.isNotEmpty) {
        StacRegistry.instance.setValue('userData.nationalCode', nationalCode);
        AppLogger.ic(
          LogCategory.registry,
          'National code saved to STAC registry: $nationalCode',
        );
      }

      final accessToken = await authManager.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        final bearerToken = accessToken.toLowerCase().startsWith('bearer ')
            ? accessToken
            : 'Bearer $accessToken';
        StacRegistry.instance.setValue('auth.accessToken', bearerToken);
        StacRegistry.instance.setValue('auth.accessTokenRaw', accessToken);
        AppLogger.ic(
          LogCategory.registry,
          'Access token saved to STAC registry',
        );
      }
    }

    return null;
  }
}

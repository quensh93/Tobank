import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
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

    await service.login(context, staticData);

    return null;
  }
}

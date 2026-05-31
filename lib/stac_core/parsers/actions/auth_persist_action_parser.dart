import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/api/auth/auth_manager.dart';
import 'package:tobank_sdui/core/helpers/logger.dart';

class AuthPersistActionModel {
  final String? accessToken;
  final String? nationalCode;

  const AuthPersistActionModel({this.accessToken, this.nationalCode});

  factory AuthPersistActionModel.fromJson(Map<String, dynamic> json) {
    return AuthPersistActionModel(
      accessToken: json['accessToken']?.toString(),
      nationalCode: json['nationalCode']?.toString(),
    );
  }
}

class AuthPersistActionParser extends StacActionParser<AuthPersistActionModel> {
  const AuthPersistActionParser();

  @override
  String get actionType => 'auth_persist';

  @override
  AuthPersistActionModel getModel(Map<String, dynamic> json) =>
      AuthPersistActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, AuthPersistActionModel model) async {
    final authManager = AuthManager();
    await authManager.initialize();

    if (model.accessToken != null && model.accessToken!.isNotEmpty) {
      final token = model.accessToken!;
      // AuthManager.saveTokens expects the cleaned token (without Bearer)
      final normalizedToken = token.toLowerCase().startsWith('bearer ')
          ? token.substring(7).trim()
          : token.trim();

      await authManager.saveTokens(accessToken: normalizedToken);

      // Also update StacRegistry for immediate use (though setValue usually does this)
      final bearerToken = normalizedToken.startsWith('Bearer')
          ? normalizedToken
          : 'Bearer $normalizedToken';
      StacRegistry.instance.setValue('auth.accessToken', bearerToken);
      StacRegistry.instance.setValue('auth.accessTokenRaw', normalizedToken);

      AppLogger.ic(
        LogCategory.network,
        'AuthPersist: Token saved and registry updated.',
      );
    }

    if (model.nationalCode != null && model.nationalCode!.isNotEmpty) {
      final nationalCode = model.nationalCode!.trim();
      await authManager.saveNationalCode(nationalCode);
      StacRegistry.instance.setValue('userData.nationalCode', nationalCode);

      AppLogger.ic(
        LogCategory.network,
        'AuthPersist: National code saved and registry updated: $nationalCode',
      );
    }

    return null;
  }
}

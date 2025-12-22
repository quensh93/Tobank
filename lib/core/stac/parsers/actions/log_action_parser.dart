import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class LogActionModel {
  final String message;
  final String? level;

  LogActionModel({required this.message, this.level});

  factory LogActionModel.fromJson(Map<String, dynamic> json) {
    return LogActionModel(
      message: (json['message'] ?? '').toString(),
      level: json['level']?.toString(),
    );
  }
}

class LogActionParser extends StacActionParser<LogActionModel> {
  const LogActionParser();

  @override
  String get actionType => 'log';

  @override
  LogActionModel getModel(Map<String, dynamic> json) => LogActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, LogActionModel model) {
    final level = (model.level ?? 'info').toLowerCase();
    final message = model.message;

    switch (level) {
      case 'debug':
        debugPrint('DEBUG: $message');
        break;
      case 'warning':
      case 'warn':
        debugPrint('WARNING: $message');
        break;
      case 'error':
        debugPrint('ERROR: $message');
        break;
      case 'info':
      default:
        debugPrint('INFO: $message');
        break;
    }

    return null;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';

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
  LogActionModel getModel(Map<String, dynamic> json) =>
      LogActionModel.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, LogActionModel model) {
    final level = (model.level ?? 'info').toLowerCase();
    final message = _resolveTemplates(model.message);

    switch (level) {
      case 'debug':
        AppLogger.dc(LogCategory.action, message);
        break;
      case 'warning':
      case 'warn':
        AppLogger.wc(LogCategory.action, message);
        break;
      case 'error':
        AppLogger.ec(LogCategory.action, message);
        break;
      case 'info':
      default:
        AppLogger.ic(LogCategory.action, message);
        break;
    }

    return null;
  }

  String _resolveTemplates(String message) {
    if (!message.contains('{{') || !message.contains('}}')) return message;

    return message.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = _evalExpression(expr);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }

  dynamic _evalExpression(String expr) {
    if (expr == 'now()') {
      return DateTime.now().millisecondsSinceEpoch;
    }

    if (expr.contains('-')) {
      final parts = expr.split('-').map((e) => e.trim()).toList();
      if (parts.length == 2) {
        final left = _evalTerm(parts[0]);
        final right = _evalTerm(parts[1]);

        final leftNum = _toNum(left);
        final rightNum = _toNum(right);
        if (leftNum != null && rightNum != null) {
          return leftNum - rightNum;
        }
      }
    }

    return _evalTerm(expr);
  }

  dynamic _evalTerm(String term) {
    if (term == 'now()') {
      return DateTime.now().millisecondsSinceEpoch;
    }

    final value = StacRegistry.instance.getValue(term);
    return value;
  }

  num? _toNum(dynamic value) {
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value);
    }
    return null;
  }
}

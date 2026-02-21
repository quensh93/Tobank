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
        _logChunked(
          message,
          (msg) => AppLogger.dc(LogCategory.stacAction, msg),
        );
        break;
      case 'warning':
      case 'warn':
        _logChunked(
          message,
          (msg) => AppLogger.wc(LogCategory.stacAction, msg),
        );
        break;
      case 'error':
        _logChunked(
          message,
          (msg) => AppLogger.ec(LogCategory.stacAction, msg),
        );
        break;
      case 'info':
      default:
        _logChunked(
          message,
          (msg) => AppLogger.ic(LogCategory.stacAction, msg),
        );
        break;
    }
    return null;
  }

  void _logChunked(String message, Function(String) logFunction) {
    const int chunkSize = 2000;
    if (message.length <= chunkSize) {
      logFunction(message);
      return;
    }

    final int totalLength = message.length;
    int start = 0;
    logFunction('--- START OF LONG MESSAGE ---');
    while (start < totalLength) {
      final int end = (start + chunkSize < totalLength)
          ? start + chunkSize
          : totalLength;
      final String chunk = message.substring(start, end);
      // Log raw chunk without prefix to allow easy copying of full string
      logFunction(chunk);
      start += chunkSize;
    }
    logFunction('--- END OF LONG MESSAGE ---');
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

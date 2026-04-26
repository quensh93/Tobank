import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

/// Model for snackbar actions (`customSnackBar` and overridden `showSnackBar`).
class ShowSnackBarActionModel {
  final String message;
  final String? backgroundColor;
  final int? duration;
  final String? textColor;

  const ShowSnackBarActionModel({
    required this.message,
    this.backgroundColor,
    this.duration,
    this.textColor,
  });

  factory ShowSnackBarActionModel.fromJson(Map<String, dynamic> json) {
    var message = (json['message'] as String?)?.trim() ?? '';

    // Built-in `showSnackBar` commonly sends message via `content.data`.
    if (message.isEmpty) {
      final content = json['content'];
      if (content is String) {
        message = content;
      } else if (content is Map) {
        final data = content['data'];
        if (data != null) {
          message = data.toString();
        }
      }
    }

    return ShowSnackBarActionModel(
      message: message,
      backgroundColor: json['backgroundColor'] as String?,
      duration: json['duration'] as int?,
      textColor: json['textColor'] as String?,
    );
  }
}

abstract class _BaseShowSnackBarActionParser
    extends StacActionParser<ShowSnackBarActionModel> {
  const _BaseShowSnackBarActionParser();

  @override
  ShowSnackBarActionModel getModel(Map<String, dynamic> json) =>
      ShowSnackBarActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(BuildContext context, ShowSnackBarActionModel model) {
    final resolvedMessage = _resolveTemplateVariables(model.message);
    if (resolvedMessage.trim().isEmpty) {
      return null;
    }

    Color? bgColor;
    if (model.backgroundColor != null) {
      bgColor = _parseColor(model.backgroundColor!);
    }

    Color? txtColor;
    if (model.textColor != null) {
      txtColor = _parseColor(model.textColor!);
    }

    final snackBar = SnackBar(
      content: Text(
        resolvedMessage,
        style: TextStyle(
          color: txtColor ?? Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: bgColor ?? Colors.black87,
      duration: Duration(milliseconds: model.duration ?? 3000),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }

  String _resolveTemplateVariables(String text) {
    var resolved = text;

    // Resolve __STAC_OPEN__expr}} syntax used in built JSON files.
    final stacOpenRegex = RegExp(r'__STAC_OPEN__([^}]+)\}\}');
    resolved = resolved.replaceAllMapped(stacOpenRegex, (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = _resolveExpression(expr);
      return value?.toString() ?? '';
    });

    // Resolve {{expr}} syntax.
    final mustacheRegex = RegExp(r'\{\{([^}]+)\}\}');
    resolved = resolved.replaceAllMapped(mustacheRegex, (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = _resolveExpression(expr);
      return value?.toString() ?? '';
    });

    return resolved;
  }

  dynamic _resolveExpression(String expr) {
    // Support simple null-coalescing: a ?? b
    final parts = expr
        .split('??')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty);

    for (final candidate in parts) {
      final value = _lookupRegistryValue(candidate);
      if (value != null && value.toString().isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  dynamic _lookupRegistryValue(String path) {
    final registry = StacRegistry.instance;

    // Direct key lookup first (supports flat dotted keys as well).
    final directValue = registry.getValue(path);
    if (directValue != null) {
      return directValue;
    }

    // Fallback path traversal: data.status.message.0 / foo[0].bar
    final normalizedPath = path.replaceAllMapped(
      RegExp(r'\[(\d+)\]'),
      (m) => '.${m.group(1)}',
    );
    final segments = normalizedPath
        .split('.')
        .where((segment) => segment.isNotEmpty)
        .toList();
    if (segments.isEmpty) return null;

    dynamic value = registry.getValue(segments.first);
    for (final segment in segments.skip(1)) {
      if (value is Map<String, dynamic>) {
        value = value[segment];
      } else if (value is Map) {
        value = value[segment];
      } else if (value is List) {
        final index = int.tryParse(segment);
        if (index == null || index < 0 || index >= value.length) {
          return null;
        }
        value = value[index];
      } else {
        return null;
      }
    }

    return value;
  }

  Color? _parseColor(String colorString) {
    try {
      final hexColor = colorString.replaceFirst('#', '');
      if (hexColor.length == 6) {
        return Color(int.parse('FF$hexColor', radix: 16));
      } else if (hexColor.length == 8) {
        return Color(int.parse(hexColor, radix: 16));
      }
    } catch (_) {}
    return null;
  }
}

/// Parser for project custom action: `customSnackBar`.
class ShowSnackBarActionParser extends _BaseShowSnackBarActionParser {
  const ShowSnackBarActionParser();

  @override
  String get actionType => 'customSnackBar';
}

/// Override parser for built-in action: `showSnackBar`.
class BuiltInShowSnackBarActionParser extends _BaseShowSnackBarActionParser {
  const BuiltInShowSnackBarActionParser();

  @override
  String get actionType => 'showSnackBar';
}

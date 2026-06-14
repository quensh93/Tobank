import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../custom_navigate_action_parser.dart';

/// Model for snackbar actions (`customSnackBar` and overridden `showSnackBar`).
class ShowSnackBarActionModel {
  final String message;
  final String? backgroundColor;
  final int? duration;
  final bool permanent;
  final String? textColor;
  final String? snackStyle;
  final Map<String, dynamic>? child;

  const ShowSnackBarActionModel({
    required this.message,
    this.backgroundColor,
    this.duration,
    this.permanent = false,
    this.textColor,
    this.snackStyle,
    this.child,
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
      permanent: (json['permanent'] == true) || (json['permenent'] == true),
      textColor: json['textColor'] as String?,
      snackStyle: json['snackStyle'] as String?,
      child: json['child'] is Map
          ? Map<String, dynamic>.from(json['child'] as Map)
          : null,
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
    NavLogger.logOverlay('push', 'snackbar', model.message ?? '');
    final resolvedMessage = _resolveTemplateVariables(model.message);
    final customChild = model.child != null
        ? Stac.fromJson(model.child!, context)
        : null;

    if (resolvedMessage.trim().isEmpty && customChild == null) {
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

    final useInfoCardStyle =
        model.snackStyle?.trim().toLowerCase() == 'infocard';

    final effectiveDurationMs = model.permanent
        ? const Duration(days: 3650).inMilliseconds
        : (model.duration ?? 3000);

    final snackBar = customChild != null
        ? SnackBar(
            content: customChild,
            backgroundColor: bgColor ?? Colors.transparent,
            duration: Duration(milliseconds: effectiveDurationMs),
            dismissDirection: model.permanent
                ? DismissDirection.none
                : DismissDirection.down,
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          )
        : useInfoCardStyle
        ? _buildInfoCardSnackBar(
            context: context,
            message: resolvedMessage,
            durationMs: effectiveDurationMs,
            permanent: model.permanent,
            backgroundColor: bgColor,
            textColor: txtColor,
          )
        : SnackBar(
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
            duration: Duration(milliseconds: effectiveDurationMs),
            dismissDirection: model.permanent
                ? DismissDirection.none
                : DismissDirection.down,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
          );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }

  SnackBar _buildInfoCardSnackBar({
    required BuildContext context,
    required String message,
    required int durationMs,
    required bool permanent,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? (backgroundColor ?? const Color(0xE11D2939))
        : Colors.white;
    final txt = isDark
        ? (textColor ?? const Color(0xFFD0D5DD))
        : const Color(0xFF475467);
    final divider = txt.withValues(alpha: 0.40);
    final iconColor = txt.withValues(alpha: 0.95);
    final iconBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFF2F4F7);
    final border = isDark
        ? const Color(0xFFD0D7DD).withValues(alpha: 0.55)
        : const Color(0xFF475467).withValues(alpha: 0.35);

    return SnackBar(
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: border, width: 2),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBg,
                ),
                child: Icon(Icons.info_outline, size: 18, color: iconColor),
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 24, color: divider),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: txt,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      duration: Duration(milliseconds: durationMs + 1000),
      dismissDirection: permanent
          ? DismissDirection.none
          : DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );
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

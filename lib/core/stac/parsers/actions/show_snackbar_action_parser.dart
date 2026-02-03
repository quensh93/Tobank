import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

/// Model for the showSnackBar action
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
    return ShowSnackBarActionModel(
      message: json['message'] as String? ?? '',
      backgroundColor: json['backgroundColor'] as String?,
      duration: json['duration'] as int?,
      textColor: json['textColor'] as String?,
    );
  }
}

/// Parser for the showSnackBar action.
/// Shows a snackbar with a message.
///
/// Example JSON:
/// ```json
/// {
///   "actionType": "showSnackBar",
///   "message": "Operation completed successfully!",
///   "backgroundColor": "#4CAF50",
///   "duration": 3000,
///   "textColor": "#FFFFFF"
/// }
/// ```
class ShowSnackBarActionParser
    extends StacActionParser<ShowSnackBarActionModel> {
  const ShowSnackBarActionParser();

  @override
  String get actionType => 'customSnackBar';

  @override
  ShowSnackBarActionModel getModel(Map<String, dynamic> json) {
    return ShowSnackBarActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(BuildContext context, ShowSnackBarActionModel model) {
    // Resolve any template variables in the message
    final resolvedMessage = _resolveTemplateVariables(model.message);

    // Parse colors
    Color? bgColor;
    if (model.backgroundColor != null) {
      bgColor = _parseColor(model.backgroundColor!);
    }

    Color? txtColor;
    if (model.textColor != null) {
      txtColor = _parseColor(model.textColor!);
    }

    // Create and show snackbar
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
  }

  String _resolveTemplateVariables(String text) {
    // Simple template resolution using registry
    final regex = RegExp(r'\{\{([^}]+)\}\}');
    return text.replaceAllMapped(regex, (match) {
      final key = match.group(1)?.trim();
      if (key == null) return match.group(0) ?? '';

      // Handle array access like data.status.message[0]
      final arrayMatch = RegExp(r'(.+)\[(\d+)\]').firstMatch(key);
      if (arrayMatch != null) {
        final baseKey = arrayMatch.group(1);
        final index = int.tryParse(arrayMatch.group(2) ?? '');
        if (baseKey != null && index != null) {
          final value = StacRegistry.instance.getValue(baseKey);
          if (value is List && index < value.length) {
            return value[index].toString();
          }
        }
      }

      final value = StacRegistry.instance.getValue(key);
      return value?.toString() ?? match.group(0) ?? '';
    });
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

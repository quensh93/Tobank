import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../../core/helpers/logger.dart';
import '../custom_navigate_action_parser.dart';

class ShowDialogActionModel {
  final Map<String, dynamic>? dialog;
  final bool? barrierDismissible;
  final String? barrierColor;
  final String? backgroundColor;

  const ShowDialogActionModel({
    this.dialog,
    this.barrierDismissible,
    this.barrierColor,
    this.backgroundColor,
  });

  factory ShowDialogActionModel.fromJson(Map<String, dynamic> json) {
    final rawDialog = json['dialog'];
    return ShowDialogActionModel(
      dialog: rawDialog is Map<String, dynamic>
          ? rawDialog
          : rawDialog is Map
          ? Map<String, dynamic>.from(rawDialog)
          : null,
      barrierDismissible: json['barrierDismissible'] as bool?,
      barrierColor: json['barrierColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
    );
  }
}

class ShowDialogActionParser extends StacActionParser<ShowDialogActionModel> {
  const ShowDialogActionParser();

  @override
  String get actionType => 'showAppDialog';

  @override
  ShowDialogActionModel getModel(Map<String, dynamic> json) {
    return ShowDialogActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowDialogActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'dialog', 'app_dialog');
    if (!context.mounted) return;

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: model.barrierDismissible ?? true,
        barrierColor: _parseColor(model.barrierColor) ?? Colors.black54,
        builder: (dialogContext) {
          final dialogJson = model.dialog;
          if (dialogJson != null) {
            return Dialog(
              backgroundColor:
                  _parseColor(model.backgroundColor) ?? Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  Stac.fromJson(dialogJson, dialogContext) ??
                  const SizedBox.shrink(),
            );
          }
          return const SizedBox.shrink();
        },
      );
    } catch (e, stackTrace) {
      AppLogger.e('Error executing showDialog action: $e', e, stackTrace);
    }
  }
}

Color? _parseColor(String? colorString) {
  if (colorString == null) return null;
  try {
    final hex = colorString.replaceAll('#', '');
    if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
    if (hex.length == 8) return Color(int.parse(hex, radix: 16));
    return null;
  } catch (_) {
    return null;
  }
}

void registerShowDialogActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowDialogActionParser(),
  );
}

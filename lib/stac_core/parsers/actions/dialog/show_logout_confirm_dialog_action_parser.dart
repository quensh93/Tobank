import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../registry/custom_component_registry.dart';
import '../custom_navigate_action_parser.dart';

class ShowLogoutConfirmDialogActionModel {
  final String title;
  final String description;
  final String positiveText;
  final String negativeText;
  final String warningIconAsset;
  final Map<String, dynamic>? positiveAction;
  final Map<String, dynamic>? negativeAction;

  const ShowLogoutConfirmDialogActionModel({
    required this.title,
    required this.description,
    required this.positiveText,
    required this.negativeText,
    required this.warningIconAsset,
    this.positiveAction,
    this.negativeAction,
  });

  factory ShowLogoutConfirmDialogActionModel.fromJson(Map<String, dynamic> json) {
    final rawPositiveAction = json['positiveAction'];
    final rawNegativeAction = json['negativeAction'];
    return ShowLogoutConfirmDialogActionModel(
      title: json['title'] as String? ?? 'مطمئن به خروج از حساب‌کاربری هستید؟',
      description: json['description'] as String? ??
          'در صورت خروج از حساب‌کاربری، برای ورود مجدد نیاز به احراز هویت خواهد داشت. احراز هویت مجدد، به منظور افزایش امنیت حساب‌کاربری و جلوگیری از دسترسی غیرمجاز افراد ناشناس به حساب شما می‌باشد.',
      positiveText: json['positiveText'] as String? ?? 'بله',
      negativeText: json['negativeText'] as String? ?? 'خیر',
      warningIconAsset:
          json['warningIconAsset'] as String? ?? 'assets/icons/ic_warning_red.svg',
      positiveAction: rawPositiveAction is Map<String, dynamic>
          ? rawPositiveAction
          : rawPositiveAction is Map
              ? Map<String, dynamic>.from(rawPositiveAction)
              : null,
      negativeAction: rawNegativeAction is Map<String, dynamic>
          ? rawNegativeAction
          : rawNegativeAction is Map
              ? Map<String, dynamic>.from(rawNegativeAction)
              : null,
    );
  }
}

class ShowLogoutConfirmDialogActionParser
    extends StacActionParser<ShowLogoutConfirmDialogActionModel> {
  const ShowLogoutConfirmDialogActionParser();

  @override
  String get actionType => 'showLogoutConfirmDialog';

  @override
  ShowLogoutConfirmDialogActionModel getModel(Map<String, dynamic> json) {
    return ShowLogoutConfirmDialogActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowLogoutConfirmDialogActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'dialog', 'logout_confirm');
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      model.warningIconAsset,
                      width: 56,
                      height: 56,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    model.title,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    model.description,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.8,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            if (model.positiveAction != null && context.mounted) {
                              Stac.onCallFromJson(model.positiveAction!, context);
                            }
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            model.positiveText,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            if (model.negativeAction != null && context.mounted) {
                              Stac.onCallFromJson(model.negativeAction!, context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            side: BorderSide(
                              color: colorScheme.outline.withValues(alpha: 0.8),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            model.negativeText,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void registerShowLogoutConfirmDialogActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowLogoutConfirmDialogActionParser(),
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';

class ShowDeleteAccountConfirmBottomSheetActionModel {
  final String title;
  final String description;
  final String warningMessageOne;
  final String warningMessageTwo;
  final String confirmText;
  final String buttonText;
  final String warningIconAsset;
  final Map<String, dynamic>? continueAction;

  const ShowDeleteAccountConfirmBottomSheetActionModel({
    required this.title,
    required this.description,
    required this.warningMessageOne,
    required this.warningMessageTwo,
    required this.confirmText,
    required this.buttonText,
    required this.warningIconAsset,
    this.continueAction,
  });

  factory ShowDeleteAccountConfirmBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawContinueAction = json['continueAction'];
    return ShowDeleteAccountConfirmBottomSheetActionModel(
      title: json['title'] as String? ?? 'حذف اطلاعات حساب کاربری',
      description: json['description'] as String? ??
          'کاربر گرامی، در صورت انتقال سیم‌کارت یا تمایل به حذف اطلاعات حساب خود می‌توانید اطلاعاتی نظیر تراکنش‌ها، کارت‌های ذخیره شده و ... را از حساب‌کاربری خود حذف کنید.',
      warningMessageOne: json['warningMessageOne'] as String? ??
          'حتما قبل از حذف اطلاعات، موجودی کیف پول خود را به شماره دیگر خود انتقال دهید.',
      warningMessageTwo: json['warningMessageTwo'] as String? ??
          'تا ۲۴ ساعت بعد از حذف حساب‌کاربری امکان ثبت‌نام مجدد نخواهید داشت',
      confirmText:
          json['confirmText'] as String? ?? 'میخواهم اطلاعات حساب کاربری خود را حذف کنم.',
      buttonText: json['buttonText'] as String? ?? 'ادامه',
      warningIconAsset:
          json['warningIconAsset'] as String? ?? 'assets/icons/ic_warning_red.svg',
      continueAction: rawContinueAction is Map<String, dynamic>
          ? rawContinueAction
          : rawContinueAction is Map
              ? Map<String, dynamic>.from(rawContinueAction)
              : null,
    );
  }
}

class ShowDeleteAccountConfirmBottomSheetActionParser
    extends StacActionParser<ShowDeleteAccountConfirmBottomSheetActionModel> {
  const ShowDeleteAccountConfirmBottomSheetActionParser();

  @override
  String get actionType => 'showDeleteAccountConfirmBottomSheet';

  @override
  ShowDeleteAccountConfirmBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowDeleteAccountConfirmBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowDeleteAccountConfirmBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final bottomInset = MediaQuery.of(bottomSheetContext).padding.bottom;
        var isConfirmed = false;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 44,
                            height: 5,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
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
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          model.description,
                          textAlign: TextAlign.right,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.7,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _warningRow(
                          text: model.warningMessageOne,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 12),
                        _warningRow(
                          text: model.warningMessageTwo,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Checkbox(
                              value: isConfirmed,
                              onChanged: (value) {
                                setModalState(() {
                                  isConfirmed = value ?? false;
                                });
                              },
                              activeColor: colorScheme.secondary,
                              side: BorderSide(
                                color: colorScheme.onSurfaceVariant,
                                width: 1.7,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                model.confirmText,
                                textAlign: TextAlign.right,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.5
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        FilledButton(
                          onPressed: isConfirmed
                              ? () {
                                  Navigator.of(bottomSheetContext).pop();
                                  if (model.continueAction != null &&
                                      context.mounted) {
                                    Stac.onCallFromJson(model.continueAction!, context);
                                  }
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor:
                                isConfirmed ? colorScheme.primary : const Color(0xFFA4A7AC),
                            disabledBackgroundColor: const Color(0xFFA4A7AC),
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            model.buttonText,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _warningRow({
    required String text,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: 25,
          color: const Color(0xFF101828),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.7,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}

void registerShowDeleteAccountConfirmBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowDeleteAccountConfirmBottomSheetActionParser(),
  );
}

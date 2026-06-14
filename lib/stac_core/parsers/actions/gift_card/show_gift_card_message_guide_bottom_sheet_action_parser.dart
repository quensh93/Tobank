import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardMessageGuideBottomSheetActionModel {
  final String title;
  final String description;
  final String closeText;

  const ShowGiftCardMessageGuideBottomSheetActionModel({
    required this.title,
    required this.description,
    required this.closeText,
  });

  factory ShowGiftCardMessageGuideBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardMessageGuideBottomSheetActionModel(
      title: json['title'] as String? ?? 'راهنما',
      description:
          json['description'] as String? ??
          'در صورت ورود متن دلخواه، یکی از متن‌های پیش‌فرض را انتخاب کنید تا در صورت عدم موافقت بانک با متن دلخواه شما، متن پیش‌فرض جایگزین آن شود',
      closeText: json['closeText'] as String? ?? 'بستن',
    );
  }
}

class ShowGiftCardMessageGuideBottomSheetActionParser
    extends StacActionParser<ShowGiftCardMessageGuideBottomSheetActionModel> {
  const ShowGiftCardMessageGuideBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardMessageGuideBottomSheet';

  @override
  ShowGiftCardMessageGuideBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardMessageGuideBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardMessageGuideBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_message_guide');
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
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 10, 24, safeBottom + 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 46,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.45,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 32,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      model.description,
                      textAlign: TextAlign.right,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,

                      ),
                    ),
                    const SizedBox(height: 26),
                    FilledButton(
                      onPressed: () => Navigator.of(bottomSheetContext).pop(),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        backgroundColor: const Color(0xFFD61F2C),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        model.closeText,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void registerShowGiftCardMessageGuideBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardMessageGuideBottomSheetActionParser(),
  );
}

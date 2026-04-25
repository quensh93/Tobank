import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class ShowGiftCardAmountGuideBottomSheetActionModel {
  final String title;
  final String closeText;
  final int minAmount;
  final int maxAmount;
  final String? description;

  const ShowGiftCardAmountGuideBottomSheetActionModel({
    required this.title,
    required this.closeText,
    required this.minAmount,
    required this.maxAmount,
    this.description,
  });

  factory ShowGiftCardAmountGuideBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardAmountGuideBottomSheetActionModel(
      title: json['title'] as String? ?? 'راهنما',
      closeText: json['closeText'] as String? ?? 'بستن',
      minAmount: (json['minAmount'] as num?)?.toInt() ?? 1000000,
      maxAmount: (json['maxAmount'] as num?)?.toInt() ?? 50000000,
      description: json['description'] as String?,
    );
  }
}

class ShowGiftCardAmountGuideBottomSheetActionParser
    extends StacActionParser<ShowGiftCardAmountGuideBottomSheetActionModel> {
  const ShowGiftCardAmountGuideBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardAmountGuideBottomSheet';

  @override
  ShowGiftCardAmountGuideBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardAmountGuideBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardAmountGuideBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final description =
        model.description ??
        'مبلغ دلخواه حداقل ${_amountLabelOnlyNumber(model.minAmount)} و حداکثر ${_amountLabelOnlyNumber(model.maxAmount)} ریال می‌باشد';

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
                  top: Radius.circular(14),
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
                        width: 62,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.45,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 34,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      description,
                      textAlign: TextAlign.right,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: () => Navigator.of(bottomSheetContext).pop(),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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

  String _amountLabelOnlyNumber(int amount) {
    return _toPersianDigits(_formatWithGrouping(amount));
  }

  String _formatWithGrouping(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write(',');
      }
    }
    return buffer.toString();
  }

  String _toPersianDigits(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    var output = input;
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(english[i], persian[i]);
    }
    return output;
  }
}

void registerShowGiftCardAmountGuideBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardAmountGuideBottomSheetActionParser(),
  );
}

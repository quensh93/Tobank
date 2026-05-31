import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';

class ShowGiftCardSelectAmountBottomSheetActionModel {
  final String title;
  final String inputHint;
  final String confirmText;
  final String amountValueKey;
  final String amountLabelKey;
  final int minAmount;
  final int maxAmount;
  final List<int> quickAmounts;

  const ShowGiftCardSelectAmountBottomSheetActionModel({
    required this.title,
    required this.inputHint,
    required this.confirmText,
    required this.amountValueKey,
    required this.amountLabelKey,
    required this.minAmount,
    required this.maxAmount,
    required this.quickAmounts,
  });

  factory ShowGiftCardSelectAmountBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawQuickAmounts = json['quickAmounts'];
    final quickAmounts = <int>[];
    if (rawQuickAmounts is List) {
      for (final item in rawQuickAmounts) {
        if (item is num) {
          quickAmounts.add(item.toInt());
        } else if (item is String) {
          final parsed = int.tryParse(item);
          if (parsed != null) quickAmounts.add(parsed);
        }
      }
    }

    return ShowGiftCardSelectAmountBottomSheetActionModel(
      title:
          json['title'] as String? ?? 'مبلغ کارت هدیه را وارد یا انتخاب نمایید',
      inputHint:
          json['inputHint'] as String? ??
          'مبلغ کارت هدیه را به ریال وارد نمایید',
      confirmText: json['confirmText'] as String? ?? 'تایید',
      amountValueKey:
          json['amountValueKey'] as String? ?? 'giftCardRealAmountValue1',
      amountLabelKey:
          json['amountLabelKey'] as String? ?? 'giftCardRealAmountLabel1',
      minAmount: (json['minAmount'] as num?)?.toInt() ?? 1000000,
      maxAmount: (json['maxAmount'] as num?)?.toInt() ?? 50000000,
      quickAmounts: quickAmounts.isEmpty
          ? const [5000000, 10000000, 20000000, 30000000, 40000000, 50000000]
          : quickAmounts,
    );
  }
}

class ShowGiftCardSelectAmountBottomSheetActionParser
    extends StacActionParser<ShowGiftCardSelectAmountBottomSheetActionModel> {
  const ShowGiftCardSelectAmountBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardSelectAmountBottomSheet';

  @override
  ShowGiftCardSelectAmountBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardSelectAmountBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardSelectAmountBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final currentAmount =
        _tryParseAmount(StacRegistry.instance.getValue(model.amountValueKey)) ??
        _tryParseAmount(StacRegistry.instance.getValue(model.amountLabelKey)) ??
        model.quickAmounts.first;

    var selectedAmount = currentAmount;
    final amountController = TextEditingController(
      text: _formatWithGrouping(currentAmount),
    );

    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final bottomInset = MediaQuery.of(bottomSheetContext).viewInsets.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                final isValid =
                    selectedAmount >= model.minAmount &&
                    selectedAmount <= model.maxAmount;

                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      10,
                      16,
                      safeBottom + bottomInset + 16,
                    ),
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
                        const SizedBox(height: 30),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9۰-۹٠-٩,،]'),
                            ),
                          ],
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: model.inputHint,
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: colorScheme.outline,
                                width: 1.2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            final parsed = _tryParseAmount(value);
                            setModalState(() {
                              selectedAmount = parsed ?? 0;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 22,
                              color: isValid
                                  ? colorScheme.onSurfaceVariant
                                  : colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'مبلغ دلخواه حداقل ${_amountLabelOnlyNumber(model.minAmount)} و حداکثر ${_amountLabelOnlyNumber(model.maxAmount)} ریال می‌باشد',
                                textAlign: TextAlign.right,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isValid
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.quickAmounts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 2.2,
                              ),
                          itemBuilder: (context, index) {
                            final amount = model.quickAmounts[index];
                            final isSelected = selectedAmount == amount;

                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                setModalState(() {
                                  selectedAmount = amount;
                                  amountController.text = _formatWithGrouping(
                                    amount,
                                  );
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorScheme.primary.withValues(
                                          alpha: 0.08,
                                        )
                                      : colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? colorScheme.primary
                                        : colorScheme.outlineVariant,
                                    width: isSelected ? 1.4 : 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${_amountLabelOnlyNumber(amount)} ریال',
                                  textAlign: TextAlign.center,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 28),
                        FilledButton(
                          onPressed: isValid
                              ? () {
                                  Navigator.of(
                                    bottomSheetContext,
                                  ).pop(selectedAmount);
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            backgroundColor: const Color(0xFFD61F2C),
                            disabledBackgroundColor: const Color(0xFFADADAD),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white,
                          ),
                          child: Text(
                            model.confirmText,
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
                );
              },
            ),
          ),
        );
      },
    );

    amountController.dispose();
    if (result == null) return;

    StacRegistry.instance.setValue(model.amountValueKey, result.toString());
    StacRegistry.instance.setValue(model.amountLabelKey, _amountLabel(result));
    RegistryNotifier.instance.notify();
  }

  int? _tryParseAmount(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    final normalized = _normalizeDigits(value.toString());
    final digitsOnly = normalized.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) return null;
    return int.tryParse(digitsOnly);
  }

  String _amountLabel(int amount) => '${_amountLabelOnlyNumber(amount)} ریال';

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

  String _normalizeDigits(String input) {
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    var output = input.replaceAll('،', ',');
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(persian[i], '$i');
      output = output.replaceAll(arabic[i], '$i');
    }
    return output;
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

void registerShowGiftCardSelectAmountBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardSelectAmountBottomSheetActionParser(),
  );
}

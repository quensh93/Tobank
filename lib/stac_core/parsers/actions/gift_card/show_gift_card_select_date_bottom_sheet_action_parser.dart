import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../../../registry/text_form_field_controller_registry.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardSelectDateBottomSheetActionModel {
  final String title;
  final String dateTitle;
  final String timeTitle;
  final String confirmText;
  final String noDateSelectedText;
  final String selectedDateKey;
  final String selectedTimeKey;
  final String confirmRouteName;
  final String? confirmAssetPath;
  final Map<String, dynamic>? confirmRequest;
  final List<String> dateOptions;
  final List<String> timeOptions;

  const ShowGiftCardSelectDateBottomSheetActionModel({
    required this.title,
    required this.dateTitle,
    required this.timeTitle,
    required this.confirmText,
    required this.noDateSelectedText,
    required this.selectedDateKey,
    required this.selectedTimeKey,
    required this.confirmRouteName,
    required this.confirmAssetPath,
    required this.confirmRequest,
    required this.dateOptions,
    required this.timeOptions,
  });

  factory ShowGiftCardSelectDateBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<String> parseList(dynamic raw) {
      final values = <String>[];
      if (raw is List) {
        for (final item in raw) {
          if (item == null) continue;
          final text = item.toString().trim();
          if (text.isNotEmpty) values.add(text);
        }
      }
      return values;
    }

    return ShowGiftCardSelectDateBottomSheetActionModel(
      title:
          json['title'] as String? ??
          'لطفا تاریخ و بازه\u200cزمانی تحویل هدیه را انتخاب کنید',
      dateTitle: json['dateTitle'] as String? ?? 'تاریخ تحویل',
      timeTitle: json['timeTitle'] as String? ?? 'محدوده ساعتی تحویل',
      confirmText: json['confirmText'] as String? ?? 'تایید',
      noDateSelectedText:
          json['noDateSelectedText'] as String? ?? 'تاریخی انتخاب نشده است',
      selectedDateKey:
          json['selectedDateKey'] as String? ?? 'giftCardRealDeliveryDate',
      selectedTimeKey:
          json['selectedTimeKey'] as String? ?? 'giftCardRealDeliveryTime',
      confirmRouteName:
          json['confirmRouteName'] as String? ?? 'gift_card_confirm',
      confirmAssetPath: (json['confirmAssetPath'] as String?)?.trim().isEmpty ==
              true
          ? null
          : (json['confirmAssetPath'] as String?),
      confirmRequest: json['confirmRequest'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(json['confirmRequest'] as Map)
          : null,
      dateOptions: parseList(json['dateOptions']),
      timeOptions: parseList(json['timeOptions']),
    );
  }
}

class ShowGiftCardSelectDateBottomSheetActionParser
    extends StacActionParser<ShowGiftCardSelectDateBottomSheetActionModel> {
  const ShowGiftCardSelectDateBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardSelectDateBottomSheet';

  @override
  ShowGiftCardSelectDateBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardSelectDateBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardSelectDateBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_select_date');
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
        final screenWidth = MediaQuery.sizeOf(bottomSheetContext).width;
        final initialDate =
            (StacRegistry.instance
                        .getValue(model.selectedDateKey)
                        ?.toString() ??
                    '')
                .trim();
        final initialTime =
            (StacRegistry.instance
                        .getValue(model.selectedTimeKey)
                        ?.toString() ??
                    '')
                .trim();

        int? selectedDateIndex = initialDate.isEmpty
            ? null
            : model.dateOptions.indexOf(initialDate);
        int? selectedTimeIndex = initialTime.isEmpty
            ? null
            : model.timeOptions.indexOf(initialTime);
        if (selectedDateIndex != null && selectedDateIndex < 0) {
          selectedDateIndex = null;
        }
        if (selectedTimeIndex != null && selectedTimeIndex < 0) {
          selectedTimeIndex = null;
        }

        return StatefulBuilder(
          builder: (context, setState) {
            Widget buildDateItem(String text, int index) {
              final selected = selectedDateIndex == index;
              final hasSingle = model.dateOptions.length == 1;
              final width = hasSingle ? screenWidth * 0.44 : screenWidth * 0.39;

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                    selectedTimeIndex = null;
                  });
                },
                child: Container(
                  width: width,
                  constraints: const BoxConstraints(minHeight: 78),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF35C0BE).withValues(alpha: 0.20)
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF27B3B0)
                          : colorScheme.outlineVariant.withValues(alpha: 0.75),
                      width: selected ? 1.4 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              );
            }

            Widget buildTimeItem(String text, int index) {
              final selected = selectedTimeIndex == index;
              return InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  setState(() {
                    selectedTimeIndex = index;
                  });
                },
                child: Container(
                  width: 74,
                  height: 74,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? const Color(0xFF35C0BE).withValues(alpha: 0.20)
                        : colorScheme.surface,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF27B3B0)
                          : colorScheme.outlineVariant.withValues(alpha: 0.75),
                      width: selected ? 1.4 : 1,
                    ),
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }

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
                        const SizedBox(height: 26),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          model.dateTitle,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (model.dateOptions.isNotEmpty)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              model.dateOptions.length,
                              (index) => buildDateItem(
                                model.dateOptions[index],
                                index,
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        const SizedBox(height: 28),
                        Text(
                          model.timeTitle,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (selectedDateIndex == null)
                          Center(
                            child: Text(
                              model.noDateSelectedText,
                              textAlign: TextAlign.center,
                              style: textTheme.titleSmall?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        else
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: List.generate(
                              model.timeOptions.length,
                              (index) => buildTimeItem(
                                model.timeOptions[index],
                                index,
                              ),
                            ),
                          ),
                        const SizedBox(height: 28),
                        FilledButton(
                          onPressed: () {
                            final selectedDate = selectedDateIndex == null
                                ? ''
                                : model.dateOptions[selectedDateIndex!];
                            final selectedTime = selectedTimeIndex == null
                                ? ''
                                : model.timeOptions[selectedTimeIndex!];

                            StacRegistry.instance.setValue(
                              model.selectedDateKey,
                              selectedDate,
                            );
                            StacRegistry.instance.setValue(
                              model.selectedTimeKey,
                              selectedTime,
                            );
                            _prepareConfirmSummaryValues(
                              selectedDate: selectedDate,
                              selectedTime: selectedTime,
                            );
                            RegistryNotifier.instance.notify();
                            Navigator.of(bottomSheetContext).pop();
                            if (!context.mounted) return;
                            final targetAssetPath =
                                model.confirmAssetPath?.trim();
                            final navigatePayload = <String, dynamic>{
                              'actionType': 'navigate',
                              'navigationStyle': 'push',
                            };
                            if (model.confirmRequest != null) {
                              navigatePayload['request'] = model.confirmRequest;
                            } else if (targetAssetPath != null &&
                                targetAssetPath.isNotEmpty) {
                              navigatePayload['assetPath'] = targetAssetPath;
                            } else {
                              navigatePayload['routeName'] =
                                  model.confirmRouteName;
                            }
                            Stac.onCallFromJson(navigatePayload, context);
                          },
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
                ),
              ),
            );
          },
        );
      },
    );
  }
}

void _prepareConfirmSummaryValues({
  required String selectedDate,
  required String selectedTime,
}) {
  final registry = StacRegistry.instance;
  final controllers = TextFormFieldControllerRegistry.instance;

  final isOwner = _readBool(registry.getValue('giftCardRealReceiverIsOwner'));

  final receiverName = isOwner
      ? 'خودم'
      : _readController(
          controllers,
          'gift_card_receiver_name',
          fallback: '---',
        );
  final receiverMobile = isOwner
      ? '---'
      : _readController(
          controllers,
          'gift_card_receiver_mobile',
          fallback: '---',
        );
  final receiverAddress = _readController(
    controllers,
    'gift_card_receiver_address',
    fallback: '---',
  );

  final showSecond = _readBool(
    registry.getValue('giftCardRealShowSecondAmountCard'),
  );
  final showThird = _readBool(
    registry.getValue('giftCardRealShowThirdAmountCard'),
  );

  int totalAmount = 0;
  int totalCards = 0;
  final line1Amount = _lineAmount(1);
  final line1Count = _lineCount(1);
  totalAmount += line1Amount * line1Count;
  totalCards += line1Count;
  if (showSecond) {
    final line2Amount = _lineAmount(2);
    final line2Count = _lineCount(2);
    totalAmount += line2Amount * line2Count;
    totalCards += line2Count;
  }
  if (showThird) {
    final line3Amount = _lineAmount(3);
    final line3Count = _lineCount(3);
    totalAmount += line3Amount * line3Count;
    totalCards += line3Count;
  }

  const issuanceFeePerCard = 36000;
  const deliveryFee = 570000;
  final issuanceFeeTotal =
      issuanceFeePerCard * (totalCards <= 0 ? 1 : totalCards);
  final paymentAmount = totalAmount + issuanceFeeTotal + deliveryFee;

  registry.setValue(
    'giftCardRealSummaryCardsAmountLabel',
    '${_formatPersianNumber(totalAmount)} ریال',
  );
  registry.setValue(
    'giftCardRealSummaryIssuanceFeeLabel',
    '${_formatPersianNumber(issuanceFeePerCard)} ریال',
  );
  registry.setValue(
    'giftCardRealSummaryDeliveryFeeLabel',
    '${_formatPersianNumber(deliveryFee)} ریال',
  );
  registry.setValue(
    'giftCardRealSummaryPaymentLabel',
    '${_formatPersianNumber(paymentAmount)} ریال',
  );
  registry.setValue('giftCardRealSummaryPaymentAmount', paymentAmount);

  registry.setValue('giftCardRealSummaryReceiverName', receiverName);
  registry.setValue('giftCardRealSummaryReceiverMobile', receiverMobile);
  registry.setValue('giftCardRealSummaryReceiverAddress', receiverAddress);
  registry.setValue(
    'giftCardRealSummaryReceiverCity',
    (registry.getValue('giftCardRealReceiverCity')?.toString() ?? '---'),
  );
  registry.setValue(
    'giftCardRealSummaryType',
    (registry.getValue('giftCardRealSelectedCategory')?.toString() ?? '---'),
  );
  registry.setValue(
    'giftCardRealSummaryDeliveryDate',
    selectedDate.isEmpty ? '---' : selectedDate,
  );
  registry.setValue(
    'giftCardRealSummaryDeliveryTime',
    selectedTime.isEmpty ? '---' : selectedTime,
  );
}

String _readController(
  TextFormFieldControllerRegistry controllers,
  String id, {
  String fallback = '',
}) {
  final text = (controllers.get(id)?.text ?? '').trim();
  return text.isEmpty ? fallback : text;
}

bool _readBool(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
  }
  return false;
}

int _lineAmount(int index) {
  final value = StacRegistry.instance.getValue('giftCardRealAmountValue$index');
  return _parseNumber(value);
}

int _lineCount(int index) {
  final value = StacRegistry.instance.getValue('giftCardRealCardCount$index');
  final count = _parseNumber(value);
  return count <= 0 ? 1 : count;
}

int _parseNumber(dynamic value) {
  if (value == null) return 0;
  var input = value.toString();
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  for (var i = 0; i < 10; i++) {
    input = input.replaceAll(persian[i], '$i');
    input = input.replaceAll(arabic[i], '$i');
  }
  final normalized = input.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(normalized) ?? 0;
}

String _formatPersianNumber(int value) {
  final raw = value.toString();
  final grouped = raw.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => ',',
  );
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  var output = grouped;
  for (var i = 0; i < 10; i++) {
    output = output.replaceAll(en[i], fa[i]);
  }
  return output;
}

void registerShowGiftCardSelectDateBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardSelectDateBottomSheetActionParser(),
  );
}

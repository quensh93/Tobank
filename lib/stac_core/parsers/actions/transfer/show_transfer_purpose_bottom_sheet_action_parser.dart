import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../custom_navigate_action_parser.dart';

class ShowTransferPurposeBottomSheetActionModel {
  static const int minAmountRial = 10000;

  final String title;
  final String selectedValueKey;
  final String hasValueKey;
  final String amountRawKey;
  final String continueEnabledKey;
  final double heightFactor;
  final List<String> purposes;

  const ShowTransferPurposeBottomSheetActionModel({
    required this.title,
    required this.selectedValueKey,
    required this.hasValueKey,
    required this.amountRawKey,
    required this.continueEnabledKey,
    required this.heightFactor,
    required this.purposes,
  });

  factory ShowTransferPurposeBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final parsedPurposes = <String>[];
    final rawPurposes = json['purposes'];
    if (rawPurposes is List) {
      for (final item in rawPurposes) {
        if (item is String && item.trim().isNotEmpty) {
          parsedPurposes.add(item.trim());
        }
      }
    }

    return ShowTransferPurposeBottomSheetActionModel(
      title: json['title'] as String? ?? 'انتقال بابت:',
      selectedValueKey:
          json['selectedValueKey'] as String? ?? 'transferApiReasonTitle',
      hasValueKey: json['hasValueKey'] as String? ?? 'transferApiHasReason',
      amountRawKey: json['amountRawKey'] as String? ?? 'transferApiAmountRaw',
      continueEnabledKey:
          json['continueEnabledKey'] as String? ??
          'transferApiDetailsContinueEnabled',
      heightFactor: (json['heightFactor'] as num?)?.toDouble() ?? 0.72,
      purposes: parsedPurposes.isNotEmpty
          ? parsedPurposes
          : const [
              'واریز حقوق',
              'امور بیمه خدمات',
              'امور درمانی',
              'امور سرمایه گذاری و بورس',
              'امور ارزی در چهارچوب ضوابط و مقررات',
              'پرداخت قرض و تادیه دیون(قرض الحسنه، بدهی و ...)',
              'امور بازنشستگی',
              'معاملات اموال منقول',
              'معاملات اموال غیر منقول',
              'مدیریت نقدینگی',
              'خرید کالا و خدمات',
              'سایر',
            ],
    );
  }
}

class ShowTransferPurposeBottomSheetActionParser
    extends StacActionParser<ShowTransferPurposeBottomSheetActionModel> {
  const ShowTransferPurposeBottomSheetActionParser();

  @override
  String get actionType => 'showTransferPurposeBottomSheet';

  @override
  ShowTransferPurposeBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowTransferPurposeBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowTransferPurposeBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'transfer_purpose');
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectedPurpose = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final screenHeight = MediaQuery.sizeOf(bottomSheetContext).height;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: SizedBox(
                height: screenHeight * model.heightFactor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      Center(
                        child: Container(
                          width: 56,
                          height: 6,
                          decoration: BoxDecoration(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.35,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        model.title,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: model.purposes.length,
                          separatorBuilder: (_, _) => Divider(
                            height: 1,
                            thickness: 1,
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.22,
                            ),
                          ),
                          itemBuilder: (itemContext, index) {
                            final title = model.purposes[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(itemContext).pop(title);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 19,
                                ),
                                child: Text(
                                  title,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (!context.mounted ||
        selectedPurpose == null ||
        selectedPurpose.trim().isEmpty) {
      return;
    }

    StacRegistry.instance.setValue(model.selectedValueKey, selectedPurpose);
    if (model.hasValueKey.trim().isNotEmpty) {
      StacRegistry.instance.setValue(model.hasValueKey, true);
    }
    final hasAmount =
        _parseAmount(StacRegistry.instance.getValue(model.amountRawKey)) >=
        ShowTransferPurposeBottomSheetActionModel.minAmountRial;
    StacRegistry.instance.setValue(model.continueEnabledKey, hasAmount);
    RegistryNotifier.instance.notify();
  }
}

int _parseAmount(dynamic input) {
  if (input == null) return 0;
  final normalized = _toEnglishDigits(
    input.toString(),
  ).replaceAll(RegExp(r'[^0-9]'), '');
  if (normalized.isEmpty) return 0;
  return int.tryParse(normalized) ?? 0;
}

String _toEnglishDigits(String value) {
  const fa = '۰۱۲۳۴۵۶۷۸۹';
  const ar = '٠١٢٣٤٥٦٧٨٩';
  var output = value;
  for (var i = 0; i < 10; i++) {
    output = output.replaceAll(fa[i], '$i').replaceAll(ar[i], '$i');
  }
  return output;
}

void registerShowTransferPurposeBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowTransferPurposeBottomSheetActionParser(),
  );
}

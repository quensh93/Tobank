import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/registry_notifier.dart';

class ShowTransferTypeBottomSheetActionModel {
  final String title;
  final double heightFactor;
  final String selectedTypeKey;
  final Map<String, dynamic>? onSelectAction;

  const ShowTransferTypeBottomSheetActionModel({
    required this.title,
    required this.heightFactor,
    required this.selectedTypeKey,
    this.onSelectAction,
  });

  factory ShowTransferTypeBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowTransferTypeBottomSheetActionModel(
      title: json['title'] as String? ?? 'روش انتقال خود را انتخاب کنید',
      heightFactor: (json['heightFactor'] as num?)?.toDouble() ?? 0.68,
      selectedTypeKey:
          json['selectedTypeKey'] as String? ?? 'transferApiTransferTypeTitle',
      onSelectAction: json['onSelectAction'] is Map<String, dynamic>
          ? json['onSelectAction'] as Map<String, dynamic>
          : json['onSelectAction'] is Map
          ? Map<String, dynamic>.from(json['onSelectAction'] as Map)
          : null,
    );
  }
}

class ShowTransferTypeBottomSheetActionParser
    extends StacActionParser<ShowTransferTypeBottomSheetActionModel> {
  const ShowTransferTypeBottomSheetActionParser();

  @override
  String get actionType => 'showTransferTypeBottomSheet';

  @override
  ShowTransferTypeBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowTransferTypeBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowTransferTypeBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectedPurpose =
        (StacRegistry.instance.getValue('transferApiReasonTitle') ?? '')
            .toString()
            .trim();
    final amountRaw = (StacRegistry.instance.getValue('transferApiAmountRaw') ??
            '')
        .toString();
    final amount = _parseAmount(amountRaw);
    const satnaMinAmount = 100000000;
    final isInsurancePurpose = selectedPurpose == 'امور بیمه خدمات';

    final options = <_TransferTypeItem>[
      _TransferTypeItem(
        title: 'درون بانکی',
        subtitle: isInsurancePurpose
            ? 'انتقال در لحظه | کارمزد: رایگان'
            : 'برای این انتقال حساب مقصد باید گردشگری باشد.',
        iconAsset: 'assets/icons/ic_gardeshgari.svg',
        enabled: isInsurancePurpose,
      ),
      _TransferTypeItem(
        title: 'پل',
        subtitle: isInsurancePurpose
            ? 'این روش برای انتقال درون بانکی فعال نیست'
            : 'انتقال در لحظه | کارمزد: ۵۰۰۰ ریال',
        iconAsset: 'assets/icons/ic_bank_transfer.svg',
        enabled: !isInsurancePurpose,
      ),
      _TransferTypeItem(
        title: 'پایا',
        subtitle: isInsurancePurpose
            ? 'این روش برای انتقال درون بانکی فعال نیست'
            : 'انتقال امروز تا ۱۹:۴۵ | کارمزد: ۳۰۰۰ ریال',
        iconAsset: 'assets/icons/ic_bank_transfer.svg',
        enabled: !isInsurancePurpose,
      ),
      _TransferTypeItem(
        title: 'ساتنا',
        subtitle: isInsurancePurpose
            ? 'این روش برای انتقال درون بانکی فعال نیست'
            : 'حداقل مبلغ انتقال در هر روز ۱۰۰,۰۰۰,۰۰۰ ریال می‌باشد.',
        iconAsset: 'assets/icons/ic_bank_transfer_dark.svg',
        enabled: !isInsurancePurpose && amount >= satnaMinAmount,
      ),
    ];

    final selectedType = await showModalBottomSheet<String>(
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
                  padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 10),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (itemContext, index) {
                            final item = options[index];
                            final disabled = !item.enabled;
                            final iconAsset = disabled &&
                                    item.iconAsset.contains('ic_bank_transfer')
                                ? 'assets/icons/ic_bank_transfer_disabled.svg'
                                : item.iconAsset;
                            const disabledTextColor = Color(0xFF98A2B3);
                            final titleColor = disabled
                                ? disabledTextColor
                                : colorScheme.onSurface;
                            final subtitleColor = disabled
                                ? disabledTextColor
                                : colorScheme.onSurfaceVariant;

                            return InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: disabled
                                  ? null
                                  : () {
                                      Navigator.of(itemContext).pop(item.title);
                                    },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  color: disabled
                                      ? const Color(0xFFF8F9FB)
                                      : null,
                                  border: Border.all(
                                    color: disabled
                                        ? const Color(0xFFD0D5DD)
                                        : colorScheme.outlineVariant
                                              .withValues(alpha: 0.24),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 46,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: disabled
                                            ? const Color(0xFFF2F4F7)
                                            : colorScheme.surfaceContainerHigh
                                                  .withValues(alpha: 0.65),
                                      ),
                                      child: Opacity(
                                        opacity: disabled ? 0.7 : 1,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            iconAsset,
                                            width: 24,
                                            height: 24,
                                            colorFilter: disabled
                                                ? ColorFilter.mode(
                                                    disabledTextColor,
                                                    BlendMode.srcIn,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            item.title,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: titleColor,
                                                ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            item.subtitle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.4,
                                                  color: subtitleColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

    if (!context.mounted || selectedType == null || selectedType.isEmpty) {
      return;
    }

    if (model.selectedTypeKey.trim().isNotEmpty) {
      StacRegistry.instance.setValue(model.selectedTypeKey, selectedType);
      RegistryNotifier.instance.notify();
    }

    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!context.mounted) return;

    if (model.onSelectAction != null) {
      await Stac.onCallFromJson(model.onSelectAction!, context);
      return;
    }

    await Stac.onCallFromJson(const {
      'actionType': 'navigate',
      'routeName': 'transfer_confirm',
      'navigationStyle': 'push',
    }, context);
  }
}

int _parseAmount(String input) {
  final normalized = _toEnglishDigits(input).replaceAll(RegExp(r'[^0-9]'), '');
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

class _TransferTypeItem {
  final String title;
  final String subtitle;
  final String iconAsset;
  final bool enabled;

  const _TransferTypeItem({
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    required this.enabled,
  });
}

void registerShowTransferTypeBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowTransferTypeBottomSheetActionParser(),
  );
}

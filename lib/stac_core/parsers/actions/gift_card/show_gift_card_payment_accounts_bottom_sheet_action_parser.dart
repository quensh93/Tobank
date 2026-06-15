import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../registry/custom_component_registry.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardPaymentAccountsBottomSheetActionModel {
  final String title;
  final String paymentAmountKey;
  final String walletLabel;
  final int walletBalance;
  final String accountsTitle;
  final String insufficientText;
  final String sufficientText;
  final String chargeButtonText;
  final String continueButtonText;
  final List<GiftCardPaymentAccountItemModel> accounts;
  final Map<String, dynamic>? continueAction;
  final Map<String, dynamic>? chargeAction;

  const ShowGiftCardPaymentAccountsBottomSheetActionModel({
    required this.title,
    required this.paymentAmountKey,
    required this.walletLabel,
    required this.walletBalance,
    required this.accountsTitle,
    required this.insufficientText,
    required this.sufficientText,
    required this.chargeButtonText,
    required this.continueButtonText,
    required this.accounts,
    this.continueAction,
    this.chargeAction,
  });

  factory ShowGiftCardPaymentAccountsBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<GiftCardPaymentAccountItemModel> parseAccounts(dynamic raw) {
      final items = <GiftCardPaymentAccountItemModel>[];
      if (raw is List) {
        for (final item in raw) {
          if (item is Map<String, dynamic>) {
            items.add(GiftCardPaymentAccountItemModel.fromJson(item));
          } else if (item is Map) {
            items.add(
              GiftCardPaymentAccountItemModel.fromJson(
                Map<String, dynamic>.from(item),
              ),
            );
          }
        }
      }
      return items;
    }

    final rawContinueAction = json['continueAction'];
    final rawChargeAction = json['chargeAction'];
    final accounts = parseAccounts(json['accounts']);

    return ShowGiftCardPaymentAccountsBottomSheetActionModel(
      title: json['title'] as String? ?? 'کارت هدیه',
      paymentAmountKey:
          json['paymentAmountKey'] as String? ??
          'giftCardRealSummaryPaymentAmount',
      walletLabel: json['walletLabel'] as String? ?? 'کیف پول',
      walletBalance: (json['walletBalance'] as num?)?.toInt() ?? 226600,
      accountsTitle:
          (json['accountsTitle'] ?? json['accountsLabel']) as String? ??
          'حساب‌ها',
      insufficientText: json['insufficientText'] as String? ?? 'موجودی ناکافی',
      sufficientText: json['sufficientText'] as String? ?? 'موجودی کافی',
      chargeButtonText: json['chargeButtonText'] as String? ?? 'شارژ حساب',
      continueButtonText: json['continueButtonText'] as String? ?? 'ادامه',
      accounts: accounts.isNotEmpty
          ? accounts
          : const [
              GiftCardPaymentAccountItemModel(
                id: 'acc_1',
                title: 'سپرده حقیقی حساب قرض الحسنه جاری حقیقی- ریالی',
                ownerName: 'سید پارسا بنی طبا',
                depositNumber: '۱۱۰.۷۰.۱۶۲۹۸۸.۱',
                availableAmount: 66770,
              ),
              GiftCardPaymentAccountItemModel(
                id: 'acc_2',
                title: 'سپرده حقیقی سپرده سرمایه گذاری کوتاه مدت',
                ownerName: 'توبانک- حقیقی ریالی سید پارسا بنی طبا',
                depositNumber: '۱۱۰.۹۹۹۲.۱۶۲۹۸۸.۱',
                availableAmount: 39148,
              ),
            ],
      continueAction: rawContinueAction is Map<String, dynamic>
          ? rawContinueAction
          : rawContinueAction is Map
          ? Map<String, dynamic>.from(rawContinueAction)
          : null,
      chargeAction: rawChargeAction is Map<String, dynamic>
          ? rawChargeAction
          : rawChargeAction is Map
          ? Map<String, dynamic>.from(rawChargeAction)
          : null,
    );
  }
}

class GiftCardPaymentAccountItemModel {
  final String id;
  final String title;
  final String ownerName;
  final String depositNumber;
  final int availableAmount;

  const GiftCardPaymentAccountItemModel({
    required this.id,
    required this.title,
    required this.ownerName,
    required this.depositNumber,
    required this.availableAmount,
  });

  factory GiftCardPaymentAccountItemModel.fromJson(Map<String, dynamic> json) {
    return GiftCardPaymentAccountItemModel(
      id:
          json['id'] as String? ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: json['title'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      depositNumber: json['depositNumber'] as String? ?? '',

      availableAmount: _parseNumber(json['availableAmount']),
    );
  }
}

class ShowGiftCardPaymentAccountsBottomSheetActionParser
    extends
        StacActionParser<ShowGiftCardPaymentAccountsBottomSheetActionModel> {
  const ShowGiftCardPaymentAccountsBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardPaymentAccountsBottomSheet';

  @override
  ShowGiftCardPaymentAccountsBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardPaymentAccountsBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardPaymentAccountsBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_payment_accounts');
    if (!context.mounted || model.accounts.isEmpty) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final paymentAmount = _parseNumber(
      StacRegistry.instance.getValue(model.paymentAmountKey) ?? 0,
    );

    int selectedIndex = 0;

    final result = await showModalBottomSheet<_GiftCardAccountSelectionResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final maxHeight = MediaQuery.of(bottomSheetContext).size.height * 0.90;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                final selectedAccount = model.accounts[selectedIndex];
                final walletHasBalance = model.walletBalance >= paymentAmount;
                final selectedHasBalance =
                    selectedAccount.availableAmount >= paymentAmount;
                final anyHasBalance = model.accounts.any(
                  (e) => e.availableAmount >= paymentAmount,
                );

                return Container(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: 50,
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
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${_formatPersianNumber(paymentAmount)} ریال',
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDisabledWalletTile(
                          context: statefulContext,
                          isDisabled: !walletHasBalance,
                          label: model.walletLabel,
                          amountLabel:
                              '${_formatPersianNumber(model.walletBalance)} ریال',
                        ),
                        const SizedBox(height: 12),
                        _buildAccountsHeaderTile(
                          context: statefulContext,
                          label: model.accountsTitle,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.separated(
                            itemCount: model.accounts.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final account = model.accounts[index];
                              final selected = selectedIndex == index;
                              final hasBalance =
                                  account.availableAmount >= paymentAmount;
                              final selectedBorderColor = colorScheme.primary;
                              final amountColor = hasBalance
                                  ? colorScheme
                                  .onSurface
                                  : colorScheme.primary;

                              return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  setModalState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    14,
                                    14,
                                    14,
                                    14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: selected
                                          ? selectedBorderColor
                                          : colorScheme.outlineVariant
                                                .withValues(alpha: 0.28),
                                      width: selected ? 1.4 : 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        textDirection: TextDirection.ltr,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildRadio(
                                            selected: selected,
                                            selectedColor: selectedBorderColor,
                                            unselectedColor: colorScheme
                                                .outlineVariant
                                                .withValues(alpha: 0.35),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  account.title,
                                                  textAlign: TextAlign.right,
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: colorScheme
                                                            .onSurface,
                                                        height: 1.8,
                                                      ),
                                                ),
                                                if (account.ownerName
                                                    .trim()
                                                    .isNotEmpty)
                                                  Text(
                                                    account.ownerName,
                                                    textAlign: TextAlign.right,
                                                    style: textTheme.titleMedium
                                                        ?.copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: colorScheme
                                                              .onSurface,
                                                          height: 1.8,
                                                        ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      _metaRow(
                                        label: 'شماره سپرده',
                                        value: account.depositNumber,
                                        textTheme: textTheme,
                                        colorScheme: colorScheme,
                                      ),
                                      const SizedBox(height: 14),
                                      _buildDashedDivider(
                                        color: colorScheme.outlineVariant
                                            .withValues(alpha: 0.35),
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Text(
                                            'قابل برداشت',
                                            style: textTheme.titleSmall
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: hasBalance
                                                      ?  colorScheme
                                                      .onSurface
                                                      : colorScheme.primary,
                                                ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '${_formatPersianNumber(account.availableAmount)} ریال',
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: amountColor,
                                                ),
                                          ),
                                          const Spacer(),
                                          if (!hasBalance)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: colorScheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                              ),
                                              child: Text(
                                                model.insufficientText,
                                                style: textTheme.titleSmall
                                                    ?.copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(bottomSheetContext).pop(
                              _GiftCardAccountSelectionResult(
                                hasEnoughBalance: selectedHasBalance,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                            backgroundColor: colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            anyHasBalance && selectedHasBalance
                                ? model.continueButtonText
                                : model.chargeButtonText,
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

    if (result == null || !context.mounted) return;

    if (result.hasEnoughBalance && model.continueAction != null) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (!context.mounted) return;
      await Stac.onCallFromJson(model.continueAction!, context);
      return;
    }

    if (!result.hasEnoughBalance && model.chargeAction != null) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (!context.mounted) return;
      await Stac.onCallFromJson(model.chargeAction!, context);
    }
  }
}

class _GiftCardAccountSelectionResult {
  final bool hasEnoughBalance;

  const _GiftCardAccountSelectionResult({required this.hasEnoughBalance});
}

Widget _buildDisabledWalletTile({
  required BuildContext context,
  required bool isDisabled,
  required String label,
  required String amountLabel,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final borderColor = isDisabled
      ? colorScheme.outlineVariant.withValues(alpha: 0.25)
      : colorScheme.outlineVariant.withValues(alpha: 0.25);
  final iconBackground = isDisabled
      ? colorScheme.outlineVariant.withValues(alpha: 0.03)
      : colorScheme.outlineVariant.withValues(alpha: 0.07);
  final iconColor = isDisabled
      ? colorScheme.onSurfaceVariant.withValues(alpha: 0.55)
      : colorScheme.onSurfaceVariant;
  final iconBorderColor = colorScheme.outlineVariant.withValues(alpha: 0.25);
  final iconOpacity = isDisabled ? 0.45 : 0.75;
  final textColor = isDisabled
      ? colorScheme.onSurfaceVariant.withValues(alpha: 0.45)
      : colorScheme.onSurfaceVariant;

  return Container(
    height: 68,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,

          ),
          child: Padding(
            padding: const EdgeInsets.all(11),
            child: Opacity(
              opacity: iconOpacity,
              child: SvgPicture.asset(
                'assets/icons/charge_wallet_icon.svg',
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.right,
            style: textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          amountLabel,
          textAlign: TextAlign.left,
          style: textTheme.titleMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAccountsHeaderTile({
  required BuildContext context,
  required String label,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Container(
    height: 68,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: colorScheme.outlineVariant.withValues(alpha: 0.20),
        width: 1,
      ),
    ),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
    ),
  );
}

Widget _buildRadio({
  required bool selected,
  required Color selectedColor,
  required Color unselectedColor,
}) {
  return Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: selected ? selectedColor : unselectedColor,
        width: 1.5,
      ),
    ),
    child: selected
        ? Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedColor,
              ),
            ),
          )
        : null,
  );
}

Widget _metaRow({
  required String label,
  required String value,
  required TextTheme textTheme,
  required ColorScheme colorScheme,
}) {
  return Row(
    textDirection: TextDirection.rtl,
    children: [
      Text(
        label,
        style: textTheme.titleSmall?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.right,
          style: textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    ],
  );
}

Widget _buildDashedDivider({required Color color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      42,
      (_) => Container(width: 4, height: 1, color: color),
    ),
  );
}

int _parseNumber(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();

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

void registerShowGiftCardPaymentAccountsBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardPaymentAccountsBottomSheetActionParser(),
  );
}

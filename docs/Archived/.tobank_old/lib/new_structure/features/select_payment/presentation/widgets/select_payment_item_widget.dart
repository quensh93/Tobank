import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../util/app_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../../widget/ui/dotted_separator_widget.dart';
import '../../../../core/entities/deposits_list_entity.dart';
import '../../../../core/theme/main_theme.dart';

class SelectPaymentItemWidget extends StatefulWidget {
  final bool isSelected;
  final DepositsListEntity depositsData;
  final int amount;
  final bool isSingleCard;

  const SelectPaymentItemWidget({
    required this.depositsData,
    required this.amount,
    required this.isSelected,
    required this.isSingleCard,
    super.key,
  });

  @override
  State<SelectPaymentItemWidget> createState() =>
      _SelectPaymentItemWidgetState();
}

class _SelectPaymentItemWidgetState extends State<SelectPaymentItemWidget> {
  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    if (widget.isSingleCard) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: (widget.isSelected &&
                  (int.parse(widget.depositsData.currentWithdrawAmount) <
                      widget.amount))
              ? MainTheme.of(context).primary.withAlpha(20)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: widget.isSelected
                    ? int.parse(widget.depositsData.currentWithdrawAmount) >=
                            widget.amount
                        ? MainTheme.of(context).secondary
                        : MainTheme.of(context).primary
                    : MainTheme.of(context).onSurfaceVariant),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: ShapeDecoration(
                color: const Color(0xfff2f4f7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Center(
                child: SvgIcon(
                  SvgIcons.loanPaymentSingleCardIcon,
                  size: 24.0,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    widget.depositsData.depositTitle.split('-')[0],
                    // 'حساب توبانکی',
                    textAlign: TextAlign.right,
                    style: MainTheme.of(context).textTheme.titleMedium,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      locale.withdrawable_amount,
                      textAlign: TextAlign.center,
                      style: widget.isSingleCard
                          ? MainTheme.of(context).textTheme.bodyMedium.copyWith(
                              color: int.parse(widget.depositsData
                                          .currentWithdrawAmount) >=
                                      widget.amount
                                  ? MainTheme.of(context).surfaceContainerHigh
                                  : MainTheme.of(context).primary,
                            )
                          : MainTheme.of(context).textTheme.bodyLarge.copyWith(
                              color: int.parse(widget.depositsData
                                          .currentWithdrawAmount) >=
                                      widget.amount
                                  ? MainTheme.of(context).green
                                  : MainTheme.of(context).primary,
                            ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      locale.amount_format(AppUtil.formatMoney(widget.depositsData.currentWithdrawAmount)),
                      textAlign: TextAlign.center,
                      style: widget.isSingleCard
                          ? MainTheme.of(context).textTheme.bodyMedium.copyWith(
                              color: int.parse(widget.depositsData
                                          .currentWithdrawAmount) >=
                                      widget.amount
                                  ? MainTheme.of(context).surfaceContainerHigh
                                  : MainTheme.of(context).primary,
                            )
                          : MainTheme.of(context).textTheme.titleMedium.copyWith(
                              color: int.parse(widget.depositsData
                                          .currentWithdrawAmount) >=
                                      widget.amount
                                  ? MainTheme.of(context).green
                                  : MainTheme.of(context).primary,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            if (int.parse(widget.depositsData.currentWithdrawAmount) <
                widget.amount)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: ShapeDecoration(
                  color: MainTheme.of(context).primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Center(
                  child: Text(
                    locale.insufficient_inventory,
                    textAlign: TextAlign.center,
                    style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: widget.isSelected
                    ? int.parse(widget.depositsData.currentWithdrawAmount) >=
                            widget.amount
                        ? MainTheme.of(context).secondary
                        : MainTheme.of(context).primary
                    : MainTheme.of(context).onSurfaceVariant),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.depositsData.depositTitle,
                    textAlign: TextAlign.right,
                    style: MainTheme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: widget.isSelected
                              ? int.parse(widget.depositsData
                                          .currentWithdrawAmount) >=
                                      widget.amount
                                  ? MainTheme.of(context).secondary
                                  : MainTheme.of(context).primary
                              : MainTheme.of(context).onSurfaceVariant),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 7.5,
                      width: 7.5,
                      decoration: ShapeDecoration(
                        color: widget.isSelected
                            ? int.parse(widget
                                        .depositsData.currentWithdrawAmount) >=
                                    widget.amount
                                ? MainTheme.of(context).secondary
                                : MainTheme.of(context).primary
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  locale.deposit_number,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                    color: MainTheme.of(context).surfaceContainer,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  widget.depositsData.depositNumber,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            if( widget.depositsData.cards != null &&  widget.depositsData.cards!.isNotEmpty)
            Row(
              children: [
                Text(
                  locale.card_number,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                    color: MainTheme.of(context).surfaceContainer,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  widget.depositsData.cards!.first.number,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const DottedSeparatorWidget(),
            Row(
              children: [
                Text(
                  locale.withdrawable_amount,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                    color:
                        int.parse(widget.depositsData.currentWithdrawAmount) >=
                                widget.amount
                            ? MainTheme.of(context).green
                            : MainTheme.of(context).primary,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  locale.amount_format(AppUtil.formatMoney(widget.depositsData.currentWithdrawAmount)),
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                    color:
                        int.parse(widget.depositsData.currentWithdrawAmount) >=
                                widget.amount
                            ? MainTheme.of(context).green
                            : MainTheme.of(context).primary,
                  ),
                ),
                const Spacer(),
                if (int.parse(widget.depositsData.currentWithdrawAmount) <
                    widget.amount)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: ShapeDecoration(
                      color: MainTheme.of(context).primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        locale.insufficient_inventory,
                        textAlign: TextAlign.center,
                        style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

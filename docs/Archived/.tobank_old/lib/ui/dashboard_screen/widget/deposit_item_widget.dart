import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class DepositItemWidget extends StatelessWidget {
  const DepositItemWidget({
    required this.deposit,
    required this.depositBalanceLoading,
    required this.activateIncreaseDepositBalance,
    required this.transferFunction,
    required this.transactionFunction,
    required this.balanceFunction,
    required this.moreFunction,
    required this.addAmountFunction,
    required this.balanceVisibilityFunction,
    super.key,
  });

  final Deposit deposit;
  final bool? depositBalanceLoading;
  final bool activateIncreaseDepositBalance;
  final Function(Deposit deposit) transferFunction;
  final Function(Deposit deposit) transactionFunction;
  final Function(Deposit deposit) balanceFunction;
  final Function(Deposit deposit) moreFunction;
  final Function(Deposit deposit) addAmountFunction;
  final Function(Deposit deposit, bool isHide) balanceVisibilityFunction;

  bool get isDepositBalanceLoading => depositBalanceLoading ?? false;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    SvgIcon(Get.isDarkMode ? SvgIcons.depositBGDark : SvgIcons.depositBG),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(minHeight: 46.0),
                                        child: Center(
                                          child: AnimatedSwitcher(
                                            duration: const Duration(milliseconds: 1500),
                                            layoutBuilder: (currentChild, previousChildren) {
                                              return currentChild ?? Container();
                                            },
                                            transitionBuilder: (child, animation) => FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                            child: deposit.isHideBalance
                                                ? InkWell(
                                                    key: const ValueKey(1),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    onTap: () {
                                                      balanceVisibilityFunction(deposit, false);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '⬤⬤⬤⬤⬤⬤⬤',
                                                            textDirection: TextDirection.ltr,
                                                            style: TextStyle(
                                                                color: ThemeUtil.textTitleColor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16,
                                                                letterSpacing: 2,
                                                                height: 1.4,
                                                                overflow: TextOverflow.ellipsis),
                                                          ),
                                                          // Text(
                                                          //   ' ریال',
                                                          //   style: TextStyle(
                                                          //       fontSize: 14, color: ThemeUtil.textSubtitleColor),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : InkWell(
                                                    key: const ValueKey(2),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    onTap: () {
                                                      balanceVisibilityFunction(deposit, true);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              deposit.balance != null
                                                                  ? AppUtil.formatMoney(deposit.balance)
                                                                  : '-',
                                                              textDirection: TextDirection.ltr,
                                                              style: TextStyle(
                                                                color: ThemeUtil.textTitleColor,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 18,
                                                                fontFamily: 'IranYekan',
                                                                height: 1.4,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   ' ریال',
                                                          //   style: TextStyle(
                                                          //       fontSize: 14, color: ThemeUtil.textSubtitleColor),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      if (deposit.isHideBalance)
                                        Text(
                                          locale.rial,
                                          style: TextStyle(fontSize: 14, color: ThemeUtil.textSubtitleColor),
                                        )
                                      else
                                        Row(
                                          children: [
                                            Text(
                                              locale.rial,
                                              style: TextStyle(fontSize: 14, color: ThemeUtil.textSubtitleColor),
                                            ),
                                            InkWell(
                                              borderRadius: BorderRadius.circular(40.0),
                                              onTap: () {
                                                if (!isDepositBalanceLoading) {
                                                  balanceFunction(deposit);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: isDepositBalanceLoading
                                                    ? SpinKitFadingCircle(
                                                        itemBuilder: (_, int index) {
                                                          return DecoratedBox(
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: context.theme.iconTheme.color,
                                                            ),
                                                          );
                                                        },
                                                        size: 24.0,
                                                      )
                                                    : SvgIcon(
                                                        SvgIcons.refresh,
                                                        colorFilter: ColorFilter.mode(
                                                            context.theme.iconTheme.color!, BlendMode.srcIn),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  Text(
                                    deposit.depositNumber ?? '',
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              const SvgIcon(
                                SvgIcons.gardeshgari,
                                size: 32.0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            deposit.depositTypeTitle ?? '',
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        transactionFunction(deposit);
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.transactionDark : SvgIcons.transaction,
                                size: 28.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            locale.deposit_turn_over,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: ThemeUtil.textTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (activateIncreaseDepositBalance)
                      InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          addAmountFunction(deposit);
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  Get.isDarkMode ? SvgIcons.receiveAmountDark : SvgIcons.receiveAmount,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              locale.deposit_money,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: ThemeUtil.textTitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        transferFunction(deposit);
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.transferAmountDark : SvgIcons.transferAmount,
                                size: 28.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            locale.transfer_money,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: ThemeUtil.textTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        moreFunction(deposit);
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.more,
                                size: 28.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            locale.more,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: ThemeUtil.textTitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

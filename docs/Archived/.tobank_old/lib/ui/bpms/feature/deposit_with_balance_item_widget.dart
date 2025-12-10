import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/app_util.dart';
import '/util/theme/theme_util.dart';
import '../../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../../widget/svg/svg_icon.dart';

class BPMSDepositWithBalanceItemWidget extends StatelessWidget {
  const BPMSDepositWithBalanceItemWidget({
    required this.deposit,
    required this.setSelectedDepositFunction,
    required this.isDepositBalanceLoading,
    required this.balanceFunction,
    required this.selectedDeposit,
    super.key,
  });

  final Deposit deposit;
  final Deposit? selectedDeposit;
  final bool isDepositBalanceLoading;
  final Function() setSelectedDepositFunction;
  final Function() balanceFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: deposit.depositNumber == selectedDeposit?.depositNumber
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            onTap: () {
              setSelectedDepositFunction();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          deposit.depositTitle!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.4,
                          ),
                        ),
                      ),
                      Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: deposit,
                          groupValue: selectedDeposit,
                          onChanged: (Deposit? deposit) {
                            setSelectedDepositFunction();
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.deposit_number,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          deposit.depositNumber ?? '',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.shaba_number,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          deposit.depositIban ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (deposit.cardInfo == null)
                    Container()
                  else
                    const SizedBox(
                      height: 16,
                    ),
                  if (deposit.cardInfo == null)
                    Container()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         locale.card_number,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            AppUtil.splitCardNumber(deposit.cardInfo!.pan ?? '', ' '),
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  const Divider(thickness: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.inventory,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              deposit.balance != null ? AppUtil.formatMoney(deposit.balance) : '-',
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
                            Text(
                              locale.rial,
                              style: TextStyle(fontSize: 14, color: ThemeUtil.textSubtitleColor),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(40.0),
                              onTap: () {
                                if (!isDepositBalanceLoading) {
                                  balanceFunction();
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
                                          context.theme.iconTheme.color!,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/deposit/response/deposit_statement_response_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class DepositTransactionItemWidget extends StatelessWidget {
  const DepositTransactionItemWidget({
    required this.turnOver,
    super.key,
  });

  final TurnOver turnOver;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    int amount = 0;
    bool isPay = false;
    if (turnOver.debtorAmount != null) {
      amount = turnOver.debtorAmount!;
      isPay = true;
    } else if (turnOver.creditorAmount != null) {
      amount = turnOver.creditorAmount!;
      isPay = false;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: ExpandableNotifier(
        controller: turnOver.expandableController,
        child: InkWell(
          onTap: () {
            turnOver.expandableController.toggle();
          },
          child: ScrollOnExpand(
            child: Column(
              children: [
                Expandable(
                  collapsed: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isPay
                                ? SvgIcon(
                                    Get.isDarkMode ? SvgIcons.outDark : SvgIcons.out,
                                  )
                                : SvgIcon(
                                    Get.isDarkMode ? SvgIcons.inDarkIcon : SvgIcons.inIcon,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isPay ? locale.withdrawal : locale.deposit_money,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  height: 1.4,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '${turnOver.date} - ${turnOver.time!.split('.')[0]}',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  height: 1.4,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          locale.amount_format(AppUtil.formatMoney(amount)),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            height: 1.4,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  expanded: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  isPay ? SvgIcons.out : SvgIcons.inIcon,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isPay ? locale.withdrawal :  locale.deposit_money,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      height: 1.4,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    '${turnOver.date} - ${turnOver.time!.split('.')[0]}',
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      height: 1.4,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              locale.amount_format(AppUtil.formatMoney(amount)),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                height: 1.4,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              '${locale.description}:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                height: 1.4,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              turnOver.description ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                height: 1.6,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

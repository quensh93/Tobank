import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/app_util.dart';
import '/util/theme/theme_util.dart';
import '../../../../../model/bpms/parsa_loan/loan_detail.dart';

class ParsaLoanPlanItemWidget extends StatelessWidget {
  const ParsaLoanPlanItemWidget({
    required this.index,
    required this.selectedIndex,
    required this.planData,
    required this.selectedPlanData,
    required this.setSelectedPlanFunction,
    super.key,
  });

  final int index;
  final int? selectedIndex;
  final DepositAverageAmountMonth planData;
  final DepositAverageAmountMonth? selectedPlanData;
  final Function(DepositAverageAmountMonth selectedPlan, int selectedPlanIndex) setSelectedPlanFunction;

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
              color: index == selectedIndex ? context.theme.colorScheme.secondary : context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            onTap: () {
              setSelectedPlanFunction(planData, index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.loan_amount,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            locale.amount_format(AppUtil.formatMoney(planData.maxPrice)),
                            style: ThemeUtil.titleStyle,
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: context.theme.colorScheme.secondary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                  child: Text(
                                    locale.service_fee_text((planData.rateInfo!.percentNumber! * 100).toInt()),
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: context.theme.colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff0079e0).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                  child: Text(
                                    '${planData.monthInfo!.monthNumber} ${locale.monthly}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff0079e0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 24,
                        width: 24,
                        child: Transform.scale(
                          scale: 1.2,
                          transformHitTests: false,
                          child: Theme(
                            data: ThemeData(unselectedWidgetColor: context.theme.dividerColor),
                            child: Radio(
                                activeColor: context.theme.colorScheme.secondary,
                                // fillColor: MaterialStateColor.resolveWith((states) => context.theme.dividerColor),
                                value: planData,
                                groupValue: selectedPlanData,
                                onChanged: (DepositAverageAmountMonth? loanPlanData) {
                                  setSelectedPlanFunction(loanPlanData!, index);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_cash.svg',
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.installment_amount_label,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                locale.amount_format(AppUtil.formatMoney(planData.installmentValue)),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 28,
                        decoration: BoxDecoration(
                          color: context.theme.dividerColor,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_percent_circle.svg',
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.loan_fee,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                locale.amount_format(AppUtil.formatMoney(planData.profitValue)),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

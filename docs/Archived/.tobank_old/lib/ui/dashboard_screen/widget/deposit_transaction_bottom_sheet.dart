import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/enums_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class DepositTransactionBottomSheet extends StatelessWidget {
  const DepositTransactionBottomSheet({required this.deposit, super.key});

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositMainPageController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(locale.deposit_turn_over, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.deposit_number,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            height: 1.4,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          deposit.depositNumber ?? '',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            height: 1.4,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(locale.base_on, style: ThemeUtil.titleStyle),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.setSelectedDepositTransactionFilter(DepositTransactionFilterType.byTime);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: controller.selectedDepositTransactionFilter == DepositTransactionFilterType.byTime
                              ? context.theme.colorScheme.secondary.withOpacity(0.15)
                              : Colors.transparent,
                          border: Border.all(
                              color: controller.selectedDepositTransactionFilter == DepositTransactionFilterType.byTime
                                  ? context.theme.colorScheme.secondary
                                  : context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Radio(
                                  activeColor: context.theme.colorScheme.secondary,
                                  value: DepositTransactionFilterType.byTime,
                                  groupValue: controller.selectedDepositTransactionFilter,
                                  onChanged: (value) {
                                    controller.setSelectedDepositTransactionFilter(value);
                                  }),
                              Text(
                                locale.time_range,
                                style: TextStyle(
                                  color:
                                      controller.selectedDepositTransactionFilter == DepositTransactionFilterType.byTime
                                          ? context.theme.colorScheme.secondary
                                          : ThemeUtil.textSubtitleColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(width: 12.0),
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.setSelectedDepositTransactionFilter(DepositTransactionFilterType.latest10);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: controller.selectedDepositTransactionFilter == DepositTransactionFilterType.latest10
                              ? context.theme.colorScheme.secondary.withOpacity(0.15)
                              : Colors.transparent,
                          border: Border.all(
                              color:
                                  controller.selectedDepositTransactionFilter == DepositTransactionFilterType.latest10
                                      ? context.theme.colorScheme.secondary
                                      : context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Radio(
                                  activeColor: context.theme.colorScheme.secondary,
                                  value: DepositTransactionFilterType.latest10,
                                  groupValue: controller.selectedDepositTransactionFilter,
                                  onChanged: (value) {
                                    controller.setSelectedDepositTransactionFilter(value);
                                  }),
                              Text(
                                locale.last_10_transactions,
                                style: TextStyle(
                                  color: controller.selectedDepositTransactionFilter ==
                                          DepositTransactionFilterType.latest10
                                      ? context.theme.colorScheme.secondary
                                      : ThemeUtil.textSubtitleColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                if (controller.selectedDepositTransactionFilter == DepositTransactionFilterType.byTime)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              locale.from_date,
                              textAlign: TextAlign.start,
                              style: ThemeUtil.titleStyle,
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Text(
                              locale.to_date,
                              textAlign: TextAlign.start,
                              style: ThemeUtil.titleStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          controller.dateRangePicker();
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: TextField(
                                      controller: controller.dateFromController,
                                      enabled: true,
                                      readOnly: true,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'IranYekan',
                                      ),
                                      keyboardType: TextInputType.text,
                                      decoration:  InputDecoration(
                                        filled: false,
                                        hintText: locale.select_hint,
                                        hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgIcon(
                                      SvgIcons.calendar,
                                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  IgnorePointer(
                                    child: TextField(
                                      controller: controller.dateToController,
                                      enabled: true,
                                      readOnly: true,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'IranYekan',
                                      ),
                                      keyboardType: TextInputType.text,
                                      decoration:  InputDecoration(
                                        filled: false,
                                        hintText: locale.select_hint,
                                        hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgIcon(
                                      SvgIcons.calendar,
                                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Container(),
                const SizedBox(height: 40.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.getDepositTransaction(deposit);
                  },
                  isLoading: controller.isDepositTransactionLoading,
                  buttonTitle: locale.confirm_continue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

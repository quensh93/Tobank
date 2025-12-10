import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';
import '../../../../model/deposit/response/customer_deposits_response_data.dart';
import 'deposit_item_widget.dart';

class BPMSDepositPage extends StatelessWidget {
  final Function callback;
  final Function(Deposit) setSelectedDepositFunction;
  final List<Deposit> depositList;
  final Deposit? selectedDeposit;
  final bool isLoading;

  const BPMSDepositPage({
    required this.callback,
    required this.setSelectedDepositFunction,
    required this.depositList,
    required this.selectedDeposit,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.select_deposit_number_for_minimum_balance_average_inquiry,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text(
                    '⬤',
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 10.0,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Flexible(
                    child: Text(
                      locale.loans_only_available_through_short_term_and_qard_hasana_savings_deposits,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        height: 1.4,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text(
                    '⬤',
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 10.0,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Flexible(
                    child: Text(
                      locale.minimum_average_balance_for_loan_is_10_million_riyal_for_6_months,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        height: 1.4,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Expanded(
          child: depositList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                      height: 100,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.no_deposit_found_for_loan_use,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  itemCount: depositList.length,
                  itemBuilder: (context, index) {
                    return BPMSDepositItemWidget(
                      deposit: depositList[index],
                      selectedDeposit: selectedDeposit,
                      setSelectedDepositFunction: setSelectedDepositFunction,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContinueButtonWidget(
                callback: callback,
                isLoading: isLoading,
                buttonTitle:locale.inquiry,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

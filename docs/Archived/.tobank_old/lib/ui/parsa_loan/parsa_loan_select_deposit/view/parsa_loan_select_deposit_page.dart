import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_select_deposit_controller.dart';
import '../../../bpms/feature/deposit_item_widget.dart';

class ParsaLoanSelectDepositPage extends StatelessWidget {
  const ParsaLoanSelectDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanSelectDepositController>(
      builder: (controller) {
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
                    locale.average_balance_and_deposit_opening_time_title,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_success.svg',
                        colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: Text(
                          locale.select_deposit_instruction,
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
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: controller.depositList.isEmpty
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
                          locale.no_deposit_found_message2,
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
                      itemCount: controller.depositList.length,
                      itemBuilder: (context, index) {
                        return BPMSDepositItemWidget(
                          deposit: controller.depositList[index],
                          selectedDeposit: controller.selectedDeposit,
                          setSelectedDepositFunction: controller.setSelectedDeposit,
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
                    callback: () {
                      controller.validateSelectDepositPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        );
      },
    );
  }
}

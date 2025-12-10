import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/open_deposit_controller.dart';
import '../../../../util/app_theme.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/button/previous_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../common/detail_item_widget.dart';

class OpenDepositResultPage extends StatelessWidget {
  const OpenDepositResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OpenDepositController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SvgIcon(
                  SvgIcons.transactionSuccess,
                ),
                const SizedBox(height: 16.0),
                 Text(
                  locale.successful_request,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${controller.selectedDepositType.localName!} ${locale.account_opened_successfully}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DetailItemWidget(
                          value: controller.mainController.authInfoData!.customerNumber ?? '',
                          title: locale.customer_number,
                          showCopyIcon: false,
                          isSecure: false,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(
                          color: context.theme.dividerColor,
                        ),
                        const SizedBox(height: 16.0),
                        DetailItemWidget(
                          value: controller.selectedDepositType.localName!,
                          title: locale.deposit_type_label,
                          showCopyIcon: false,
                          isSecure: false,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(
                          color: context.theme.dividerColor,
                        ),
                        const SizedBox(height: 16.0),
                        DetailItemWidget(
                          value: controller.openDepositResponse.data!.depositId ?? '',
                          title: locale.deposit_number,
                          showCopyIcon: true,
                          isSecure: false,
                          copyClipboardFunction: (value) {
                            controller.copyClipboard(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateDepositResultPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.card_request,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                PreviousButtonWidget(
                  callback: () {
                    Get.back();
                  },
                  buttonTitle: locale.return_to_services,
                  isLoading: controller.isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

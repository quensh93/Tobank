import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/pay_browser/pay_browser_controller.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/svg/svg_icon.dart';

class PayInBrowserWidget extends StatelessWidget {
  const PayInBrowserWidget({
    super.key,
    this.returnDataFunction,
    this.url,
    this.amount,
    this.titleText,
    this.isLoading = false,
  });

  final Function? returnDataFunction;
  final String? url;
  final int? amount;
  final String? titleText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PayBrowserController>(
      init: PayBrowserController(url: url!, returnDataFunction: returnDataFunction),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 16.0,
              ),
              const SvgIcon(SvgIcons.warning),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.pay_with_browser_or_bank_portal,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                shadowColor: Colors.transparent,
                margin: EdgeInsets.zero,
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
                        locale.payable_amount,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        locale.amount_format(AppUtil.formatMoney(amount)),
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  if (controller.isEnable) {
                    returnDataFunction!();
                  }
                },
                isLoading: isLoading,
                buttonTitle: locale.check_payment,
                isEnabled: controller.isEnable,
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

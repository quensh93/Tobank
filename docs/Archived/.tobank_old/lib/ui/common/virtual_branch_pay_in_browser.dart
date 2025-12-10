import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/pay_browser/pay_browser_controller.dart';
import '../../util/app_util.dart';
import '../../widget/button/continue_button_widget.dart';
import 'key_value_widget.dart';

class VirtualBranchPayInBrowserWidget extends StatelessWidget {
  const VirtualBranchPayInBrowserWidget({
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
                height: 24.0,
              ),
              KeyValueWidget(
                keyString: locale.payable_amount,
                valueString: locale.amount_format(AppUtil.formatMoney(amount)),
              ),
              const SizedBox(
                height: 24.0,
              ),
               Text(
                locale.pay_with_browser_or_bank_portal,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
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

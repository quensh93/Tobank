import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/pay_browser/pay_browser_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';

class ContinueRequestPromissoryPayInBrowserWidget extends StatelessWidget {
  const ContinueRequestPromissoryPayInBrowserWidget({
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
              Row(
                children: <Widget>[
                   Expanded(
                    child: Text(
                      locale.amount,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    locale.amount_format(AppUtil.formatMoney(amount)),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
               Text(
                locale.continue_payment_browser_text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  returnDataFunction!();
                },
                isLoading: isLoading,
                buttonTitle: locale.check_payment,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

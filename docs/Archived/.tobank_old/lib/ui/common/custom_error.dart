import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '/widget/button/continue_button_widget.dart';
import '/widget/button/previous_button_widget.dart';

class CustomError extends StatelessWidget {
  const CustomError({
    required this.message,
    required this.retryFunction,
    super.key,
    this.backFunction,
  });

  final String message;
  final Function retryFunction;
  final Function? backFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40.0,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            height: 1.6,
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        ContinueButtonWidget(
          callback: () {
            retryFunction();
          },
          isLoading: false,
          buttonTitle: locale.try_again,
        ),
        const SizedBox(
          height: 16.0,
        ),
        PreviousButtonWidget(
          callback: () {
            if (backFunction == null) {
              Get.back();
            } else {
              backFunction!();
            }
          },
          buttonTitle: locale.return_,
          isLoading: false,
        ),
      ],
    );
  }
}

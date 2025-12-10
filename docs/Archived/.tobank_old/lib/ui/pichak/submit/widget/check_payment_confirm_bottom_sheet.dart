import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class CheckPaymentConfirmBottomSheet extends StatelessWidget {
  const CheckPaymentConfirmBottomSheet({
    required this.confirmFunction,
    required this.denyFunction,
    super.key,
  });

  final VoidCallback confirmFunction;
  final VoidCallback denyFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                height: 16.0,
              ),
              Text(locale.identity_verification_title, style: ThemeUtil.titleStyle),
              const SizedBox(height: 16.0),
              Text(locale.identity_verification_description,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          denyFunction();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: context.theme.dividerColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(
                          locale.cancel,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: context.theme.iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ContinueButtonWidget(
                      callback: () {
                        confirmFunction();
                      },
                      isLoading: false,
                      buttonTitle:locale.continue_label,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Column(
                children: [
                  Image.asset(
                    'assets/images/authentication_success.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    locale.authentication_done_successfully,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ContinueButtonWidget(
                callback: () async {
                  await controller.endEkyc();
                  Future.delayed(Constants.duration500, () {
                    Get.delete<AuthenticationRegisterController>(force: true);
                  });
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
            ],
          ),
        );
      },
    );
  }
}

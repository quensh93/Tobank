import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/automatic_dynamic_pin/automatic_dynamic_pin_active_controller.dart';
import '../common/custom_app_bar.dart';
import 'view/automatic_dynamic_pin_active_verify_page.dart';
import 'view/automatic_dynamic_pin_phone_page.dart';

class AutomaticDynamicPinActiveScreen extends StatelessWidget {
  const AutomaticDynamicPinActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AutomaticDynamicPinActiveController>(
        init: AutomaticDynamicPinActiveController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.automatic_dynamic_password_activation,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: const <Widget>[
                        AutomaticDynamicPinActivePhonePage(),
                        AutomaticDynamicPinActiveVerifyPage()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

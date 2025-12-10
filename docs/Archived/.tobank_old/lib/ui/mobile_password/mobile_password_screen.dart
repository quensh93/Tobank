import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/deposit/modern_banking_change_password_controller.dart';
import '../common/custom_app_bar.dart';
import 'view/mobile_password_confirm_page.dart';
import 'view/mobile_password_result_page.dart';

class MobilePasswordScreen extends StatelessWidget {
  const MobilePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ModernBankingChangePasswordController>(
      init: ModernBankingChangePasswordController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.reset_password_mobile_bank,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          MobilePasswordConfirmPage(),
                          MobilePasswordResultPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

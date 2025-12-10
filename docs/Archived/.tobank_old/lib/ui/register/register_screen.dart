import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/register/register_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/virtual_branch_loading_page.dart';
import 'page/authorization_page.dart';
import 'page/registration_page.dart';
import 'page/rules_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.authentication_title,
                  context: context,
                ),
                body: SafeArea(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.pageController,
                            children: [
                              VirtualBranchLoadingPage(
                                controller.errorTitle,
                                hasError: controller.hasError,
                                isLoading: controller.isLoading,
                                retryFunction: () {
                                  controller.getVirtualBranchRulesRequest();
                                },
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                              const RulesPage(),
                              const AuthorizationPage(),
                              const RegistrationPage(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

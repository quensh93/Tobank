import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign_up/sign_up_controller.dart';
import 'view/login_page.dart';
import 'view/new_password_page.dart';
import 'view/verify_code_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 40.0),
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: const <Widget>[
                            LoginPageWidget(),
                            VerifyCodePageWidget(),
                            NewPasswordPageWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/register/only_register_controller.dart';
import 'view/registration_page.dart';

class OnlyRegisterScreen extends StatelessWidget {
  const OnlyRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnlyRegisterController>(
        init: OnlyRegisterController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              body: SafeArea(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.pageController,
                            children: const [
                              RegistrationPage(),
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

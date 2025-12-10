import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/about_us/about_us_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/about_us_page.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AboutUsController>(
          init: AboutUsController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.about_us,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getAboutUsRequest();
                            },
                          ),
                          const AboutUsPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

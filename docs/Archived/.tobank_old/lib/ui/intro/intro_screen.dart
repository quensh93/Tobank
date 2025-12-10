import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/intro/intro_controller.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import 'page/intro_page.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: SafeArea(
        child: GetBuilder<IntroController>(
            init: IntroController(),
            builder: (controller) {
              return Column(
                children: [
                  Expanded(
                      child: PageView(
                    controller: controller.pageController,
                    children:  [
                      IntroPage(
                        icon: 'assets/icons/intro_1.svg',
                        title: locale.intro_1_title_manage_card,
                        description:
                        locale.intro_1_description_manage_card,
                      ),
                      IntroPage(
                        icon: 'assets/icons/intro_2.svg',
                        title:locale.intro_2_title_open_deposit,
                        description:
                           locale.intro_2_description_open_deposit,
                      ),
                      IntroPage(
                        icon: 'assets/icons/intro_3.svg',
                        title:locale.intro_3_title_internet_bank,
                        description:
                           locale.intro_3_description_internet_bank,
                      ),
                      IntroPage(
                        icon: 'assets/icons/intro_4.svg',
                        title: locale.intro_4_title_virtual_branch,
                        description:
                           locale.intro_4_description_virtual_branch,
                      ),
                    ],
                  )),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller.pageController,
                          count: 4,
                          effect: ExpandingDotsEffect(
                            activeDotColor: ThemeUtil.primaryColor,
                            dotColor: const Color(0xffeaeaea),
                            dotHeight: 12.0,
                            dotWidth: 12.0,
                          ),
                          onDotClicked: (index) {},
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            controller.handleDoneClick();
                          },
                          child: Row(
                            children: [
                              Text(locale.start_button_text,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const SizedBox(width: 8.0),
                              const SvgIcon(SvgIcons.buttonNext),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                ],
              );
            }),
      )),
    );
  }
}

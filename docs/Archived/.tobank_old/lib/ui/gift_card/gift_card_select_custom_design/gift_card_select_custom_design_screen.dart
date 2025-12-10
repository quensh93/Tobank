import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/loading_page.dart';
import 'page/gift_card_image_selector_page.dart';
import 'page/gift_card_message_page.dart';
import 'page/gift_card_select_design_page.dart';

class GiftCardSelectCustomDesignScreen extends StatelessWidget {
  const GiftCardSelectCustomDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<GiftCardSelectDesignController>(
          init: GiftCardSelectDesignController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.gift_card,
                  context: context,
                ),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getEventPlansRequest();
                            },
                          ),
                          const PhysicalGiftCardSelectorPage(),
                          const GiftCardSelectDesignPage(),
                          const GiftCardMessagePage(),
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

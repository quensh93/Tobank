import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_list_controller.dart';
import '../../../model/common/menu_data_model.dart';
import '../../common/custom_app_bar.dart';
import '../../common/loading_page.dart';
import 'page/gift_card_detail_page.dart';
import 'page/gift_card_list_page.dart';

class GiftCardMainScreen extends StatelessWidget {
  const GiftCardMainScreen({super.key, this.menuItemData});

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<GiftCardListController>(
          init: GiftCardListController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: menuItemData != null ? menuItemData!.title! : locale.gift_card,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView(
                                  controller: controller.pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    LoadingPage(
                                      controller.errorTitle,
                                      hasError: controller.hasError,
                                      isLoading: controller.isLoading,
                                      retryFunction: () {
                                        controller.getGiftCardListRequest();
                                      },
                                    ),
                                    const GiftCardListPage(),
                                    const GiftCardDetailViewWidget(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

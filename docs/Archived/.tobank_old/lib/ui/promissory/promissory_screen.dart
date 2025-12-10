import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/promissory/promissory_controller.dart';
import '../../../model/common/menu_data_model.dart';
import '../../../util/enums_constants.dart';
import '../common/custom_app_bar.dart';
import '../common/selector_item_widget.dart';
import '../common/virtual_branch_loading_page.dart';
import 'my_promissory_page.dart';
import 'promissory_service_page.dart';

class PromissoryScreen extends StatelessWidget {
  const PromissoryScreen({super.key, this.menuItemData});

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PromissoryController>(
          init: PromissoryController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.online_promissory,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    if (controller.hasError || controller.isLoading)
                      Expanded(
                        child: VirtualBranchLoadingPage(
                          controller.errorTitle,
                          hasError: controller.hasError,
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          isLoading: controller.isLoading,
                          retryFunction: () {
                            controller.getPromissoryAssetRequest();
                          },
                        ),
                      )
                    else
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            Card(
                              elevation: Get.isDarkMode ? 1 : 0,
                              margin: const EdgeInsets.symmetric(horizontal: 16.0),
                              shadowColor: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SelectorItemWidget(
                                      title: locale.promissory_services,
                                      isSelected:
                                          controller.promissoryMenuType == PromissoryMenuType.promissoryServices,
                                      callBack: () {
                                        controller.showPromissoryServices();
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 24.0,
                                    width: 2.0,
                                    color: context.theme.dividerColor,
                                  ),
                                  Expanded(
                                    child: SelectorItemWidget(
                                      title: locale.my_promissory,
                                      isSelected: controller.promissoryMenuType == PromissoryMenuType.myPromissory,
                                      callBack: () {
                                        controller.showMyPromissory();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Expanded(
                              child: PageView(
                                controller: controller.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: const [
                                  PromissoryServicePage(),
                                  MyPromissoryPage(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

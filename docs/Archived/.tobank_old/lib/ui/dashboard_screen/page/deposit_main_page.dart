import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../common/banner_view.dart';
import '../widget/customer_club_widget.dart';
import '../widget/deposit_list_loading_widget.dart';
import '../widget/tobank_services_widget.dart';

class DepositMainPage extends StatelessWidget {
  const DepositMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositMainPageController>(
        init: DepositMainPageController(),
        autoRemove: false,
        builder: (controller) {
          return SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 16.0),
              if (controller.isLoading || controller.hasError)
                const DepositListLoadingWidget()
              else
                Column(
                  children: [
                    ExpandablePageView(
                        controller: controller.pageController,
                        onPageChanged: (page) {
                          controller.setSelectedDepositIndex(page);
                        },
                        children: List.generate(
                          controller.depositListWidget().length,
                          (index) {
                            return controller.depositListWidget()[index];
                          },
                        )),
                    const SizedBox(height: 12.0),
                    SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.depositWidgetListCount,
                      effect: ScrollingDotsEffect(
                        maxVisibleDots: 7,
                        dotColor: const Color(0xffD0D5DD),
                        activeDotColor: ThemeUtil.primaryColor,
                        dotHeight: 12.0,
                        dotWidth: 12.0,
                      ),
                      onDotClicked: (index) {},
                    ),
                  ],
                ),
              const SizedBox(height: 24.0),
              const TobankServicesWidget(),
              const SizedBox(height: 24.0),
              BannerView(
                bannerData: controller.mainController.menuDataModel.bannerData,
                handleBannerClick: AppUtil.handleBannerClick,
              ),
              CustomerClub(
                showCustomerClubScreen: controller.showCustomerClubScreen,
              ),
              const SizedBox(height: 8.0),
            ],
          ));
        });
  }
}

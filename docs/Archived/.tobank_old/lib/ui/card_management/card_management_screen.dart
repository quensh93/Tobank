import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_management/card_management_controller.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../model/service_item_data.dart';
import '../../util/data_constants.dart';
import '../../util/theme/theme_util.dart';
import '../common/custom_app_bar.dart';
import 'widget/card_service_item_widget.dart';
import 'widget/disabled_card_service_item_widget.dart';
import 'widget/disabled_extra_card_service_item_widget.dart';
import 'widget/extra_card_service_item_widget.dart';

class CardManagementScreen extends StatelessWidget {
  const CardManagementScreen({
    required this.customerCardList,
    required this.bankInfoList,
    required this.customerCard,
    super.key,
  });

  final List<CustomerCard> customerCardList;
  final List<BankInfo> bankInfoList;
  final CustomerCard? customerCard;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardManagementController>(
        init: CardManagementController(
            customerCardList, bankInfoList, customerCard),
        builder: (controller) {
          final List<ServiceItemData> extraCardServices =
              DataConstants.getExtraCardServicesItems(controller.isGardeshgary);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.manage_cards,
                  context: context,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: ExpandablePageView(
                          controller: controller.cardPageController,
                          onPageChanged: (page) {
                            // Notify the controller of the page change
                            controller.onCardChange(page);
                          },
                          children: controller.cardWidgets,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SmoothPageIndicator(
                          controller: controller.cardPageController,
                          count: controller.cardWidgets.length,
                          effect: ScrollingDotsEffect(
                            maxVisibleDots: 7,
                            activeDotColor: ThemeUtil.primaryColor,
                            dotColor: context.theme.iconTheme.color!,
                            dotHeight: 12.0,
                            dotWidth: 12.0,
                          ),
                          onDotClicked: (index) {}),
                      if (!controller.isGardeshgary && !controller.isWallet)
                        Container()
                      else
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                          ),
                          children: controller.isWallet
                              ? List<Widget>.generate(
                                  DataConstants.getWalletServicesItems().length,
                                  (index) {
                                  return CardServiceItemWidget(
                                    serviceItemData: DataConstants
                                        .getWalletServicesItems()[index],
                                    clickedServiceItemData:
                                        controller.clickedServiceItemData,
                                    isLoading:
                                        controller.isReissueCardFeeLoading,
                                    returnDataFunction: (serviceItemData) {
                                      controller.handleCardServiceItemClick(
                                          serviceItemData);
                                    },
                                  );
                                })
                              : List<Widget>.generate(
                                  DataConstants.getCardServicesItems().length,
                                  (index) {
                                    final cardService = DataConstants
                                        .getCardServicesItems()[index];
                                    if (controller.isDisabledGardeshgaryCard(
                                        controller.selectedCustomerCard)) {
                                      // Enable card reissuance even the card is disabled
                                      if (cardService.eventCode == 3) {
                                        return CardServiceItemWidget(
                                          serviceItemData: cardService,
                                          clickedServiceItemData:
                                              controller.clickedServiceItemData,
                                          isLoading: controller
                                              .isReissueCardFeeLoading,
                                          returnDataFunction:
                                              (serviceItemData) {
                                            controller
                                                .handleCardServiceItemClick(
                                                    serviceItemData);
                                          },
                                        );
                                      } else {
                                        return DisabledCardServiceItemWidget(
                                          serviceItemData: cardService,
                                        );
                                      }
                                    } else {
                                      return CardServiceItemWidget(
                                        serviceItemData: cardService,
                                        clickedServiceItemData:
                                            controller.clickedServiceItemData,
                                        isLoading:
                                            controller.isReissueCardFeeLoading,
                                        returnDataFunction: (serviceItemData) {
                                          controller.handleCardServiceItemClick(
                                              serviceItemData);
                                        },
                                      );
                                    }
                                  },
                                ),
                        ),
                      if (!controller.isGardeshgary && !controller.isWallet)
                        const SizedBox(height: 16.0)
                      else
                        Container(),
                      if (controller.isWallet || !showWidget(extraCardServices))
                        Container()
                      else

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: context.theme.dividerColor,
                                  width: 0.5),
                            ),
                            child: GridView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 12.0,
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                              ),
                              children: List<Widget>.generate(
                                  extraCardServices.length, (index) {
                                if (extraCardServices[index].eventCode == 1) {
                                  return const SizedBox.shrink();
                                }
                                //
                                return controller.isDisabledGardeshgaryCard(
                                        controller.selectedCustomerCard)
                                    ? DisabledExtraCardServiceItemWidget(
                                        serviceItemData:
                                            extraCardServices[index],
                                      )
                                    : ExtraCardServiceItemWidget(
                                        serviceItemData:
                                            extraCardServices[index],
                                        returnDataFunction: (serviceItemData) {
                                          controller
                                              .handleExtraCardServicesClick(
                                                  serviceItemData);
                                        },
                                      );
                              }),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        });

  }
  bool showWidget(List<ServiceItemData> extraCardServices){
    if( extraCardServices.isEmpty){
      return false;
    }else{
      bool show = false;
      extraCardServices.forEach((item){
        if(item.eventCode != 1){
          show = true;
        }
      });
      return show;
    }
  }
}

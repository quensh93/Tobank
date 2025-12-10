import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_list_controller.dart';
import '../../../../util/constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../widget/gift_card_item_widget.dart';

class GiftCardListPage extends StatelessWidget {
  const GiftCardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardListController>(builder: (controller) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: (controller.physicalGiftCardDataList.isEmpty && controller.isLoad)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                              height: 200,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              locale.no_purchased_card,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction == ScrollDirection.reverse) {
                            controller.setAddButtonVisible(false);
                          } else if (notification.direction == ScrollDirection.forward) {
                            controller.setAddButtonVisible(true);
                          }
                          return true;
                        },
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
                          itemCount: controller.physicalGiftCardDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GiftCardItemWidget(
                              physicalGiftCardData: controller.physicalGiftCardDataList[index],
                              showDetailFunction: (physicalGiftCardData) {
                                controller.showDetailFunction(physicalGiftCardData);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            child: AnimatedContainer(
              duration: Constants.duration300,
              curve: Curves.fastEaseInToSlowEaseOut,
              height: controller.showAddButton ? 56 : 0,
              width: controller.showAddButton ? 160 : 0,
              child: FloatingActionButton.extended(
                elevation: 0,
                backgroundColor: ThemeUtil.primaryColor,
                onPressed: () {
                  controller.getCostsRequest();
                },
                label: !controller.showAddButton
                    ? Container()
                    : controller.isLoading
                        ? SpinKitFadingCircle(
                            itemBuilder: (_, int index) {
                              return const DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              );
                            },
                            size: 24.0,
                          )
                        :  Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                locale.buy_gift_card,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

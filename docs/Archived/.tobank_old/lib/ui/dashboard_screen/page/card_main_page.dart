import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/card_main_page_controller.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../common/card_wallet_widget.dart';
import '../widget/card_item_loading_widget.dart';
import '../widget/card_item_widget.dart';

class CardMainPage extends StatelessWidget {
  const CardMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardMainPageController>(
        init: CardMainPageController(),
        autoRemove: false,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: controller.isLoading || controller.hasError
                ? const Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      CardItemLoadingWidget(),
                    ],
                  )
                : Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction == ScrollDirection.reverse) {
                            controller.setAddButtonVisible(false);
                          } else if (notification.direction == ScrollDirection.forward) {
                            controller.setAddButtonVisible(true);
                          }
                          return true;
                        },
                        child: CustomScrollView(
                          physics: const ClampingScrollPhysics(),
                          controller: controller.scrollController,
                          clipBehavior: Clip.none,
                          slivers: [
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                height: controller.customerCardList.length > 2 ? 180 : 250,
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final customerCard = controller.customerCardList[index];
                                  final itemPositionOffset = index * controller.itemHeight;
                                  final difference = controller.scrollController.offset -
                                      itemPositionOffset * Constants.cardHeightFactor;
                                  final percent = 1 - (difference / 300);
                                  final cardNumber = controller.customerCardList.length;

                                  double scale = percent;
                                  if (scale > 1.0) scale = 1.0;
                                  if (scale < 0.0) scale = 0.0;
                                  if (index == 0) {
                                    return CardWalletWidget(
                                      scale: scale,
                                      itemHeight: controller.itemHeight,
                                      callback: () {
                                        controller.showCardManagementScreen();
                                      },
                                      showScrollIcon: cardNumber > 3,
                                    );
                                  } else {
                                    return CardItemWidget(
                                      scale: scale,
                                      itemHeight: controller.itemHeight,
                                      customerCard: customerCard,
                                      bankInfoList: controller.bankInfo,
                                      returnDataFunction: (customerCard) {
                                        controller.showCardManagementScreen(customerCard: customerCard);
                                      },
                                    );
                                  }
                                },
                                childCount: controller.customerCardList.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        child: AnimatedContainer(
                          duration: Constants.duration300,
                          curve: Curves.fastEaseInToSlowEaseOut,
                          height: controller.showAddButton ? 56 : 0,
                          width: controller.showAddButton ? 56 : 0,
                          child: !controller.showAddButton
                              ? Container()
                              : FloatingActionButton(
                                  elevation: 1,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  onPressed: () {
                                    controller.showAddCardScreen();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeUtil.primaryColor,
                                    size: 20.0,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/destination_notebook/card_notebook_controller.dart';
import '../../../../util/constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../widget/card_notebook_item.dart';

class CardListPage extends StatelessWidget {
  const CardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardNotebookController>(builder: (controller) {
      return Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          if (controller.notebookCardDataList.isNotEmpty)
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NotificationListener<UserScrollNotification>(
                          onNotification: (notification) {
                            final ScrollDirection direction = notification.direction;
                            if (direction == ScrollDirection.reverse) {
                              controller.setAddButtonVisible(false);
                            } else if (direction == ScrollDirection.forward) {
                              controller.setAddButtonVisible(true);
                            }
                            return true;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            itemCount: controller.notebookCardDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardNotebookItem(
                                customerCard: controller.notebookCardDataList[index],
                                bankInfoList: controller.bankInfoList,
                                selectedCustomerCard: controller.selectedCustomerCard,
                                isDeleteLoading: controller.isDeleteLoading,
                                editCardDataFunction: (customerCard) {
                                  controller.showEditCardPage(customerCard);
                                },
                                deleteCardDataFunction: (customerCard) {
                                  controller.deleteCard(customerCard);
                                },
                                copyToClipboardFunction: controller.copyToClipboard,
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
                      width: controller.showAddButton ? 180 : 0,
                      child: FloatingActionButton.extended(
                        elevation: 6,
                        backgroundColor: ThemeUtil.primaryColor,
                        onPressed: () {
                          controller.showInsertPage();
                        },
                        label: !controller.showAddButton
                            ? Container()
                            :  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SvgIcon(
                                    SvgIcons.add,
                                    size: 24,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    locale.add_destination_card,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                    height: 180,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    locale.no_card_registered,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    locale.add_card_instructions,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.showInsertPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.add_new_card,
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }
}

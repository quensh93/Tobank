import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/constants.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../widget/bill_item_widget.dart';
import '../widget/bill_type_item.dart';

class ListBillPage extends StatelessWidget {
  const ListBillPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<InvoiceController>(builder: (controller) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 56.0,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return BillTypeItemWidget(
                          billTypeData: DataConstants.getBllTypeDataList()[index],
                          selectedBillTypeData: controller.selectedBillTypeData,
                          returnDataFunction: (billTypeData) {
                            controller.setSelectedBillTypeData(billTypeData);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8.0,
                        );
                      },
                      itemCount: DataConstants.getBllTypeDataList().length),
                ),
              ),
              if (controller.isInvoiceListEmpty())
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 16.0,
                      ),
                      Image.asset(
                        Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                        height: 180,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                       locale.you_have_not_registered_receipt,
                        style:
                            TextStyle(color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: NotificationListener<UserScrollNotification>(

                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.reverse) {
                        controller.setAddButtonVisible(false);
                      } else if (notification.direction == ScrollDirection.forward) {
                        controller.setAddButtonVisible(true);
                      }
                      return true;
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: controller.filteredBillDataList!.length,
                      itemBuilder: (BuildContext context, int index) {

//locale
                        final locale = AppLocalizations.of(context)!;
                        return BillItemWidget(
                          billData: controller.filteredBillDataList![index],
                          clickedBillDataItem: controller.selectedBillData,
                          isLoading: controller.isLoading,
                          isDeleteLoading: controller.isDeleteLoading,
                          inquiryFunction: (billData) {
                            controller.inquiryBillRequest(billData);
                          },
                          editBillDataFunction: (billData) {
                            controller.showEditBillDataBottomSheet(billData);
                          },
                          deleteBillDataFunction: (billData) {
                            controller.confirmDeleteBillData(billData);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10.0,
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(
                height: 16.0,
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
                elevation: 6,
                backgroundColor: ThemeUtil.primaryColor,
                onPressed: () {
                  controller.showBillTypeSelectorBottomSheet();
                },
                label: !controller.showAddButton
                    ? Container()
                    :  Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            locale.add_new_bill,
                            style: const TextStyle(color: Colors.white),
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

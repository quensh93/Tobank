import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/tobank_services/tobank_services_controller.dart';
import '/util/app_util.dart';
import '../common/service_item_widget.dart';

class ListTobankServicesPage extends GetView<TobankServicesController> {
  const ListTobankServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppUtil.getCrossAxisCount(context),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        children: controller.virtualBranchMenuItemList.map((menuItemData) {
          return ServiceItemWidget(
            menuItemData: menuItemData,
            selectProcessFunction: (selectedProcess) {
              controller.handleMenuItemClick(selectedProcess);
            },
            isEnroll: true,
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/facility/facility_controller.dart';
import '/util/app_util.dart';
import '../common/service_item_widget.dart';

class ListFacilityPage extends GetView<FacilityController> {
  const ListFacilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
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
    );
  }
}

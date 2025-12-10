import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/services_main_page_controller.dart';
import '../widget/service_item_widget.dart';

class ServicesMainPage extends StatelessWidget {
  const ServicesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesMainPageController>(
        init: ServicesMainPageController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.85,
              ),
              children: List<Widget>.generate(controller.mainController.menuDataModel.paymentServices.length, (index) {
                return ServiceItemWidget(
                  menuItemData: controller.mainController.menuDataModel.paymentServices[index],
                  returnDataFunction: (menuItem) {
                    controller.handleMenuItemClick(menuItem);
                  },
                );
              }),
            ),
          );
        });
  }
}

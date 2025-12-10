import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/notification/notification_controller.dart';
import '../../common/loading_page.dart';
import 'notification_update_list_page.dart';

class NotificationUpdatePage extends StatelessWidget {
  const NotificationUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (controller) {
      return PageView(
        controller: controller.updatePageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoadingPage(
            controller.errorTitle,
            hasError: controller.hasError,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            isLoading: controller.isLoading,
            retryFunction: () {
              controller.getNotificationsRequest();
            },
          ),
          const NotificationUpdateListPage(),
        ],
      );
    });
  }
}

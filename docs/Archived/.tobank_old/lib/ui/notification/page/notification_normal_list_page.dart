import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/notification/notification_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../widget/notification_normal_item.dart';

class NotificationNormalListPage extends StatelessWidget {
  const NotificationNormalListPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<NotificationController>(builder: (controller) {
      return Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          if (controller.notificationNormalDataList.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                    height: 180,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.no_notifications,
                    style: TextStyle(color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: SlidableAutoCloseBehavior(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  itemCount: controller.notificationNormalDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationNormalItemWidget(
                      notificationData: controller.notificationNormalDataList[index],
                      returnDataFunction: (notificationData) {
                        controller.showNotificationDataBottomSheet(
                          notificationData: notificationData,
                        );
                      },
                      deleteDataFunction: (notificationData) {
                        controller.showDeleteNotificationDialog(notificationData);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                ),
              ),
            )
        ],
      );
    });
  }
}

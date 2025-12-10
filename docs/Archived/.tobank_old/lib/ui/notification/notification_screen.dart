import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/notification/notification_controller.dart';
import '../../util/enums_constants.dart';
import '../common/custom_app_bar.dart';
import '../common/selector_item_widget.dart';
import 'page/notification_normal_page.dart';
import 'page/notification_update_page.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<NotificationController>(
          init: NotificationController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.notifications_title,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: Get.isDarkMode ? 1 : 0,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      shadowColor: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: SelectorItemWidget(
                              title:locale.public_notifications,
                              isSelected: controller.currentNotificationType == NotificationType.normal,
                              callBack: () {
                                controller.setNotificationType(NotificationType.normal);
                              },
                            ),
                          ),
                          Container(
                            height: 24.0,
                            width: 2.0,
                            color: context.theme.dividerColor,
                          ),
                          Expanded(
                            child: SelectorItemWidget(
                              title: locale.updates,
                              isSelected: controller.currentNotificationType == NotificationType.update,
                              callBack: () {
                                controller.setNotificationType(NotificationType.update);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          NotificationNormalPage(),
                          NotificationUpdatePage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

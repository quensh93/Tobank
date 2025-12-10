import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard/home_controller.dart';
import '../../../util/log_util.dart';
import '../../../widget/svg/svg_icon.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: Get.find<ApiLogService>().gotoLogHistory,
                    child: const SvgIcon(
                      SvgIcons.tobankRed,
                      size: 18.0,
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      controller.showBranchMapScreen();
                    },
                    borderRadius: BorderRadius.circular(40.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(
                        SvgIcons.map,
                        colorFilter: ColorFilter.mode(
                          context.theme.iconTheme.color!,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      controller.showNotificationScreen();
                    },
                    borderRadius: BorderRadius.circular(40.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.notificationCount() > 0
                          ? SvgIcon(
                              Get.isDarkMode ? SvgIcons.notificationUnreadDark : SvgIcons.notificationUnread,
                            )
                          : SvgIcon(
                              SvgIcons.notification,
                              colorFilter: ColorFilter.mode(
                                context.theme.iconTheme.color!,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     controller.showSoonSnackBar();
                  //   },
                  //   borderRadius: BorderRadius.circular(40.0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: SvgPicture.asset(
                  //       'assets/icons/ic_chart.svg',
                  //       colorFilter: ColorFilter.mode(
                  //         context.theme.iconTheme.color!,
                  //         BlendMode.srcIn,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     controller.showSoonSnackBar();
                  //   },
                  //   borderRadius: BorderRadius.circular(40.0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: SvgPicture.asset(
                  //       'assets/icons/ic_fav.svg',
                  //       colorFilter: ColorFilter.mode(
                  //         context.theme.iconTheme.color!,
                  //         BlendMode.srcIn,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      controller.showSupportScreen();
                    },
                    borderRadius: BorderRadius.circular(40.0),
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.support,
                          colorFilter: ColorFilter.mode(
                            context.theme.iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      );
    });
  }
}

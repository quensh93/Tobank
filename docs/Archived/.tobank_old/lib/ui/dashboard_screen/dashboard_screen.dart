import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../widget/svg/svg_icon.dart';
import 'page/account_page.dart';
import 'page/home_page.dart';
import 'page/report_main_page.dart';
import 'page/transaction_main_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: context.theme.colorScheme.surface,
              statusBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.grey.withOpacity(0.01),
              statusBarIconBrightness: Brightness.dark,
            ),
      child: GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (controller) {
            return Directionality(
                textDirection: TextDirection.rtl,
                child: PopScope(
                  canPop: false,
                  onPopInvokedWithResult: controller.onBackPressed,
                  child: Scaffold(
                    bottomNavigationBar: Container(
                      decoration:
                          BoxDecoration(border: Border(top: BorderSide(color: context.theme.dividerColor, width: 1.5))),
                      child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: SvgIcon(
                              SvgIcons.homeMain,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            activeIcon: SvgIcon(
                              SvgIcons.homeMainSelected,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgIcon(
                              SvgIcons.transactionMain,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            activeIcon: SvgIcon(
                              SvgIcons.transactionMainSelected,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgIcon(
                              SvgIcons.cardboard,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            activeIcon: SvgIcon(
                              SvgIcons.cardboardSelected,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgIcon(
                              SvgIcons.profileMain,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            activeIcon: SvgIcon(
                              SvgIcons.profileMainSelected,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            ),
                            label: '',
                          ),
                        ],
                        currentIndex: controller.currentIndex,
                        onTap: (int index) {
                          controller.setCurrentIndex(index);
                        },
                      ),
                    ),
                    body: SafeArea(
                        child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: controller.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              HomePage(),
                              TransactionMainPage(),
                              ReportMainPage(),
                              AccountPage(),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                ));
          }),
    );
  }
}

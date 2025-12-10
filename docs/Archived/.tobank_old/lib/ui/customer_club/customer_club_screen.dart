import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/customer_club/customer_club_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../../util/theme/theme_util.dart';
import '../common/loading_page.dart';
import 'view/customer_club_web_view_page.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

class CustomerClubScreen extends StatelessWidget {
  const CustomerClubScreen({
    super.key,
    this.menuItemData,
  });

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CustomerClubController>(
          init: CustomerClubController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPressed,
              child: Scaffold(
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      CustomerClubHeaderWidget(
                        showSupportButton: false,
                        hideBackButton: true,
                        returnFunction: () {
                          controller.onBackPressed(false);
                        },
                      ),
                      Expanded(
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            LoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.getShcc();
                              },
                            ),
                            const CustomerClubWebViewPage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class CustomerClubHeaderWidget extends StatelessWidget {
  const CustomerClubHeaderWidget({
    super.key,
    this.returnFunction,
    this.hideBackButton,
    this.showSupportButton = true,
  });

  final Function? returnFunction;
  final bool? hideBackButton;
  final bool showSupportButton;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 80.0,
              ),
              Text(
               locale.tobank_customer_club,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        locale.close,
                        style: context.theme.textTheme.bodyLarge,
                      )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

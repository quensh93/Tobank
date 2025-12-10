import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_requests_history_controller.dart';
import '../../common/custom_app_bar.dart';
import '../../common/loading_page.dart';
import 'page/promissory_requests_history_page.dart';

class PromissoryRequestsHistoryScreen extends StatelessWidget {
  const PromissoryRequestsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PromissoryRequestsHistoryController>(
          init: PromissoryRequestsHistoryController(),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.open_requests,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
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
                                controller.getPromissoryHistoryRequest();
                              },
                            ),
                            const PromissoryRequestsHistoryPage(),
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

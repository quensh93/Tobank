import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_manage/add_card_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/add_card_page.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<AddCardController>(
            init: AddCardController(),
            builder: (controller) {
              return Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.add_new_card,
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
                              isLoading: controller.isBankLoading,
                              retryFunction: () {
                                controller.getListBankDataRequest();
                              },
                            ),
                            const AddCardPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

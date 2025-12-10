import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/pichak/pichak_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'pichak_list_service_page.dart';

class PichakScreen extends StatelessWidget {
  const PichakScreen({super.key, this.menuItemData});

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PichakController>(
          init: PichakController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: menuItemData != null ? menuItemData!.title! :locale.system_pichak,
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
                              controller.getRemoteUserCards();
                            },
                          ),
                          const PichakListServicePage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

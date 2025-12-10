import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/tobank_services/tobank_services_controller.dart';
import '/ui/common/custom_screen.dart';
import '/ui/common/custom_state_page.dart';
import '/util/app_state.dart';
import 'list_tobank_services_page.dart';

class TobankServicesScreen extends GetView<TobankServicesController> {
  const TobankServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return CustomScreen(
      title:locale.tobank_special_services,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          Obx(() {
            final AppState state = controller.state;
            return CustomStatePage(
              state: state,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              retryFunction: () {
                controller.getCustomerInfoRequest(clearServerCache: true);
              },
            );
          }),
          const ListTobankServicesPage(),
        ],
      ),
    );
  }
}

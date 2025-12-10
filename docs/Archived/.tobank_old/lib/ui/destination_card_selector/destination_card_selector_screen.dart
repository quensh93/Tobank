import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/destination_card_selector/destination_card_selector_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/destination_card_selector_page.dart';

class DestinationCardSelectorScreen extends StatelessWidget {
  const DestinationCardSelectorScreen({
    required this.returnDataFunction,
    super.key,
  });

  final Function(String cardNumber,String destinationName) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    //locale
  final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<DestinationCardSelectorController>(
          init: DestinationCardSelectorController(
            returnDataFunction: returnDataFunction,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.select_destination_card,
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
                              controller.getCustomerCardRequest();
                            },
                          ),
                          const DestinationCardSelectorPage(),
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

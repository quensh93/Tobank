import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/source_card_selector/source_card_selector_controller.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'view/source_card_selector_page.dart';

class SourceCardSelectorScreen extends StatelessWidget {
  const SourceCardSelectorScreen({
    required this.returnDataFunction,
    required this.title,
    required this.description,
    required this.isPichak,
    super.key,
    this.checkIsTransfer,
  });

  final Function(CustomerCard customerCard, BankInfo bankInfo) returnDataFunction;
  final String title;
  final String description;
  final bool? checkIsTransfer;
  final bool isPichak;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<SourceCardSelectorController>(
          init: SourceCardSelectorController(
            returnDataFunction: returnDataFunction,
            checkIsTransfer: checkIsTransfer,
            description: description,
            isPichak: isPichak,
          ),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: title,
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
                          const SourceCardSelectorPage(),
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

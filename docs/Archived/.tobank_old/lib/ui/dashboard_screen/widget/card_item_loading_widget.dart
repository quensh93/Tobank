import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/dashboard/card_main_page_controller.dart';
import '../../common/minify_loading_page.dart';

class CardItemLoadingWidget extends StatelessWidget {
  const CardItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardMainPageController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          height: 140,
          child: controller.hasError
              ? MinifyLoadingPage(
                  controller.errorTitle,
                  hasError: controller.hasError,
                  isLoading: false,
                  retryFunction: () {
                    controller.getCustomerCardRequest();
                  },
                )
              : Shimmer.fromColors(
                  baseColor: Colors.blueGrey.withOpacity(0.3),
                  highlightColor: Colors.grey.withOpacity(0.1),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(color: Color(0x141b1f44), offset: Offset(0, 16), blurRadius: 30)],
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

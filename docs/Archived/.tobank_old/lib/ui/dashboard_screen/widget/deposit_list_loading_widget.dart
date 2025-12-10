import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../common/minify_loading_page.dart';

class DepositListLoadingWidget extends StatelessWidget {
  const DepositListLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositMainPageController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          constraints: const BoxConstraints(minHeight: 255),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: context.theme.dividerColor),
          ),
          child: controller.hasError
              ? MinifyLoadingPage(
                  controller.errorTitle,
                  hasError: controller.hasError,
                  isLoading: false,
                  retryFunction: () {
                    controller.getDepositListRequest();
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.blueGrey.withOpacity(0.3),
                    highlightColor: Colors.grey.withOpacity(0.1),
                    child: Card(
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container()),
                  ),
                ),
        ),
      );
    });
  }
}

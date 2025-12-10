import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../controller/parsa_loan/parsa_loan_get_customer_score_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../common/loading_page.dart';

class ParsaLoanGetCustomerScoreLoadingPage extends StatelessWidget {
  const ParsaLoanGetCustomerScoreLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParsaLoanGetCustomerScoreController>(builder: (controller) {
      return (controller.isLoading || controller.hasError)
          ? LoadingPage(
              controller.errorTitle,
              hasError: controller.hasError,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              isLoading: controller.isLoading,
              retryFunction: () {
                controller.inquiryCbs();
              },
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SpinKitFadingCircle(
                        itemBuilder: (_, int index) {
                          return const DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0EBEBE),
                            ),
                          );
                        },
                        size: 200.0,
                      ),
                      Text(
                        controller.getTimer(),
                      ),
                    ],
                  ),
                  Text(
                    controller.descriptionString,
                    textAlign: TextAlign.center,
                    style: ThemeUtil.titleStyle,
                  ),
                ],
              ),
            );
    });
  }
}

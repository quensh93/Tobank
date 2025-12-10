import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/renew_certificate/renew_certificate_controller.dart';
import 'page/expired_certificate_page.dart';
import 'page/generate_certificate_page.dart';
import 'page/renew_certificate_result_page.dart';

class RenewCertificateBottomSheet extends StatelessWidget {
  const RenewCertificateBottomSheet({required this.remainingDays, super.key});

  final int remainingDays;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RenewCertificateController>(
      init: RenewCertificateController(remainingDays: remainingDays),
      builder: (controller) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 36,
                          height: 4,
                          decoration:
                              BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    height: Get.height / 2,
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        if (controller.remainingDays <= 0)
                          const ExpiredCertificatePage()
                        else
                          const GenerateCertificatePage(),
                        const RenewCertificateResultPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

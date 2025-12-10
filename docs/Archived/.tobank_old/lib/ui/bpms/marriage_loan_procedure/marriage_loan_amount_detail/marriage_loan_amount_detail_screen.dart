import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_amount_detail_controller.dart';
import '../../../common/custom_app_bar.dart';

class MarriageLoanAmountDetailScreen extends StatelessWidget {
  const MarriageLoanAmountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanAmountDetailController>(
      init: MarriageLoanAmountDetailController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: CustomAppBar(
              titleString: locale.marriage_loan_amounts,
              context: context,
            ),
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: Stack(
                    children: [
                      WebViewWidget(
                        controller: controller.webViewController,
                        key: controller.webViewKey,
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                            Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer(),
                            ),
                          ),
                      ),
                      if (controller.progress < 100)
                        const Align(
                          child: CircularProgressIndicator(),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

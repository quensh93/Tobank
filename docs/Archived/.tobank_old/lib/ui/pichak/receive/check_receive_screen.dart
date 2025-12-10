import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/check_receive_controller.dart';
import '../../common/custom_app_bar.dart';
import 'page/check_receive_cheque_detail_page.dart';
import 'page/check_receive_cheque_info_page.dart';
import 'page/check_receive_result_page.dart';

class CheckReceiveScreen extends StatelessWidget {
  const CheckReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckReceiveController>(
        init: CheckReceiveController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.cheque_receive,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: const [
                          CheckReceiveChequeInfoPage(),
                          CheckReceiveChequeDetailPage(),
                          CheckReceiveResultPage(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/check_submit_controller.dart';
import '../../common/custom_app_bar.dart';
import 'page/check_submit_cheque_detail_page.dart';
import 'page/check_submit_cheque_info_page.dart';
import 'page/check_submit_confirm_page.dart';
import 'page/check_submit_receiver_page.dart';
import 'page/check_submit_result_page.dart';

class CheckSubmitScreen extends StatelessWidget {
  const CheckSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CheckSubmitController>(
            init: CheckSubmitController(),
            builder: (controller) {
              return PopScope(
                canPop: false,
                onPopInvoked: controller.onBackPress,
                child: Scaffold(
                  appBar: CustomAppBar(
                    titleString: locale.register_cheque,
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
                              CheckSubmitChequeInfoPage(),
                              CheckSubmitChequeDetailPage(),
                              CheckSubmitReceiverPage(),
                              CheckSubmitConfirmPage(),
                              CheckSubmitResultPage(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

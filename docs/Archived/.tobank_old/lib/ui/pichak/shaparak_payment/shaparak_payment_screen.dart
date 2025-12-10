import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/pichak/shaparak_payment_controller.dart';
import '../../common/custom_app_bar.dart';
import 'page/shaparak_payment_card_info_page.dart';

class ShaparakPaymentScreen extends StatelessWidget {
  const ShaparakPaymentScreen({
    required this.returnDataFunction,
    super.key,
  });

  final Function(bool isPay, String? manaId) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<ShaparakPaymentController>(
          init: ShaparakPaymentController(returnDataFunction: returnDataFunction),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString:locale.inventory_transaction,
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
                          ShaparakPaymentCardInfoPage(),
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

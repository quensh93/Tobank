import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../controller/bpms/credit_card_facility/credit_card_add_warranty_controller.dart';
import '../../../../../../util/theme/theme_util.dart';

class CustomerDemandNoteWarrantyWidget extends StatelessWidget {
  const CustomerDemandNoteWarrantyWidget({required this.pageIndex, super.key});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CreditCardAddWarrantyController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            locale.bank_guarantee_info,
            style: TextStyle(
              color: ThemeUtil.textSubtitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),
        ],
      );
    });
  }
}

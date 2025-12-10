import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/bank_info/bank_info_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/ui/dotted_line_widget.dart';

class CustomerAddressBottomSheet extends StatelessWidget {
  const CustomerAddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<BankInfoController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                const SizedBox(height: 24.0),
                Text(
                  locale.address_registered_in_the_bank ,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.address,
                          style:
                              TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          controller.getCustomerAddress(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 36.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             locale.postal_code,
                              style: TextStyle(
                                  color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            Text(
                              controller.getPostalCode(),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.showUpdateAddressScreen();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.edit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/enums_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';

class PhoneMidtermBottomSheet extends StatelessWidget {
  const PhoneMidtermBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<InvoiceController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  locale.bill_type,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    controller.setMobileTermType(MobileTermType.finalTerm);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: context.theme.dividerColor)),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: MobileTermType.finalTerm,
                          groupValue: controller.selectedMobileTermType,
                          onChanged: (dynamic value) {
                            controller.setMobileTermType(value);
                          },
                        ),
                        Text(
                          locale.endterm,
                          style: TextStyle(
                              color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    controller.setMobileTermType(MobileTermType.midTerm);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: context.theme.dividerColor)),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: context.theme.colorScheme.secondary,
                          value: MobileTermType.midTerm,
                          groupValue: controller.selectedMobileTermType,
                          onChanged: (dynamic value) {
                            controller.setMobileTermType(value);
                          },
                        ),
                        Text(
                          locale.midterm,
                          style: TextStyle(
                              color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validatePhoneMidterm();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: controller.confirmButtonTitle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

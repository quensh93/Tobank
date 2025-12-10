import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import 'invoice_type_selector_widget.dart';

class SelectBillTypeBottomSheet extends StatelessWidget {
  const SelectBillTypeBottomSheet({super.key});

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
                Text(locale.bill_inquiry_payment_title, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.bill_selection_instruction,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 24.0,
                ),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  children: List<Widget>.generate(DataConstants.getBillTypeSelectors().length, (index) {
                    return InvoiceTypeSelectorWidget(
                      billTypeData: DataConstants.getBillTypeSelectors()[index],
                      returnDataFunction: (billTypeData) {
                        controller.handleBillTypeDataClick(billTypeData);
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  height: 56.0,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.showInvoiceBarcodeBottomSheet();
                    },
                    child: Text(locale.pay_bill_with_pay_id,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

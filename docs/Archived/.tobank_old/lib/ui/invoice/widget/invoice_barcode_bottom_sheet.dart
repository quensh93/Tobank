import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/button_with_icon.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class InvoiceBarcodeBottomSheet extends StatelessWidget {
  const InvoiceBarcodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<InvoiceController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
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
                  Text(locale.pay_bill_with_pay_id, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    locale.bill_id_label,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: 'IranYekan',
                    ),
                    controller: controller.billIdHasBarcodeController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    textDirection: TextDirection.ltr,
                    onChanged: (value) {
                      controller.update();
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText:locale.bill_id_hint,
                      errorText: controller.isBillIdHasBarcodeValid ? null : locale.invalid_bill_id,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      suffixIcon: TextFieldClearIconWidget(
                        isVisible: controller.billIdHasBarcodeController.text.isNotEmpty,
                        clearFunction: () {
                          controller.billIdHasBarcodeController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.pay_id_label,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    children: <Widget>[
                      TextField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        controller: controller.payIdController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        textDirection: TextDirection.ltr,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.pay_id_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPayIdValid ? null : locale.invalid_pay_id,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 16.0,
                          ),
                          suffixIcon: TextFieldClearIconWidget(
                            isVisible: controller.payIdController.text.isNotEmpty,
                            clearFunction: () {
                              controller.payIdController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  if (controller.billIdHasBarcodeController.text.isEmpty && controller.payIdController.text.isEmpty)
                    ButtonWithIcon(
                      buttonTitle: locale.scan_barcode_bill,
                      buttonIcon: SvgIcons.scanner,
                      onPressed: controller.permissionMessageDialog,
                    )
                  else
                    ContinueButtonWidget(
                      callback: () {
                        controller.validateInvoiceBarcode();
                      },
                      isLoading: controller.isLoading,
                      buttonTitle: locale.inquiry_bill,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class CustomerIdInquiryBottomSheet extends StatelessWidget {
  const CustomerIdInquiryBottomSheet({super.key});

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
                  Text(locale.gas_bill_title, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(locale.subscription_number_label, style: ThemeUtil.titleStyle),
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
                    controller: controller.customerIdController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    textDirection: TextDirection.ltr,
                    onChanged: (value) {
                      controller.update();
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText:locale.subscription_number_hint,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isCustomerIdValid ? null : locale.subscription_number_error,
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
                        isVisible: controller.customerIdController.text.isNotEmpty,
                        clearFunction: () {
                          controller.customerIdController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(locale.bill_name_label, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: controller.titleController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      controller.update();
                    },
                    decoration: InputDecoration(
                      hintText: locale.bill_name_hint,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isTitleValid ? null : locale.bill_name_error,
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
                        isVisible: controller.titleController.text.isNotEmpty,
                        clearFunction: () {
                          controller.titleController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.save_bill_text,
                        style: ThemeUtil.titleStyle,
                      ),
                      Container(
                        color: Colors.transparent,
                        width: 36.0,
                        height: 24.0,
                        child: Transform.scale(
                          scale: 0.7,
                          transformHitTests: false,
                          child: CupertinoSwitch(
                            activeColor: context.theme.colorScheme.secondary,
                            value: controller.isStoreBill,
                            onChanged: (value) {
                              controller.setIsStoreBill(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateCustomerIdInquiry();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: controller.confirmButtonTitle,
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

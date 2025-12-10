import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class DepositTransferAmountPage extends StatelessWidget {
  const DepositTransferAmountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransferController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.amount_to_transfer,
                      style: ThemeUtil.titleStyle,
                    ),
                    Text(
                      controller.getAmountDetail(),
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  onChanged: (value) {
                    controller.validateAmountValue(value, controller.amountDepositController);
                  },
                  controller: controller.amountDepositController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(14),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_rial_transfer_amount,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isAmountDepositValid ? null : locale.valid_amount_error,
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
                      isVisible: controller.amountDepositController.text.isNotEmpty,
                      clearFunction: () {
                        controller.clearAmountTextField();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  locale.regard_or_about_or_paid_for,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showTransactionPurposeBottomSheet();
                  },
                  child: IgnorePointer(
                    child: TextField(
                      enabled: true,
                      readOnly: true,
                      controller: controller.transactionPurposeController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: locale.select_transaction_reason,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isPurposeValid ? null :locale.select_reason_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),

                Text(
                  locale.pay_id,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: controller.referenceNumberController,
                  textAlign: TextAlign.right,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  onChanged: (value) {
                    controller.update();
                  },
                  minLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_pay_id_optional,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.referenceNumberController.text.isNotEmpty,
                      clearFunction: () {
                        controller.referenceNumberController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),



                Text(
                  locale.from_description,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.localDescriptionController,
                  textAlign: TextAlign.right,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  onChanged: (value) {
                    controller.update();
                  },
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.from_description_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.localDescriptionController.text.isNotEmpty,
                      clearFunction: () {
                        controller.localDescriptionController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                 locale.transaction_description,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.transactionDescriptionController,
                  textAlign: TextAlign.right,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  onChanged: (value) {
                    controller.update();
                  },
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.transaction_description_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.transactionDescriptionController.text.isNotEmpty,
                      clearFunction: () {
                        controller.transactionDescriptionController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateTransferAmountPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

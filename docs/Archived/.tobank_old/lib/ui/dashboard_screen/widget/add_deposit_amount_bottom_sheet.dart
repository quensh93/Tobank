import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../model/deposit/response/customer_deposits_response_data.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class AddDepositAmountBottomSheet extends StatelessWidget {
  const AddDepositAmountBottomSheet({
    required this.deposit,
    super.key,
  });

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositMainPageController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
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
                Text(
                  locale.deposit_money,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.deposit_number_for_deposit,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(deposit.depositNumber ?? '',
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.amount,
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
                Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        controller.validateAmountValue(value);
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      controller: controller.depositAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(Constants.amountLength),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.enter_transfer_amount_rial,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.depositAmountValid ? null : locale.invalid_amount_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.depositAmountController.text.isNotEmpty,
                          clearFunction: () {
                            controller.clearAmountTextField();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    if (!controller.isChargeDepositBalanceLoading) {
                      controller.addDepositAmountValidate(deposit: deposit);
                    }
                  },
                  isLoading: controller.isChargeDepositBalanceLoading,
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

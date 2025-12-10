import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/charity/charity_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/ui/dotted_line_widget.dart';
import '../../common/key_value_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class CharityAmountBottomSheetWidget extends StatelessWidget {
  const CharityAmountBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CharityController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
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
                  Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(controller.selectedCharityData!.title ?? '',
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(controller.selectedCharityData!.instituteName ?? '',
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          const SizedBox(height: 16.0),
                          MySeparator(
                            color: context.theme.dividerColor,
                          ),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.collected_amount,
                            valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedCharityData!.paidAmount!)),
                          ),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.required_budget,
                            valueString: locale.amount_format(AppUtil.formatMoney(controller.selectedCharityData!.needAmount!)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    locale.enter_donation_amount,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       locale.donation_amount,
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
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(Constants.amountLength),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          filled: false,
                          hintText:locale.enter_transfer_amount_rial,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.amountValid ? null :locale.invalid_amount_error,
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
                            isVisible: controller.amountController.text.isNotEmpty,
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
                      controller.validate();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle:locale.confirm_donation_button,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

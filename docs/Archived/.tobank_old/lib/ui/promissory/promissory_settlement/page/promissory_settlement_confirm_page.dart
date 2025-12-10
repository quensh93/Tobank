import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_settlement_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/key_value_widget.dart';

class PromissorySettlementConfirmPage extends StatelessWidget {
  const PromissorySettlementConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissorySettlementController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Card(
                  elevation: Get.isDarkMode ? 1 : 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        KeyValueWidget(
                          keyString: locale.unique_promissory_code,
                          valueString: controller.promissoryInfo.promissoryId!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.issuer_name,
                          valueString: controller.promissoryInfo.issuerFullName!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.issuer_national_code,
                          valueString: controller.promissoryInfo.issuerNn!,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.registration_date,
                          valueString: controller.promissoryInfo.creationDate ?? '',
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.commitment_amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.promissoryInfo.amount)),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: locale.settled_amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(
                            (controller.promissoryInfo.amount ?? 0) - (controller.promissoryInfo.remainingAmount ?? 0),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KeyValueWidget(
                      keyString: locale.remaining_amount,
                      valueString: locale.amount_format(AppUtil.formatMoney(controller.promissoryInfo.remainingAmount)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                     Text(
                      locale.instructions_all_promissory_amount,
                      style: const TextStyle(
                        height: 1.6,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
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
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextField(
                          onChanged: (value) {
                            controller.validateAmountValue(value);
                          },
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(Constants.amountLength),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_transfer_amount_rial,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isAmountValid ? null : locale.amount_error,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.setAllAmount();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: ThemeUtil.primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                              child:  Text(
                                locale.total_remaining_amount,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateConfirmPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.settlement,
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

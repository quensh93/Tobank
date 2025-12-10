import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class WalletChargeBottomSheet extends StatelessWidget {
  const WalletChargeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
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
                  Text(locale.charge_wallet, style: ThemeUtil.titleStyle),
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
                      child: SizedBox(
                        width: 300,
                        child: Row(
                          children: [
                            SvgIcon(
                        Get.isDarkMode ? SvgIcons.alertDark : SvgIcons.alertLight,
                              colorFilter: ColorFilter.mode(context.theme.colorScheme.primary, BlendMode.srcIn),
                              size: 16,
                            ),
                            const SizedBox(width: 8), // Add some spacing between icon and text
                            Expanded( // This allows the text to take up available space
                              child: Text(
                                locale.cant_withdraw_wallet_just_use_in_tobank,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, // Ensure it does not exceed two lines
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  height: 1.6,
                                  fontFamily: 'IranYekan',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.charge_amount,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      TextField(
                        onChanged: (value) {
                          controller.validateAmountValue(value);
                        },
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(Constants.amountLength),
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
                          hintText: locale.enter_charge_amount_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isAmountValid ? null : controller.errorMessage,
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
                            isVisible: controller.amountController.text.isNotEmpty,
                            clearFunction: () {
                              controller.clearAmountTextField();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            text: locale.min_amount_of_charge,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 1.6,
                              fontFamily: 'IranYekan',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppUtil.formatMoney(10000),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: locale.balance_limit,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: AppUtil.formatMoney(
                                    controller.mainController.walletDetailData!.data!.maxAmount.toString()),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' ${locale.rial}',
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 3.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(controller.amounts.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: context.theme.dividerColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.setSelectedAmount(controller.amounts[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Center(
                              child: Text(
                                locale.amount_format(AppUtil.formatMoney(controller.amounts[index])),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateCharge();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
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

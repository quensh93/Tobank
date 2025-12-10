import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/request_promissory_controller.dart';
import '../../../../../util/constants.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../../common/text_field_error_widget.dart';

class RequestPromissoryDataPage extends StatelessWidget {
  const RequestPromissoryDataPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RequestPromissoryController>(
      builder: (controller) {
        final isIndividual = controller.selectedReceiverType == PromissoryCustomerType.individual;
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.recipient_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ?locale.national_code_title : locale.national_code,
                          valueString: controller.receiverNationalCodeController.text,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ?  locale.mobile_number : locale.phone_number,
                          valueString: controller.receiverMobileController.text,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        KeyValueWidget(
                          keyString: isIndividual ? locale.full_name : locale.name,
                          valueString: controller.receiverName ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                         Text(
                          locale.promissory_note_info,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              locale.commitment_amount,
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            Text(
                              controller.getAmountDetail(),
                              style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            controller.validateAmountValue(value);
                          },
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(Constants.amountLength),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textDirection: TextDirection.ltr,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.promissory_amount_rial,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
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
                              isVisible: controller.amountController.text.isNotEmpty,
                              clearFunction: () {
                                controller.clearAmountTextField();
                              },
                            ),
                          ),
                        ),
                        if (controller.isAmountValid)
                           Column(
                            children: [
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                locale.minimum_commitment_twenty_million,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          )
                        else
                          TextFieldErrorWidget(
                            isValid: controller.isAmountValid,
                            errorText: locale.valid_amount_error,
                          ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                             Expanded(
                              child: Text(
                                locale.payment_promissory_date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                             Text(
                              locale.due_on_demand,
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            const SizedBox(
                              width: 12.0,
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
                                    value: controller.isOnTime,
                                    onChanged: (dynamic value) {
                                      controller.setIsOnTime(value);
                                    }),
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        if (controller.isOnTime)
                          Container()
                        else
                          InkWell(
                            onTap: () {
                              controller.showSelectDateDialog();
                            },
                            child: Column(
                              children: [
                                IgnorePointer(
                                  child: TextField(
                                    controller: controller.dateController,
                                    enabled: true,
                                    readOnly: true,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'IranYekan',
                                      fontSize: 16.0,
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: locale.select_payment_date,
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                      ),
                                      errorText: controller.isDateValid ? null : locale.enter_select_payment_date,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 16.0,
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgIcon(
                                          SvgIcons.calendar,
                                          colorFilter:
                                              ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                locale.third_party_transfer_possible,
                                style: ThemeUtil.titleStyle,
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: 32.0,
                              height: 20.0,
                              child: Transform.scale(
                                scale: 0.7,
                                transformHitTests: false,
                                child: CupertinoSwitch(
                                  activeColor: context.theme.colorScheme.secondary,
                                  value: controller.isTransferable,
                                  onChanged: (bool value) {
                                    controller.setIsTransferable(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.payment_address,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.paymentAddressController,
                          enabled: isIndividual,
                          readOnly: !isIndividual,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(200),
                          ],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 4,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            hintText: locale.payment_address_hint,
                            errorText:
                                controller.isPaymentAddressValid ? null : locale.payment_address_error,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: TextFieldClearIconWidget(
                              isVisible: controller.paymentAddressController.text.isNotEmpty,
                              clearFunction: () {
                                controller.paymentAddressController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.description_title,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.descriptionController,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 4,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.issue_description_hint,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isDescriptionValid ? null : locale.issue_description_error,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: TextFieldClearIconWidget(
                              isVisible: controller.descriptionController.text.isNotEmpty,
                              clearFunction: () {
                                controller.descriptionController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateDataPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
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

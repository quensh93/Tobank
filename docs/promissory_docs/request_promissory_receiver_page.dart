import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/l10n/gen/app_localizations.dart';
import '../../../../../controller/promissory/request_promissory_controller.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../receiver_type_item_widget.dart';

class RequestPromissoryReceiverPage extends StatelessWidget {
  const RequestPromissoryReceiverPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    // TODO: Check UI
    return GetBuilder<RequestPromissoryController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.recipient_information,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ReceiverTypeItemWidget(
                              title: locale.receiver_type_individual,
                              receiverType: PromissoryCustomerType.individual,
                              selectedReceiverType: controller.selectedReceiverType,
                              setSelectedReceiverType: () {
                                controller.setSelectedReceiverType(PromissoryCustomerType.individual);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: ReceiverTypeItemWidget(
                              title: locale.receiver_type_legal,
                              receiverType: PromissoryCustomerType.company,
                              selectedReceiverType: controller.selectedReceiverType,
                              setSelectedReceiverType: () {
                                controller.setSelectedReceiverType(PromissoryCustomerType.company);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      if (controller.selectedReceiverType == PromissoryCustomerType.individual) ...[
                        Text(
                         locale.national_code_title,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.receiverNationalCodeController,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'IranYekan',
                            fontSize: 16.0,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_receiver_national_code,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isReceiverNationalCodeValid ? null : locale.enter_national_code_error,
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
                              isVisible: controller.receiverNationalCodeController.text.isNotEmpty,
                              clearFunction: () {
                                controller.receiverNationalCodeController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.mobile_number,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.receiverMobileController,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_recipient_mobile_number,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isReceiverMobileValid ? null : locale.enter_value_mobile,
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
                              isVisible: controller.receiverMobileController.text.isNotEmpty,
                              clearFunction: () {
                                controller.receiverMobileController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.birthdate_label,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            controller.showSelectBirthDateDialog();
                          },
                          child: IgnorePointer(
                            child: TextField(
                              controller: controller.birthDateController,
                              enabled: true,
                              readOnly: true,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'IranYekan',
                                fontSize: 16.0,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.reciver_birthday_hint_text,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                errorText:
                                    controller.isBirthdayValid ? null : locale.reciver_birthday_error_text,
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
                                    colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: 32.0,
                              height: 20.0,
                              child: Transform.scale(
                                scale: 0.7,
                                transformHitTests: false,
                                child: CupertinoSwitch(
                                  activeColor: context.theme.colorScheme.secondary,
                                  value: controller.isGardeshgariSelected,
                                  onChanged: (bool value) {
                                    controller.setTourismBankLegal(value);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            const SvgIcon(
                              SvgIcons.gardeshgari,
                              size: 24.0,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Text(locale.select_bank_as_recipient,
                                  style: ThemeUtil.titleStyle, textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.national_code,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.receiverNationalCodeController,
                          readOnly: controller.isGardeshgariSelected,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'IranYekan',
                            fontSize: 16.0,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_receiver_national_identifier,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isReceiverNationalCodeValid ? null : locale.enter_valid_national_code,
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
                              isVisible: controller.receiverNationalCodeController.text.isNotEmpty,
                              clearFunction: () {
                                controller.receiverNationalCodeController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.contact_number,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: controller.receiverMobileController,
                          readOnly: controller.isGardeshgariSelected,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_receiver_contact_number,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isReceiverMobileValid ? null : locale.enter_valid_contact_number,
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
                              isVisible: controller.receiverMobileController.text.isNotEmpty,
                              clearFunction: () {
                                controller.receiverMobileController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 40,
                      ),
                      ContinueButtonWidget(
                        callback: () {
                          controller.validateReceiverPage();
                        },
                        isLoading: controller.isLoading,
                        buttonTitle:locale.continue_label,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

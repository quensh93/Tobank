import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class MilitaryGuaranteePersonInfoPage extends StatelessWidget {
  const MilitaryGuaranteePersonInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeStartController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.beneficiary_identity_info,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            locale.dont_have_national_card,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: 44.0,
                          height: 28.0,
                          child: Transform.scale(
                            scale: 0.8,
                            transformHitTests: false,
                            child: CupertinoSwitch(
                              activeColor: context.theme.colorScheme.secondary,
                              onChanged: (bool value) {
                                controller.setNoNationalCard(value);
                              },
                              value: controller.noNationalCard,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.national_code_title,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.personNationalCodeController,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'IranYekan',
                    fontSize: 16.0,
                  ),
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
                    hintText:locale.enter_national_code,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isPersonNationalCodeValid ? null : locale.national_code_error_message,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.personNationalCodeController.text.isNotEmpty,
                      clearFunction: () {
                        controller.personNationalCodeController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.noNationalCard ? locale.national_id_tracking_number : locale.serial_back_national_id,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: controller.personNationalIdTrackingNumberController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'IranYekan',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: controller.noNationalCard ? TextInputType.number : TextInputType.text,
                      inputFormatters: controller.noNationalCard
                          ? <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ]
                          : <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                            ],
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: controller.noNationalCard
                            ? locale.enter_tracking_code
                            : locale.enter_serial_back_id,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isPersonNationalIdTrackingNumberValid
                            ? null
                            : controller.noNationalCard
                                ?  locale.enter_tracking_code
                                : locale.enter_serial_back_id,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.personNationalIdTrackingNumberController.text.isNotEmpty,
                          clearFunction: () {
                            controller.personNationalIdTrackingNumberController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
                Text(
                  locale.birth_date,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showSelectBirthDateDialog(birthDayId: 1);
                  },
                  child: IgnorePointer(
                    child: TextField(
                      enabled: true,
                      readOnly: true,
                      controller: controller.personBirthDateController,
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
                        hintText: locale.enter_birth_date_beneficiary,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isPersonBirthdayValid ? null : locale.enter_birth_date,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            SvgIcons.calendar,
                            colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                            size: 24,
                          ),
                        ),
                      ),
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
                  controller: controller.personMobileController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  textInputAction: TextInputAction.done,
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
                    hintText: locale.enter_beneficiary_mobile_number,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isPersonMobileValid ? null : locale.enter_valid_mobile_number_value,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.personMobileController.text.isNotEmpty,
                      clearFunction: () {
                        controller.personMobileController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validatePersonInfoPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle:locale.inquiry,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class MilitaryGuaranteePersonAddressPage extends StatelessWidget {
  const MilitaryGuaranteePersonAddressPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeStartController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.beneficiary_residence_info,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.beneficiary_inductee_postal_code,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment:
                      controller.isPersonPostalCodeValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.personPostalCodeController,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.isPersonAddressInquirySuccessful = false;
                          controller.resetPersonAddressInputs();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_postal_code,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isPersonPostalCodeValid ? null : controller.personPostalCodeErrorMessage,
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
                            isVisible: controller.personPostalCodeController.text.isNotEmpty,
                            clearFunction: () {
                              controller.clearPersonPostalCodeTextField();
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      constraints: const BoxConstraints(minWidth: 120.0),
                      height: 56,
                      child: ElevatedButton(
                          onPressed: () {
                            if (!controller.isPostalCodeLoading) {
                              controller.validatePersonPostalCodeInquiry();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ThemeUtil.primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.isPostalCodeLoading
                                ? SpinKitFadingCircle(
                                    itemBuilder: (_, int index) {
                                      return const DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    size: 24.0,
                                  )
                                :   Text(
                              locale.inquiry,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.isPersonAddressInquirySuccessful)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                       locale.province,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personProvinceController,
                        enabled: false,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.please_inquire_beneficiary_postal_code,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPersonProvinceValid ? null : locale.please_inquire_beneficiary_postal_code,
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
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.city,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personCityController,
                        textAlign: TextAlign.right,
                        enabled: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.please_inquire_beneficiary_postal_code,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPersonCityValid ? null : locale.please_inquire_beneficiary_postal_code,
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
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.county,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personTownshipController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText:locale.enter_county_value,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPersonTownshipValid ? null : locale.please_enter_county_value,
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
                            isVisible: controller.personTownshipController.text.isNotEmpty,
                            clearFunction: () {
                              controller.personTownshipController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.main_street_label,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personLastStreetController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_main_street_of_beneficiary,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isPersonLastStreetValid ? null : locale.main_street_error,
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
                            isVisible: controller.personLastStreetController.text.isNotEmpty,
                            clearFunction: () {
                              controller.personLastStreetController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.secondary_street_label,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personSecondLastStreetController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_sub_street_of_beneficiary,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isPersonSecondLastStreetValid ? null : locale.secondary_street_error,
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
                            isVisible: controller.personSecondLastStreetController.text.isNotEmpty,
                            clearFunction: () {
                              controller.personSecondLastStreetController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.plaque_label,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personPlaqueController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.update();
                        },
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_plaque_of_beneficiary,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPersonPlaqueValid ? null : locale.plaque_error,
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
                            isVisible: controller.personPlaqueController.text.isNotEmpty,
                            clearFunction: () {
                              controller.personPlaqueController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.unit_label,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.personUnitController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        minLines: 1,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          controller.update();
                        },
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_unit_of_beneficiary,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPersonUnitValid ? null : locale.unit_error,
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
                            isVisible: controller.personUnitController.text.isNotEmpty,
                            clearFunction: () {
                              controller.personUnitController.clear();
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
                          controller.validatePersonAddressPage();
                        },
                        isLoading: controller.isLoading,
                        buttonTitle: locale.request_submit,
                      ),
                    ],
                  )
                else
                  Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class MilitaryGuaranteeCustomerAddressPage extends StatelessWidget {
  const MilitaryGuaranteeCustomerAddressPage({
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
                  locale.applicant_residence_info,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.applicant_postal_code,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment:
                      controller.isCustomerPostalCodeValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: controller.customerPostalCodeController,
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
                              controller.isCustomerAddressInquirySuccessful = false;
                              controller.resetCustomerAddressInputs();
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.enter_correct_postal_code_value,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isCustomerPostalCodeValid
                                  ? null
                                  : controller.customerPostalCodeErrorMessage,
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
                                isVisible: controller.customerPostalCodeController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.clearCustomerPostalCodeTextField();
                                },
                              ),
                            ),
                          ),
                        ],
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
                              controller.validateCustomerPostalCodeInquiry();
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
                                :  Text(
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
                if (controller.isCustomerAddressInquirySuccessful)
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
                        controller: controller.customerProvinceController,
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
                          hintText: locale.inquire_postal_code_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isCustomerProvinceValid ? null : locale.inquire_postal_code_hint,
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
                        controller: controller.customerCityController,
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
                          hintText: locale.inquire_postal_code_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isCustomerCityValid ? null : locale.inquire_postal_code_hint,
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
                        controller: controller.customerTownshipController,
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
                          hintText: locale.enter_county_value,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isCustomerTownshipValid ? null :locale.please_enter_county_value,
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
                            isVisible: controller.customerTownshipController.text.isNotEmpty,
                            clearFunction: () {
                              controller.customerTownshipController.clear();
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
                        controller: controller.customerLastStreetController,
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
                          hintText: locale.enter_applicant_main_street,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isCustomerLastStreetValid ? null : locale.main_street_error,
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
                            isVisible: controller.customerLastStreetController.text.isNotEmpty,
                            clearFunction: () {
                              controller.customerLastStreetController.clear();
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
                      Column(
                        children: <Widget>[
                          TextField(
                            controller: controller.customerSecondLastStreetController,
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
                              hintText:locale.secondary_street_hint,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isCustomerSecondLastStreetValid
                                  ? null
                                  : locale.secondary_street_error,
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
                                isVisible: controller.customerSecondLastStreetController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.customerSecondLastStreetController.clear();
                                  controller.update();
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
                        locale.plaque_label,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.customerPlaqueController,
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
                          hintText: locale.plaque_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isCustomerPlaqueValid ? null : locale.plaque_error,
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
                            isVisible: controller.customerPlaqueController.text.isNotEmpty,
                            clearFunction: () {
                              controller.customerPlaqueController.clear();
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
                        controller: controller.customerUnitController,
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
                          hintText: locale.enter_applicant_unit,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isCustomerUnitValid ? null : locale.unit_error,
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
                            isVisible: controller.customerUnitController.text.isNotEmpty,
                            clearFunction: () {
                              controller.customerUnitController.clear();
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
                          controller.validateCustomerAddressPage();
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

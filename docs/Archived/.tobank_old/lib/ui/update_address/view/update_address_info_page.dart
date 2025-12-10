import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/update_address/update_address_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class UpdateAddressInfoPage extends StatelessWidget {
  const UpdateAddressInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<UpdateAddressController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.province_city,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 48.0,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${controller.normalizedAddress.province} / ${controller.normalizedAddress.city}',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ),
                  ],
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
                controller: controller.streetController,
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
                  hintText: locale.main_street_hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isStreetValid ? null : locale.main_street_error,
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
                    isVisible: controller.streetController.text.isNotEmpty,
                    clearFunction: () {
                      controller.streetController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.side_street_alley,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.sideStreetController,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.side_street_hint_alley,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isSideStreetValid ? null : locale.side_street_error_alley,
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
                    isVisible: controller.sideStreetController.text.isNotEmpty,
                    clearFunction: () {
                      controller.sideStreetController.clear();
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
                controller: controller.plaqueController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.plaque_hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isPlaqueValid ? null : locale.plaque_error,
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
                    isVisible: controller.plaqueController.text.isNotEmpty,
                    clearFunction: () {
                      controller.plaqueController.clear();
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
                controller: controller.floorSideController,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.unit_hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isFloorSideValid ? null : locale.unit_error,
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
                    isVisible: controller.floorSideController.text.isNotEmpty,
                    clearFunction: () {
                      controller.floorSideController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.floor_label,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.floorController,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.floor_hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isFloorValid ? null : locale.floor_error,
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
                    isVisible: controller.floorController.text.isNotEmpty,
                    clearFunction: () {
                      controller.floorController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.postal_code,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Column(
                children: <Widget>[
                  TextField(
                    readOnly: true,
                    enabled: false,
                    controller: controller.postalCodeController,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: 'IranYekan',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: locale.postal_code_hint,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isPostalCodeValid ? null : locale.enter_correct_postal_code_value,
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
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.landline_number,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                controller: controller.phoneNumberController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.digitsOnly
                ],
                textDirection: TextDirection.ltr,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_landline_number_with_city_code,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isPhoneNumberValid ? null : locale.enter_valid_cell_phone,
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
                    isVisible: controller.phoneNumberController.text.isNotEmpty,
                    clearFunction: () {
                      controller.phoneNumberController.clear();
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
                  controller.validateAddressInfoPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.edit ,
              ),
            ],
          ),
        ),
      );
    });
  }
}

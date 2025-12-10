import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/card_management/card_reissue_start_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../common/text_field_clear_icon_widget.dart';
import '../../../../common/text_field_error_widget.dart';

class CardReissueStartConfirmPage extends StatelessWidget {
  const CardReissueStartConfirmPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<CardReissueStartController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${locale.city}/${locale.county}',
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.provinceCityController,
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
                    filled: true,
                    hintText: locale.inquire_about_postal_code,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isProvinceCityValid ? null : locale.inquire_about_postal_code,
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
                  controller: controller.townshipController,
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
                    hintText: locale.enter_county,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isTownShipValid ? null :locale.enter_county_value,
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
                      isVisible: controller.townshipController.text.isNotEmpty,
                      clearFunction: () {
                        controller.townshipController.clear();
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
                  controller: controller.lastStreetController,
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
                    hintText:locale.main_street_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isLastStreetValid ? null : locale.main_street_error,
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
                      isVisible: controller.lastStreetController.text.isNotEmpty,
                      clearFunction: () {
                        controller.lastStreetController.clear();
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
                  controller: controller.secondLastStreetController,
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
                    errorText: controller.isSecondLastStreetValid ? null :locale.secondary_street_error,
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
                      isVisible: controller.secondLastStreetController.text.isNotEmpty,
                      clearFunction: () {
                        controller.secondLastStreetController.clear();
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
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
                        Radius.circular(8.0),
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
                  controller: controller.unitController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
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
                    errorText: controller.isUnitValid ? null : locale.unit_error,
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
                      isVisible: controller.unitController.text.isNotEmpty,
                      clearFunction: () {
                        controller.unitController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                if (controller.selectedLocation == null)
                  InkWell(
                    onTap: () {
                      controller.showSelectLocationScreen();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add_location_alt_outlined,
                            color: ThemeUtil.primaryColor,
                            size: 24.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                           locale.select_location,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.showSelectLocationScreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${controller.selectedLocation!.latitude.toStringAsFixed(4)}° N,${controller.selectedLocation!.longitude.toStringAsFixed(4)}° E',
                              textDirection: TextDirection.ltr,
                              style: ThemeUtil.titleStyle,
                            ),
                            InkWell(
                              onTap: () {
                                controller.removeSelectedMapLocation();
                              },
                              borderRadius: BorderRadius.circular(32.0),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgIcon(
                                  SvgIcons.delete,
                                  colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.srcIn),
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                TextFieldErrorWidget(
                  isValid: controller.isLocationValid,
                  errorText:locale.location_error,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateConfirmPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_continue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

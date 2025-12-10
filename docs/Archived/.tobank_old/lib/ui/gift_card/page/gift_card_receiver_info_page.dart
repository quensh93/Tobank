import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';
import '../../common/text_field_error_widget.dart';
import '../widget/city_item_widget.dart';
import '../widget/province_item_widget.dart';

class GiftCardSReceiverInfoPage extends StatelessWidget {
  const GiftCardSReceiverInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    locale.i_am_reciever,
                    style: ThemeUtil.titleStyle,
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
                        value: controller.isOwner,
                        onChanged: (bool value) {
                          controller.setOwner(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(thickness: 1),
              const SizedBox(height: 16.0),
              Text(
                locale.name_and_last_name,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.nameController,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_name_and_last_name,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isNameValid ? null : locale.enter_the_value_of_name_and_last_name,
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
                  suffixIcon: controller.nameController.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              controller.nameController.clear();
                              controller.update();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                )),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                locale.reciver_mobile,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: controller.mobileController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
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
                      hintText: locale.enter_reciver_mobile,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isMobileValid ? null : locale.enter_value_mobile,
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
                      suffixIcon: controller.mobileController.text.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: () {
                                  controller.mobileController.clear();
                                  controller.update();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 12,
                                    )),
                              ),
                            )
                          : const SizedBox(
                              width: 0,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                locale.province,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.toggleProvinceListShowing();
                },
                child: Container(
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              controller.selectedProvince != null
                                  ? controller.selectedProvince!.name!
                                  : locale.select_province,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: controller.selectedProvince != null
                                    ? ThemeUtil.textTitleColor
                                    : ThemeUtil.textSubtitleColor,
                                fontWeight: controller.selectedProvince != null ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: controller.isShowProvinceList
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: context.theme.iconTheme.color,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: context.theme.iconTheme.color,
                              ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              if (controller.isShowProvinceList)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                        bottom: Radius.circular(8),
                      ),
                      color: context.theme.colorScheme.surface),
                  constraints: const BoxConstraints(maxHeight: 160),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.cityProvinceDataModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProvinceItemWidget(
                        cityProvinceDataModel: controller.cityProvinceDataModelList[index],
                        selectedCityProvinceDataModel: controller.selectedProvince,
                        returnDataFunction: (cityProvinceDataModel) {
                          controller.setSelectedProvince(cityProvinceDataModel);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(thickness: 1);
                    },
                  ),
                )
              else
                Container(),
              TextFieldErrorWidget(
                isValid: controller.isProvinceValid,
                errorText: locale.error_select_province,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                locale.city,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.toggleCityListShowing();
                },
                child: Container(
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              controller.selectedCity != null ? controller.selectedCity!.name! : locale.select_city,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.selectedCity != null
                                    ? ThemeUtil.textTitleColor
                                    : ThemeUtil.textSubtitleColor,
                                fontWeight: controller.selectedCity != null ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: controller.isShowCityList
                            ? Icon(
                                Icons.keyboard_arrow_up,
                                color: context.theme.iconTheme.color,
                              )
                            : Icon(
                                Icons.keyboard_arrow_down,
                                color: context.theme.iconTheme.color,
                              ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              if (controller.isShowCityList)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                        bottom: Radius.circular(8),
                      ),
                      color: context.theme.colorScheme.surface),
                  constraints: const BoxConstraints(maxHeight: 160),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CityItemWidget(
                        city: controller.cityDataModelList![index],
                        selectedCity: controller.selectedCity,
                        returnDataFunction: (city) {
                          controller.setSelectedCity(city);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemCount: controller.cityDataModelList!.length,
                  ),
                )
              else
                Container(),
              TextFieldErrorWidget(
                isValid: controller.isCityValid,
                errorText: locale.choose_city,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                locale.reciver_postal_code,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
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
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_postal_code,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isPostalCodeValid ? null : locale.enter_postal_code_value,
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
                    isVisible: controller.postalCodeController.text.isNotEmpty,
                    clearFunction: () {
                      controller.postalCodeController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.reciver_postal_address,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.addressController,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_postal_address,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isAddressValid ? null : locale.enter_postal_address_value,
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
                  suffixIcon: controller.addressController.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              controller.addressController.clear();
                              controller.update();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                )),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                ),
              ),
              const SizedBox(
                height: 16.0,
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
                                Get.isDarkMode ? SvgIcons.deleteDark : SvgIcons.delete,
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
                errorText: locale.location_error,
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSixthPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
            ],
          ),
        ),
      );
    });
  }
}

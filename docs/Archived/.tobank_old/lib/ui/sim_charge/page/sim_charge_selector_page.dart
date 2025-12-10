import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/sim_charge/sim_charge_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/fav_contact_item.dart';
import '../../common/text_field_clear_icon_widget.dart';

class SimChargeSelectorPage extends StatelessWidget {
  const SimChargeSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SimChargeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              locale.cell_phone_number,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              crossAxisAlignment: controller.isPhoneNumberValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      controller.update();
                      if (value.length >= 4) {
                        controller.detectOperator(value.substring(0, 4));
                      }
                    },
                    controller: controller.phoneNumberController,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(11),
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
                      hintText: locale.like_09123456789,
                      hintStyle: ThemeUtil.hintStyle,
                      errorText: controller.isPhoneNumberValid ? null : locale.enter_valid_cell_phone,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
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
                ),
                const SizedBox(
                  width: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.setMinePhoneNumber();
                  },
                  child: Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgIcon(
                          Get.isDarkMode ? SvgIcons.userProfileDark : SvgIcons.userProfile,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                if(!kIsWeb)
                InkWell(
                  onTap: () {
                    controller.showSelectContactScreen();
                  },
                  child: Card(
                    elevation: Get.isDarkMode ? 1 : 0,
                    shadowColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: SizedBox(
                      height: 56.0,
                      width: 56.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgIcon(
                          Get.isDarkMode ? SvgIcons.contactListDark : SvgIcons.contactList,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: controller.showFavList()
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(locale.sim_cards, style: ThemeUtil.titleStyle),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return FavContactItem(
                                  storedContactData: controller.storedContactDataList[index],
                                  returnDataFunction: (storedContactData) {
                                    controller.setSelectedPhoneNumberFav(storedContactData);
                                  },
                                  removeDataFunction: (storedContactData) {
                                    controller.removeContactLocalStorage(storedContactData);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                );
                              },
                              itemCount: controller.storedContactDataList.length),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(
                            thickness: 1,
                            height: 0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.save_sim_card_number,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                                  value: controller.isStorePhone,
                                  onChanged: (bool value) {
                                    controller.setIsStorePhone(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            if (!controller.showFavList())
              ContinueButtonWidget(
                callback: () {
                  controller.validatePhoneSelectorPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              )
            else
              Container(),
          ],
        ),
      );
    });
  }
}

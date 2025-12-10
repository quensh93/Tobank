import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../common/gift_card_item_label.dart';

class GiftCardMessagePage extends StatelessWidget {
  const GiftCardMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardSelectDesignController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          locale.gift_card,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        InkWell(
                          onTap: () {
                            controller.showHelpBottomSheet();
                          },
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgIcon(
                              Get.isDarkMode ? SvgIcons.alertDark : SvgIcons.alertLight,
                              colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      onChanged: (value) {
                        controller.update();
                      },
                      controller: controller.cardTitleController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(40),
                      ],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 2,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.write_custom_text_40char,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isTitleValid ? null : locale.text_length_error_40char,
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
                          isVisible: controller.cardTitleController.text.isNotEmpty,
                          clearFunction: () {
                            controller.cardTitleController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          locale.default_replacement_text,
                          style: ThemeUtil.titleStyle,
                        ),
                        Text(
                          locale.required_field_star,
                          style: TextStyle(
                            color: ThemeUtil.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.messageGiftCardList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GiftCardItemLabelWidget(
                          messageData: controller.messageGiftCardList[index],
                          selectedMessageData: controller.selectedMessageData,
                          returnDataFunction: (messageData) {
                            controller.setSelectedMessageData(messageData);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12.0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ContinueButtonWidget(
              callback: () {
                controller.validateAlternative();
              },
              isLoading: controller.isLoading,
              buttonTitle:locale.continue_label,
              isEnabled: controller.selectedMessageData != null,
            ),
          ],
        ),
      );
    });
  }
}

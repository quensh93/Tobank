import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../../../util/app_theme.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class PhysicalGiftCardSelectorPage extends StatelessWidget {
  const PhysicalGiftCardSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardSelectDesignController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          locale.place_photo_in_frame,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        controller.selectAndSendImage();
                      },
                      child: controller.selectedCustomImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: context.theme.dividerColor, width: 2),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgIcon(
                                          SvgIcons.gardeshgaryTextLogo,
                                          size: 24.0,
                                        ),
                                        SvgIcon(
                                          SvgIcons.shetab,
                                          size: 28.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Image.file(
                                        controller.selectedCustomImage!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      const Column(
                                        children: [
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                    color: AppTheme.giftCardTitle,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: context.theme.dividerColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                child: Text(
                                  locale.select_photo_from_gallery,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16.0),
                    MySeparator(color: context.theme.dividerColor),
                    const SizedBox(height: 16.0),
                    Text(
                     locale.gift_card_text,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: controller.cardTitleController,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(40),
                      ],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 3,
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.write_custom_text_40char,
                        errorText: controller.isTitleValid ? null : locale.text_length_error_40char,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
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
                          isVisible: controller.cardTitleController.text.isNotEmpty,
                          clearFunction: () {
                            controller.cardTitleController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContinueButtonWidget(
              callback: () {
                controller.validateImageSelectorPage();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.continue_label,
            ),
          ),
        ],
      );
    });
  }
}

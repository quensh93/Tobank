import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/destination_notebook/card_notebook_controller.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class AddCardNotebookBottomSheet extends StatelessWidget {
  const AddCardNotebookBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardNotebookController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.currentOperationType == OperationType.insert ? locale.add_new_card : locale.edit_card,
                        style: ThemeUtil.titleStyle),
                    if (!kIsWeb)
                      ElevatedButton(
                        onPressed: () {
                          controller.showCardScannerScreen();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: context.theme.iconTheme.color!,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgIcon(
                              SvgIcons.scanner,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              locale.scan_card,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: context.theme.iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.card_number,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textDirection: TextDirection.ltr,
                  controller: controller.cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'IranYekan',
                    fontSize: 16.0,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_card_number,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.cardNumberValid ? null : locale.enter_card_number,
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
                      isVisible: controller.cardNumberController.text.isNotEmpty,
                      clearFunction: () {
                        controller.cardNumberController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.card_title,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.customerController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_card_title,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isTitleValid ? null : locale.enter_card_title,
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
                      isVisible: controller.customerController.text.isNotEmpty,
                      clearFunction: () {
                        controller.customerController.clear();
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
                    controller.validate();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: controller.currentOperationType == OperationType.insert ? locale.submit_button : locale.edit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

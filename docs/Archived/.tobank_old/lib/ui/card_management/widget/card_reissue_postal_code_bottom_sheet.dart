import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class CardReissuePostalCodeBottomSheet extends StatelessWidget {
  const CardReissuePostalCodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
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
                  Text(locale.reissue_request_title, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgIcon(
                        SvgIcons.success,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Flexible(
                        child: Text(locale.card_info_change_message,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgIcon(
                        SvgIcons.success,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Flexible(
                        child: Text(locale.reissue_fee_message,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgIcon(
                        SvgIcons.success,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 16,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Flexible(
                        child:
                            Text(locale.reissue_fee_amount_message(AppUtil.formatMoney(controller.reissueFee)),
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    locale.postal_code,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: controller.postalCodeController,
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
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                controller.update();
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.enter_your_postal_code,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                                errorText: controller.isPostalCodeValid ? null : controller.postalCodeErrorMessage,
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
                                  isVisible: controller.postalCodeController.text.isNotEmpty,
                                  clearFunction: () {
                                    controller.postalCodeController.clear();
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      if (!controller.isPostalCodeLoading) {
                        controller.validateCustomerAddressInquiry();
                      }
                    },
                    isLoading: controller.isPostalCodeLoading,
                    buttonTitle: locale.inquiry,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

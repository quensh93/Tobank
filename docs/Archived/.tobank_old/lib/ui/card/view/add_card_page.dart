import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_manage/add_card_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/button_with_icon.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AddCardController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    children: [
                      Text(
                       locale.covered_origin_banks_to_banks_in_country,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 80,
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SvgPicture.network(
                                    AppUtil.baseUrlStatic() + controller.bankInfoList![index].symbol!,
                                    semanticsLabel: '',
                                    placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                                    height: 36.0,
                                    width: 36.0,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    controller.bankInfoList![index].title!,
                                    style: TextStyle(
                                      color: ThemeUtil.textSubtitleColor,
                                      fontSize: 12.0,
                                    ),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10.0,
                              );
                            },
                            itemCount: controller.bankInfoList!.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ///Need test on IOS
              if (!kIsWeb)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ButtonWithIcon(
                      buttonTitle: locale.scan_card,
                      buttonIcon: SvgIcons.scanner,
                      onPressed: controller.showCardScannerScreen,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              else
                Container(),
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
                onChanged: (value) {
                  if (value.length == Constants.cardNumberWithDashLength) {
                    controller.showExpireDateBottomSheet();
                  }
                  controller.update();
                },
                inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_your_card_number,
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
                locale.card_expiration_date,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              InkWell(
                onTap: () {
                  controller.showExpireDateBottomSheet();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: IgnorePointer(
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          controller: controller.monthController,
                          textInputAction: TextInputAction.next,
                          enabled: true,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.month,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.cardExpMonthValid ? null : locale.invalid_value,
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
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: IgnorePointer(
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          controller: controller.yearController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          enabled: true,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.year,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.cardExpYearValid ? null : locale.invalid_value,
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
                      ),
                    )
                  ],
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
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                controller: controller.titleController,
                onChanged: (value) {
                  controller.update();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText:locale.enter_card_title,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isTitleValid ? null :locale.enter_card_title,
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
                    isVisible: controller.titleController.text.isNotEmpty,
                    clearFunction: () {
                      controller.titleController.clear();
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
                buttonTitle: locale.save_card,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}

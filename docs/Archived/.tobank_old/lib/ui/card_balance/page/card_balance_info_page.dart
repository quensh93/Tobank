import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_balance/card_balance_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';

class CardBalanceInfoPage extends StatelessWidget {
  const CardBalanceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardBalanceController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  locale.card_number,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showSelectSourceCardScreen();
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      IgnorePointer(
                        child: TextField(
                          enabled: true,
                          readOnly: true,
                          controller: controller.sourceCardController,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.card_placeholder,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isSourceCardNumberValid ? null : locale.enter_card_number,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 60.0,
                              vertical: 16.0,
                            ),
                          ),
                        ),
                      ),
                      if (controller.sourceCardSymbol != null)
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.network(
                                AppUtil.baseUrlStatic() + controller.sourceCardSymbol!,
                                semanticsLabel: '',
                                height: 30.0,
                                width: 30.0,
                                placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
                                  itemBuilder: (_, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.theme.iconTheme.color,
                                      ),
                                    );
                                  },
                                  size: 24.0,
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              SvgIcon(
                                SvgIcons.switchCard,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            SvgIcons.cardDown,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.expiration_date,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showExpireDateBottomSheet();
                  },
                  child: IgnorePointer(
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'IranYekan',
                      ),
                      controller: controller.expireDateController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: '${locale.month}/${locale.year}',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isCardExpValid ? null :locale.invalid_value,
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
                  height: 16.0,
                ),
                Text(
                  locale.cvv2,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: controller.cvv2Controller,
                      textAlign: TextAlign.right,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      onChanged: (String? str) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText:locale.enter_cvv2,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isCvvValid ? null : locale.enter_cvv2_password,
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
                          isVisible: controller.cvv2Controller.text.isNotEmpty,
                          clearFunction: () {
                            controller.cvv2Controller.clear();
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
                  locale.dynamic_password,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            textDirection: TextDirection.ltr,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            autofillHints: const [AutofillHints.oneTimeCode],
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            textInputAction: TextInputAction.done,
                            controller: controller.passwordController,
                            onChanged: (String? str) {
                              controller.update();
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText:locale.enter_dynamic_password,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isPasswordValid ? null : locale.enter_validate_password,
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
                                isVisible: controller.passwordController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.passwordController.clear();
                                  controller.update();
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
                    Expanded(
                      child: SizedBox(
                        height: 56.0,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            controller.requestOpt();
                          },
                          child: controller.isLoadingOtp
                              ? SpinKitFadingCircle(
                                  itemBuilder: (_, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.theme.iconTheme.color,
                                      ),
                                    );
                                  },
                                  size: 16.0,
                                )
                              : Text(
                                  controller.counter <= 0 ? locale.dynamic_password : controller.getMinutesAndSecond(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: context.theme.iconTheme.color,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    fontFamily: 'IranYekan',
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:locale.amount,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontFamily: 'IranYekan',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          TextSpan(
                              text:locale.fee,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontFamily: 'IranYekan',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                          TextSpan(
                            text:locale.fee_deducted_from_account,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontFamily: 'IranYekan',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
                  buttonTitle: locale.receive_inventory,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

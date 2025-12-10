import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/card_transfer_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class CardTransferPaymentPage extends StatelessWidget {
  const CardTransferPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardTransferController>(
      builder: (controller) {
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
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.from_origin,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Card(
                                    elevation: 1,
                                    margin: EdgeInsets.zero,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: controller.selectedSourceBankInfo != null
                                          ? SvgPicture.network(
                                              AppUtil.baseUrlStatic() + controller.selectedSourceBankInfo!.symbol!,
                                              semanticsLabel: '',
                                              height: 24.0,
                                              width: 24.0,
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
                                            )
                                          : const SizedBox(height: 24.0, width: 24.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.getCustomerName(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          AppUtil.splitCardNumber(controller.sourceCustomerCard!.cardNumber!, '  '),
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Divider(thickness: 1),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.to_destination,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Card(
                                    elevation: 1,
                                    margin: EdgeInsets.zero,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: controller.destinationCardSymbol != null
                                          ? SvgPicture.network(
                                              AppUtil.baseUrlStatic() + controller.destinationCardSymbol!,
                                              semanticsLabel: '',
                                              height: 24.0,
                                              width: 24.0,
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
                                            )
                                          : const SizedBox(height: 24.0, width: 24.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.getCardOwnerName(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          AppUtil.splitCardNumber(
                                              controller.destinationCardController.text.trim().replaceAll('-', ''),
                                              '  '),
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: ThemeUtil.textTitleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Divider(thickness: 1),
                              const SizedBox(height: 8.0),
                              Text(
                                locale.in_amount_of,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Card(
                                    elevation: 1,
                                    margin: EdgeInsets.zero,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgIcon(
                                        SvgIcons.amount,
                                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    locale.amount_format(controller.amountController.text),
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                            controller: controller.expireDateController,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.done,
                            enabled: true,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: false,
                              hintText: '${locale.month}/${locale.year}',
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isExpireDateValid ? null : locale.select_expiration_date_value,
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
                            onChanged: (value) {
                              controller.setCVV(value);
                            },
                            controller: controller.cvv2Controller,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.cvv2_password,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isCvvValid ? null :locale.enter_cvv2_password,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
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
                                hintText: locale.enter_dynamic_password,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                errorText: controller.isPasswordValid ? null :locale.enter_validate_password,
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
                                  controller.requestOtp();
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
                          )
                        ],
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
                  controller.validatePaymentPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.transfer,
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_to_card/card_to_card_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class CardToCardAmountPage extends StatelessWidget {
  const CardToCardAmountPage({super.key});




  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CardToCardController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                        AppUtil.splitCardNumber(
                                            controller.selectedSourceCustomerCard!.cardNumber!, '  '),
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
                            const Divider(
                              thickness: 1,
                            ),
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
                                      if(controller.destinationName != '')
                                      Text(
                                        controller.destinationName,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: ThemeUtil.textTitleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if(controller.destinationName != '')
                                      const SizedBox(height: 8.0),
                                      Text(
                                        AppUtil.splitCardNumber(
                                            controller.destinationCardController.text.trim().replaceAll('-', ''), '  '),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: ThemeUtil.textTitleColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.amount,
                          style: ThemeUtil.titleStyle,
                        ),
                        Text(
                          controller.getAmountDetail(),
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      onChanged: (value) {
                        controller.validateAmountValue(value);
                      },
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(Constants.amountLength),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        hintText: locale.enter_amount,
                        errorText: controller.isAmountValid ? null :locale.valid_amount_error,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.amountController.text.isNotEmpty,
                          clearFunction: () {
                            controller.clearAmountTextField();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      locale.description,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: controller.descriptionController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 5,
                      minLines: 3,
                      onChanged: (String? str) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        hintText: locale.enter_description,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: controller.descriptionController.text.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.descriptionController.clear();
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
                    if(!controller.isSaved)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.save_destination_card,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: 44.0,
                          height: 28.0,
                          child: Transform.scale(
                            scale: 0.8,
                            transformHitTests: false,
                            child: CupertinoSwitch(
                              activeColor: context.theme.colorScheme.secondary,
                              value: controller.storeDestinationCard,
                              onChanged: (bool value) {
                                controller.setStoreDestinationCard(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ContinueButtonWidget(
                isEnabled: controller.isEnabled,
                isLoading: controller.isLoading,
                callback: () {
                  controller.validateAmountPage();
                },
                buttonTitle: locale.continue_label,
              ),
            ),
          ],
        ),
      );
    });
  }
}

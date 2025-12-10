import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_to_card/card_to_card_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';

class CardToCardSelectCardsPage extends StatelessWidget {
  const CardToCardSelectCardsPage({super.key});

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
            Text(
              locale.origin_card_number,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                controller.showSelectSourceCardScreen();
              },
              child: Stack(
                alignment: controller.isSourceCardValid ? Alignment.centerLeft : Alignment.topLeft,
                children: [
                  IgnorePointer(
                    child: TextField(
                      readOnly: true,
                      controller: controller.sourceCardController,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
                      decoration: InputDecoration(
                        filled: false,
                        border: InputBorder.none,
                        hintText:locale.select_origin_card_hint,
                        errorText: controller.isSourceCardValid ? null :locale.valid_origin_card_error,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (controller.sourceCardSymbol != null)
                          SvgPicture.network(
                            AppUtil.baseUrlStatic() + controller.sourceCardSymbol!,
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
                        else
                          Container(),
                        const SizedBox(
                          width: 16.0,
                        ),
                        SvgIcon(
                          SvgIcons.switchCard,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          size: 24.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.destination_card_number,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Stack(
              alignment: controller.isDestinationCardValid ? Alignment.centerLeft : Alignment.topLeft,
              children: [
                TextField(
                  controller: controller.destinationCardController,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                  onChanged: (value) {
                    controller.isSaved = false;
                    controller.destinationName = '';
                    controller.detectDestinationBank(value);
                  },
                  inputFormatters: <TextInputFormatter>[TextInputMask(mask: '9999-9999-9999-9999')],
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    hintText:locale.enter_or_select_destination_card,
                    errorText: controller.isDestinationCardValid ? null :locale.enter_valid_destination_card_number,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    controller.showDestinationSelectScreen();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.destinationCardSymbol != null)
                          SvgPicture.network(
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
                        else
                          Container(),
                        const SizedBox(
                          width: 16.0,
                        ),
                        SvgIcon(
                          SvgIcons.switchCard,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            ContinueButtonWidget(
              callback: () {
                controller.validateSelectCardsPage();
              },
              isLoading: controller.isLoading,
              buttonTitle: locale.continue_label,
            )
          ],
        ),
      );
    });
  }
}

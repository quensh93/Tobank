import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/gift_card/gift_card_controller.dart';
import '../../../util/app_theme.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../../widget/ui/dotted_line_widget.dart';

class GiftCardCustomDesignSelectorPage extends StatelessWidget {
  const GiftCardCustomDesignSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardController>(builder: (controller) {
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
                    Text(
                      controller.giftCardSelectedDesignData == null
                          ? locale.choose_desired_text_and_image
                          : locale.review_and_confirm_selected_text_and_image,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    if (controller.giftCardSelectedDesignData != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: context.theme.dividerColor),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      SvgIcon(
                                        SvgIcons.gardeshgaryTextLogo,
                                        size: 32.0,
                                      ),
                                    ],
                                  ),
                                ),
                                const MySeparator(color: AppTheme.dividerColor),
                                Image.file(controller.giftCardSelectedDesignData!.customImageFile!),
                                const MySeparator(color: AppTheme.dividerColor),
                                const SizedBox(height: 16.0),
                                Text(
                                  controller.getCustomTitle(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  AppUtil.splitCardNumber('50541630********', '  '),
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      Container(),
                    if (controller.giftCardSelectedDesignData != null) const SizedBox(height: 16.0) else Container(),
                    Container(
                      constraints: const BoxConstraints(minHeight: 234.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: context.theme.dividerColor),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              if (controller.giftCardSelectedDesignData != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                  child: Image.network(
                                    AppUtil.baseUrlStatic() +
                                        controller.giftCardSelectedDesignData!.selectedPlan!.image!,
                                    loadingBuilder:
                                        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return SizedBox(
                                        height: 200.0,
                                        child: Center(
                                          child: Container(
                                            height: 60.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.8),
                                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                            ),
                                            child: SpinKitFadingCircle(
                                              itemBuilder: (_, int index) {
                                                return const DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme.dividerColor,
                                                  ),
                                                );
                                              },
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, url, error) {
                                      return Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.update();
                                              },
                                              child: const SvgIcon(
                                                SvgIcons.imageLoadError,
                                                colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                                                size: 32,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                             Text(
                                              locale.gift_card_image_not_found,
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 24.0,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          SvgIcon(
                                            SvgIcons.gardeshgaryTextLogo,
                                            size: 32.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    MySeparator(color: context.theme.dividerColor),
                                    const SizedBox(height: 16.0),
                                     SizedBox(
                                        height: 96.0,
                                        child: Center(
                                          child: Text(
                                            locale.your_desired_image,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height: 16.0),
                                    MySeparator(color: context.theme.dividerColor),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      controller.getCardTitle(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      AppUtil.splitCardNumber('50541630********', '  '),
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (controller.giftCardSelectedDesignData != null)
                            Positioned(
                              bottom: 8.0,
                              left: 0.0,
                              right: 0.0,
                              child: Column(
                                children: [
                                  Text(
                                    controller.getAlternativeCardTitle(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    AppUtil.splitCardNumber('50541630********', '  '),
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.showGiftCardSelectScreen();
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SvgIcon(
                                Get.isDarkMode ? SvgIcons.textDark : SvgIcons.imageText,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                           Text(locale.select_text_and_image,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: controller.giftCardSelectedDesignData != null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.loadCityProvinceData();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirm_continue,
              ),
            ),
          ),
        ],
      );
    });
  }
}

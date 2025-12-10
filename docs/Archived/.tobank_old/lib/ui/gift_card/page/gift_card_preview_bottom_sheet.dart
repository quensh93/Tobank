import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/gift_card/response/list_gift_card_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';

class GiftCardPreviewBottomSheet extends StatelessWidget {
  const GiftCardPreviewBottomSheet({required this.selectedPhysicalGiftCardData, super.key});

  final PhysicalGiftCardData selectedPhysicalGiftCardData;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
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
            if (selectedPhysicalGiftCardData.image != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${locale.your_desire_design}:',
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
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
                            FastCachedImage(
                              url: AppUtil.baseUrlStatic() + selectedPhysicalGiftCardData.image!,
                              loadingBuilder: (context, progress) => SpinKitFadingCircle(
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
                              errorBuilder: (context, url, error) {
                                return const Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgIcon(
                                        SvgIcons.imageLoadError,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Column(
                              children: [
                                Text(
                                  selectedPhysicalGiftCardData.title ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              )
            else
              Container(),
            if (selectedPhysicalGiftCardData.alternativeImage != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${locale.selected_text_and_design}:',
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: context.theme.disabledColor, width: 2),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            FastCachedImage(
                              url: AppUtil.baseUrlStatic() + selectedPhysicalGiftCardData.alternativeImage!,
                              loadingBuilder: (context, progress) => SpinKitFadingCircle(
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
                              errorBuilder: (context, url, error) {
                                return Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const SvgIcon(
                                          SvgIcons.imageLoadError,
                                          size: 32,
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
                            Positioned(
                                child: Column(
                              children: [
                                Text(
                                  selectedPhysicalGiftCardData.alternativeTitle ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
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
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              Container(),
            const SizedBox(
              height: 40,
            ),
            ContinueButtonWidget(
              callback: () {
                Get.back();
              },
              isLoading: false,
              buttonTitle: locale.return_,
            ),
          ],
        ),
      ),
    );
  }
}

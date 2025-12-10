import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/response/card_issuance_template_response_data.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class CardTemplateItem extends StatelessWidget {
  const CardTemplateItem({
    required this.index,
    required this.cardTemplate,
    required this.onToggle,
    super.key,
    this.selectedIndex,
  });

  final int? index;
  final int? selectedIndex;
  final CardTemplate? cardTemplate;
  final Function onToggle;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          constraints: BoxConstraints(minHeight: Get.height / 3, maxHeight: Get.height / 2),
          child: FlipCard(
            flipOnTouch: false,
            controller: cardTemplate!.flipCardController,
            front: FastCachedImage(
              fit: BoxFit.contain,
              url: AppUtil.baseUrlStatic() + cardTemplate!.templateImage!.template!,
              loadingBuilder: (context, progress) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              errorBuilder: (context, url, error) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
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
            back: cardTemplate!.templateImage!.templateBack == null
                ? Container()
                : FastCachedImage(
                    fit: BoxFit.contain,
                    url: AppUtil.baseUrlStatic() + cardTemplate!.templateImage!.templateBack!,
                    loadingBuilder: (context, progress) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorBuilder: (context, url, error) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
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
          ),
        ),
        const SizedBox(height: 8.0),
        if (cardTemplate!.templateImage!.templateBack == null)
          const SizedBox(height: 8.0)
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {
                  cardTemplate?.flipCardController.toggleCard();
                  cardTemplate!.isFront = !cardTemplate!.isFront;
                  onToggle();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SvgIcon(
                        SvgIcons.refresh,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        cardTemplate!.isFront ? locale.front_of_card : locale.back_of_card,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_intro')
StacWidget giftCardRealIntro() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
    body: StacStack(
      children: [
        StacAlign(
          alignment: StacAlignmentDirectional.center,
          child: StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 72),
            child: StacColumn(
              mainAxisSize: StacMainAxisSize.min,
              children: [
                StacImage(
                  src: 'assets/images/empty_list.png',
                  imageType: StacImageType.asset,
                  width: 220,
                  height: 220,
                  fit: StacBoxFit.contain,
                ),
                StacSizedBox(height: 24),
                StacText(
                  data: 'شما کارتی خریداری نکرده‌اید',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ),
        StacAlign(
          alignment: StacAlignmentDirectional.bottomCenter,
          child: StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 54),
            child: StacFilledButton(
              onPressed: const StacShowGiftCardPurchaseBottomSheetAction(
                continueAction: StacNavigateAction(
                  routeName: 'gift_card_real_select_amount',
                  navigationStyle: NavigationStyle.push,
                ),
              ),
              style: StacButtonStyle(
                fixedSize: StacSize(190, 64),
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(14),
                ),
                elevation: 0,
              ),
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacIcon(
                    icon: 'add',
                    size: 22,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                  StacSizedBox(width: 8),
                  StacText(
                    data: 'خرید کارت هدیه',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

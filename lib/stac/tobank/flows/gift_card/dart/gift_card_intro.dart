import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_intro')
StacWidget giftCardRealIntro() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'کارت هدیه',
    ),
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
              onPressed: _giftCardPurchaseBottomSheetAction(),
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

StacAction _giftCardPurchaseBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardPurchaseBottomSheet',
    'continueAction': {
      'actionType': 'navigate',
      'fileName': 'gift_card_select_amount',
      'navMode': 'dart',
      'navigationStyle': 'push',
    },
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
    title: 'gift_card_intro',
    backgroundColor: '#00000000',
    sheet: StacStatefulWidget(
      onInit: StacSequenceAction(
        actions: [
          StacCustomAction.fromJson(legacyAction),
          const StacNavigateAction(navigationStyle: NavigationStyle.pop),
        ],
      ),
      child: StacSizedBox(width: 0, height: 0),
    ).toJson(),
  );
}




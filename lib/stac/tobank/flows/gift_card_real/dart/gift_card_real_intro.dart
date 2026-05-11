import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_intro')
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
      'routeName': 'gift_card_real_select_amount',
      'navigationStyle': 'push',
    },
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
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

StacWidget _giftCardPurchaseBottomSheet() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'giftCardRealIntroRulesAccepted',
      value: false,
    ),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 24, top: 10, right: 24, bottom: 18),
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacCenter(
              child: StacContainer(
                width: 62,
                height: 6,
                decoration: StacBoxDecoration(
                  color: '#737373',
                  borderRadius: StacBorderRadius.all(999),
                ),
              ),
            ),
            StacSizedBox(height: 32),
            StacText(
              data: 'خرید کارت هدیه',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w800,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 24),
            StacText(
              data:
                  'به مبالغ ۳۶,۰۰۰ ریال بابت کارمزد و ۵۷۰,۰۰۰ ریال بابت ارسال کارت هدیه به تحویل گیرنده اضافه می‌گردد',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
                height: 1.9,
              ),
            ),
            StacSizedBox(height: 36),
            StacGestureDetector(
              onTap: const StacCustomSetValueAction(
                key: 'giftCardRealIntroRulesAccepted',
                value: '{{giftCardRealIntroRulesAccepted ? false : true}}',
              ),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacContainer(
                    width: 25,
                    height: 25,
                    decoration: StacBoxDecoration(
                      color:
                          '{{giftCardRealIntroRulesAccepted ? "#D61F2C" : "#FFFFFF"}}',
                      borderRadius: StacBorderRadius.all(6),
                      border: StacBorder.all(
                        color:
                            '{{giftCardRealIntroRulesAccepted ? "#D61F2C" : "#1F2937"}}',
                        width: 2,
                      ),
                    ),
                    child: StacCustomOpacity(
                      opacity: '{{giftCardRealIntroRulesAccepted ? 1 : 0}}',
                      child: StacCenter(
                        child: StacIcon(
                          icon: 'check',
                          size: 15,
                          color: '#FFFFFF',
                        ),
                      ).toJson(),
                    ),
                  ),
                  StacSizedBox(width: 10),
                  StacExpanded(
                    child: StacText(
                      data: 'قوانین و مقررات توبانک را خوانده و قبول دارم',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StacSizedBox(height: 34),
            StacCustomReactiveElevatedButton(
              enabledKey: 'giftCardRealIntroRulesAccepted',
              onPressed: const StacNavigateAction(
                routeName: 'gift_card_real_select_amount',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 64),
                backgroundColor: '#D61F2C',
                foregroundColor: '#FFFFFF',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(14),
                ),
                elevation: 0,
              ).toJson(),
              disabledStyle: StacButtonStyle(
                fixedSize: StacSize(999999, 64),
                backgroundColor: '#ADADAD',
                foregroundColor: '#FFFFFF',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(14),
                ),
                elevation: 0,
              ).toJson(),
              child: StacText(
                data: 'ادامه',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '#FFFFFF',
                ),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_select_amount')
StacWidget giftCardRealSelectAmount() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealShowSecondAmountCard', 'value': false},
        {'key': 'giftCardRealShowThirdAmountCard', 'value': false},
        {'key': 'giftCardRealAmountValue1', 'value': '5000000'},
        {'key': 'giftCardRealAmountValue2', 'value': '5000000'},
        {'key': 'giftCardRealAmountValue3', 'value': '5000000'},
        {
          'key': 'giftCardRealAmountLabel1',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.rial}}',
        },
        {
          'key': 'giftCardRealAmountLabel2',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.rial}}',
        },
        {
          'key': 'giftCardRealAmountLabel3',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.rial}}',
        },
        {
          'key': 'giftCardRealCardCount1',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.number_value}}',
        },
        {
          'key': 'giftCardRealCardCount2',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.number_value}}',
        },
        {
          'key': 'giftCardRealCardCount3',
          'value':
              '{{appStrings.generated.gift_card.gift_card_select_amount.number_value}}',
        },
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.homePage.services.giftCard}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.only(left: 16, right: 16, top: 22),
              child: StacCustomRegistryReactive(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      mainAxisAlignment: StacMainAxisAlignment.start,
                      children: [
                        StacText(
                          data:
                              '{{appStrings.generated.gift_card.gift_card_select_amount.title}}',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.center,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(width: 8),
                        StacGestureDetector(
                          onTap: _giftCardAmountGuideBottomSheetAction(),
                          child: StacIcon(
                            icon: 'info_outline',
                            size: 22,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 26),
                    _buildAmountCard(cardIndex: 1),
                    StacCustomVisibility(
                      visible: '[[giftCardRealShowSecondAmountCard]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacSizedBox(height: 16),
                          _buildAmountCard(
                            cardIndex: 2,
                            removeAction: const StacCustomAction.fromJson({
                              'actionType': 'removeGiftCardAmountCard',
                              'cardIndex': 2,
                              'secondCardVisibleKey':
                                  'giftCardRealShowSecondAmountCard',
                              'thirdCardVisibleKey':
                                  'giftCardRealShowThirdAmountCard',
                            }),
                          ),
                        ],
                      ).toJson(),
                    ),
                    StacCustomVisibility(
                      visible: '[[giftCardRealShowThirdAmountCard]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacSizedBox(height: 16),
                          _buildAmountCard(
                            cardIndex: 3,
                            removeAction: const StacCustomAction.fromJson({
                              'actionType': 'removeGiftCardAmountCard',
                              'cardIndex': 3,
                              'secondCardVisibleKey':
                                  'giftCardRealShowSecondAmountCard',
                              'thirdCardVisibleKey':
                                  'giftCardRealShowThirdAmountCard',
                            }),
                          ),
                        ],
                      ).toJson(),
                    ),
                    StacSizedBox(height: 22),
                    StacCustomVisibility(
                      visible: '[[!giftCardRealShowThirdAmountCard]]',
                      child: StacGestureDetector(
                        onTap: const StacCustomAction.fromJson({
                          'actionType': 'addGiftCardAmountCard',
                          'secondCardVisibleKey':
                              'giftCardRealShowSecondAmountCard',
                          'thirdCardVisibleKey':
                              'giftCardRealShowThirdAmountCard',
                        }),
                        child: StacPadding(
                          padding: StacEdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment: StacMainAxisAlignment.center,
                            children: [
                              StacIcon(
                                icon: 'add',
                                size: 28,
                                color: '{{appColors.current.text.title}}',
                              ),
                              StacSizedBox(width: 6),
                              StacText(
                                data:
                                    '{{appStrings.generated.gift_card.gift_card_select_amount.amount_new_card}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).toJson(),
                    ),
                  ],
                ).toJson(),
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: StacFilledButton(
              onPressed: _giftCardDesignTypeBottomSheetAction(),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 64),
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(16),
                ),
                elevation: 0,
              ),
              child: StacText(
                data: '{{appStrings.common.continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildAmountCard({
  required int cardIndex,
  StacAction? removeAction,
}) {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacExpanded(
              child: StacGestureDetector(
                onTap: _giftCardSelectAmountBottomSheetAction(cardIndex),
                child: StacContainer(
                  height: 55,
                  padding: StacEdgeInsets.symmetric(horizontal: 10),
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    borderRadius: StacBorderRadius.all(10),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacRow(
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacText(
                        data: '{{giftCardRealAmountLabel$cardIndex}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacExpanded(child: StacContainer()),
                      StacIcon(
                        icon: 'keyboard_arrow_down',
                        size: 25,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (removeAction != null) StacSizedBox(width: 10),
            if (removeAction != null)
              StacGestureDetector(
                onTap: removeAction,
                child: StacContainer(
                  width: 36,
                  height: 36,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    borderRadius: StacBorderRadius.all(10),
                    border: StacBorder.all(
                      color: '{{appColors.current.primary.color}}',
                      width: 1.2,
                    ),
                  ),
                  child: StacCenter(
                    child: StacIcon(
                      icon: 'delete_outline',
                      size: 20,
                      color: '{{appColors.current.primary.color}}',
                    ),
                  ),
                ),
              ),
          ],
        ),

        StacSizedBox(height: 18),
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacText(
              data:
                  '{{appStrings.generated.gift_card.gift_card_select_amount.card}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                _buildCountActionButton(
                  icon: 'add',
                  iconColor: '{{appColors.current.primary.color}}',
                  onTap: StacCustomAction.fromJson({
                    'actionType': 'updateGiftCardAmountCount',
                    'countKey': 'giftCardRealCardCount$cardIndex',
                    'delta': 1,
                    'min': 1,
                    'max': 5,
                  }),
                ),
                StacSizedBox(width: 16),
                StacText(
                  data: '{{giftCardRealCardCount$cardIndex}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 22,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(width: 16),
                _buildCountActionButton(
                  icon: 'remove',
                  iconColor: '{{appColors.current.primary.color}}',
                  onTap: StacCustomAction.fromJson({
                    'actionType': 'updateGiftCardAmountCount',
                    'countKey': 'giftCardRealCardCount$cardIndex',
                    'delta': -1,
                    'min': 1,
                    'max': 5,
                  }),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

StacAction _giftCardAmountGuideBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardAmountGuideBottomSheet',
    'title': '{{appStrings.authentication.guideLabel}}',
    'minAmount': 1000000,
    'maxAmount': 50000000,
    'closeText':
        '{{appStrings.generated.gift_card.gift_card_message.close_button}}',
  });
}

StacAction _giftCardDesignTypeBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardDesignTypeBottomSheet',
    'title':
        '{{appStrings.generated.gift_card.gift_card_select_amount.select_card}}',
    'readyDesignTitle':
        '{{appStrings.generated.gift_card.gift_card_select_amount.ready_designs_title}}',
    'customDesignTitle':
        '{{appStrings.generated.gift_card.gift_card_image_selector.custom_design_title}}',
    'readyDesignAction': {
      'actionType': 'navigate',
      'fileName': 'gift_card_design_selector',
      'navMode': 'dart',
      'navigationStyle': 'push',
    },
    'customDesignAction': {
      'actionType': 'navigate',
      'fileName': 'gift_card_custom_design_selector',
      'navMode': 'dart',
      'navigationStyle': 'push',
    },
  });
}

StacAction _giftCardSelectAmountBottomSheetAction(int cardIndex) {
  return _proxyLegacyBottomSheetAction({
    'actionType': 'showGiftCardSelectAmountBottomSheet',
    'amountValueKey': 'giftCardRealAmountValue$cardIndex',
    'amountLabelKey': 'giftCardRealAmountLabel$cardIndex',
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
    title: 'gift_card_amount',
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

StacWidget _buildCountActionButton({
  required String icon,
  required String iconColor,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      width: 31,
      height: 31,
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.text.title}}',
          width: 1.5,
        ),
      ),
      child: StacCenter(
        child: StacIcon(icon: icon, size: 20, color: iconColor),
      ),
    ),
  );
}

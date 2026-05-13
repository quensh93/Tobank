import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_select_amount')
StacWidget giftCardRealSelectAmount() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealShowSecondAmountCard', 'value': false},
        {'key': 'giftCardRealShowThirdAmountCard', 'value': false},
        {'key': 'giftCardRealAmountValue1', 'value': '5000000'},
        {'key': 'giftCardRealAmountValue2', 'value': '5000000'},
        {'key': 'giftCardRealAmountValue3', 'value': '5000000'},
        {'key': 'giftCardRealAmountLabel1', 'value': '۵,۰۰۰,۰۰۰ ریال'},
        {'key': 'giftCardRealAmountLabel2', 'value': '۵,۰۰۰,۰۰۰ ریال'},
        {'key': 'giftCardRealAmountLabel3', 'value': '۵,۰۰۰,۰۰۰ ریال'},
        {'key': 'giftCardRealCardCount1', 'value': '۱'},
        {'key': 'giftCardRealCardCount2', 'value': '۱'},
        {'key': 'giftCardRealCardCount3', 'value': '۱'},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'کارت هدیه',
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
                          data: 'مبلغ کارت هدیه را وارد یا انتخاب نمایید',
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
                                data: 'افزودن کارت با مبلغ جدید',
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
                data: 'ادامه',
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
              data: 'تعداد کارت',
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
    'title': 'راهنما',
    'minAmount': 1000000,
    'maxAmount': 50000000,
    'closeText': 'بستن',
  });
}

StacWidget _giftCardAmountGuideBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 24, top: 10, right: 24, bottom: 20),
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
          StacSizedBox(height: 24),
          StacText(
            data: 'راهنما',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 14),
          StacText(
            data: 'حداقل مبلغ: ۱,۰۰۰,۰۰۰ ریال',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'حداکثر مبلغ: ۵۰,۰۰۰,۰۰۰ ریال',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 20),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              navigationStyle: NavigationStyle.pop,
            ),
            style: StacButtonStyle(
              fixedSize: StacSize(999999, 56),
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
              elevation: 0,
            ),
            child: StacText(
              data: 'بستن',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _giftCardDesignTypeBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardDesignTypeBottomSheet',
    'title': 'طرح کارت را انتخاب کنید',
    'readyDesignTitle': 'طرح‌های آماده',
    'customDesignTitle': 'طرح سفارشی',
    'readyDesignAction': {
      'actionType': 'navigate',
      'routeName': 'gift_card_real_design_selector',
      'navigationStyle': 'push',
    },
    'customDesignAction': {
      'actionType': 'navigate',
      'routeName': 'gift_card_real_custom_design_selector',
      'navigationStyle': 'push',
    },
  });
}

StacWidget _giftCardDesignTypeBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 20, top: 12, right: 20, bottom: 20),
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
          StacSizedBox(height: 20),
          StacText(
            data: 'طرح کارت را انتخاب کنید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _giftCardDesignTypeTile(
            title: 'طرح‌های آماده',
            action: const StacSequenceAction(
              actions: [
                StacNavigateAction(navigationStyle: NavigationStyle.pop),
                StacNavigateAction(
                  routeName: 'gift_card_real_design_selector',
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
          ),
          StacSizedBox(height: 10),
          _giftCardDesignTypeTile(
            title: 'طرح سفارشی',
            action: const StacSequenceAction(
              actions: [
                StacNavigateAction(navigationStyle: NavigationStyle.pop),
                StacNavigateAction(
                  routeName: 'gift_card_real_custom_design_selector',
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _giftCardDesignTypeTile({
  required String title,
  required StacAction action,
}) {
  return StacGestureDetector(
    onTap: action,
    child: StacContainer(
      height: 58,
      padding: StacEdgeInsets.symmetric(horizontal: 14),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacIcon(
            icon: 'chevron_left',
            color: '{{appColors.current.text.subtitle}}',
          ),
        ],
      ),
    ),
  );
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

StacWidget _giftCardSelectAmountBottomSheet(int cardIndex) {
  final values = <Map<String, String>>[
    {'value': '1000000', 'label': '۱,۰۰۰,۰۰۰ ریال'},
    {'value': '5000000', 'label': '۵,۰۰۰,۰۰۰ ریال'},
    {'value': '10000000', 'label': '۱۰,۰۰۰,۰۰۰ ریال'},
    {'value': '20000000', 'label': '۲۰,۰۰۰,۰۰۰ ریال'},
    {'value': '50000000', 'label': '۵۰,۰۰۰,۰۰۰ ریال'},
  ];
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 20, top: 12, right: 20, bottom: 20),
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
          StacSizedBox(height: 20),
          StacText(
            data: 'مبلغ کارت هدیه را انتخاب کنید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 14),
          ...values.map((item) {
            return StacPadding(
              padding: StacEdgeInsets.only(bottom: 10),
              child: StacGestureDetector(
                onTap: StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'giftCardRealAmountValue$cardIndex',
                          'value': item['value']!,
                        },
                        {
                          'key': 'giftCardRealAmountLabel$cardIndex',
                          'value': item['label']!,
                        },
                      ],
                    ),
                    const StacNavigateAction(
                      navigationStyle: NavigationStyle.pop,
                    ),
                  ],
                ),
                child: StacContainer(
                  height: 52,
                  padding: StacEdgeInsets.symmetric(horizontal: 14),
                  decoration: StacBoxDecoration(
                    borderRadius: StacBorderRadius.all(10),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacAlign(
                    alignment: StacAlignmentDirectional.centerStart,
                    child: StacText(
                      data: item['label']!,
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ),
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

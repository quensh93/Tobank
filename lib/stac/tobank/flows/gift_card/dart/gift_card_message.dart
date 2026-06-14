import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_message')
StacWidget giftCardRealMessage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealContinueEnabled', 'value': false},
        {'key': 'giftCardRealHasCustomMessage', 'value': false},
        {'key': 'giftCardRealHasPresetMessage', 'value': false},
        {'key': 'giftCardRealSelectedPresetMessage', 'value': ''},
        {'key': 'giftCardRealMessageOption1Selected', 'value': false},
        {'key': 'giftCardRealMessageOption2Selected', 'value': false},
        {'key': 'giftCardRealMessageOption3Selected', 'value': false},
        {'key': 'giftCardRealMessageOption4Selected', 'value': false},
        {'key': 'giftCardRealMessageOption5Selected', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '???? ????',
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.only(left: 16, right: 16, top: 20),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacText(
                          data: '???? ????',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.right,
                          style: StacCustomTextStyle(
                            fontSize: 19,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(width: 8),
                        StacGestureDetector(
                          onTap: _giftCardMessageGuideBottomSheetAction(),
                          child: StacIcon(
                            icon: 'error_outline',
                            size: 24,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 18),
                    StacContainer(
                      decoration: StacBoxDecoration(
                        color: '{{appColors.current.background.surface}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color: '{{appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacCustomTextFormField(
                        id: 'gift_card_custom_message',
                        textDirection: 'rtl',
                        textAlign: 'right',
                        style: StacCustomTextStyle(
                          fontSize: 19,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ).toJson(),
                        minLines: 2,
                        maxLines: 3,
                        maxLength: 40,
                        keyboardType: 'multiline',
                        textInputAction: 'newline',
                        decoration: StacInputDecoration(
                          hintText: '??? ????????? ?? ??????? (?? ?? ???????)',
                          hintStyle: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.hint}}',
                          ),
                          filled: false,
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ).toJson(),
                        onChanged: StacSequenceAction(
                          actions: [
                            const StacCustomSetValueAction(
                              key: 'giftCardRealCustomMessage',
                              value: StacGetFormValueAction(
                                id: 'gift_card_custom_message',
                              ),
                            ),
                            StacValidateFieldsAction(
                              resultKey: 'giftCardRealHasCustomMessage',
                              fields: const [
                                {
                                  'id': 'gift_card_custom_message',
                                  'rule': r'^.{1,40}$',
                                },
                              ],
                            ),
                            const StacCustomSetValueAction(
                              key: 'giftCardRealContinueEnabled',
                              value:
                                  '{{giftCardRealHasCustomMessage ? true : giftCardRealHasPresetMessage}}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    StacSizedBox(height: 20),
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacText(
                          data: '??? ???\u200c??? ???????',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.right,
                          style: StacCustomTextStyle(
                            fontSize: 19,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacText(
                          data: ' *',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.right,
                          style: StacCustomTextStyle(
                            fontSize: 35,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.primary.color}}',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 14),
                    _buildPresetMessageCard(
                      message: '????? ?????',
                      selectedKey: 'giftCardRealMessageOption1Selected',
                      optionId: 1,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: '?????? ????? ???? ?????',
                      selectedKey: 'giftCardRealMessageOption2Selected',
                      optionId: 2,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message:
                          '???? ?? ?? ?? ???? ????? ?????? ?? ?? ???? ? ??? ??',
                      selectedKey: 'giftCardRealMessageOption3Selected',
                      optionId: 3,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: '?? ?????? ???? ??? ???? ???????? ???? ????',
                      selectedKey: 'giftCardRealMessageOption4Selected',
                      optionId: 4,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: '???????? ??????? ?? ?????? ??? ??????? ????',
                      selectedKey: 'giftCardRealMessageOption5Selected',
                      optionId: 5,
                    ),
                    StacSizedBox(height: 14),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: StacCustomReactiveElevatedButton(
                enabledKey: 'giftCardRealContinueEnabled',
                onPressed: StacSequenceAction(
                  actions: [
                    const StacCustomSetValueAction(
                      key: 'giftCardRealCustomMessage',
                      value: StacGetFormValueAction(
                        id: 'gift_card_custom_message',
                      ),
                    ),
                    const StacCustomSetValueAction(
                      key: 'giftCardRealFinalMessage',
                      value:
                          '{{giftCardRealHasCustomMessage ? giftCardRealCustomMessage : giftCardRealSelectedPresetMessage}}',
                    ),
                    const StacCustomSetValueAction(
                      key: 'giftCardRealHasSelection',
                      value: true,
                    ),
                    const StacNavigateAction(
                      navigationStyle: NavigationStyle.pop,
                    ),
                    const StacNavigateAction(
                      navigationStyle: NavigationStyle.pop,
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 62),
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                  elevation: 0,
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  fixedSize: StacSize(999999, 62),
                  backgroundColor:
                      '{{appColors.current.button.disabled.backgroundColor}}',
                  foregroundColor:
                      '{{appColors.current.button.disabled.foregroundColor}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                  elevation: 0,
                ).toJson(),
                child: StacText(
                  data: '?????',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacAction _giftCardMessageGuideBottomSheetAction() {
  return _proxyLegacyBottomSheetAction(const {
    'actionType': 'showGiftCardMessageGuideBottomSheet',
    'title': '??????',
    'description':
        '?? ???? ???? ??? ??????? ??? ?? ??????? ??????? ?? ?????? ???? ?? ?? ???? ??? ?????? ???? ?? ??? ?????? ???? ??? ??????? ??????? ?? ???',
    'closeText': '????',
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
    title: 'gift_card_message',
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

StacWidget _giftCardMessageGuideBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 24, top: 10, right: 24, bottom: 24),
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
            data: '??????',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data:
                '?? ???? ???? ??? ??????? ??? ?? ??????? ??????? ?? ?????? ???? ?? ?? ???? ??? ?????? ???? ?? ??? ?????? ???? ??? ??????? ??????? ?? ???',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              height: 1.8,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 24),
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
              data: '????',
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

StacWidget _buildPresetMessageCard({
  required String message,
  required String selectedKey,
  required int optionId,
}) {
  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {'key': 'giftCardRealMessageOption1Selected', 'value': false},
            {'key': 'giftCardRealMessageOption2Selected', 'value': false},
            {'key': 'giftCardRealMessageOption3Selected', 'value': false},
            {'key': 'giftCardRealMessageOption4Selected', 'value': false},
            {'key': 'giftCardRealMessageOption5Selected', 'value': false},
          ],
        ),
        const StacCustomSetValueAction(
          key: 'giftCardRealHasPresetMessage',
          value: true,
        ),
        StacCustomSetValueAction(key: selectedKey, value: true),
        StacCustomSetValueAction(
          key: 'giftCardRealSelectedPresetMessage',
          value: message,
        ),
        const StacCustomSetValueAction(
          key: 'giftCardRealContinueEnabled',
          value: true,
        ),
        // Keep selected option id for future backend wiring.
        StacCustomSetValueAction(
          key: 'giftCardRealSelectedPresetOptionId',
          value: optionId,
        ),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacExpanded(
            child: StacText(
              data: message,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 10),
          StacStack(
            alignment: StacAlignment.center,
            children: [
              StacCustomVisibility(
                visible: '{{$selectedKey}}',
                child: StacIcon(
                  icon: 'radio_button_checked',
                  size: 30,
                  color: '{{appColors.current.secondary.color}}',
                ).toJson(),
              ),
              StacCustomVisibility(
                visible: '{{!$selectedKey}}',
                child: StacIcon(
                  icon: 'radio_button_unchecked',
                  size: 30,
                  color: '{{appColors.current.text.title}}',
                ).toJson(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_custom_message')
StacWidget giftCardRealCustomMessage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealCustomAltMessageContinueEnabled', 'value': false},
        {'key': 'giftCardRealCustomAltMessageOption1Selected', 'value': false},
        {'key': 'giftCardRealCustomAltMessageOption2Selected', 'value': false},
        {'key': 'giftCardRealCustomAltMessageOption3Selected', 'value': false},
        {'key': 'giftCardRealCustomAltMessageOption4Selected', 'value': false},
        {'key': 'giftCardRealCustomAltMessageOption5Selected', 'value': false},
        {'key': 'giftCardRealCustomReplacementMessage', 'value': ''},
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
              padding: StacEdgeInsets.only(left: 16, right: 16, top: 16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacContainer(
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.background.surface}}',
                      borderRadius: StacBorderRadius.all(10),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacPadding(
                      padding: StacEdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      child: StacText(
                        data:
                            '{{appStrings.generated.gift_card.gift_card_custom_message.select_text_until_bank_text}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                          height: 1.7,
                        ),
                      ),
                    ),
                  ),
                  StacSizedBox(height: 20),
                  StacRow(
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacText(
                        data:
                            '{{appStrings.generated.gift_card.gift_card_custom_message.default_replacement_text}}',
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
                  _buildCustomAltMessageCard(
                    message:
                        '{{appStrings.generated.gift_card.gift_card_custom_message.happiness_wish_message}}',
                    selectedKey: 'giftCardRealCustomAltMessageOption1Selected',
                    optionId: 1,
                  ),
                  StacSizedBox(height: 12),
                  _buildCustomAltMessageCard(
                    message:
                        '{{appStrings.generated.gift_card.gift_card_custom_message.wedding_anniversary_message}}',
                    selectedKey: 'giftCardRealCustomAltMessageOption2Selected',
                    optionId: 2,
                  ),
                  StacSizedBox(height: 12),
                  _buildCustomAltMessageCard(
                    message:
                        '{{appStrings.generated.gift_card.gift_card_custom_message.all_my_heart_message}}',
                    selectedKey: 'giftCardRealCustomAltMessageOption3Selected',
                    optionId: 3,
                  ),
                  StacSizedBox(height: 12),
                  _buildCustomAltMessageCard(
                    message:
                        '{{appStrings.generated.gift_card.gift_card_custom_message.forever_companion_message}}',
                    selectedKey: 'giftCardRealCustomAltMessageOption4Selected',
                    optionId: 4,
                  ),
                  StacSizedBox(height: 12),
                  _buildCustomAltMessageCard(
                    message:
                        '{{appStrings.generated.gift_card.gift_card_custom_message.romantic_poem_message}}',
                    selectedKey: 'giftCardRealCustomAltMessageOption5Selected',
                    optionId: 5,
                  ),
                  StacSizedBox(height: 18),
                ],
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: StacCustomReactiveElevatedButton(
              enabledKey: 'giftCardRealCustomAltMessageContinueEnabled',
              onPressed: StacSequenceAction(
                actions: [
                  const StacCustomSetValueAction(
                    values: [
                      {'key': 'giftCardRealHasSelection', 'value': true},
                      {'key': 'giftCardRealCustomHasSelection', 'value': true},
                    ],
                  ),
                  const StacNavigateAction(
                    navigationStyle: NavigationStyle.pop,
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
                data: '{{appStrings.common.continue}}',
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
  );
}

StacWidget _buildCustomAltMessageCard({
  required String message,
  required String selectedKey,
  required int optionId,
}) {
  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {
              'key': 'giftCardRealCustomAltMessageOption1Selected',
              'value': false,
            },
            {
              'key': 'giftCardRealCustomAltMessageOption2Selected',
              'value': false,
            },
            {
              'key': 'giftCardRealCustomAltMessageOption3Selected',
              'value': false,
            },
            {
              'key': 'giftCardRealCustomAltMessageOption4Selected',
              'value': false,
            },
            {
              'key': 'giftCardRealCustomAltMessageOption5Selected',
              'value': false,
            },
          ],
        ),
        StacCustomSetValueAction(key: selectedKey, value: true),
        StacCustomSetValueAction(
          key: 'giftCardRealCustomReplacementMessage',
          value: message,
        ),
        const StacCustomSetValueAction(
          key: 'giftCardRealCustomHasReplacementMessage',
          value: true,
        ),
        const StacCustomSetValueAction(
          key: 'giftCardRealCustomAltMessageContinueEnabled',
          value: true,
        ),
        StacCustomSetValueAction(
          key: 'giftCardRealCustomReplacementMessageOptionId',
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

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_message')
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
      appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
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
                          data: 'کارت هدیه',
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
                          onTap: const StacShowGiftCardMessageGuideBottomSheetAction(
                            title: 'راهنما',
                            description:
                                'در صورت ورود متن دلخواه، یکی از متن‌های پیش‌فرض را انتخاب کنید تا در صورت عدم موافقت بانک با متن دلخواه شما، متن پیش‌فرض جایگزین آن شود',
                            closeText: 'بستن',
                          ),
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
                        id: 'gift_card_real_custom_message',
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
                          hintText: 'متن دلخواهتان را بنویسید (تا ۴۰ کاراکتر)',
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
                                id: 'gift_card_real_custom_message',
                              ),
                            ),
                            StacValidateFieldsAction(
                              resultKey: 'giftCardRealHasCustomMessage',
                              fields: const [
                                {
                                  'id': 'gift_card_real_custom_message',
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
                          data: 'متن پیش\u200cفرض جایگزین',
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
                      message: 'تولدت مبارک',
                      selectedKey: 'giftCardRealMessageOption1Selected',
                      optionId: 1,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: 'سالروز زمینی شدنت مبارک',
                      selectedKey: 'giftCardRealMessageOption2Selected',
                      optionId: 2,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message:
                          'روزی که تو به دنیا آمدی، قلبمان پر از شادی و عشق شد',
                      selectedKey: 'giftCardRealMessageOption3Selected',
                      optionId: 3,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: 'چه فرخنده روزی است تولد زیباترین دختر دنیا',
                      selectedKey: 'giftCardRealMessageOption4Selected',
                      optionId: 4,
                    ),
                    StacSizedBox(height: 12),
                    _buildPresetMessageCard(
                      message: 'امیدوارم روزگارت به زیبایی قلب مهربانت باشد',
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
                        id: 'gift_card_real_custom_message',
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
                  data: 'ادامه',
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

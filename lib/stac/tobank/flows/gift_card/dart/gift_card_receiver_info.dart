import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const _provinceOptions = <String>[
  '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.sample_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.sample_message}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.sample_label}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.east_azerbaijan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.khuzestan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.gilan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.mazandaran_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.alborz_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.kerman_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.yazd_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.qom_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.kermanshah_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.hamedan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.golestan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.markazi_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.zanjan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.ardabil_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.qazvin_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.semnan_province}}',
];

const _cityOptions = <String>[
  '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.mashhad_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.sample_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.shiraz_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.tabriz_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.ahvaz_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.rasht_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.karaj_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.qom_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.kermanshah_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.urmia_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.yazd_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.hamedan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.qazvin_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.ardabil_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.zahedan_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.bandar_abbas_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.gorgan_city}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.zanjan_province}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.arak_city}}',
];

const _deliveryDateOptions = <String>[
  '{{appStrings.generated.gift_card.gift_card_receiver_info.date_value}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.date_value_message}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.date_value_label}}',
];

const _deliveryTimeOptions = <String>[
  '{{appStrings.generated.gift_card.gift_card_receiver_info.number_value}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.number_value_text}}',
  '{{appStrings.generated.gift_card.gift_card_receiver_info.number_value_label}}',
];

@StacScreen(screenName: 'gift_card_receiver_info')
StacWidget giftCardRealReceiverInfo() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealReceiverIsOwner', 'value': false},
        {'key': 'giftCardRealReceiverContinueEnabled', 'value': false},
        {
          'key': 'giftCardRealReceiverProvince',
          'value':
              '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
        },
        {
          'key': 'giftCardRealReceiverCity',
          'value':
              '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
        },
        {'key': 'giftCardRealDeliveryDate', 'value': ''},
        {'key': 'giftCardRealDeliveryTime', 'value': ''},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.homePage.services.giftCard}}',
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.only(left: 16, right: 16, top: 14),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                      crossAxisAlignment: StacCrossAxisAlignment.center,
                      children: [
                        StacText(
                          data:
                              '{{appStrings.generated.gift_card.gift_card_receiver_info.title}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 18,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacCustomReactiveSwitch(
                          valueKey: 'giftCardRealReceiverIsOwner',
                          initialValue: false,
                          scale: 0.95,
                          activeColor: '{{appColors.current.secondary.color}}',
                          onChanged: _receiverFormValidationAction(),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 12),
                    StacContainer(
                      height: 1,
                      color: '{{appColors.current.input.borderEnabled}}',
                    ),
                    StacSizedBox(height: 20),
                    StacCustomVisibility(
                      visible: '[[!giftCardRealReceiverIsOwner]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          _buildLabel(
                            '{{appStrings.generated.child_loan.child_loan_customer_check.name}}',
                          ),
                          StacSizedBox(height: 8),
                          _buildInput(
                            hint:
                                '{{appStrings.generated.gift_card.gift_card_receiver_info.name_enter_message}}',
                            id: 'gift_card_receiver_name',
                            onChanged: _receiverFormValidationAction(),
                          ),
                          StacSizedBox(height: 24),
                          _buildLabel(
                            '{{appStrings.generated.gift_card.gift_card_receiver_info.mobile_number_receiver}}',
                          ),
                          StacSizedBox(height: 8),
                          _buildInput(
                            hint:
                                '{{appStrings.generated.gift_card.gift_card_receiver_info.receiver_phone_enter_message}}',
                            id: 'gift_card_receiver_mobile',
                            keyboardType: 'number',
                            maxLength: 11,
                            inputFormatters: const [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            onChanged: _receiverFormValidationAction(),
                          ),
                          StacSizedBox(height: 24),
                        ],
                      ).toJson(),
                    ),
                    _buildLabel(
                      '{{appStrings.generated.child_loan.child_loan_guarantee_address.province}}',
                    ),
                    StacSizedBox(height: 8),
                    _buildDropdownLike(
                      valueKey: 'giftCardRealReceiverProvince',
                      onTap: StacSequenceAction(
                        actions: [
                          _locationSelectorBottomSheetAction(
                            title:
                                '{{appStrings.generated.gift_card.gift_card_receiver_info.select_province}}',
                            selectedKey: 'giftCardRealReceiverProvince',
                            options: _provinceOptions,
                          ),
                          _receiverFormValidationAction(),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel(
                      '{{appStrings.generated.child_loan.child_loan_guarantee_address.city}}',
                    ),
                    StacSizedBox(height: 8),
                    _buildDropdownLike(
                      valueKey: 'giftCardRealReceiverCity',
                      onTap: StacSequenceAction(
                        actions: [
                          _locationSelectorBottomSheetAction(
                            title:
                                '{{appStrings.generated.gift_card.gift_card_receiver_info.select_city}}',
                            selectedKey: 'giftCardRealReceiverCity',
                            options: _cityOptions,
                          ),
                          _receiverFormValidationAction(),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel(
                      '{{appStrings.generated.gift_card.gift_card_receiver_info.postal_code_receiver}}',
                    ),
                    StacSizedBox(height: 8),
                    _buildInput(
                      hint:
                          '{{appStrings.generated.gift_card.gift_card_receiver_info.postal_code_enter_message}}',
                      id: 'gift_card_receiver_postal_code',
                      keyboardType: 'number',
                      maxLength: 10,
                      inputFormatters: const [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      onChanged: _receiverFormValidationAction(),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel(
                      '{{appStrings.generated.gift_card.gift_card_receiver_info.receiver_address_postal}}',
                    ),
                    StacSizedBox(height: 8),
                    _buildInput(
                      hint:
                          '{{appStrings.generated.gift_card.gift_card_receiver_info.address_postal_enter_message}}',
                      id: 'gift_card_receiver_address',
                      minLines: 4,
                      maxLines: 4,
                      onChanged: _receiverFormValidationAction(),
                    ),
                    StacSizedBox(height: 24),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: StacCustomReactiveElevatedButton(
                enabledKey: 'giftCardRealReceiverContinueEnabled',
                onPressed: _deliveryDateTimeBottomSheetAction(),
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
    ),
  );
}

StacWidget _buildLabel(String title) {
  return StacText(
    data: title,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildInput({
  required String hint,
  required String id,
  required StacAction onChanged,
  String? keyboardType,
  int? maxLength,
  List<Map<String, dynamic>>? inputFormatters,
  int minLines = 1,
  int maxLines = 1,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacCustomTextFormField(
      id: id,
      textDirection: 'rtl',
      textAlign: 'right',
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: StacCustomTextStyle(
        fontSize: 17,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.title}}',
      ).toJson(),
      decoration: StacInputDecoration(
        hintText: hint,
        hintStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ),
        filled: false,
        contentPadding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ).toJson(),
    ),
  );
}

StacAction _receiverFormValidationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'giftCardRealReceiverContinueEnabled',
    fields: [
      {
        'id': 'gift_card_receiver_name',
        'optional': 'giftCardRealReceiverIsOwner',
      },
      {
        'id': 'gift_card_receiver_mobile',
        'rule': r'^[0-9]{11}$',
        'optional': 'giftCardRealReceiverIsOwner',
      },
      {'id': 'gift_card_receiver_postal_code', 'rule': r'^[0-9]{10}$'},
      {'id': 'gift_card_receiver_address'},
    ],
  );
}

StacAction _locationSelectorBottomSheetAction({
  required String title,
  required String selectedKey,
  required List<String> options,
}) {
  return _proxyLegacyBottomSheetAction({
    'actionType': 'showGiftCardLocationSelectorBottomSheet',
    'title': title,
    'selectedKey': selectedKey,
    'options': options,
  });
}

StacAction _deliveryDateTimeBottomSheetAction() {
  return _proxyLegacyBottomSheetAction({
    'actionType': 'showGiftCardSelectDateBottomSheet',
    'title':
        '{{appStrings.generated.gift_card.gift_card_receiver_info.select_date}}',
    'dateTitle':
        '{{appStrings.generated.gift_card.gift_card_receiver_info.date}}',
    'timeTitle':
        '{{appStrings.generated.gift_card.gift_card_receiver_info.time}}',
    'confirmText': '{{appStrings.common.confirm}}',
    'noDateSelectedText':
        '{{appStrings.generated.gift_card.gift_card_receiver_info.select_date_message}}',
    'dateOptions': _deliveryDateOptions,
    'timeOptions': _deliveryTimeOptions,
    'selectedDateKey': 'giftCardRealDeliveryDate',
    'selectedTimeKey': 'giftCardRealDeliveryTime',
    'confirmAssetPath':
        'lib/stac/tobank/flows/gift_card/json/gift_card_confirm.json',
  });
}

StacAction _proxyLegacyBottomSheetAction(Map<String, dynamic> legacyAction) {
  return StacShowBottomSheetAction(
    title: 'gift_card_receiver',
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

StacWidget _buildDropdownLike({
  required String valueKey,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      height: 56,
      padding: StacEdgeInsets.symmetric(horizontal: 16),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacCustomRegistryReactive(
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacText(
              data: '{{$valueKey}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacIcon(
              icon: 'keyboard_arrow_down',
              size: 30,
              color: '{{appColors.current.text.title}}',
            ),
          ],
        ).toJson(),
      ),
    ),
  );
}

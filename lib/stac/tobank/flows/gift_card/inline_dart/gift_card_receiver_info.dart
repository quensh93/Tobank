import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const _provinceOptions = <String>[
  'تهران',
  'اصفهان',
  'فارس',
  'خراسان رضوی',
  'آذربایجان شرقی',
  'خوزستان',
  'گیلان',
  'مازندران',
  'البرز',
  'کرمان',
  'یزد',
  'قم',
  'کرمانشاه',
  'همدان',
  'گلستان',
  'مرکزی',
  'زنجان',
  'اردبیل',
  'قزوین',
  'سمنان',
];

const _cityOptions = <String>[
  'تهران',
  'مشهد',
  'اصفهان',
  'شیراز',
  'تبریز',
  'اهواز',
  'رشت',
  'کرج',
  'قم',
  'کرمانشاه',
  'ارومیه',
  'یزد',
  'همدان',
  'قزوین',
  'اردبیل',
  'زاهدان',
  'بندرعباس',
  'گرگان',
  'زنجان',
  'اراک',
];

const _deliveryDateOptions = <String>[
  'پنج‌شنبه ۱۴۰۵/۰۲/۰۳',
  'جمعه ۱۴۰۵/۰۲/۰۴',
  'شنبه ۱۴۰۵/۰۲/۰۵',
];

const _deliveryTimeOptions = <String>['۱۳ - ۱۸', '۱۰ - ۱۳', '۱۸ - ۲۱'];

@StacScreen(screenName: 'gift_card_receiver_info')
StacWidget giftCardRealReceiverInfo() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealReceiverIsOwner', 'value': false},
        {'key': 'giftCardRealReceiverContinueEnabled', 'value': false},
        {'key': 'giftCardRealReceiverProvince', 'value': 'تهران'},
        {'key': 'giftCardRealReceiverCity', 'value': 'تهران'},
        {'key': 'giftCardRealDeliveryDate', 'value': ''},
        {'key': 'giftCardRealDeliveryTime', 'value': ''},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'کارت هدیه',
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
                          data: 'گیرنده خودم هستم',
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
                          _buildLabel('نام و نام‌خانوادگی'),
                          StacSizedBox(height: 8),
                          _buildInput(
                            hint: 'نام و نام‌خانوادگی را وارد کنید',
                            id: 'gift_card_receiver_name',
                            onChanged: _receiverFormValidationAction(),
                          ),
                          StacSizedBox(height: 24),
                          _buildLabel('شماره همراه گیرنده'),
                          StacSizedBox(height: 8),
                          _buildInput(
                            hint: 'تلفن همراه تحویل گیرنده را وارد کنید',
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
                    _buildLabel('استان'),
                    StacSizedBox(height: 8),
                    _buildDropdownLike(
                      valueKey: 'giftCardRealReceiverProvince',
                      onTap: StacSequenceAction(
                        actions: [
                          _locationSelectorBottomSheetAction(
                            title: 'انتخاب استان',
                            selectedKey: 'giftCardRealReceiverProvince',
                            options: _provinceOptions,
                          ),
                          _receiverFormValidationAction(),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel('شهر'),
                    StacSizedBox(height: 8),
                    _buildDropdownLike(
                      valueKey: 'giftCardRealReceiverCity',
                      onTap: StacSequenceAction(
                        actions: [
                          _locationSelectorBottomSheetAction(
                            title: 'انتخاب شهر',
                            selectedKey: 'giftCardRealReceiverCity',
                            options: _cityOptions,
                          ),
                          _receiverFormValidationAction(),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel('کد پستی گیرنده'),
                    StacSizedBox(height: 8),
                    _buildInput(
                      hint: 'کد پستی را وارد کنید',
                      id: 'gift_card_receiver_postal_code',
                      keyboardType: 'number',
                      maxLength: 10,
                      inputFormatters: const [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      onChanged: _receiverFormValidationAction(),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel('آدرس پستی گیرنده'),
                    StacSizedBox(height: 8),
                    _buildInput(
                      hint: 'آدرس پستی را وارد کنید',
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

StacWidget _locationSelectorBottomSheet({
  required String title,
  required String selectedKey,
  required List<String> options,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
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
          StacSizedBox(height: 18),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w800,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 14),
          StacContainer(
            constraints: const StacBoxConstraints(maxHeight: 360),
            child: StacSingleChildScrollView(
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: options.map((option) {
                  return StacPadding(
                    padding: StacEdgeInsets.only(bottom: 10),
                    child: StacGestureDetector(
                      onTap: StacSequenceAction(
                        actions: [
                          StacCustomSetValueAction(
                            key: selectedKey,
                            value: option,
                          ),
                          const StacNavigateAction(
                            navigationStyle: NavigationStyle.pop,
                          ),
                        ],
                      ),
                      child: StacContainer(
                        padding: StacEdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: StacBoxDecoration(
                          borderRadius: StacBorderRadius.all(10),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 1,
                          ),
                        ),
                        child: StacText(
                          data: option,
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.right,
                          style: StacCustomTextStyle(
                            fontSize: 15,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _deliveryDateTimeBottomSheetAction() {
  return _proxyLegacyBottomSheetAction({
    'actionType': 'showGiftCardSelectDateBottomSheet',
    'title': 'لطفا تاریخ و بازه‌زمانی تحویل هدیه را انتخاب کنید',
    'dateTitle': 'تاریخ تحویل',
    'timeTitle': 'محدوده ساعتی تحویل',
    'confirmText': 'تایید',
    'noDateSelectedText': 'تاریخی انتخاب نشده است',
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

StacWidget _deliveryDateTimeBottomSheet() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealTempDeliveryDate', 'value': ''},
        {'key': 'giftCardRealTempDeliveryTime', 'value': ''},
      ],
    ),
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: const StacBorderRadius.only(topLeft: 12, topRight: 12),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
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
            StacSizedBox(height: 18),
            StacText(
              data: 'لطفا تاریخ و بازه‌زمانی تحویل هدیه را انتخاب کنید',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w800,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 14),
            ..._deliveryDateOptions.map((date) {
              return StacPadding(
                padding: StacEdgeInsets.only(bottom: 8),
                child: StacGestureDetector(
                  onTap: StacCustomSetValueAction(
                    key: 'giftCardRealTempDeliveryDate',
                    value: date,
                  ),
                  child: StacContainer(
                    padding: StacEdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: StacBoxDecoration(
                      borderRadius: StacBorderRadius.all(10),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacText(
                      data: date,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ),
              );
            }),
            StacSizedBox(height: 6),
            ..._deliveryTimeOptions.map((time) {
              return StacPadding(
                padding: StacEdgeInsets.only(bottom: 8),
                child: StacGestureDetector(
                  onTap: StacCustomSetValueAction(
                    key: 'giftCardRealTempDeliveryTime',
                    value: time,
                  ),
                  child: StacContainer(
                    padding: StacEdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: StacBoxDecoration(
                      borderRadius: StacBorderRadius.all(10),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacText(
                      data: time,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ),
              );
            }),
            StacSizedBox(height: 8),
            StacFilledButton(
              onPressed: const StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'giftCardRealDeliveryDate',
                    value: '{{giftCardRealTempDeliveryDate}}',
                  ),
                  StacCustomSetValueAction(
                    key: 'giftCardRealDeliveryTime',
                    value: '{{giftCardRealTempDeliveryTime}}',
                  ),
                  StacNavigateAction(navigationStyle: NavigationStyle.pop),
                  StacNavigateAction(
                    routeName: 'gift_card_confirm',
                    navigationStyle: NavigationStyle.push,
                  ),
                ],
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
                data: 'تایید',
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
    ),
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


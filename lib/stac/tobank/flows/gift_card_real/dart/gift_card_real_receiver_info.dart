import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

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

@StacScreen(screenName: 'gift_card_real_receiver_info')
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
      appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
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
                            id: 'gift_card_real_receiver_name',
                            onChanged: _receiverFormValidationAction(),
                          ),
                          StacSizedBox(height: 24),
                          _buildLabel('شماره همراه گیرنده'),
                          StacSizedBox(height: 8),
                          _buildInput(
                            hint: 'تلفن همراه تحویل گیرنده را وارد کنید',
                            id: 'gift_card_real_receiver_mobile',
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
                          StacCustomAction.fromJson({
                            'actionType':
                                'showGiftCardLocationSelectorBottomSheet',
                            'title': 'انتخاب استان',
                            'selectedKey': 'giftCardRealReceiverProvince',
                            'options': _provinceOptions,
                          }),
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
                          StacCustomAction.fromJson({
                            'actionType':
                                'showGiftCardLocationSelectorBottomSheet',
                            'title': 'انتخاب شهر',
                            'selectedKey': 'giftCardRealReceiverCity',
                            'options': _cityOptions,
                          }),
                          _receiverFormValidationAction(),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildLabel('کد پستی گیرنده'),
                    StacSizedBox(height: 8),
                    _buildInput(
                      hint: 'کد پستی را وارد کنید',
                      id: 'gift_card_real_receiver_postal_code',
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
                      id: 'gift_card_real_receiver_address',
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
                onPressed: StacCustomAction.fromJson({
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
                }),
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
        'id': 'gift_card_real_receiver_name',
        'optional': 'giftCardRealReceiverIsOwner',
      },
      {
        'id': 'gift_card_real_receiver_mobile',
        'rule': r'^[0-9]{11}$',
        'optional': 'giftCardRealReceiverIsOwner',
      },
      {'id': 'gift_card_real_receiver_postal_code', 'rule': r'^[0-9]{10}$'},
      {'id': 'gift_card_real_receiver_address'},
    ],
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

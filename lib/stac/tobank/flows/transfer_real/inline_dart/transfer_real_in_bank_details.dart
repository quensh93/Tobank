import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/amount_to_words_action.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transfer_real_in_bank_details')
StacWidget transferRealInBankDetails() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'transferApiAmountWords', 'value': ''},
        {'key': 'transferApiReasonTitle', 'value': ''},
        {'key': 'transferApiHasReason', 'value': false},
        {'key': 'transferApiDetailsContinueEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: 'انتقال وجه',
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacPadding(
          padding: StacEdgeInsets.only(
            left: 16,
            top: 16,
            right: 16,
            bottom: 23,
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacExpanded(
                child: StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      _amountLabelRow(),
                      StacSizedBox(height: 8),
                      _textInput(
                        id: 'transferApiAmountInput',
                        hint: 'مبلغ انتقال را به ریال وارد کنید',
                        textDirection: 'ltr',
                        textAlign: 'left',
                        hintTextDirection: 'rtl',
                        hintTextAlign: 'right',
                        keyboardType: 'number',
                        maxLength: 14,
                        digitsOnly: true,
                        formatThousands: true,
                        thousandsSeparator: ',',
                        onChanged: StacSequenceAction(
                          actions: [
                            StacCustomSetValueAction(
                              key: 'transferApiAmountRaw',
                              value: StacGetFormValueAction(
                                id: 'transferApiAmountInput',
                              ),
                            ),
                            StacAmountToWordsAction(
                              sourceKey: 'transferApiAmountRaw',
                              destinationKey: 'transferApiAmountWords',
                              divideBy: 10,
                              minDigits: 2,
                              suffix: 'تومان',
                            ),
                            const StacCustomAction.fromJson({
                              'actionType': 'setTransferDetailsContinueEnabled',
                              'amountRawKey': 'transferApiAmountRaw',
                              'reasonSelectedKey': 'transferApiHasReason',
                              'continueEnabledKey':
                                  'transferApiDetailsContinueEnabled',
                            }),
                          ],
                        ),
                      ),
                      StacSizedBox(height: 16),
                      _label('بابت'),
                      StacSizedBox(height: 8),
                      _reasonPickerInput(),
                      StacSizedBox(height: 16),
                      _label('شناسه پرداخت'),
                      StacSizedBox(height: 8),
                      _textInput(
                        id: 'transferApiPayIdInput',
                        hint: 'شناسه پرداخت (اختیاری)',
                        textDirection: 'ltr',
                        keyboardType: 'number',
                        digitsOnly: true,
                      ),
                      StacSizedBox(height: 16),
                      _label('توضیحات'),
                      StacSizedBox(height: 8),
                      _textInput(
                        id: 'transferApiDescriptionInput',
                        hint: 'توضیحات تراکنش (اختیاری)',
                        textDirection: 'rtl',
                        keyboardType: 'text',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              StacSizedBox(height: 12),
              StacCustomReactiveElevatedButton(
                enabledKey: 'transferApiDetailsContinueEnabled',
                onPressed: _showTransferInBankTypeBottomSheetAction(),
                style: StacButtonStyle(
                  fixedSize: const StacSize(999999, 57),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                  backgroundColor:
                      '{{appColors.current.button.primary.backgroundColor}}',
                  foregroundColor:
                      '{{appColors.current.button.primary.foregroundColor}}',
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  fixedSize: const StacSize(999999, 57),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  foregroundColor: '{{appColors.current.text.hint}}',
                ).toJson(),
                child: StacText(
                  data: 'ادامه',
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color:
                        '{{appColors.current.button.primary.foregroundColor}}',
                  ),
                ).toJson(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _amountLabelRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      _label('مبلغ'),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacCustomRegistryReactive(
          registryKey: 'transferApiAmountWords',
          child: {
            'type': 'text',
            'data': '{{transferApiAmountWords}}',
            'textDirection': 'rtl',
            'textAlign': 'left',
            'maxLines': 2,
            'overflow': 'ellipsis',
            'style': {
              'type': 'custom',
              'fontSize': 13,
              'fontWeight': 'w600',
              'height': 1.35,
              'color': '{{appColors.current.text.subtitle}}',
            },
          },
        ),
      ),
    ],
  );
}

StacWidget _label(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 19,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _textInput({
  required String id,
  required String hint,
  required String textDirection,
  String textAlign = 'right',
  String? hintTextDirection,
  String? hintTextAlign,
  required String keyboardType,
  int? maxLength,
  int maxLines = 1,
  bool digitsOnly = false,
  bool formatThousands = false,
  String? thousandsSeparator,
  dynamic onChanged,
}) {
  return StacCustomTextFormField(
    id: id,
    textDirection: textDirection,
    textAlign: textAlign,
    keyboardType: keyboardType,
    maxLength: maxLength,
    maxLines: maxLines,
    formatThousands: formatThousands ? true : null,
    thousandsSeparator: formatThousands ? (thousandsSeparator ?? ',') : null,
    inputFormatters: digitsOnly
        ? const [
            {'type': 'allow', 'rule': '[0-9]'},
          ]
        : null,
    onChanged: onChanged,
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    decoration: {
      ...StacInputDecoration(
        hintText: hint,
        hintStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ),
        contentPadding: StacEdgeInsets.symmetric(
          horizontal: 16,
          vertical: 19.5,
        ),
        filled: false,
      ).toJson(),
      if (hintTextDirection != null) 'hintTextDirection': hintTextDirection,
      if (hintTextAlign != null) 'hintTextAlign': hintTextAlign,
    },
  );
}

StacWidget _reasonPickerInput() {
  return StacGestureDetector(
    onTap: _showTransferPurposeBottomSheetAction(),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 19.5),
      decoration: StacBoxDecoration(
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
        borderRadius: StacBorderRadius.all(14),
      ),
      child: StacRow(
        textDirection: StacTextDirection.ltr,
        mainAxisAlignment: StacMainAxisAlignment.start,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacIcon(
            icon: 'keyboard_arrow_down',
            color: '{{appColors.current.text.title}}',
            size: 22,
          ),
          StacSizedBox(width: 10),
          StacExpanded(
            child: StacCustomVisibility(
              visible: '[[transferApiHasReason]]',
              child: StacCustomRegistryReactive(
                registryKey: 'transferApiReasonTitle',
                child: {
                  'type': 'text',
                  'data': '{{transferApiReasonTitle}}',
                  'textDirection': 'rtl',
                  'textAlign': 'right',
                  'maxLines': 2,
                  'overflow': 'ellipsis',
                  'style': {
                    'type': 'custom',
                    'fontSize': 16,
                    'fontWeight': 'w600',
                    'color': '{{appColors.current.text.title}}',
                  },
                },
              ).toJson(),
              replacement: StacText(
                data: 'دلیل انتقال وجه',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.hint}}',
                ),
              ).toJson(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _showTransferInBankTypeBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildTransferInBankTypeBottomSheet().toJson(),
  );
}

StacAction _showTransferPurposeBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildTransferPurposeBottomSheet().toJson(),
  );
}

StacWidget _buildTransferInBankTypeBottomSheet() {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacContainer(
            width: 56,
            height: 6,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.input.borderEnabled}}',
              borderRadius: StacBorderRadius.all(999),
            ),
          ),
        ),
        StacSizedBox(height: 20),
        StacText(
          data: 'روش انتقال خود را انتخاب کنید',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 19,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        _transferTypeItem(
          title: 'درون بانکی',
          subtitle: 'انتقال در لحظه | کارمزد: رایگان',
          iconAsset: 'assets/icons/ic_gardeshgari.svg',
          enabled: true,
          onTap: _selectTransferTypeAndContinue(
            'درون بانکی',
            'transfer_real_in_bank_confirm',
          ),
        ),
        StacSizedBox(height: 12),
        _transferTypeItem(
          title: 'پل',
          subtitle: 'این روش برای انتقال درون بانکی فعال نیست',
          iconAsset: 'assets/icons/ic_bank_transfer_dark.svg',
          enabled: false,
          onTap: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
        ),
        StacSizedBox(height: 12),
        _transferTypeItem(
          title: 'پایا',
          subtitle: 'این روش برای انتقال درون بانکی فعال نیست',
          iconAsset: 'assets/icons/ic_bank_transfer_dark.svg',
          enabled: false,
          onTap: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
        ),
        StacSizedBox(height: 12),
        _transferTypeItem(
          title: 'ساتنا',
          subtitle: 'این روش برای انتقال درون بانکی فعال نیست',
          iconAsset: 'assets/icons/ic_bank_transfer_dark.svg',
          enabled: false,
          onTap: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
        ),
      ],
    ),
  );
}

StacWidget _transferTypeItem({
  required String title,
  required String subtitle,
  required String iconAsset,
  required bool enabled,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: enabled ? onTap : null,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(11),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            width: 46,
            height: 46,
            decoration: StacBoxDecoration(
              shape: StacBoxShape.circle,
              color: '{{appColors.current.background.surfaceContainer}}',
            ),
            child: StacCenter(
              child: StacImage(
                src: iconAsset,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
          StacSizedBox(width: 14),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: enabled
                        ? '{{appColors.current.text.title}}'
                        : '{{appColors.current.text.hint}}',
                  ),
                ),
                StacSizedBox(height: 7),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: enabled
                        ? '{{appColors.current.text.subtitle}}'
                        : '{{appColors.current.text.hint}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _selectTransferTypeAndContinue(String type, String routeName) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        key: 'transferApiTransferTypeTitle',
        value: type,
      ),
      const StacNavigateAction(navigationStyle: NavigationStyle.pop),
      StacNavigateAction(
        routeName: routeName,
        navigationStyle: NavigationStyle.push,
      ),
    ],
  );
}

StacWidget _buildTransferPurposeBottomSheet() {
  const purposes = [
    'واریز حقوق',
    'امور بیمه خدمات',
    'امور درمانی',
    'امور سرمایه گذاری و بورس',
    'امور ارزی در چهارچوب ضوابط و مقررات',
    'پرداخت قرض و تادیه دیون(قرض الحسنه، بدهی و ...)',
    'امور بازنشستگی',
    'معاملات اموال منقول',
    'معاملات اموال غیر منقول',
    'مدیریت نقدینگی',
    'خرید کالا و خدمات',
    'سایر',
  ];

  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 8),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacContainer(
            width: 56,
            height: 6,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.input.borderEnabled}}',
              borderRadius: StacBorderRadius.all(999),
            ),
          ),
        ),
        StacSizedBox(height: 24),
        StacText(
          data: 'انتقال بابت:',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 19,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacSizedBox(
          height: 420,
          child: StacSingleChildScrollView(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                for (final p in purposes) ...[
                  StacGestureDetector(
                    onTap: _selectTransferPurposeAction(p),
                    child: StacPadding(
                      padding: StacEdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 19,
                      ),
                      child: StacText(
                        data: p,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 19,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                  ),
                  StacContainer(
                    height: 1,
                    color: '{{appColors.current.input.borderEnabled}}',
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

StacAction _selectTransferPurposeAction(String purpose) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'transferApiReasonTitle', 'value': purpose},
          {'key': 'transferApiHasReason', 'value': true},
        ],
      ),
      const StacCustomAction.fromJson({
        'actionType': 'setTransferDetailsContinueEnabled',
        'amountRawKey': 'transferApiAmountRaw',
        'reasonSelectedKey': 'transferApiHasReason',
        'continueEnabledKey': 'transferApiDetailsContinueEnabled',
      }),
      const StacNavigateAction(navigationStyle: NavigationStyle.pop),
    ],
  );
}

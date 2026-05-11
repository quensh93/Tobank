import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

const String _cardPaymentEnabledKey = 'transferApiCardPaymentEnabled';
const String _cardExpireFieldId = 'transferApiCardExpireInput';
const String _cardCvv2FieldId = 'transferApiCardCvv2Input';
const String _cardOtpFieldId = 'transferApiCardOtpInput';

@StacScreen(screenName: 'transfer_real_confirm')
StacWidget transferRealConfirm() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': _cardPaymentEnabledKey, 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: 'انتقال وجه',
      ),
      body: StacCustomVisibility(
        visible: '[[transferApiTabCard]]',
        child: _cardConfirmContent().toJson(),
        replacement: _defaultConfirmContent().toJson(),
      ),
    ),
  );
}

StacWidget _cardConfirmContent() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 21),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _cardSummaryCard(),
                StacSizedBox(height: 16),
                _paymentFieldLabel('تاریخ انقضا'),
                StacSizedBox(height: 8),
                _paymentInput(
                  id: _cardExpireFieldId,
                  hint: '۰۶/۱۰',
                  keyboardType: 'number',
                  textDirection: 'ltr',
                  maxLength: 5,
                  readOnly: true,
                  onTapAction: _showCardExpireBottomSheetAction(),
                  inputFormatters: const [
                    {'type': 'allow', 'rule': '[0-9/]'},
                  ],
                ),
                StacSizedBox(height: 16),
                _paymentFieldLabel('CVV2'),
                StacSizedBox(height: 8),
                _paymentInput(
                  id: _cardCvv2FieldId,
                  hint: 'CVV2 را وارد نمایید',
                  keyboardType: 'number',
                  textDirection: 'ltr',
                  maxLength: 4,
                  inputFormatters: const [
                    {'type': 'allow', 'rule': '[0-9]'},
                  ],
                ),
                StacSizedBox(height: 16),
                _paymentFieldLabel('رمز پویا'),
                StacSizedBox(height: 8),
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacExpanded(
                      flex: 2,
                      child: _paymentInput(
                        id: _cardOtpFieldId,
                        hint: 'رمز پویا را وارد نمایید',
                        keyboardType: 'number',
                        textDirection: 'ltr',
                        inputFormatters: const [
                          {'type': 'allow', 'rule': '[0-9]'},
                        ],
                      ),
                    ),
                    StacSizedBox(width: 8),
                    StacExpanded(
                      child: StacRawJsonWidget({
                        'type': 'otpCountdownButton',
                        'initialSeconds': 119,
                        'startOnTap': true,
                        'requestLabel': 'رمز پویا',
                        'retryLabel': 'دریافت مجدد',
                        'showIcon': false,
                        'borderColor':
                            '{{appColors.current.input.borderEnabled}}',
                        'expiredBorderColor':
                            '{{appColors.current.input.borderEnabled}}',
                        'countdownTextColor':
                            '{{appColors.current.text.title}}',
                        'retryTextColor': '{{appColors.current.text.title}}',
                        'backgroundColor':
                            '{{appColors.current.background.surface}}',
                        'height': 56,
                        'minWidth': 132,
                        'onStart': const StacCustomSnackBarAction(
                          title: 'اعلان',
                          detail: 'رمز پویا با موفقیت ارسال شد.',
                          duration: 2200,
                        ).toJson(),
                        'onRetry': const StacCustomSnackBarAction(
                          title: 'اعلان',
                          detail: 'رمز پویا با موفقیت ارسال شد.',
                          duration: 2200,
                        ).toJson(),
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        StacSizedBox(height: 12),
        StacCustomReactiveElevatedButton(
          enabledKey: _cardPaymentEnabledKey,
          onPressed: _showTransferCardConfirmDialogAction(),
          style: StacButtonStyle(
            fixedSize: const StacSize(999999, 57),
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(10),
            ),
            backgroundColor: '{{appColors.current.primary.color}}',
            foregroundColor: '{{appColors.current.text.onPrimary}}',
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
            data: 'انتقال وجه',
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.onPrimary}}',
            ),
          ).toJson(),
        ),
      ],
    ),
  );
}

StacWidget _paymentFieldLabel(String label) {
  return StacText(
    data: label,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 19,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _paymentInput({
  required String id,
  required String hint,
  required String keyboardType,
  required String textDirection,
  int? maxLength,
  List<Map<String, dynamic>>? inputFormatters,
  bool readOnly = false,
  StacAction? onTapAction,
}) {
  return StacCustomTextFormField(
    id: id,
    textDirection: textDirection,
    textAlign: 'right',
    keyboardType: keyboardType,
    maxLength: maxLength,
    readOnly: readOnly,
    inputFormatters: inputFormatters,
    onTap: onTapAction,
    onChanged: _validateCardPaymentFieldsAction(),
    style: StacCustomTextStyle(
      fontSize: 18,
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
      contentPadding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 19.5),
      filled: false,
    ).toJson(),
  );
}

StacAction _showCardExpireBottomSheetAction() {
  return StacRawJsonAction({
    'actionType': 'showCardExpireSelectBottomSheet',
    'formFieldId': _cardExpireFieldId,
    'title': 'تاریخ انقضای کارت را انتخاب نمایید',
    'monthTitle': 'ماه',
    'yearTitle': 'سال',
    'confirmText': 'تایید',
    'onSelectedAction': _validateCardPaymentFieldsAction().toJson(),
  });
}

StacAction _showTransferCardConfirmDialogAction() {
  return StacShowDialogAction(
    barrierDismissible: true,
    barrierColor: '#8B63708C',
    dialog: _buildTransferCardConfirmDialog().toJson(),
  );
}

StacWidget _buildTransferCardConfirmDialog() {
  return StacContainer(
    padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: 'تایید اطلاعات کارت به کارت',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 17,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 14),
        _confirmRow('کارت مقصد', '{{transferApiCardDestinationNumber}}'),
        StacSizedBox(height: 8),
        _confirmRow('نام صاحب کارت', '{{transferApiCardDestinationName}}'),
        StacSizedBox(height: 8),
        _confirmRow('مبلغ انتقال', '{{transferApiCardAmountRaw}} ریال'),
        StacSizedBox(height: 18),
        StacRow(
          textDirection: StacTextDirection.ltr,
          children: [
            StacExpanded(
              child: StacFilledButton(
                onPressed: StacSequenceAction(
                  actions: [
                    const StacCloseDialogAction(),
                    const StacNavigateAction(
                      routeName: 'transfer_real_card_result',
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                  elevation: 0,
                ),
                child: StacText(
                  data: 'تایید',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: StacOutlinedButton(
                onPressed: const StacCloseDialogAction(),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  side: StacBorderSide(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1.2,
                  ),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                ),
                child: StacText(
                  data: 'انصراف',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _confirmRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

StacAction _validateCardPaymentFieldsAction() {
  return StacRawJsonAction({
    'actionType': 'validateFields',
    'resultKey': _cardPaymentEnabledKey,
    'fields': [
      {'id': _cardExpireFieldId, 'rule': r'^[0-9۰-۹]{2}/[0-9۰-۹]{2}$'},
      {'id': _cardCvv2FieldId, 'rule': r'^\d{3,4}$'},
      {'id': _cardOtpFieldId, 'rule': r'^\d{5,8}$'},
    ],
  });
}

StacWidget _cardSummaryCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(14),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacText(
              data: 'مبلغ انتقال',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacCustomRegistryReactive(
              registryKey: 'transferApiCardAmountRaw',
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.ltr,
                children: [
                  StacText(
                    data: 'ریال',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 15,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(width: 4),
                  StacRawJsonWidget({
                    'type': 'text',
                    'data': '{{transferApiCardAmountRaw}}',
                    'textDirection': 'ltr',
                    'textAlign': 'left',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  }),
                ],
              ).toJson(),
            ),
          ],
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _cardPartySection(
          sideLabel: 'مبدا',
          nameKey: 'transferApiCardSourceName',
          numberKey: 'transferApiCardSourceNumber',
          iconKey: 'transferApiCardSourceIcon',
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _cardPartySection(
          sideLabel: 'مقصد',
          nameKey: 'transferApiCardDestinationName',
          numberKey: 'transferApiCardDestinationNumber',
          iconKey: 'transferApiCardDestinationIcon',
        ),
      ],
    ),
  );
}

StacWidget _cardPartySection({
  required String sideLabel,
  required String nameKey,
  required String numberKey,
  required String iconKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      _sectionLabel(sideLabel),
      StacSizedBox(width: 10),
      StacCustomRegistryReactive(
        registryKey: iconKey,
        child: StacContainer(
          width: 38,
          height: 38,
          decoration: StacBoxDecoration(
            shape: StacBoxShape.circle,
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
            color: '{{appColors.current.background.surfaceContainer}}',
          ),
          child: StacCenter(
            child: StacRawJsonWidget({
              'type': 'image',
              'src': '{{$iconKey}}',
              'imageType': 'asset',
              'width': 24,
              'height': 24,
            }),
          ),
        ).toJson(),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacCustomRegistryReactive(
              registryKey: nameKey,
              child: {
                'type': 'text',
                'data': '{{$nameKey}}',
                'textDirection': 'rtl',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 18,
                  'fontWeight': 'w600',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
            StacSizedBox(height: 8),
            StacCustomRegistryReactive(
              registryKey: numberKey,
              child: {
                'type': 'text',
                'data': '{{$numberKey}}',
                'textDirection': 'ltr',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 17,
                  'fontWeight': 'w700',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _defaultConfirmContent() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 21),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _defaultSummaryCard(),
        StacExpanded(child: StacSizedBox()),
        StacFilledButton(
          onPressed: const StacNavigateAction(
            routeName: 'transfer_real_result',
            navigationStyle: NavigationStyle.push,
          ),
          style: StacButtonStyle(
            fixedSize: const StacSize(999999, 57),
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(10),
            ),
            backgroundColor: '#E31B2F',
            foregroundColor: '#FFFFFF',
          ),
          child: StacText(
            data: 'انتقال وجه',
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '#FFFFFF',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _defaultSummaryCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(14),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacCustomRegistryReactive(
              registryKey: 'transferApiTransferTypeTitle',
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacText(
                    data: 'مبلغ انتقال',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(width: 4),

                  StacRawJsonWidget({
                    'type': 'text',
                    'data': '{{transferApiTransferTypeTitle}}',
                    'textDirection': 'rtl',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  }),
                ],
              ).toJson(),
            ),
            StacCustomRegistryReactive(
              registryKey: 'transferApiAmountRaw',
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.ltr,
                children: [
                  StacText(
                    data: 'ریال',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 15,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(width: 4),

                  StacRawJsonWidget({
                    'type': 'text',
                    'data': '{{transferApiAmountRaw}}',
                    'textDirection': 'ltr',
                    'textAlign': 'left',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  }),
                ],
              ).toJson(),
            ),
          ],
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _accountSection(
          sectionTitle: 'مبدا',
          accountHolder: 'سجاد رحمانی پور',
          accountValue: '۱۱۰.۹۹۲۲.۱۷۹۳۸۵۸.۱',
          iconAsset: 'assets/icons/ic_gardeshgari.svg',
          accountDirection: StacTextDirection.ltr,
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _destinationSection(),
      ],
    ),
  );
}

StacWidget _destinationSection() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      _sectionLabel('مقصد'),
      StacSizedBox(width: 10),
      StacContainer(
        width: 38,
        height: 38,
        decoration: StacBoxDecoration(
          shape: StacBoxShape.circle,
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
          color: '{{appColors.current.background.surfaceContainer}}',
        ),
        child: StacCenter(
          child: StacImage(
            src: 'assets/icons/ic_gardeshgari.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacCustomRegistryReactive(
              registryKey: 'transferApiDestinationName',
              child: {
                'type': 'text',
                'data': '{{transferApiDestinationName}}',
                'textDirection': 'rtl',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 18,
                  'fontWeight': 'w600',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
            StacSizedBox(height: 8),
            StacCustomRegistryReactive(
              registryKey: 'transferApiDestinationIban',
              child: {
                'type': 'text',
                'data': 'IR{{transferApiDestinationIban}}',
                'textDirection': 'ltr',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 17,
                  'fontWeight': 'w700',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _accountSection({
  required String sectionTitle,
  required String accountHolder,
  required String accountValue,
  required String iconAsset,
  required StacTextDirection accountDirection,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      _sectionLabel(sectionTitle),
      StacSizedBox(width: 10),
      StacContainer(
        width: 38,
        height: 38,
        decoration: StacBoxDecoration(
          shape: StacBoxShape.circle,
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
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
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacText(
              data: accountHolder,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacText(
              data: accountValue,
              textDirection: accountDirection,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _sectionLabel(String title) {
  return StacContainer(
    width: 42,
    child: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.subtitle}}',
      ),
    ),
  );
}

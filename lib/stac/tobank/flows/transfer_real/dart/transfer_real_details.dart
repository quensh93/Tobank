import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/amount_to_words_action.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transfer_real_details')
StacWidget transferRealDetails() {
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
      appBar: StacAppBar(
        title: StacText(
          data: 'انتقال وجه',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: const StacNavigateAction(
            navigationStyle: NavigationStyle.pop,
          ),
          icon: StacImage(
            src: '{{appAssets.icons.arrowRight}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
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
                onPressed: const StacCustomAction.fromJson({
                  'actionType': 'showTransferTypeBottomSheet',
                  'title': 'روش انتقال خود را انتخاب کنید',
                  'heightFactor': 0.68,
                  'selectedTypeKey': 'transferApiTransferTypeTitle',
                  'onSelectAction': {
                    'actionType': 'navigate',
                    'routeName': 'transfer_real_confirm',
                    'navigationStyle': 'push',
                  },
                }),
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
    textAlign: 'right',
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

StacWidget _reasonPickerInput() {
  return StacGestureDetector(
    onTap: const StacCustomAction.fromJson({
      'actionType': 'showTransferPurposeBottomSheet',
      'title': 'انتقال بابت:',
      'selectedValueKey': 'transferApiReasonTitle',
      'hasValueKey': 'transferApiHasReason',
      'amountRawKey': 'transferApiAmountRaw',
      'continueEnabledKey': 'transferApiDetailsContinueEnabled',
      'heightFactor': 0.72,
    }),
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

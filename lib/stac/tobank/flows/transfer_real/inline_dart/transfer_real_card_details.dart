import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/amount_to_words_action.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transfer_real_card_details')
StacWidget transferRealCardDetails() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'transferApiCardAmountWords', 'value': ''},
        {'key': 'transferApiCardDetailsContinueEnabled', 'value': false},
        {'key': 'transferApiCardAmountHasText', 'value': false},
        {'key': 'transferApiCardDescription', 'value': ''},
        {'key': 'transferApiCardDescriptionHasText', 'value': false},
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
                      _cardsSummaryCard(),
                      StacSizedBox(height: 18),
                      _label('مبلغ'),
                      StacSizedBox(height: 8),
                      _amountInput(),
                      StacSizedBox(height: 6),
                      _amountWords(),
                      StacSizedBox(height: 16),
                      _label('توضیحات'),
                      StacSizedBox(height: 8),
                      _descriptionInput(),
                    ],
                  ),
                ),
              ),
              StacSizedBox(height: 12),
              StacCustomReactiveElevatedButton(
                enabledKey: 'transferApiCardDetailsContinueEnabled',
                onPressed: const StacNavigateAction(
                  routeName: 'transfer_real_confirm',
                  navigationStyle: NavigationStyle.push,
                ),
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

StacWidget _cardsSummaryCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _cardPartyRow(
          sideLabel: 'مبدا',
          nameKey: 'transferApiCardSourceName',
          numberKey: 'transferApiCardSourceNumber',
          iconKey: 'transferApiCardSourceIcon',
        ),
        StacSizedBox(height: 12),
        StacDivider(
          thickness: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacSizedBox(height: 12),
        _cardPartyRow(
          sideLabel: 'مقصد',
          nameKey: 'transferApiCardDestinationName',
          numberKey: 'transferApiCardDestinationNumber',
          iconKey: 'transferApiCardDestinationIcon',
        ),
      ],
    ),
  );
}

StacWidget _cardPartyRow({
  required String sideLabel,
  required String nameKey,
  required String numberKey,
  required String iconKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacSizedBox(
        width: 44,
        child: StacAlign(
          alignment: StacAlignmentDirectional.centerStart,
          child: StacText(
            data: sideLabel,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ),
      ),
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
            color: '#FFFFFF',
          ),
          child: StacCenter(
            child: StacRawJsonWidget({
              'type': 'image',
              'src': '{{$iconKey}}',
              'imageType': 'asset',
              'width': 28,
              'height': 28,
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
                  'fontSize': 16,
                  'fontWeight': 'w700',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
            StacSizedBox(height: 6),
            StacCustomRegistryReactive(
              registryKey: numberKey,
              child: {
                'type': 'text',
                'data': '{{$numberKey}}',
                'textDirection': 'ltr',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 15,
                  'fontWeight': 'w600',
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

StacWidget _amountInput() {
  return StacCustomTextFormField(
    id: 'transferApiCardAmountInput',
    textDirection: 'ltr',
    textAlign: 'left',
    keyboardType: 'number',
    maxLength: 14,
    formatThousands: true,
    thousandsSeparator: ',',
    inputFormatters: const [
      {'type': 'allow', 'rule': '[0-9]'},
    ],
    onChanged: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'transferApiCardAmountRaw',
          value: StacGetFormValueAction(id: 'transferApiCardAmountInput'),
        ),
        StacAmountToWordsAction(
          sourceKey: 'transferApiCardAmountRaw',
          destinationKey: 'transferApiCardAmountWords',
          divideBy: 10,
          minDigits: 2,
          suffix: 'تومان',
        ),
        StacRawJsonAction({
          'actionType': 'validateFields',
          'resultKey': 'transferApiCardDetailsContinueEnabled',
          'fields': [
            {'id': 'transferApiCardAmountInput'},
          ],
        }),
        StacRawJsonAction({
          'actionType': 'validateFields',
          'resultKey': 'transferApiCardAmountHasText',
          'fields': [
            {'id': 'transferApiCardAmountInput'},
          ],
        }),
      ],
    ),
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    decoration: {
      ...StacInputDecoration(
        hintText: 'مبلغ انتقال را به ریال وارد کنید',
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
        suffixIcon: StacRawJsonWidget({
          'type': 'visibility',
          'visible': '[[transferApiCardAmountHasText]]',
          'child': StacGestureDetector(
            onTap: const StacCustomSetValueAction(
              values: [
                {'key': 'transferApiCardAmountInput', 'value': ''},
                {'key': 'transferApiCardAmountRaw', 'value': ''},
                {'key': 'transferApiCardAmountWords', 'value': ''},
                {
                  'key': 'transferApiCardDetailsContinueEnabled',
                  'value': false,
                },
                {'key': 'transferApiCardAmountHasText', 'value': false},
              ],
            ),
            child: StacPadding(
              padding: StacEdgeInsets.only(left: 10, right: 10),
              child: StacIcon(
                icon: StacIcons.close,
                size: 19,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ).toJson(),
          'replacement': StacSizedBox(width: 24).toJson(),
        }),
      ).toJson(),
      'hintTextDirection': 'rtl',
      'hintTextAlign': 'right',
    },
  );
}

StacWidget _amountWords() {
  return StacCustomRegistryReactive(
    registryKey: 'transferApiCardAmountWords',
    child: {
      'type': 'text',
      'data': '{{transferApiCardAmountWords}}',
      'textDirection': 'rtl',
      'textAlign': 'right',
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
  );
}

StacWidget _descriptionInput() {
  return StacCustomTextFormField(
    id: 'transferApiCardDescriptionInput',
    onChanged: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'transferApiCardDescription',
          value: StacGetFormValueAction(id: 'transferApiCardDescriptionInput'),
        ),
        StacRawJsonAction({
          'actionType': 'validateFields',
          'resultKey': 'transferApiCardDescriptionHasText',
          'fields': [
            {'id': 'transferApiCardDescriptionInput'},
          ],
        }),
      ],
    ),
    textDirection: 'rtl',
    textAlign: 'right',
    keyboardType: 'text',
    maxLines: 2,
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    decoration: StacInputDecoration(
      hintText: 'توضیحات تراکنش (اختیاری)',
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

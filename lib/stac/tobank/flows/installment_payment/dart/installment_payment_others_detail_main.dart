import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/amount/amount_to_words_action.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'installment_payment_others_receipt.dart' as others_receipt;

@StacScreen(screenName: 'installment_payment_others_detail_main')
StacWidget installmentPaymentOthersDetailMain() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'othersDetailAmountHasText', 'value': false},
        {'key': 'othersDetailPayEnabled', 'value': false},
        {'key': 'othersDetailAmountWords', 'value': ''},
        {'key': 'othersPayment.receiverName', 'value': 'مهدی جمشیدپور'},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'پرداخت اقساط دیگران',
        showSupport: true,
        showBack: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _loanInfoCard(),
              StacSizedBox(height: 16),
              _paymentCard(),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _loanInfoCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      children: [
        _detailRow('شماره تسهیلات', '{{othersPayment.loanNumber}}'),
        _dashedDivider(),
        _detailRow('نوع تسهیلات', 'قرض الحسنه طرح پارسا (۲ درصدی)'),
        _dashedDivider(),
        _detailRow('دریافت کننده', '{{othersPayment.receiverName}}'),
      ],
    ),
  );
}

StacWidget _paymentCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: 'مبلغ مورد نظر را وارد نمایید',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        StacCustomVisibility(
          visible: '[[othersDetailAmountHasText]]',
          child: _amountInput(showCurrency: true).toJson(),
          replacement: _amountInput(showCurrency: false).toJson(),
        ),
        StacSizedBox(height: 8),
        StacCustomVisibility(
          visible: '[[othersDetailAmountHasText]]',
          child: StacText(
            data: '{{othersDetailAmountWords}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ).toJson(),
          replacement: StacSizedBox(height: 24).toJson(),
        ),
        StacSizedBox(height: 16),
        StacCustomReactiveElevatedButton(
          enabledKey: 'othersDetailPayEnabled',
          onPressed: _showOthersPaymentAccountsSheetAction(),
          style: StacButtonStyle(
            fixedSize: StacSize(999999, 56),
            elevation: 0,
            backgroundColor: '{{appColors.current.primary.color}}',
            foregroundColor: '{{appColors.current.primary.onPrimary}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(10),
            ),
          ).toJson(),
          disabledStyle: StacButtonStyle(
            fixedSize: StacSize(999999, 56),
            elevation: 0,
            backgroundColor: '{{appColors.current.input.borderEnabled}}',
            foregroundColor: '{{appColors.current.text.subtitle}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(10),
            ),
          ).toJson(),
          child: StacText(
            data: 'پرداخت',
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.primary.onPrimary}}',
            ),
          ).toJson(),
          loadingChild: StacText(
            data: 'پرداخت',
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.primary.onPrimary}}',
            ),
          ).toJson(),
        ),
      ],
    ),
  );
}

StacAction _showOthersPaymentAccountsSheetAction() {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'othersPaymentSheet.acc1Selected', 'value': false},
          {'key': 'othersPaymentSheet.acc2Selected', 'value': false},
          {'key': 'othersPaymentSheet.canSubmit', 'value': false},
          {
            'key': 'othersPaymentSheet.amount',
            'value': StacGetFormValueAction(id: 'othersDetailAmountInput'),
          },
        ],
      ),
      StacShowBottomSheetAction(
        backgroundColor: '#8B63708C',
        sheet: _buildOthersPaymentAccountsBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _buildOthersPaymentAccountsBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 16, topRight: 16),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 18),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 40,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 14),
          StacText(
            data: 'پرداخت اقساط دیگران',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 18),
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: StacBoxDecoration(
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
              borderRadius: StacBorderRadius.all(6),
            ),
            child: StacText(
              data: 'حساب‌ها',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 12),
          _othersPaymentAccountCard(
            selectedKey: 'othersPaymentSheet.acc1Selected',
            onTap: _selectOthersPaymentAccount(canSubmit: true, account: 1),
            title: 'سپرده ۶ ماهه کوتاه مدت توبانکی',
            depositNo: '۱۱۰.۷۰۰.۲۱۰.۱۲۴۱۵۷۱.۱',
            cardNo: '۵۵۹۴ - ۱۶۱۷ - ۱۲۳۴ - ۵۶۷۸',
            amount: '۸۱۱,۱۲۴,۶۰۷ ریال',
            isInsufficient: false,
          ),
          StacSizedBox(height: 10),
          _othersPaymentAccountCard(
            selectedKey: 'othersPaymentSheet.acc2Selected',
            onTap: _selectOthersPaymentAccount(canSubmit: false, account: 2),
            title: 'سپرده حقیقی سپرده سرمایه‌گذاری بلند مدت حقیقی ریالی زهرا حبیبی',
            depositNo: '۱۱۰.۷۰۰.۲۱۰.۱۲۴۱۵۷۱.۱',
            cardNo: '۵۵۹۴ - ۱۶۱۷ - ۱۲۳۴ - ۵۶۷۸',
            amount: '۷۴۵,۵۲۴,۶۰۷ ریال',
            isInsufficient: true,
          ),
          StacSizedBox(height: 96),
          StacCustomVisibility(
            visible: '[[othersPaymentSheet.canSubmit]]',
            child: _othersPaymentSheetSubmitButton(enabled: true).toJson(),
            replacement: _othersPaymentSheetSubmitButton(enabled: false)
                .toJson(),
          ),
          StacSizedBox(height: 7),
        ],
      ),
    ),
  );
}

StacAction _selectOthersPaymentAccount({
  required bool canSubmit,
  required int account,
}) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'othersPaymentSheet.acc1Selected', 'value': account == 1},
      {'key': 'othersPaymentSheet.acc2Selected', 'value': account == 2},
      {'key': 'othersPaymentSheet.canSubmit', 'value': canSubmit},
    ],
  );
}

StacWidget _othersPaymentSheetSubmitButton({required bool enabled}) {
  return StacFilledButton(
    onPressed: enabled
        ? StacSequenceAction(
            actions: [
              const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              StacNavigateAction(
                widgetJson: others_receipt.installmentPaymentOthersReceipt()
                    .toJson(),
                navigationStyle: NavigationStyle.push,
              ),
            ],
          )
        : null,
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 55),
      backgroundColor: enabled ? '#E31C3D' : '#D0D5DD',
      foregroundColor: enabled ? '#FFFFFF' : '#98A2B3',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(11)),
      elevation: 0,
    ),
    child: StacText(
      data: 'تایید و پرداخت',
      style: StacTextStyle(
        fontSize: 19,
        fontWeight: StacFontWeight.w700,
        color: enabled ? '#FFFFFF' : '#98A2B3',
      ),
    ),
  );
}

StacWidget _othersPaymentAccountCard({
  required String selectedKey,
  required StacAction onTap,
  required String title,
  required String depositNo,
  required String cardNo,
  required String amount,
  required bool isInsufficient,
}) {
  final statusColor = isInsufficient ? '#E31C3D' : '#13A780';
  final card = StacPadding(
    padding: StacEdgeInsets.all(12),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          crossAxisAlignment: StacCrossAxisAlignment.start,
          children: [
            StacExpanded(
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 17,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 10),
            _othersPaymentAccountRadio(selectedKey),
          ],
        ),
        StacSizedBox(height: 12),
        _othersPaymentSheetMetaRow(label: 'شماره سپرده', value: depositNo),
        StacSizedBox(height: 8),
        _othersPaymentSheetMetaRow(label: 'شماره کارت', value: cardNo),
        StacContainer(
          margin: StacEdgeInsets.symmetric(vertical: 10),
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: 'قابل برداشت',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: statusColor,
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: amount,
              textDirection: StacTextDirection.ltr,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: statusColor,
              ),
            ),
            StacExpanded(child: StacSizedBox()),
            if (isInsufficient)
              StacContainer(
                padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: StacBoxDecoration(
                  color: '#E31C3D',
                  borderRadius: StacBorderRadius.all(999),
                ),
                child: StacText(
                  data: 'موجودی ناکافی',
                  style: StacTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w500,
                    color: '#FFFFFF',
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: card,
      ).toJson(),
      replacement: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: card,
      ).toJson(),
    ),
  );
}

StacWidget _othersPaymentAccountRadio(String selectedKey) {
  return StacContainer(
    width: 18,
    height: 18,
    decoration: StacBoxDecoration(
      shape: StacBoxShape.circle,
      border: StacBorder.all(color: '#20C4D8', width: 1),
    ),
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacCenter(
        child: StacContainer(
          width: 8,
          height: 8,
          decoration: StacBoxDecoration(
            shape: StacBoxShape.circle,
            color: '#20C4D8',
          ),
        ),
      ).toJson(),
      replacement: StacSizedBox().toJson(),
    ),
  );
}

StacWidget _othersPaymentSheetMetaRow({
  required String label,
  required String value,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacText(
        data: value,
        textDirection: StacTextDirection.ltr,
        style: StacTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _amountInput({required bool showCurrency}) {
  return StacCustomTextFormField(
    id: 'othersDetailAmountInput',
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
          values: const [
            {
              'key': 'othersDetailAmountRaw',
              'value': StacGetFormValueAction(id: 'othersDetailAmountInput'),
            },
            {'key': 'othersDetailPayEnabled', 'value': false},
            {
              'key': 'othersDetailPayEnabled',
              'value': true,
              'condition': 'othersDetailAmountRaw > 10000',
            },
          ],
        ),
        StacAmountToWordsAction(
          sourceKey: 'othersDetailAmountRaw',
          destinationKey: 'othersDetailAmountWords',
          divideBy: 10,
          minDigits: 2,
          suffix: 'تومان',
        ),
        StacValidateFieldsAction(
          resultKey: 'othersDetailAmountHasText',
          fields: const [
            {'id': 'othersDetailAmountInput'},
          ],
        ),
      ],
    ),
    textDirection: 'ltr',
    textAlign: 'center',
    decoration: {
      'hintText': 'مبلغ دلخواه',
      if (showCurrency) 'prefixText': 'ریال',
      if (showCurrency)
        'prefixStyle': {
          'fontSize': 18,
          'fontWeight': 'w700',
          'color': '{{appColors.current.text.title}}',
        },
      'enabledBorder': {
        'type': 'outline',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1.0,
        },
        'borderRadius': {'all': 12},
      },
      'focusedBorder': {
        'type': 'outline',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1.0,
        },
        'borderRadius': {'all': 12},
      },
      'contentPadding': {'left': 8, 'top': 18, 'right': 8, 'bottom': 18},
      'hintStyle': {
        'fontSize': 18,
        'fontWeight': 'w500',
        'color': '{{appColors.current.text.hint}}',
      },
    },
    style: const {
      'fontSize': 17,
      'fontWeight': 'w700',
      'color': '{{appColors.current.text.title}}',
    },
  );
}

StacWidget _detailRow(String title, String value) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 14),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(width: 12),
        StacExpanded(
          child: StacText(
            data: value,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _dashedDivider() {
  return StacContainer(
    height: 1,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.input.borderEnabled}}',
    ),
  );
}

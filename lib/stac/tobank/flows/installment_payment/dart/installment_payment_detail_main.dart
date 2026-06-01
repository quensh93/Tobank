import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/amount/amount_to_words_action.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/installment_payment/dart/installment_payment_receipt.dart'
    as installment_payment_receipt_dart;

@StacScreen(screenName: 'installment_payment_detail_main')
StacWidget installmentPaymentDetailMain() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'loanDetail.payTypeInstallment', 'value': true},
        {'key': 'loanDetail.payTypeSettlement', 'value': false},
        {'key': 'loanDetail.payTypeCustom', 'value': false},
        {'key': 'loanDetail.customByInstallmentCount', 'value': false},
        {'key': 'loanDetail.customAmountInput', 'value': ''},
        {'key': 'loanDetail.customPayableAmountDisplay', 'value': '۰'},
        {'key': 'loanDetail.customInstallmentCountRaw', 'value': '0.0'},
        {'key': 'loanDetail.customInstallmentCount', 'value': '۰'},
        {'key': 'loanDetail.customCountPayableAmount', 'value': '۱۱۱,۸۴۷,۱۴۵'},
        {'key': 'loanDetail.customAmountWords', 'value': ''},
        {'key': 'loanDetail.customPayEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: StacText(
          data: '{{loanDetail.appBarTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leadingWidth: 84,
        leading: StacRow(
          children: [
            StacPadding(
              padding: StacEdgeInsets.only(left: 12),
              child: StacCenter(
                child: StacImage(
                  src: '{{appAssets.icons.support}}',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacIconButton(
              onPressed: _showLoanDetailMoreBottomSheetAction(),
              icon: StacImage(
                src: 'assets/icons/ic_more_options.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
        actions: [
          StacPadding(
            padding: StacEdgeInsets.only(right: 8),
            child: StacIconButton(
              onPressed: const StacNavigateAction(
                navigationStyle: NavigationStyle.pop,
              ),
              icon: StacImage(
                src: '{{appAssets.icons.arrowBack}}',
                imageType: StacImageType.asset,
                width: 30,
                height: 30,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ],
      ),
      body: StacForm(
        child: StacDefaultTabController(
          length: 2,
          initialIndex: 1,
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.symmetric(vertical: 16),
            child: StacColumn(
              children: [
                StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 16),
                  child: _loanSummaryCard(),
                ),
                StacSizedBox(height: 16),
                StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 16),
                  child: _paymentTypeCard(),
                ),
                StacSizedBox(height: 16),
                _historySection(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

StacWidget _loanSummaryCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        children: [
          _loanProgressCircle(),
          StacSizedBox(height: 8),
          StacText(
            data: '{{loanDetail.approvedAmount}}',
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: '{{loanDetail.paidSummary}}',
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 30),
          StacStack(
            alignment: StacAlignment.center,
            children: [
              StacSizedBox(
                height: 44,
                child: StacContainer(
                  width: 1,
                  color: '{{appColors.current.input.borderEnabled}}',
                ),
              ),
              StacRow(
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacColumn(
                    children: [
                      StacText(
                        data: 'تسویه شده',
                        style: StacTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                      StacSizedBox(height: 8),
                      _amountWithRial(
                        amount: '{{loanDetail.settledAmount}}',
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                      ),
                    ],
                  ),
                  StacColumn(
                    children: [
                      StacText(
                        data: 'بدهی مانده',
                        style: StacTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                      StacSizedBox(height: 8),
                      _amountWithRial(
                        amount: '{{loanDetail.debtAmount}}',
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

StacWidget _loanProgressCircle() {
  return StacSizedBox(
    width: 100,
    height: 100,
    child: StacStack(
      alignment: StacAlignment.center,
      children: [
        StacSizedBox(
          width: 100,
          height: 100,
          child: StacCircularProgressIndicator(
            value: 1,
            color: '{{appColors.current.input.borderEnabled}}',
            strokeWidth: 6,
            strokeCap: StacStrokeCap.butt,
          ),
        ),
        StacCustomWidget.fromJson({
          'type': 'registryReactive',
          'registryKey': 'loanDetail.progress',
          'child': {
            'type': 'sizedBox',
            'width': 100,
            'height': 100,
            'child': {
              'type': 'circularProgressIndicator',
              'value': '{{loanDetail.progress}}',
              'color': '#D61F2C',
              'backgroundColor': '#00000000',
              'strokeWidth': 6,
              'strokeCap': 'butt',
            },
          },
        }),
        StacPadding(
          padding: StacEdgeInsets.all(10),
          child: StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.input.borderEnabled}}',
              shape: StacBoxShape.circle,
            ),
            child: StacCenter(
              child: StacImage(
                src: 'assets/icons/loan_detail_information.svg',
                imageType: StacImageType.asset,
                width: 43,
                height: 43,
                color: '#D61F2C',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _paymentTypeCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        children: [
          StacText(
            data: 'نوع پرداخت',
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 26),
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 3),
                  child: _reactivePaymentChip(
                    title: 'پرداخت قسط',
                    visibleKey: 'loanDetail.payTypeInstallment',
                    onTap: const StacCustomSetValueAction(
                      values: [
                        {'key': 'loanDetail.payTypeInstallment', 'value': true},
                        {'key': 'loanDetail.payTypeSettlement', 'value': false},
                        {'key': 'loanDetail.payTypeCustom', 'value': false},
                        {
                          'key': 'loanDetail.customByInstallmentCount',
                          'value': false,
                        },
                      ],
                    ),
                  ),
                ),
              ),
              StacExpanded(
                child: StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 3),
                  child: _reactivePaymentChip(
                    title: 'تسویه وام',
                    visibleKey: 'loanDetail.payTypeSettlement',
                    onTap: const StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'loanDetail.payTypeInstallment',
                          'value': false,
                        },
                        {'key': 'loanDetail.payTypeSettlement', 'value': true},
                        {'key': 'loanDetail.payTypeCustom', 'value': false},
                        {
                          'key': 'loanDetail.customByInstallmentCount',
                          'value': false,
                        },
                      ],
                    ),
                  ),
                ),
              ),
              StacExpanded(
                child: StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 3),
                  child: _reactivePaymentChip(
                    title: 'مقدار دلخواه',
                    visibleKey: 'loanDetail.payTypeCustom',
                    onTap: const StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'loanDetail.payTypeInstallment',
                          'value': false,
                        },
                        {'key': 'loanDetail.payTypeSettlement', 'value': false},
                        {'key': 'loanDetail.payTypeCustom', 'value': true},
                        {
                          'key': 'loanDetail.customByInstallmentCount',
                          'value': false,
                        },
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 26),
          StacCustomWidget.fromJson({
            'type': 'visibility',
            'visible': '[[loanDetail.payTypeInstallment]]',
            'child': _paymentTypeInfoRow(
              title: '{{loanDetail.nextInstallmentTitle}}',
              amount: '{{loanDetail.nextInstallmentAmount}}',
            ).toJson(),
            'replacement': StacSizedBox().toJson(),
          }),
          StacCustomWidget.fromJson({
            'type': 'visibility',
            'visible': '[[loanDetail.payTypeSettlement]]',
            'child': _paymentTypeInfoRow(
              title: 'مبلغ قابل پرداخت',
              amount: '{{loanDetail.settlementPayableAmount}}',
            ).toJson(),
            'replacement': StacSizedBox().toJson(),
          }),
          StacCustomWidget.fromJson({
            'type': 'visibility',
            'visible': '[[loanDetail.payTypeCustom]]',
            'child': _customPaymentContent().toJson(),
            'replacement': StacSizedBox().toJson(),
          }),
          StacCustomWidget.fromJson({
            'type': 'visibility',
            'visible': '[[!loanDetail.payTypeCustom]]',
            'child': StacColumn(
              children: [
                StacSizedBox(height: 38),
                StacRow(
                  children: [
                    StacExpanded(
                      child: StacFilledButton(
                        onPressed: _showPaymentAccountsBottomSheetAction(),
                        style: StacButtonStyle(
                          padding: StacEdgeInsets.symmetric(vertical: 18),
                          backgroundColor: '#E31C3D',
                          foregroundColor: '#FFFFFF',
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(10),
                          ),
                        ),
                        child: StacText(
                          data: 'پرداخت',
                          style: StacTextStyle(
                            fontSize: 18,
                            fontWeight: StacFontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).toJson(),
            'replacement': StacSizedBox().toJson(),
          }),
          StacCustomWidget.fromJson({
            'type': 'visibility',
            'visible': '[[loanDetail.payTypeCustom]]',
            'child': StacColumn(
              children: [
                StacSizedBox(height: 22),
                StacRow(
                  children: [
                    StacExpanded(
                      child: StacCustomReactiveElevatedButton(
                        enabledKey: 'loanDetail.customPayEnabled',
                        onPressed: _showPaymentAccountsBottomSheetAction(),
                        style: StacButtonStyle(
                          padding: StacEdgeInsets.symmetric(vertical: 18),
                          backgroundColor: '#E31C3D',
                          foregroundColor: '#FFFFFF',
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(10),
                          ),
                        ).toJson(),
                        disabledStyle: StacButtonStyle(
                          padding: StacEdgeInsets.symmetric(vertical: 18),
                          backgroundColor: '#8B8B8B',
                          foregroundColor: '#FFFFFF',
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(10),
                          ),
                        ).toJson(),
                        child: StacText(
                          data: 'پرداخت',
                          style: StacTextStyle(
                            fontSize: 18,
                            fontWeight: StacFontWeight.w700,
                            color: '#FFFFFF',
                          ),
                        ).toJson(),
                      ),
                    ),
                  ],
                ),
              ],
            ).toJson(),
            'replacement': StacSizedBox().toJson(),
          }),
        ],
      ),
    ),
  );
}

StacShowBottomSheetAction _showLoanDetailMoreBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _buildLoanDetailMoreBottomSheet().toJson(),
  );
}

StacAction _showPaymentAccountsBottomSheetAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'loanPaymentSheet.acc1Selected', 'value': false},
          {'key': 'loanPaymentSheet.acc2Selected', 'value': false},
          {'key': 'loanPaymentSheet.canSubmit', 'value': false},
          {'key': 'loanPaymentSheet.title', 'value': 'پرداخت اقساط'},
          {'key': 'loanPaymentSheet.showSubtitle', 'value': true},
          {
            'key': 'loanPaymentSheet.subtitle',
            'value': '{{loanDetail.nextInstallmentTitle}}',
            'condition': 'loanDetail.payTypeInstallment',
          },
          {
            'key': 'loanPaymentSheet.amount',
            'value': '{{loanDetail.nextInstallmentAmount}}',
            'condition': 'loanDetail.payTypeInstallment',
          },
          {
            'key': 'loanPaymentSheet.receiptMessage',
            'value':
                '{{loanDetail.nextInstallmentTitle}} به مبلغ {{loanDetail.nextInstallmentAmount}} ریال پرداخت گردید',
            'condition': 'loanDetail.payTypeInstallment',
          },
          {
            'key': 'loanPaymentSheet.subtitle',
            'value': 'تسویه وام',
            'condition': 'loanDetail.payTypeSettlement',
          },
          {
            'key': 'loanPaymentSheet.amount',
            'value': '{{loanDetail.settlementPayableAmount}}',
            'condition': 'loanDetail.payTypeSettlement',
          },
          {
            'key': 'loanPaymentSheet.receiptMessage',
            'value': 'تسویه تسهیلات با موفقیت انجام شد',
            'condition': 'loanDetail.payTypeSettlement',
          },
          {
            'key': 'loanPaymentSheet.showSubtitle',
            'value': false,
            'condition': 'loanDetail.payTypeCustom',
          },
          {
            'key': 'loanPaymentSheet.amount',
            'value': '{{loanDetail.customPayableAmountDisplay}}',
            'condition': 'loanDetail.payTypeCustom',
          },
          {
            'key': 'loanPaymentSheet.receiptMessage',
            'value':
                'مبلغ {{loanDetail.customPayableAmountDisplay}} ریال پرداخت گردید',
            'condition': 'loanDetail.payTypeCustom',
          },
          {
            'key': 'loanPaymentSheet.showSubtitle',
            'value': true,
            'condition': 'loanDetail.customByInstallmentCount',
          },
          {
            'key': 'loanPaymentSheet.subtitle',
            'value': '{{loanDetail.customInstallmentCount}} قسط انتخاب شده',
            'condition': 'loanDetail.customByInstallmentCount',
          },
          {
            'key': 'loanPaymentSheet.amount',
            'value': '{{loanDetail.customCountPayableAmount}}',
            'condition': 'loanDetail.customByInstallmentCount',
          },
          {
            'key': 'loanPaymentSheet.receiptMessage',
            'value': '{{loanDetail.customInstallmentCount}} قسط پرداخت گردید',
            'condition': 'loanDetail.customByInstallmentCount',
          },
        ],
      ),
      StacShowBottomSheetAction(
        backgroundColor: '#8B63708C',
        sheet: _buildPaymentAccountsBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _buildPaymentAccountsBottomSheet() {
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
            data: '{{loanPaymentSheet.title}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacCustomVisibility(
            visible: '[[loanPaymentSheet.showSubtitle]]',
            child: StacText(
              data: '{{loanPaymentSheet.subtitle}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          StacSizedBox(height: 6),
          StacCenter(
            child: _amountWithRial(
              amount: '{{loanPaymentSheet.amount}}',
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
            ),
          ),
          StacSizedBox(height: 16),
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
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 12),
          _paymentAccountCard(
            selectedKey: 'loanPaymentSheet.acc1Selected',
            onTap: _selectPaymentAccount(canSubmit: true, account: 1),
            title: 'سپرده ۶ ماهه کوتاه مدت توبانکی',
            depositNo: '۱۱۰.۷۰۰.۲۱۰.۱۲۴۱۵۷۱.۱',
            cardNo: '۵۵۹۴ - ۱۶۱۷ - ۱۲۳۴ - ۵۶۷۸',
            amount: '۸۱۱,۱۲۴,۶۰۷ ریال',
            isInsufficient: false,
          ),
          StacSizedBox(height: 10),
          _paymentAccountCard(
            selectedKey: 'loanPaymentSheet.acc2Selected',
            onTap: _selectPaymentAccount(canSubmit: false, account: 2),
            title: 'سپرده حقیقی سپرده سرمایه‌گذاری بلند مدت',
            depositNo: '۱۱۰.۷۰۰.۲۱۰.۱۲۴۱۵۷۱.۱',
            cardNo: '۵۵۹۴ - ۱۶۱۷ - ۱۲۳۴ - ۵۶۷۸',
            amount: '۷۴۵,۵۲۴,۶۰۷ ریال',
            isInsufficient: true,
          ),
          StacSizedBox(height: 20),
          StacCustomVisibility(
            visible: '[[loanPaymentSheet.canSubmit]]',
            child: _paymentSheetSubmitButton(enabled: true).toJson(),
            replacement: _paymentSheetSubmitButton(enabled: false).toJson(),
          ),
          StacSizedBox(height: 7),
        ],
      ),
    ),
  );
}

StacAction _selectPaymentAccount({
  required bool canSubmit,
  required int account,
}) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'loanPaymentSheet.acc1Selected', 'value': account == 1},
      {'key': 'loanPaymentSheet.acc2Selected', 'value': account == 2},
      {'key': 'loanPaymentSheet.canSubmit', 'value': canSubmit},
    ],
  );
}

StacWidget _paymentSheetSubmitButton({required bool enabled}) {
  return StacFilledButton(
    onPressed: enabled
        ? StacSequenceAction(
            actions: [
              const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              StacNavigateAction(
                widgetJson: installment_payment_receipt_dart
                    .installmentPaymentReceipt()
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
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(6)),
      elevation: 0,
    ),
    child: StacText(
      data: 'تایید و پرداخت',
      style: StacTextStyle(
        fontSize: 17,
        fontWeight: StacFontWeight.w700,
        color: enabled ? '#FFFFFF' : '#98A2B3',
      ),
    ),
  );
}

StacWidget _paymentAccountCard({
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
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
            StacSizedBox(width: 10),
            _paymentAccountRadio(selectedKey),
          ],
        ),
        StacSizedBox(height: 12),
        _paymentSheetMetaRow(label: 'شماره سپرده', value: depositNo),
        StacSizedBox(height: 8),
        _paymentSheetMetaRow(label: 'شماره کارت', value: cardNo),
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
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: statusColor,
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: amount,
              textDirection: StacTextDirection.ltr,
              style: StacTextStyle(
                fontSize: 15,
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
                    fontSize: 12,
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

StacWidget _paymentAccountRadio(String selectedKey) {
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

StacWidget _paymentSheetMetaRow({
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
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacText(
        data: value,
        textDirection: StacTextDirection.ltr,
        style: StacTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _buildLoanDetailMoreBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 18),
          StacText(
            data: 'گزینه‌های بیشتر',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 6),
          StacText(
            data: '{{loanDetail.appBarTitle}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 15,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 14),
          _loanMoreOptionItem(
            title: 'ارسال لینک مستقیم پرداخت به دیگران',
            showSoon: true,
            onTap: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
          ),
          StacDivider(
            color: '{{appColors.current.input.borderEnabled}}',
            thickness: 1,
            height: 16,
          ),
          _loanMoreOptionItem(
            title: 'جزئیات وام',
            showSoon: false,
            onTap: StacSequenceAction(
              actions: [
                const StacNavigateAction(navigationStyle: NavigationStyle.pop),
                StacShowBottomSheetAction(
                  backgroundColor: '#8B63708C',
                  sheet: _buildLoanMoreDetailBottomSheet().toJson(),
                ),
              ],
            ),
          ),
          StacDivider(
            color: '{{appColors.current.input.borderEnabled}}',
            thickness: 1,
            height: 16,
          ),
          _loanMoreOptionItem(
            title: 'پرداخت خودکار اقساط',
            showSoon: true,
            onTap: const StacNavigateAction(navigationStyle: NavigationStyle.pop),
          ),
        ],
      ),
    ),
  );
}

StacWidget _loanMoreOptionItem({
  required String title,
  required bool showSoon,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      width: 999999,
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacExpanded(child: StacSizedBox()),
          if (showSoon)
            StacContainer(
              padding: StacEdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: StacBoxDecoration(
                color: '{{appColors.current.text.title}}',
                borderRadius: StacBorderRadius.all(999),
              ),
              child: StacText(
                data: 'به زودی',
                style: StacTextStyle(
                  fontSize: 13,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.background.surface}}',
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

StacWidget _buildLoanMoreDetailBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'جزئیات وام',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _loanMoreDetailRow(label: 'مبلغ وام', value: '{{loanDetail.approvedAmount}}'),
          _loanMoreDetailDivider(),
          _loanMoreDetailRow(label: 'مانده کل وام', value: '{{loanDetail.debtAmount}}'),
          _loanMoreDetailDivider(),
          _loanMoreDetailRow(label: 'تاریخ اعطای وام', value: '۱۴۰۱/۰۶/۱۲'),
          _loanMoreDetailDivider(),
          _loanMoreDetailRow(label: 'تاریخ آخرین بازپرداخت', value: '۱۴۰۵/۰۲/۳۰'),
          _loanMoreDetailDivider(),
          _loanMoreDetailRow(
            label: 'شماره پرونده تسهیلات',
            value: '۱۴۴-۳۰۲۰-۷۶۳۰۲۰-۱',
          ),
        ],
      ),
    ),
  );
}

StacWidget _loanMoreDetailRow({required String label, required String value}) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 12),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _loanMoreDetailDivider() {
  return StacContainer(height: 1, color: '{{appColors.current.input.borderEnabled}}');
}

StacWidget _amountWithRial({
  required String amount,
  required double fontSize,
  required StacFontWeight fontWeight,
}) {
  return StacRow(
    mainAxisSize: StacMainAxisSize.min,
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: amount,
        style: StacTextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(width: 4),
      StacText(
        data: 'ریال',
        style: StacTextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _paymentChip({required String title, required bool active}) {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.symmetric(horizontal: 6, vertical: 8),
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: active ? '#00BABA' : '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacText(
      data: title,
      textAlign: StacTextAlign.center,
      style: StacTextStyle(
        fontSize: 14,
        fontWeight: StacFontWeight.w600,
        color: active ? '#00BABA' : '{{appColors.current.text.title}}',
      ),
    ),
  );
}

StacWidget _reactivePaymentChip({
  required String title,
  required String visibleKey,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomWidget.fromJson({
      'type': 'visibility',
      'visible': '[[$visibleKey]]',
      'replacement': _paymentChip(title: title, active: false).toJson(),
      'child': _paymentChip(title: title, active: true).toJson(),
    }),
  );
}

StacWidget _paymentTypeInfoRow({
  required String title,
  required String amount,
}) {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: title,
        style: StacTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      _amountWithRial(
        amount: amount,
        fontSize: 18,
        fontWeight: StacFontWeight.w700,
      ),
    ],
  );
}

StacWidget _customPaymentContent() {
  return StacColumn(
    children: [
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[!loanDetail.customByInstallmentCount]]',
        'child': _customDesiredAmountSection().toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[loanDetail.customByInstallmentCount]]',
        'child': _customInstallmentCountPicker().toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
      StacSizedBox(height: 32),
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[!loanDetail.customByInstallmentCount]]',
        'child': StacGestureDetector(
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'loanDetail.customByInstallmentCount', 'value': true},
              {'key': 'loanDetail.customInstallmentCountRaw', 'value': '0.0'},
              {'key': 'loanDetail.customInstallmentCount', 'value': '۰'},
              {'key': 'loanDetail.customAmountWords', 'value': ''},
              {'key': 'loanDetail.customPayEnabled', 'value': false},
            ],
          ),
          child: StacText(
            data: 'تغییر به تعداد قسط',
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w500,
              color: '#D61F2C',
            ),
          ),
        ).toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[loanDetail.customByInstallmentCount]]',
        'child': StacGestureDetector(
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'loanDetail.customByInstallmentCount', 'value': false},
              {'key': 'loanDetail.customAmountInput', 'value': ''},
              {'key': 'loanDetail.customPayableAmountDisplay', 'value': '۰'},
              {'key': 'loanDetail.customAmountWords', 'value': ''},
              {'key': 'loanDetail.customPayEnabled', 'value': false},
            ],
          ),
          child: StacText(
            data: 'تغییر به مبلغ دلخواه',
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w500,
              color: '#D61F2C',
            ),
          ),
        ).toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
      StacSizedBox(height: 24),
      StacDivider(
        height: 1,
        thickness: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      StacSizedBox(height: 18),
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[!loanDetail.customByInstallmentCount]]',
        'child': _paymentTypeInfoRow(
          title: 'مبلغ قابل پرداخت',
          amount: '{{loanDetail.customPayableAmountDisplay}}',
        ).toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
      StacCustomWidget.fromJson({
        'type': 'visibility',
        'visible': '[[loanDetail.customByInstallmentCount]]',
        'child': _paymentTypeInfoRow(
          title: 'مبلغ قابل پرداخت',
          amount: '{{loanDetail.customCountPayableAmount}}',
        ).toJson(),
        'replacement': StacSizedBox().toJson(),
      }),
    ],
  );
}

StacWidget _customDesiredAmountSection() {
  return StacColumn(
    children: [
      _customDesiredAmountInput(),
      StacSizedBox(height: 8),
      StacCustomWidget.fromJson({
        'type': 'registryReactive',
        'registryKey': 'loanDetail.customAmountWords',
        'child': {
          'type': 'text',
          'data': '{{loanDetail.customAmountWords}}',
          'textDirection': 'rtl',
          'textAlign': 'center',
          'style': {
            'fontSize': 12,
            'fontWeight': 'w500',
            'color': '{{appColors.current.text.hint}}',
          },
        },
      }),
    ],
  );
}

StacWidget _customDesiredAmountInput() {
  return StacCustomTextFormField(
    id: 'loan_detail_custom_amount',
    textDirection: 'rtl',
    textAlign: 'center',
    keyboardType: 'number',
    formatThousands: true,
    thousandsSeparator: ',',
    inputFormatters: const [
      {'type': 'allow', 'rule': '[0-9۰-۹]'},
    ],
    onChanged: const StacCustomSetValueAction(
      values: [
        {'key': 'loanDetail.customPayEnabled', 'value': false},
        {
          'key': 'loanDetail.customAmountInput',
          'value': StacGetFormValueAction(id: 'loan_detail_custom_amount'),
        },
        {
          'key': 'loanDetail.customPayableAmountDisplay',
          'value': StacGetFormValueAction(id: 'loan_detail_custom_amount'),
        },
        {
          'key': 'loanDetail.customPayEnabled',
          'value': true,
          'condition': 'loanDetail.customAmountInput >= 10000',
        },
      ],
      action: StacAmountToWordsAction(
        sourceKey: 'loanDetail.customAmountInput',
        destinationKey: 'loanDetail.customAmountWords',
        divideBy: 10,
        minDigits: 2,
        suffix: 'تومان',
      ),
    ),
    decoration: {
      'hintText': 'مبلغ دلخواه',
      'hintStyle': {
        'textDirection': 'rtl',
        'style': {
          'color': '{{appColors.current.text.hint}}',
          'fontSize': 16,
          'fontWeight': 'w500',
        },
      },
      'enabledBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {'color': '#8F2B3A', 'width': 1.2},
        'borderRadius': {'all': 12},
      },
      'focusedBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {'color': '#8F2B3A', 'width': 1.2},
        'borderRadius': {'all': 12},
      },
      'prefixText': 'ریال',
      'prefixStyle': {
        'color': '{{appColors.current.text.title}}',
        'fontSize': 16,
        'fontWeight': 'w600',
      },
      'contentPadding': {'left': 16, 'top': 12, 'right': 16, 'bottom': 12},
    },
    style: const {
      'fontSize': 17,
      'fontWeight': 'w600',
      'color': '{{appColors.current.text.title}}',
    },
  );
}

StacWidget _customInstallmentCountPicker() {
  return StacColumn(
    children: [
      StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: 'تعداد قسط',
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacCustomWidget.fromJson({
            'type': 'registryReactive',
            'registryKey': 'loanDetail.customInstallmentCount',
            'child': {
              'type': 'text',
              'data': '{{loanDetail.customInstallmentCount}}',
              'style': {
                'fontSize': 17,
                'fontWeight': 'w600',
                'color': '{{appColors.current.text.title}}',
              },
            },
          }),
        ],
      ),
      StacSizedBox(height: 10),
      StacCustomWidget.fromJson({
        'type': 'tobankSeekBar',
        'id': 'loan_detail_custom_count_slider',
        'initialValue': 0,
        'min': 0,
        'max': '{{loanDetail.remainingInstallments}}',
        'activeTrackHeight': 10,
        'inactiveTrackHeight': 6,
        'thumbSize': 24,
        'activeTrackColor': '#00BABA',
        'inactiveTrackColor': '{{appColors.current.input.borderEnabled}}',
        'thumbColor': '#6ED5D5',
        'perInstallmentAmountKey': 'loanDetail.nextInstallmentAmount',
        'computedAmountDestinationKey': 'loanDetail.customCountPayableAmount',
        'onChanged': const StacCustomSetValueAction(
          values: [
            {
              'key': 'loanDetail.customInstallmentCountRaw',
              'value': StacGetFormValueAction(
                id: 'loan_detail_custom_count_slider',
              ),
            },
            {
              'key': 'loanDetail.customInstallmentCount',
              'value':
                  "{{replace(loanDetail.customInstallmentCountRaw,'.0','')}}",
            },
            {'key': 'loanDetail.customPayEnabled', 'value': false},
            {
              'key': 'loanDetail.customPayEnabled',
              'value': true,
              'condition': 'loanDetail.customInstallmentCountRaw >= 1',
            },
          ],
        ).toJson(),
      }),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 4),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacText(
              data: '۰',
              style: StacTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacCustomWidget.fromJson({
              'type': 'registryReactive',
              'registryKey': 'loanDetail.remainingInstallmentsLabel',
              'child': {
                'type': 'text',
                'data': '{{loanDetail.remainingInstallmentsLabel}}',
                'style': {
                  'fontSize': 14,
                  'fontWeight': 'w500',
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
            }),
          ],
        ),
      ),
    ],
  );
}

StacWidget _historySection() {
  return StacColumn(
    children: [
      StacTabBar(
        tabs: const [
          StacTab(text: 'پرداخت شده'),
          StacTab(text: 'پرداخت نشده'),
        ],
        indicatorColor: '#E31C3D',
        indicatorWeight: 3,
        labelColor: '{{appColors.current.text.title}}',
        unselectedLabelColor: '{{appColors.current.text.title}}',
        labelStyle: StacTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
        ),
        unselectedLabelStyle: StacTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
        ),
        dividerColor: '{{appColors.current.input.borderEnabled}}',
        dividerHeight: 1,
      ),
      StacSizedBox(
        height: 560,
        child: StacTabBarView(
          physics: StacScrollPhysics.never,
          children: [_paidInstallmentsList(), _unpaidInstallmentsList()],
        ),
      ),
    ],
  );
}

StacWidget _unpaidInstallmentsList() {
  const items = [
    _InstallmentHistoryItemData(
      date: '۱۴۰۳/۰۵/۲۲',
      installmentTitle: 'قسط ۳',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۳/۰۵/۲۲',
      installmentTitle: 'قسط ۴',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
  ];

  return StacContainer(
    decoration: StacBoxDecoration(
      border: StacBorder(
        top: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
        bottom: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
    ),
    child: _installmentsColumn(items: items, isPaid: false),
  );
}

StacWidget _paidInstallmentsList() {
  const items = [
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۰۷/۱۲',
      installmentTitle: 'قسط ۱',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۰۸/۱۲',
      installmentTitle: 'قسط ۲',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۰۹/۱۲',
      installmentTitle: 'قسط ۳',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۱۰/۱۲',
      installmentTitle: 'قسط ۴',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۱۱/۱۲',
      installmentTitle: 'قسط ۵',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
    _InstallmentHistoryItemData(
      date: '۱۴۰۱/۱۲/۱۲',
      installmentTitle: 'قسط ۶',
      amount: '۲۵,۳۹۳,۰۰۰ ریال',
    ),
  ];

  return StacContainer(
    decoration: StacBoxDecoration(
      border: StacBorder(
        top: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
        bottom: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
    ),
    child: _installmentsColumn(items: items, isPaid: true),
  );
}

StacWidget _installmentsColumn({
  required List<_InstallmentHistoryItemData> items,
  required bool isPaid,
}) {
  final children = <StacWidget>[];
  for (var i = 0; i < items.length; i++) {
    children.add(
      _installmentHistoryRow(
        date: items[i].date,
        installmentTitle: items[i].installmentTitle,
        amount: items[i].amount,
        isPaid: isPaid,
      ),
    );
    if (i < items.length - 1) {
      children.add(
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      );
    }
  }
  return StacColumn(children: children);
}

StacWidget _installmentHistoryRow({
  required String date,
  required String installmentTitle,
  required String amount,
  required bool isPaid,
}) {
  final amountValue = amount
      .replaceAll('ریال', '')
      .replaceAll('rial', '')
      .trim();

  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 16),
    child: StacStack(
      alignment: StacAlignment.centerRight,
      children: [
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 20),
          child: StacImage(
            src: isPaid
                ? 'assets/icons/loan_detail_history_item_payed.svg'
                : 'assets/icons/ic_calendar.svg',
            imageType: StacImageType.asset,
            width: 17,
            height: 17,
            color: isPaid ? null : '{{appColors.current.text.title}}',
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 50),
          child: StacRow(
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacColumn(
                children: [
                  StacRow(
                    mainAxisSize: StacMainAxisSize.min,
                    children: [
                      StacText(
                        data: 'ریال',
                        style: StacTextStyle(
                          fontSize: 15,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(width: 4),
                      StacText(
                        data: amountValue,
                        style: StacTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 8),
                  StacText(
                    data: 'مبلغ',
                    textAlign: StacTextAlign.center,
                    style: StacTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                ],
              ),
              StacColumn(
                children: [
                  StacText(
                    data: date,
                    style: StacTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 8),
                  StacText(
                    data: installmentTitle,
                    style: StacTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _InstallmentHistoryItemData {
  final String date;
  final String installmentTitle;
  final String amount;

  const _InstallmentHistoryItemData({
    required this.date,
    required this.installmentTitle,
    required this.amount,
  });
}

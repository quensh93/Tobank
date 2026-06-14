import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'installment_payment_others_detail_main.dart';

@StacScreen(screenName: 'installment_payment_others_main')
StacWidget installmentPaymentOthersMain() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'othersLoanContinueEnabled',
      value: false,
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'پرداخت اقساط دیگران',
        showSupport: true,
        showBack: true,
      ),
      body: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacContainer(
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
                data: 'شماره تسهیلات',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacExpanded(
                    flex: 4,
                    child: _othersInputBox(id: 'others_loan_4'),
                  ),
                  _dashBetween(),
                  StacExpanded(
                    flex: 7,
                    child: _othersInputBox(id: 'others_loan_3'),
                  ),
                  _dashBetween(),
                  StacExpanded(
                    flex: 5,
                    child: _othersInputBox(id: 'others_loan_2'),
                  ),
                  _dashBetween(),
                  StacExpanded(
                    flex: 5,
                    child: _othersInputBox(id: 'others_loan_1'),
                  ),
                ],
              ),
              StacSizedBox(height: 30),
              StacText(
                data: 'کدملی دارنده تسهیلات',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              _othersInputBox(id: 'others_national_code', maxLength: 10),
              StacSizedBox(height: 30),
              StacCustomReactiveElevatedButton(
                enabledKey: 'othersLoanContinueEnabled',
                onPressed: StacRawJsonAction({
                  'actionType': 'showInstallmentPaymentOthersResultDialog',
                  'nationalCodeFieldId': 'others_national_code',
                  'defaultAction': StacNavigateAction(
                    widgetJson: installmentPaymentOthersDetailMain().toJson(),
                    navigationStyle: NavigationStyle.push,
                  ).toJson(),
                }),
                style: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  fixedSize: StacSize(999999, 50),
                  backgroundColor: '{{appColors.current.input.borderEnabled}}',
                  foregroundColor: '{{appColors.current.text.subtitle}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                ).toJson(),
                child: StacText(
                  data: 'ادامه',
                  style: StacTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
                loadingChild: StacText(
                  data: 'ادامه',
                  style: StacTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.primary.onPrimary}}',
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

StacWidget _othersInputBox({required String id, int? maxLength}) {
  return StacCustomTextFormField(
    id: id,
    keyboardType: 'number',
    maxLength: maxLength,
    inputFormatters: const [
      {'type': 'allow', 'rule': '[0-9۰-۹]'},
    ],
    onChanged: _othersValidationAction(),
    textDirection: 'ltr',
    textAlign: 'center',
    decoration: {
      'hintText': '',
      'enabledBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1.0,
        },
        'borderRadius': {'all': 12},
      },
      'focusedBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1.0,
        },
        'borderRadius': {'all': 12},
      },
      'contentPadding': {'left': 8, 'top': 18, 'right': 8, 'bottom': 18},
    },
    style: const {
      'fontSize': 18,
      'fontWeight': 'w600',
      'color': '{{appColors.current.text.title}}',
    },
  );
}

StacValidateFieldsAction _othersValidationAction() {
  return StacValidateFieldsAction(
    resultKey: 'othersLoanContinueEnabled',
    fields: const [
      {'id': 'others_loan_1'},
      {'id': 'others_loan_2'},
      {'id': 'others_loan_3'},
      {'id': 'others_loan_4'},
      {'id': 'others_national_code', 'rule': r'^\d{10}$'},
    ],
  );
}

StacWidget _dashBetween() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 4),
    child: StacContainer(
      width: 2,
      height: 1,
      color: '{{appColors.current.input.borderEnabled}}',
    ),
  );
}

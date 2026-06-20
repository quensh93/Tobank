import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_guarantee/widget/promissory_guarantee_deposit_bottom_sheet.dart'
    as guarantee_deposit_bottom_sheet_dart;

@StacScreen(screenName: 'promissory_guarantee_confirm_page')
StacWidget promissoryGuaranteeConfirmPage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'isGuaranteeConfirmEnabled',
      value: false,
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: '{{appStrings.promissory.guaranteePromissory}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.always,
        child: StacSingleChildScrollView(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildInfoCard(),
                StacSizedBox(height: 24),
                _buildMultilineField(
                  id: 'guarantee_payment_address',
                  title: '{{appStrings.profile.real.bankInfo.addressLabel}}',
                  hint:
                      '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.payment_place_address_until}}',
                ),
                StacSizedBox(height: 24),
                _buildMultilineField(
                  id: 'guarantee_description',
                  title: '{{appStrings.promissory.descriptionLabel}}',
                  hint:
                      '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.description_guarantee_until}}',
                ),
                StacSizedBox(height: 40),
                StacCustomReactiveElevatedButton(
                  enabledKey: 'isGuaranteeConfirmEnabled',
                  enabled: false,
                  onPressed: StacShowBottomSheetAction(
                    title: 'promissory_confirm',
                    isScrollControlled: true,
                    useSafeArea: false,
                    heightFactor: 0.67,
                    backgroundColor: '#00000000',
                    barrierColor: '#55000000',
                    sheet: guarantee_deposit_bottom_sheet_dart
                        .promissoryGuaranteeDepositBottomSheet()
                        .toJson(),
                  ),
                  style: StacButtonStyle(
                    backgroundColor: '#D91F2A',
                    foregroundColor: '#FFFFFF',
                    elevation: 0,
                    fixedSize: StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  disabledStyle: StacButtonStyle(
                    backgroundColor: '#E8A0A5',
                    foregroundColor: '#FFFFFF',
                    elevation: 0,
                    fixedSize: StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  child: StacText(
                    data: '{{appStrings.authentication.confirmAndContinue}}',
                    style: StacTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                    ),
                  ).toJson(),
                ),
                StacSizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

StacWidget _buildInfoCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _sectionTitle('{{appStrings.promissory.dataTitle}}'),
          StacSizedBox(height: 8),
          StacDivider(
            thickness: 1,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(height: 8),
          _buildKeyValue(
            '{{appStrings.promissory.amountLabel}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.rial}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.promissory.payDate}}',
            '{{appStrings.promissory.onDemand}}',
          ),
          StacSizedBox(height: 16),
          _buildLabelValue(
            '{{appStrings.promissory.descriptionLabel}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.promissory_loan}}',
          ),
          StacSizedBox(height: 16),
          _buildLabelValue(
            '{{appStrings.promissory.paymentPlaceLabel}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.plaque}}',
          ),
          StacSizedBox(height: 16),
          StacDivider(
            thickness: 1,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(height: 16),
          _sectionTitle('{{appStrings.promissory.issuerTitle}}'),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.login.nationalCodeTitle}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.title}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.promissory.issuerPhoneNumber}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.amount_value}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.generated.child_loan.child_loan_customer_check.name}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.sample_person_name}}',
          ),
          StacSizedBox(height: 16),
          _buildLabelValue(
            '{{appStrings.promissory.residencesAddress}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.plaque_unit_floor}}',
          ),
          StacSizedBox(height: 16),
          StacDivider(
            thickness: 1,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(height: 16),
          _sectionTitle(
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.information}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.promissory.nationalId}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.amount_value_text}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.promissory.contactNumber}}',
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.amount_value_label}}',
          ),
          StacSizedBox(height: 16),
          _buildKeyValue(
            '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.name}}',
            '{{appStrings.generated.transfer.transfer_card_result.bank}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildMultilineField({
  required String id,
  required String title,
  required String hint,
}) {
  final hasValueKey = '${id}_has_value';
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacCustomTextFormField(
        id: id,
        textDirection: 'rtl',
        textAlign: 'right',
        supportTextDirection: 'rtl',
        autovalidateMode: 'always',
        maxLength: 200,
        minLines: 4,
        maxLines: 6,
        style: {
          'type': 'custom',
          'fontSize': 16,
          'fontWeight': 'w700',
          'color': '{{appColors.current.text.title}}',
        },
        decoration: {
          'hintText': hint,
          'filled': false,
          'hintStyle': {
            'type': 'custom',
            'fontSize': 14,
            'fontWeight': 'w400',
            'color': '{{appColors.current.text.subtitle}}',
          },
          'hintTextDirection': 'rtl',
          'hintTextAlign': 'right',
          'contentPadding': {'left': 16, 'top': 16, 'right': 16, 'bottom': 16},
          'prefixIcon': {
            'type': 'visibility',
            'visible': '[[$hasValueKey]]',
            'child': {
              'type': 'gestureDetector',
              'onTap': {
                'actionType': 'sequence',
                'actions': [
                  {
                    'actionType': 'setValue',
                    'values': [
                      {'key': id, 'value': ''},
                      {'key': hasValueKey, 'value': false},
                    ],
                  },
                  {
                    'actionType': 'validateFields',
                    'resultKey': 'isGuaranteeConfirmEnabled',
                    'fields': [
                      {
                        'id': 'guarantee_payment_address',
                        'rule': r'^.{1,200}$',
                      },
                      {'id': 'guarantee_description', 'rule': r'^.{1,200}$'},
                    ],
                  },
                ],
              },
              'child': {
                'type': 'padding',
                'padding': {'all': 12},
                'child': {
                  'type': 'icon',
                  'icon': 'close',
                  'size': 20,
                  'color': '{{appColors.current.text.title}}',
                },
              },
            },
            'replacement': {'type': 'sizedBox', 'width': 24},
          },
          'border': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1},
            'borderRadius': {'all': 10},
          },
          'enabledBorder': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1},
            'borderRadius': {'all': 10},
          },
          'focusedBorder': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1.2},
            'borderRadius': {'all': 10},
          },
        },
        keyboardType: 'multiline',
        textInputAction: 'next',
        validatorRules: const [
          {
            'rule': 'matches',
            'options': {'pattern': r'^.{1,200}$'},
            'message':
                '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.required_field_message}}',
          },
        ],
        onChanged: StacSequenceAction(
          actions: [
            StacValidateFieldsAction(
              resultKey: hasValueKey,
              fields: [
                {'id': id, 'rule': r'^.{1,200}$'},
              ],
            ),
            _confirmValidationAction(),
          ],
        ),
      ),
    ],
  );
}

StacWidget _sectionTitle(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildKeyValue(String key, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data: key,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
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
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildLabelValue(String label, String value) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
          height: 1.6,
        ),
      ),
    ],
  );
}

StacValidateFieldsAction _confirmValidationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'isGuaranteeConfirmEnabled',
    fields: [
      {'id': 'guarantee_payment_address', 'rule': r'^.{1,200}$'},
      {'id': 'guarantee_description', 'rule': r'^.{1,200}$'},
    ],
  );
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'card_management_reissue_request')
StacWidget dashboardCardReissueRequest() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'cardsManagement.reissue.addressNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.card_management.card_management_reissue_color.card_reissue}}',
        showBack: true,
        backOnRight: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _addressLabel(
                text:
                    '{{appStrings.generated.card_management.card_management_reissue_request.county_city}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_city',
                textDirection: 'rtl',
                textAlign: 'right',
                initialValue:
                    '{{appStrings.generated.card_management.card_management_reissue_request.sample_city_pair}}',
                readOnly: true,
                enabled: false,
                style: {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
                decoration: {
                  'filled': true,
                  'fillColor':
                      '{{appColors.current.background.surfaceContainerLow}}',
                  'disabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 20),
              _addressLabel(
                text:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.county}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_county',
                textDirection: 'rtl',
                textAlign: 'right',
                supportTextDirection: 'rtl',
                autovalidateMode: 'always',
                validatorRules: const [
                  {
                    'rule': 'matches',
                    'options': {'pattern': r'^.*\S.*$'},
                    'message':
                        '{{appStrings.generated.card_management.card_management_reissue_request.county_enter}}',
                  },
                ],
                onChanged: _addressValidateAction(),
                decoration: {
                  'hintText':
                      '{{appStrings.generated.card_management.card_management_reissue_request.county_enter_data}}',
                  'hintStyle': {
                    'textDirection': 'rtl',
                    'style': {
                      'color': '{{appColors.current.text.hint}}',
                      'fontSize': 14,
                    },
                  },
                  'errorStyle': {
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {'fontSize': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'focusedBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color':
                          '{{appColors.current.button.primary.backgroundColor}}',
                      'width': 1.5,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 20),
              _addressLabel(
                text:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.street_main}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_street',
                textDirection: 'rtl',
                textAlign: 'right',
                supportTextDirection: 'rtl',
                autovalidateMode: 'always',
                validatorRules: const [
                  {
                    'rule': 'matches',
                    'options': {'pattern': r'^.*\S.*$'},
                    'message':
                        '{{appStrings.generated.card_management.card_management_reissue_request.street_main_enter}}',
                  },
                ],
                onChanged: _addressValidateAction(),
                decoration: {
                  'hintText':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.street_main_enter}}',
                  'hintStyle': {
                    'textDirection': 'rtl',
                    'style': {
                      'color': '{{appColors.current.text.hint}}',
                      'fontSize': 14,
                    },
                  },
                  'errorStyle': {
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {'fontSize': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'focusedBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color':
                          '{{appColors.current.button.primary.backgroundColor}}',
                      'width': 1.5,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 20),
              _addressLabel(
                text:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.street}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_alley',
                textDirection: 'rtl',
                textAlign: 'right',
                supportTextDirection: 'rtl',
                autovalidateMode: 'always',
                validatorRules: const [
                  {
                    'rule': 'matches',
                    'options': {'pattern': r'^.*\S.*$'},
                    'message':
                        '{{appStrings.generated.card_management.card_management_reissue_request.street_enter}}',
                  },
                ],
                onChanged: _addressValidateAction(),
                decoration: {
                  'hintText':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.street_enter}}',
                  'hintStyle': {
                    'textDirection': 'rtl',
                    'style': {
                      'color': '{{appColors.current.text.hint}}',
                      'fontSize': 14,
                    },
                  },
                  'errorStyle': {
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {'fontSize': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'focusedBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color':
                          '{{appColors.current.button.primary.backgroundColor}}',
                      'width': 1.5,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 20),
              _addressLabel(
                text:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.plaque}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_plaque',
                textDirection: 'rtl',
                textAlign: 'right',
                supportTextDirection: 'rtl',
                autovalidateMode: 'always',
                keyboardType: 'number',
                inputFormatters: const [
                  {'type': 'allow', 'rule': '[0-9۰-۹]'},
                ],
                validatorRules: const [
                  {
                    'rule': 'matches',
                    'options': {'pattern': r'^[0-9۰-۹]+$'},
                    'message':
                        '{{appStrings.generated.card_management.card_management_reissue_request.plaque_enter}}',
                  },
                ],
                onChanged: _addressValidateAction(),
                decoration: {
                  'hintText':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.plaque_enter}}',
                  'hintStyle': {
                    'textDirection': 'rtl',
                    'style': {
                      'color': '{{appColors.current.text.hint}}',
                      'fontSize': 14,
                    },
                  },
                  'errorStyle': {
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {'fontSize': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'focusedBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color':
                          '{{appColors.current.button.primary.backgroundColor}}',
                      'width': 1.5,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 20),
              _addressLabel(
                text:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.unit}}',
              ),
              StacSizedBox(height: 8),
              StacCustomTextFormField(
                id: 'reissue_unit',
                textDirection: 'rtl',
                textAlign: 'right',
                supportTextDirection: 'rtl',
                autovalidateMode: 'always',
                keyboardType: 'number',
                inputFormatters: const [
                  {'type': 'allow', 'rule': '[0-9۰-۹]'},
                ],
                validatorRules: const [
                  {
                    'rule': 'matches',
                    'options': {'pattern': r'^[0-9۰-۹]+$'},
                    'message':
                        '{{appStrings.generated.card_management.card_management_reissue_request.unit_enter}}',
                  },
                ],
                onChanged: _addressValidateAction(),
                decoration: {
                  'hintText':
                      '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.unit_enter}}',
                  'hintStyle': {
                    'textDirection': 'rtl',
                    'style': {
                      'color': '{{appColors.current.text.hint}}',
                      'fontSize': 14,
                    },
                  },
                  'errorStyle': {
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {'fontSize': 12},
                  },
                  'enabledBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color': '{{appColors.current.input.borderEnabled}}',
                      'width': 1,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'focusedBorder': {
                    'type': 'outlineInputBorder',
                    'borderSide': {
                      'color':
                          '{{appColors.current.button.primary.backgroundColor}}',
                      'width': 1.5,
                    },
                    'borderRadius': {'all': 12},
                  },
                  'contentPadding': {
                    'left': 16,
                    'top': 16,
                    'right': 16,
                    'bottom': 16,
                  },
                },
              ),
              StacSizedBox(height: 24),
              StacCustomReactiveElevatedButton(
                enabledKey: 'cardsManagement.reissue.addressNextEnabled',
                onPressed: NavigationAction(
                  fileName: 'card_management_reissue_color',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                ),
                style: StacButtonStyle(
                  padding: StacEdgeInsets.symmetric(vertical: 8),
                  minimumSize: const StacSize(0, 56),
                  backgroundColor:
                      '{{appColors.current.button.primary.backgroundColor}}',
                  foregroundColor:
                      '{{appColors.current.button.primary.foregroundColor}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  padding: StacEdgeInsets.symmetric(vertical: 8),
                  minimumSize: const StacSize(0, 56),
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  foregroundColor: '{{appColors.current.text.hint}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                child: StacText(
                  data: '{{appStrings.authentication.confirmAndContinue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w700,
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

StacAction _addressValidateAction() {
  return const StacValidateFieldsAction(
    resultKey: 'cardsManagement.reissue.addressNextEnabled',
    fields: [
      {'id': 'reissue_county', 'rule': r'^.*\S.*$'},
      {'id': 'reissue_street', 'rule': r'^.*\S.*$'},
      {'id': 'reissue_alley', 'rule': r'^.*\S.*$'},
      {'id': 'reissue_plaque', 'rule': r'^[0-9۰-۹]+$'},
      {'id': 'reissue_unit', 'rule': r'^[0-9۰-۹]+$'},
    ],
  );
}

StacWidget _addressLabel({required String text}) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 14,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

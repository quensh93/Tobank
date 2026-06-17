import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

const _secondaryPinCurrentFieldId = 'secondary_pin_current';
const _secondaryPinNewFieldId = 'secondary_pin_new';
const _secondaryPinConfirmFieldId = 'secondary_pin_confirm';
const _secondaryPinEnabledKey =
    'cardsManagement.secondaryPinChange.submitEnabled';

@StacScreen(screenName: 'card_management_secondary_pin_change')
StacWidget dashboardSecondaryPinChange() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title:
          '{{appStrings.generated.card_management.card_management_root.change_second_pin_title}}',
      showSupport: true,
      showBack: true,
    ),
    body: StacForm(
      autovalidateMode: StacAutovalidateMode.always,
      child: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacText(
              data:
                  '{{appStrings.generated.card_management.card_management_primary_pin_change.requirements_title}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 12),
            _ruleRow(
              text:
                  '{{appStrings.generated.card_management.card_management_secondary_pin_change.second_pin_card}}',
            ),
            StacSizedBox(height: 8),
            _ruleRow(
              text:
                  '{{appStrings.generated.card_management.card_management_secondary_pin_change.select_pin_not}}',
            ),
            StacSizedBox(height: 24),
            StacText(
              data:
                  '{{appStrings.generated.card_management.card_management_primary_pin_change.current_pin}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: _secondaryPinCurrentFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_primary_pin_change.current_pin_empty}}',
                },
              ],
              onChanged: _validateSecondaryPinChangeAction(),
              decoration: {
                'hintText':
                    '{{appStrings.profile.real.changePassword.currentPasswordHint}}',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
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
            StacText(
              data:
                  '{{appStrings.generated.card_management.card_management_primary_pin_change.new_pin}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: _secondaryPinNewFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_primary_pin_change.new_pin_empty}}',
                },
              ],
              onChanged: _validateSecondaryPinChangeAction(),
              decoration: {
                'hintText':
                    '{{appStrings.generated.card_management.card_management_primary_pin_change.new_pin_enter}}',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
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
            StacText(
              data:
                  '{{appStrings.generated.card_management.card_management_primary_pin_change.repeat_new_pin}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: _secondaryPinConfirmFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_primary_pin_change.repeat_new_pin_empty}}',
                },
                {
                  'rule': 'compare',
                  'message':
                      '{{appStrings.generated.card_management.card_management_primary_pin_change.repeat_new_pin_new_pin}}',
                  'options': {'fieldId': _secondaryPinNewFieldId},
                },
              ],
              onChanged: _validateSecondaryPinChangeAction(),
              decoration: {
                'hintText':
                    '{{appStrings.generated.card_management.card_management_primary_pin_change.new_pin_repeat}}',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
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
              enabledKey: _secondaryPinEnabledKey,
              onPressed: NavigationAction(
                fileName: 'card_management_secondary_pin_result',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ).toJson(),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              disabledStyle: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor: '{{appColors.current.input.borderEnabled}}',
                foregroundColor: '{{appColors.current.text.subtitle}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              child: StacText(
                data:
                    '{{appStrings.generated.card_management.card_management_root.change_second_pin_title}}',
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
  );
}

StacValidateFieldsAction _validateSecondaryPinChangeAction() {
  return const StacValidateFieldsAction(
    resultKey: _secondaryPinEnabledKey,
    fields: [
      {'id': _secondaryPinCurrentFieldId, 'rule': r'.+'},
      {'id': _secondaryPinNewFieldId, 'rule': r'.+'},
      {
        'id': _secondaryPinConfirmFieldId,
        'rule': 'compare',
        'options': {'fieldId': _secondaryPinNewFieldId},
      },
    ],
  );
}

StacWidget _ruleRow({required String text}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacPadding(
        padding: StacEdgeInsets.only(top: 2),
        child: StacImage(
          src: '{{appAssets.current.icons.successCheck}}',
          imageType: StacImageType.asset,
          width: 18,
          height: 18,
          color: '{{appColors.current.button.primary.backgroundColor}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacText(
          data: text,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.hint}}',
          ),
        ),
      ),
    ],
  );
}

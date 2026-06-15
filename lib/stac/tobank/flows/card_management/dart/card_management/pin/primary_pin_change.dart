import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

const _primaryPinCurrentFieldId = 'primary_pin_current';
const _primaryPinNewFieldId = 'primary_pin_new';
const _primaryPinConfirmFieldId = 'primary_pin_confirm';
const _primaryPinEnabledKey = 'cardsManagement.primaryPinChange.submitEnabled';

@StacScreen(screenName: 'card_management_primary_pin_change')
StacWidget dashboardPrimaryPinChange() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: 'تغییر رمز اول',
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
              data: 'رعایت این موارد الزامیست...',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 12),
            _ruleRow(text: 'رمز اول کارت باید ۴ رقم باشد'),
            StacSizedBox(height: 8),
            _ruleRow(text: 'از انتخاب رمز ساده نظیر ۱۱۱۱ یا ۱۲۳۴ خودداری کنید'),
            StacSizedBox(height: 24),
            StacText(
              data: 'رمز فعلی',
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
              id: _primaryPinCurrentFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message': 'رمز فعلی نمی‌تواند خالی باشد',
                },
              ],
              onChanged: _validatePrimaryPinChangeAction(),
              decoration: {
                'hintText': 'رمز عبور فعلی را وارد کنید',
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
              data: 'رمز جدید',
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
              id: _primaryPinNewFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message': 'رمز جدید نمی‌تواند خالی باشد',
                },
              ],
              onChanged: _validatePrimaryPinChangeAction(),
              decoration: {
                'hintText': 'رمز جدید را وارد کنید',
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
              data: 'تکرار رمز جدید',
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
              id: _primaryPinConfirmFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message': 'تکرار رمز جدید نمی‌تواند خالی باشد',
                },
                {
                  'rule': 'compare',
                  'message': 'رمز جدید و تکرار رمز جدید باید یکسان باشند',
                  'options': {'fieldId': _primaryPinNewFieldId},
                },
              ],
              onChanged: _validatePrimaryPinChangeAction(),
              decoration: {
                'hintText': 'رمز جدید را تکرار کنید',
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
              enabledKey: _primaryPinEnabledKey,
              onPressed: NavigationAction(
                fileName: 'card_management_primary_pin_result',
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
                data: 'تغییر رمز اول',
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

StacValidateFieldsAction _validatePrimaryPinChangeAction() {
  return const StacValidateFieldsAction(
    resultKey: _primaryPinEnabledKey,
    fields: [
      {'id': _primaryPinCurrentFieldId, 'rule': r'.+'},
      {'id': _primaryPinNewFieldId, 'rule': r'.+'},
      {
        'id': _primaryPinConfirmFieldId,
        'rule': 'compare',
        'options': {'fieldId': _primaryPinNewFieldId},
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

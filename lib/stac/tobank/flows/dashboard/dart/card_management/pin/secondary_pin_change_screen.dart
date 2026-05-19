import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_secondary_pin_change')
StacWidget dashboardSecondaryPinChange() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'تغییر رمز دوم', showBack: true),
    body: StacSingleChildScrollView(
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
          _ruleRow(text: 'رمز دوم کارت باید حداقل ۵ و حداکثر ۱۲ رقم باشد'),
          StacSizedBox(height: 8),
          _ruleRow(
            text: 'انتخاب رمزهای ساده نظیر ۱۱۱۱۱ یا ۱۲۳۴۵۶ امکان پذیر نیست',
          ),
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
            id: 'secondary_pin_current',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
            id: 'secondary_pin_new',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
            id: 'secondary_pin_confirm',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
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
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
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
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'dashboard_secondary_pin_result',
              'navigationStyle': 'push',
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(16),
              ),
            ),
            child: StacText(
              data: 'تغییر رمز دوم',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
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

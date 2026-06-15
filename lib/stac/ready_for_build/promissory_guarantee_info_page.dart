import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'promissory_guarantee_info_page')
StacWidget promissoryGuaranteeInfoPage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'isInquiryEnabled',
      value: false,
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: 'ضمانت سفته api واقعی',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.always,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                child: StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 16),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacSizedBox(height: 16),
                      _buildField(
                        id: 'guarantee_promissory_id',
                        label: 'شناسه یکتای سفته',
                        hint: 'شناسه یکتای سفته را وارد کنید',
                        maxLength: 20,
                        rule: r'^\d{1,20}$',
                        message: 'شناسه یکتای سفته معتبر نیست',
                      ),
                      StacSizedBox(height: 16),
                      _buildField(
                        id: 'guarantee_promissory_national_code',
                        label: 'کد ملی صادرکننده',
                        hint: 'کد ملی صادرکننده را وارد کنید',
                        maxLength: 10,
                        rule: r'^\d{10}$',
                        message: 'کد ملی باید ۱۰ رقم باشد',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacCustomReactiveElevatedButton(
                enabledKey: 'isInquiryEnabled',
                enabled: false,
                onPressed: const StacNavigateAction(
                  routeName: 'promissory_guarantee_confirm_page',
                  navigationStyle: NavigationStyle.push,
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
                  data: 'استعلام',
                  style: StacTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                  ),
                ).toJson(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildField({
  required String id,
  required String label,
  required String hint,
  required int maxLength,
  required String rule,
  required String message,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: label,
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
        maxLength: maxLength,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        decoration: {
          'hintText': hint,
          'filled': false,
          'isDense': true,
          'contentPadding': {'left': 16, 'top': 14, 'right': 16, 'bottom': 14},
          'border': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1},
            'borderRadius': {'all': 12},
          },
          'enabledBorder': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1},
            'borderRadius': {'all': 12},
          },
          'focusedBorder': {
            'type': 'outlineInputBorder',
            'borderSide': {'color': '#D6D6D6', 'width': 1.2},
            'borderRadius': {'all': 12},
          },
        },
        keyboardType: 'number',
        textInputAction: 'next',
        validatorRules: [
          {
            'rule': 'matches',
            'options': {'pattern': rule},
            'message': message,
          },
        ],
        onChanged: _validationAction(),
      ),
    ],
  );
}

StacValidateFieldsAction _validationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'isInquiryEnabled',
    fields: [
      {'id': 'guarantee_promissory_id', 'rule': r'^\d{1,20}$'},
      {'id': 'guarantee_promissory_national_code', 'rule': r'^\d{10}$'},
    ],
  );
}

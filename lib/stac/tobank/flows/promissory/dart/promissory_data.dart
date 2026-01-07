import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Data Entry Page
///
/// This screen collects the promissory note data:
/// 1. Amount (مبلغ سفته)
/// 2. Date picker for due date (using Persian date picker action)
/// 3. Payment Place
///
/// Reference: docs/promissory_docs/request_promissory_data_page.dart
@StacScreen(screenName: 'promissory_data')
StacWidget promissoryData() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isDataFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.dataTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.all(16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    // Amount Field
                    StacText(
                      data: '{{appStrings.promissory.amountLabel}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'promissory_amount',
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'textDirection': 'ltr',
                      'textAlign': 'right',
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.enterAmount}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        suffixText: '{{appStrings.common.rial}}',
                      ).toJson(),
                      'validatorRules': [
                        {
                          'rule': r'^\d+$',
                          'message': 'مبلغ سفته را وارد نمایید',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isDataFormValid',
                        fields: [
                          {'id': 'promissory_amount', 'rule': r'^\d+$'},
                          {
                            'id': 'promissory_due_date',
                            'rule': r'^\d{4}/\d{2}/\d{2}$',
                          },
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Due Date Field with Persian Date Picker
                    StacText(
                      data: '{{appStrings.promissory.dueDateLabel}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacGestureDetector(
                      onTap: StacPersianDatePickerAction(
                        formFieldId: 'promissory_due_date',
                        firstDate: '1403/01/01',
                        lastDate: '1410/12/29',
                        onDateSelected: StacValidateFieldsAction(
                          resultKey: 'isDataFormValid',
                          fields: [
                            {'id': 'promissory_amount', 'rule': r'^\d+$'},
                            {
                              'id': 'promissory_due_date',
                              'rule': r'^\d{4}/\d{2}/\d{2}$',
                            },
                          ],
                        ).toJson(),
                      ),
                      child: StacTextFormField(
                        id: 'promissory_due_date',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.ltr,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: '{{appStrings.promissory.selectDueDate}}',
                          filled: false,
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          prefixIcon: StacPadding(
                            padding: StacEdgeInsets.all(8),
                            child: StacImage(
                              src: 'assets/icons/ic_calendar.svg',
                              imageType: StacImageType.asset,
                              width: 24,
                              height: 24,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ),
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: r'^\d{4}/\d{2}/\d{2}$',
                            message: 'تاریخ سررسید را انتخاب نمایید',
                          ),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Payment Place Field
                    StacText(
                      data: '{{appStrings.promissory.paymentPlaceLabel}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacTextFormField(
                      id: 'promissory_payment_place',
                      textInputAction: StacTextInputAction.done,
                      textDirection: StacTextDirection.rtl,
                      decoration: StacInputDecoration(
                        hintText: '{{appStrings.promissory.enterPaymentPlace}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    StacSizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Continue Button
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isDataFormValid',
                'enabled': false,
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_confirm',
                  'navigationStyle': 'push',
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import '../../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';

/// Promissory Real Flow - Data Entry Page
///
/// This screen collects the promissory details:
/// 1. Amount
/// 2. Due Date
/// 3. Description (Optional)
/// 4. Payment Place (Optional)
///
/// It also displays a summary of the Receiver Information.
@StacScreen(screenName: 'promissory_real_data')
StacWidget promissoryRealData() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isDataFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'اطلاعات سفته',
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
                  textDirection: StacTextDirection.rtl,
                  children: [
                    // Receiver Info Summary Card
                    _buildReceiverInfoCard(),
                    StacSizedBox(height: 24),

                    // Amount Field
                    StacText(
                      data: 'مبلغ سفته',
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
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'decoration': StacInputDecoration(
                        hintText: 'مبلغ را وارد نمایید',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        suffixIcon: StacPadding(
                          padding: StacEdgeInsets.all(12),
                          child: StacText(
                            data: 'ریال',
                            style: StacCustomTextStyle(
                              color: '{{appColors.current.text.subtitle}}',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ).toJson(),
                      'keyboardType': 'number',
                      'inputFormatters': [
                        {'type': 'currency'},
                      ],
                      'validatorRules': [
                        {'rule': 'required', 'message': 'مبلغ الزامی است'},
                      ],
                      'onChanged': _getFullValidationAction().toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Due Date Field
                    StacText(
                      data: 'تاریخ سررسید',
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
                        firstDate: '1403/01/01', // Example constraint
                        lastDate: '1450/12/29',
                        onDateSelected: _getFullValidationAction().toJson(),
                      ),
                      child: StacTextFormField(
                        id: 'promissory_due_date',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: 'انتخاب تاریخ',
                          filled: false,
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          prefixIcon: StacIcon(
                            icon: StacIcons.calendar_today,
                            color: '{{appColors.current.text.subtitle}}',
                            size: 20,
                          ),
                        ),
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: 'required',
                            message: 'تاریخ سررسید الزامی است',
                          ),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Description Field (Optional)
                    StacText(
                      data: 'بابت (اختیاری)',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacTextFormField(
                      id: 'description',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      decoration: StacInputDecoration(
                        hintText: 'توضیحات...',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Payment Place Field (Optional)
                    StacText(
                      data: 'محل پرداخت (اختیاری)',
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
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      decoration: StacInputDecoration(
                        hintText: 'محل پرداخت...',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Continue Button (Navigation Update)
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isDataFormValid',
                'onPressed': StacMultiAction(
                  actions: [
                    // Save form data to registry
                    StacCustomSetValueAction(
                      key: 'form.promissory_amount',
                      value: StacGetFormValueAction(id: 'promissory_amount'),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.promissory_due_date',
                      value: StacGetFormValueAction(id: 'promissory_due_date'),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.description',
                      value: StacGetFormValueAction(id: 'description'),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.promissory_payment_place',
                      value: StacGetFormValueAction(
                        id: 'promissory_payment_place',
                      ),
                    ),
                    // Navigate to Real Confirm
                    StacRawJsonAction({
                      'actionType': 'navigate',
                      'widgetType': 'promissory_real_confirm', // Updated Target
                      'navigationStyle': 'push',
                    }),
                  ],
                ).toJson(),
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

StacAction _getFullValidationAction() {
  return StacValidateFieldsAction(
    resultKey: 'isDataFormValid',
    fields: [
      {'id': 'promissory_amount', 'rule': 'required'},
      {'id': 'promissory_due_date', 'rule': 'required'},
    ],
  );
}

/// Helper: Receiver Info Card
StacWidget _buildReceiverInfoCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: 'مشخصات ذینفع',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 12),
        _buildInfoRow('کد ملی', '{{form.receiver_national_code}}'),
        StacSizedBox(height: 8),
        _buildInfoRow('شماره همراه', '{{form.receiver_mobile}}'),
        StacSizedBox(height: 8),
        // USING RECEIVER IDENTITY FROM REGISTRY
        _buildInfoRow('نام و نام خانوادگی', '{{receiverIdentity.fullName}}'),
      ],
    ),
  );
}

StacWidget _buildInfoRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacText(
        data: value,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
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

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import 'package:tobank_sdui/core/stac/parsers/actions/persian_date_picker_action_model.dart';

/// Promissory Flow - Data Entry Page (Step 6)
///
/// This screen collects the promissory note data:
/// 1. Receiver Information Summary (read-only display from previous step)
/// 2. Amount (مبلغ سفته) - with validation
/// 3. Due Date (تاریخ سررسید) - toggled by "On Demand" switch
/// 4. Payment Place (محل پرداخت)
/// 5. Description (توضیحات) - optional
///
/// Reference: docs/promissory_docs/request_promissory_data_page.dart
/// Reference: docs/promissory_docs/promissory_issuance.md (Step 6)
@StacScreen(screenName: 'promissory_data')
StacWidget promissoryData() {
  return StacStatefulWidget(
    onInit: StacMultiAction(
      actions: [
        StacCustomSetValueAction(key: 'isDataFormValid', value: false),
        StacCustomSetValueAction(key: 'isOnDemand', value: false),
        StacCustomSetValueAction(key: 'isTransferable', value: true),
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: false,
        backIconSrc: 'assets/icons/ic_right_arrow.svg',
        title: 'اطلاعات سفته',
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacSizedBox(height: 16),

                    // ============================================
                    // SECTION 1: Receiver Information Summary Card
                    // ============================================
                    _buildReceiverInfoCard(),
                    StacSizedBox(height: 16),

                    // ============================================
                    // SECTION 2: Promissory Note Information
                    // ============================================
                    StacContainer(
                      decoration: StacBoxDecoration(
                        color:
                            '{{appColors.current.background.surfaceContainer}}',
                        borderRadius: StacBorderRadius.all(8),
                        border: StacBorder.all(
                          color: '{{appColors.current.input.borderEnabled}}',
                          width: 0.5,
                        ),
                      ),
                      padding: StacEdgeInsets.all(16),
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          // Section Title
                          StacText(
                            data: 'اطلاعات سفته',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w700,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 16),

                          // Amount Field with Label and Hint
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                            children: [
                              StacText(
                                data: 'مبلغ سفته',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacText(
                                data: '',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 12,
                                  fontWeight: StacFontWeight.w400,
                                  color: '{{appColors.current.text.subtitle}}',
                                ),
                              ),
                            ],
                          ),
                          StacSizedBox(height: 8),
                          StacCustomTextFormField(
                            id: 'promissory_amount',
                            keyboardType: 'number',
                            textInputAction: 'next',
                            textDirection: 'ltr',
                            textAlign: 'right',
                            inputFormatters: const [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            decoration: StacInputDecoration(
                              hintText: 'مبلغ سفته را وارد نمایید',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              suffixText: '{{appStrings.common.rial}}',
                            ).toJson(),
                            validatorRules: const [
                              {
                                'rule': r'^\d+$',
                                'message': 'مبلغ سفته را وارد نمایید',
                              },
                            ],
                            onChanged: _getFullValidationAction().toJson(),
                          ),
                          StacSizedBox(height: 16),

                          // Due Date Toggle
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                            children: [
                              StacText(
                                data: 'تاریخ سررسید',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisSize: StacMainAxisSize.min,
                                children: [
                                  StacText(
                                    data: 'عندالمطالبه',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 12,
                                      fontWeight: StacFontWeight.w500,
                                    ),
                                  ),
                                  StacSizedBox(width: 8),
                                  StacRawJsonWidget({
                                    'type': 'reactiveSwitch',
                                    'id': 'dueDateSwitch',
                                    'valueKey': 'isOnDemand',
                                    'activeColor':
                                        '{{appColors.current.primary.color}}',
                                    'onChanged': _getFullValidationAction()
                                        .toJson(),
                                  }),
                                ],
                              ),
                            ],
                          ),
                          StacSizedBox(height: 8),

                          // Due Date Picker (Hidden if On Demand is true)
                          StacRawJsonWidget({
                            'type': 'visibility',
                            'visible': '{{!isOnDemand}}',
                            'child': StacGestureDetector(
                              onTap: StacPersianDatePickerAction(
                                formFieldId: 'promissory_due_date',
                                firstDate: '1403/01/01',
                                lastDate: '1420/12/29',
                                onDateSelected: _getFullValidationAction()
                                    .toJson(),
                              ),
                              child: StacTextFormField(
                                id: 'promissory_due_date',
                                readOnly: true,
                                enabled: false,
                                textDirection: StacTextDirection.ltr,
                                textAlign: StacTextAlign.right,
                                decoration: StacInputDecoration(
                                  hintText:
                                      'تاریخ سررسید سفته را انتخاب نمایید',
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
                                      color:
                                          '{{appColors.current.text.subtitle}}',
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
                            ).toJson(),
                          }),
                          StacSizedBox(height: 16),

                          // Transferable Toggle
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                            children: [
                              StacExpanded(
                                child: StacText(
                                  data: 'قابل انتقال به شخص ثالث (حواله کرد)',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                              ),
                              StacRawJsonWidget({
                                'type': 'reactiveSwitch',
                                'id': 'transferableSwitch',
                                'valueKey': 'isTransferable',
                                'activeColor':
                                    '{{appColors.current.primary.color}}',
                              }),
                            ],
                          ),
                          StacSizedBox(height: 16),

                          // Payment Place Field
                          StacText(
                            data: 'محل پرداخت',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacCustomTextFormField(
                            id: 'promissory_payment_place',
                            textInputAction: 'next',
                            textDirection: 'rtl',
                            textAlign: 'right',
                            maxLines: 3,
                            minLines: 2,
                            decoration: StacInputDecoration(
                              hintText: 'محل پرداخت سفته را وارد نمایید',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            validatorRules: const [
                              {
                                'rule': r'^.{1,200}$',
                                'message': 'محل پرداخت را وارد نمایید',
                              },
                            ],
                            onChanged: _getFullValidationAction().toJson(),
                          ),
                          StacSizedBox(height: 16),

                          // Description Field (Optional)
                          StacText(
                            data: 'توضیحات (اختیاری)',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacTextFormField(
                            id: 'promissory_description',
                            textInputAction: StacTextInputAction.done,
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.right,
                            maxLines: 4,
                            minLines: 2,
                            decoration: StacInputDecoration(
                              hintText: 'توضیحات مورد نظر را وارد نمایید',
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
                'onPressed': StacMultiAction(
                  actions: [
                    // Save form data to registry before navigation
                    StacCustomSetValueAction(
                      key: 'form.promissory_amount',
                      value: StacGetFormValueAction(id: 'promissory_amount'),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.promissory_due_date',
                      value: StacGetFormValueAction(id: 'promissory_due_date'),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.promissory_payment_place',
                      value: StacGetFormValueAction(
                        id: 'promissory_payment_place',
                      ),
                    ),
                    StacCustomSetValueAction(
                      key: 'form.promissory_description',
                      value: StacGetFormValueAction(
                        id: 'promissory_description',
                      ),
                    ),
                    // Save switch states
                    StacCustomSetValueAction(
                      key: 'form.isOnDemand',
                      value: '{{isOnDemand}}',
                    ),
                    StacCustomSetValueAction(
                      key: 'form.isTransferable',
                      value: '{{isTransferable}}',
                    ),
                    // Navigate to confirm page
                    StacRawJsonAction({
                      'actionType': 'navigate',
                      'widgetType': 'promissory_confirm',
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
                  data: 'ادامه',
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

/// Builds the Receiver Information Summary Card (read-only display)
StacWidget _buildReceiverInfoCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: 'اطلاعات ذینفع (دریافت‌کننده)',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 12),
        // National Code
        _buildInfoRow(
          label: 'کد ملی',
          value: '{{form.receiver_national_code}}',
        ),
        StacSizedBox(height: 8),
        // Mobile Number
        _buildInfoRow(label: 'شماره همراه', value: '{{form.receiver_mobile}}'),
        StacSizedBox(height: 8),
        // Full Name (from receiver inquiry)
        _buildInfoRow(
          label: 'نام و نام خانوادگی',
          value: '{{receiverData.fullName}}',
        ),
      ],
    ),
  );
}

/// Builds a key-value row for displaying information
StacWidget _buildInfoRow({required String label, required String value}) {
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
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

/// Full validation action for all required fields
/// Note: Due Date is only required if NOT On Demand
StacValidateFieldsAction _getFullValidationAction() {
  return StacValidateFieldsAction(
    resultKey: 'isDataFormValid',
    fields: [
      {'id': 'promissory_amount', 'rule': r'^\d+$'},
      {
        'id': 'promissory_due_date',
        // Make rule conditional or always validate but rely on visibility?
        // In STAC, validation runs on form fields. If field is hidden, it's removed?
        // Visibility widget just hides it effectively in Flutter, but STAC form might still see it.
        // Let's use a regex that matches if optional is true logic, but here we can just use a simple
        // approach: validate it. If user hides it, we should probably clear it or ignore it.
        // For now, let's keep basic validation.
        'rule': r'^\d{4}/\d{2}/\d{2}$',
        'optional':
            'isOnDemand', // If isOnDemand is true, this field is optional
      },
      {'id': 'promissory_payment_place', 'rule': r'^.{1,200}$'},
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

import 'package:stac_core/stac_core.dart';

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
                              hintText: 'مبلغ سفته را وارد نمایید',
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
                            'onChanged': _getFullValidationAction().toJson(),
                          }),
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
                          StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'promissory_payment_place',
                            'textInputAction': 'next',
                            'textDirection': 'rtl',
                            'textAlign': 'right',
                            'maxLines': 3,
                            'minLines': 2,
                            'decoration': StacInputDecoration(
                              hintText: 'محل پرداخت سفته را وارد نمایید',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            'validatorRules': [
                              {
                                'rule': r'^.{1,200}$',
                                'message': 'محل پرداخت را وارد نمایید',
                              },
                            ],
                            'onChanged': _getFullValidationAction().toJson(),
                          }),
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








// ==========================================
// Local Helper Classes (Inlined to avoid import issues)
// ==========================================

/// Dart builder for 'stateFull' STAC widgets.
class StacStatefulWidget extends StacWidget {
  final dynamic onInit;
  final dynamic onBuild;
  final dynamic onDependenciesChanged;
  final dynamic onWidgetUpdated;
  final dynamic onReassemble;
  final dynamic onDeactivate;
  final dynamic onDispose;
  final dynamic onResume;
  final dynamic onPause;
  final dynamic onInactive;
  final dynamic onHidden;
  final dynamic onDetached;
  final StacWidget child;

  const StacStatefulWidget({
    this.onInit,
    this.onBuild,
    this.onDependenciesChanged,
    this.onWidgetUpdated,
    this.onReassemble,
    this.onDeactivate,
    this.onDispose,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onHidden,
    this.onDetached,
    required this.child,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'stateFull',
      if (onInit != null) 'onInit': _actionToJson(onInit),
      if (onBuild != null) 'onBuild': _actionToJson(onBuild),
      if (onDependenciesChanged != null)
        'onDependenciesChanged': _actionToJson(onDependenciesChanged),
      if (onWidgetUpdated != null)
        'onWidgetUpdated': _actionToJson(onWidgetUpdated),
      if (onReassemble != null) 'onReassemble': _actionToJson(onReassemble),
      if (onDeactivate != null) 'onDeactivate': _actionToJson(onDeactivate),
      if (onDispose != null) 'onDispose': _actionToJson(onDispose),
      if (onResume != null) 'onResume': _actionToJson(onResume),
      if (onPause != null) 'onPause': _actionToJson(onPause),
      if (onInactive != null) 'onInactive': _actionToJson(onInactive),
      if (onHidden != null) 'onHidden': _actionToJson(onHidden),
      if (onDetached != null) 'onDetached': _actionToJson(onDetached),
      'child': child.toJson(),
    };
  }

  dynamic _actionToJson(dynamic action) {
    if (action == null) return null;
    if (action is Map) return action;
    try {
      return action.toJson();
    } catch (e) {
      return action;
    }
  }
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

/// Builder for 'sequence' action.
class StacSequenceAction extends StacAction {
  final List<dynamic> actions;

  const StacSequenceAction({required this.actions});

  @override
  String get actionType => 'sequence';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'sequence',
      'actions': actions.map((a) {
        if (a is StacAction) return a.toJson();
        if (a is Map) return a;
        try {
          return a.toJson();
        } catch (_) {
          return a;
        }
      }).toList(),
    };
  }
}

/// Alias for StacSequenceAction as some files use StacMultiAction
typedef StacMultiAction = StacSequenceAction;

/// Builder for 'networkRequest' action.
class StacNetworkRequestAction extends StacAction {
  final String url;
  final String method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final List<dynamic>? results;

  const StacNetworkRequestAction({
    required this.url,
    this.method = 'get',
    this.data,
    this.headers,
    this.results,
  });

  @override
  String get actionType => 'networkRequest';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'networkRequest',
      'url': url,
      'method': method,
      if (data != null) 'data': data,
      if (headers != null) 'headers': headers,
      if (results != null)
        'results': results!.map((r) {
          if (r is Map) {
            // Check if any values inside the map are StacAction objects and serialize them
            return r.map((key, value) {
              if (value is StacAction) {
                return MapEntry(key, value.toJson());
              }
              return MapEntry(key, value);
            }).cast<String, dynamic>();
          }
          try {
            return (r as dynamic).toJson();
          } catch (_) {
            return r;
          }
        }).toList(),
    };
  }
}

/// Builder for 'setValue' action.
class StacCustomSetValueAction extends StacAction {
  final String? key;
  final dynamic value;
  final List<Map<String, dynamic>>? values;

  const StacCustomSetValueAction({this.key, this.value, this.values});

  @override
  String get actionType => 'setValue';

  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {'actionType': 'setValue', 'values': values};
    }
    dynamic processedValue = value;
    if (value is StacGetFormValueAction) {
      processedValue = value.toJson();
    } else if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}

/// Helper for 'getFormValue' action used inside setValue
class StacGetFormValueAction {
  final String id;

  const StacGetFormValueAction({required this.id});

  Map<String, dynamic> toJson() {
    return {'actionType': 'getFormValue', 'id': id};
  }
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

/// Builder for 'validateFields' action.
class StacValidateFieldsAction extends StacAction {
  final String resultKey;
  final List<Map<String, dynamic>> fields;

  const StacValidateFieldsAction({
    required this.resultKey,
    required this.fields,
  });

  @override
  String get actionType => 'validateFields';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'validateFields',
      'resultKey': resultKey,
      'fields': fields,
    };
  }
}

/// StacAction wrapper for Persian Date Picker
class StacPersianDatePickerAction extends StacAction {
  const StacPersianDatePickerAction({
    required this.formFieldId,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
  });

  final String formFieldId;
  final String? initialDate;
  final String? firstDate;
  final String? lastDate;
  final dynamic onDateSelected;

  @override
  String get actionType => 'persianDatePicker';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      if (initialDate != null) 'initialDate': initialDate,
      if (firstDate != null) 'firstDate': firstDate,
      if (lastDate != null) 'lastDate': lastDate,
      if (onDateSelected != null) 'onDateSelected': onDateSelected is StacAction ? onDateSelected.toJson() : onDateSelected,
    };
  }
}

/// Builder for 'log' action.
class StacLogAction extends StacAction {
  final String message;
  final String? level;

  const StacLogAction({required this.message, this.level});

  @override
  String get actionType => 'log';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'log',
      'message': message,
      if (level != null) 'level': level,
    };
  }
}
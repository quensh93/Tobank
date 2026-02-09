import 'package:stac_core/stac_core.dart';

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
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isDataFormValid', 'value': false},
        {'key': 'isIdentityLoading', 'value': false},
      ],
    ),
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
        child: StacStack(
          children: [
            StacColumn(
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
                        StacContainer(
                          decoration: StacBoxDecoration(
                            color:
                                '{{appColors.current.background.surfaceContainer}}',
                            borderRadius: StacBorderRadius.all(12),
                            border: StacBorder.all(
                              color:
                                  '{{appColors.current.input.borderEnabled}}',
                              width: 1,
                            ),
                          ),
                          padding: StacEdgeInsets.all(16),
                          child: StacColumn(
                            crossAxisAlignment: StacCrossAxisAlignment.stretch,
                            children: [
                              StacText(
                                data:
                                    '{{appStrings.promissory.receiverDetails}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 12),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                    StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data:
                                        '{{appStrings.promissory.nationalCode}}',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      color:
                                          '{{appColors.current.text.subtitle}}',
                                    ),
                                  ),
                                  StacText(
                                    data: '{{form.receiver_national_code}}',
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                    StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data:
                                        '{{appStrings.promissory.mobileNumber}}',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      color:
                                          '{{appColors.current.text.subtitle}}',
                                    ),
                                  ),
                                  StacText(
                                    data: '{{form.receiver_mobile}}',
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              // USING RECEIVER IDENTITY FROM REGISTRY
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                    StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data: '{{appStrings.promissory.fullName}}',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      color:
                                          '{{appColors.current.text.subtitle}}',
                                    ),
                                  ),
                                  StacText(
                                    data: '{{receiverIdentity.fullName}}',
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        StacSizedBox(height: 24),

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
                          'textDirection': 'rtl',
                          'textAlign': 'right',
                          'decoration': StacInputDecoration(
                            hintText: '{{appStrings.promissory.enterAmount}}',
                            filled: false,
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            suffixIcon: StacPadding(
                              padding: StacEdgeInsets.all(12),
                              child: StacText(
                                data: '{{appStrings.common.rial}}',
                                style: StacCustomTextStyle(
                                  color: '{{appColors.current.text.subtitle}}',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ).toJson(),
                          'keyboardType': 'number',
                          'inputFormatters': [
                            {'type': 'allow', 'rule': '[0-9]'},
                          ],
                          'validatorRules': [
                            {
                              'rule': r'^\d+$',
                              'message':
                                  '{{appStrings.promissory.amountRequired}}',
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

                        // Due Date Field
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
                            firstDate: '1403/01/01', // Example constraint
                            lastDate: '1450/12/29',
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
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.right,
                            decoration: StacInputDecoration(
                              hintText: '{{appStrings.promissory.selectDate}}',
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
                                rule: r'^\d{4}/\d{2}/\d{2}$',
                                message:
                                    '{{appStrings.promissory.dueDateRequired}}',
                              ),
                            ],
                          ),
                        ),
                        StacSizedBox(height: 16),

                        // Description Field (Optional)
                        StacText(
                          data:
                              '{{appStrings.promissory.amountOptionalSuffix}}',
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
                            hintText:
                                '{{appStrings.promissory.descriptionHint}}',
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
                          data:
                              '{{appStrings.promissory.paymentPlaceOptional}}',
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
                            hintText:
                                '{{appStrings.promissory.paymentPlaceHint}}',
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
                    'onPressed': StacSequenceAction(
                      actions: [
                        // Save form data to registry
                        StacCustomSetValueAction(
                          key: 'form.promissory_amount',
                          value: StacGetFormValueAction(
                            id: 'promissory_amount',
                          ),
                        ),
                        StacCustomSetValueAction(
                          key: 'form.promissory_due_date',
                          value: StacGetFormValueAction(
                            id: 'promissory_due_date',
                          ),
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
                        // Ensure compact birth date exists for later steps
                        StacCustomSetValueAction(
                          key: 'receiver.birthDateCompact',
                          value: "{{replace(receiver.birthDate,'/','')}}}",
                        ),
                        StacRawJsonAction({
                          'actionType': 'navigate',
                          'widgetType': 'promissory_real_confirm',
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
                      data:
                          "{{isIdentityLoading ? appStrings.promissory.loadingText : appStrings.common.continue}}",
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
          ],
        ),
      ),
    ),
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

/// Helper class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);

  @override
  StacTextStyleType get type => StacTextStyleType.custom;

  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
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

/// Builder for 'persianDatePicker' action.
class StacPersianDatePickerAction extends StacAction {
  final String formFieldId;
  final String firstDate;
  final String lastDate;
  final String? initialDate;
  final dynamic onDateSelected;

  const StacPersianDatePickerAction({
    required this.formFieldId,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  String get actionType => 'persianDatePicker';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      'firstDate': firstDate,
      'lastDate': lastDate,
      if (initialDate != null) 'initialDate': initialDate,
      if (onDateSelected != null)
        'onDateSelected': onDateSelected is StacAction
            ? onDateSelected.toJson()
            : onDateSelected,
    };
  }
}

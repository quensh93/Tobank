import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// Supports both Individual (حقیقی) and Legal (حقوقی) receiver types.
///
/// Reference: docs/promissory_docs/request_promissory_receiver_page.dart
@StacScreen(screenName: 'promissory_receiver')
StacWidget promissoryReceiver() {
  return StacStatefulWidget(
    onInit: StacMultiAction(
      actions: [
        // Receiver type: true = Individual, false = Legal
        StacCustomSetValueAction(key: 'isIndividualSelected', value: true),
        StacCustomSetValueAction(key: 'isLegalSelected', value: false),
        StacCustomSetValueAction(key: 'isReceiverFormValid', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'اطلاعات ذینفع',
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
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacSizedBox(height: 16),
                    // Title
                    StacText(
                      data: 'اطلاعات ذینفع (دریافت‌کننده)',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Receiver Type Selection Row
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        // Individual Button
                        StacExpanded(
                          child: _buildReceiverTypeButton(
                            title: 'حقیقی',
                            selectedKey: 'isIndividualSelected',
                            otherKey: 'isLegalSelected',
                          ),
                        ),
                        StacSizedBox(width: 8),
                        // Legal Button
                        StacExpanded(
                          child: _buildReceiverTypeButton(
                            title: 'حقوقی',
                            selectedKey: 'isLegalSelected',
                            otherKey: 'isIndividualSelected',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 16),

                    // Individual Form Fields
                    // National Code Field
                    StacText(
                      data: 'کد ملی',
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
                      'id': 'receiver_national_code',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 10,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: 'کد ملی ذینفع را وارد نمایید',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message': 'کد ملی معتبر وارد نمایید',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                          {
                            'id': 'receiver_birthdate',
                            'rule': r'^\d{4}/\d{2}/\d{2}$',
                          },
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Mobile Number Field
                    StacText(
                      data: 'شماره همراه',
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
                      'id': 'receiver_mobile',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 11,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: 'شماره همراه ذینفع را وارد نمایید',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'keyboardType': 'phone',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message': 'شماره همراه معتبر وارد نمایید',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                          {
                            'id': 'receiver_birthdate',
                            'rule': r'^\d{4}/\d{2}/\d{2}$',
                          },
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Birthdate Field
                    StacText(
                      data: 'تاریخ تولد',
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
                        formFieldId: 'receiver_birthdate',
                        firstDate: '1350/01/01',
                        lastDate: '1450/12/29',
                        onDateSelected: StacValidateFieldsAction(
                          resultKey: 'isReceiverFormValid',
                          fields: [
                            {
                              'id': 'receiver_national_code',
                              'rule': r'^\d{10}$',
                            },
                            {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                            {
                              'id': 'receiver_birthdate',
                              'rule': r'^\d{4}/\d{2}/\d{2}$',
                            },
                          ],
                        ).toJson(),
                      ),
                      child: StacTextFormField(
                        id: 'receiver_birthdate',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: 'تاریخ تولد ذینفع را انتخاب نمایید',
                          hintStyle: StacCustomTextStyle(
                            color: '{{appColors.current.text.subtitle}}',
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                          ),
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
                              fit: StacBoxFit.scaleDown,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ),
                        keyboardType: StacTextInputType.text,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: r'^\d{4}/\d{2}/\d{2}$',
                            message: 'تاریخ تولد را انتخاب نمایید',
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
                'enabledKey': 'isReceiverFormValid',
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_data',
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

/// Builds a receiver type selection button (Individual or Legal)
StacWidget _buildReceiverTypeButton({
  required String title,
  required String selectedKey,
  required String otherKey,
}) {
  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        StacCustomSetValueAction(key: selectedKey, value: true),
        StacCustomSetValueAction(key: otherKey, value: false),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 12),
      decoration: StacBoxDecoration(
        color:
            '{{$selectedKey ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color:
              '{{$selectedKey ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacCenter(
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color:
                '{{$selectedKey ? appColors.current.primary.onPrimary : appColors.current.text.title}}',
          ),
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
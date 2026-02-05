import 'package:stac_core/stac_core.dart';

/// Promissory Real Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// Supports both Individual (حقیقی) and Legal (حقوقی) receiver types.
/// Uses Real API for identity inquiry.
@StacScreen(screenName: 'promissory_real_receiver')
StacWidget promissoryRealReceiver() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
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
          data: '{{appStrings.promissory.receiverTitle}}',
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
                      data: '{{appStrings.promissory.receiverSubtitle}}',
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
                          child: StacGestureDetector(
                            onTap: StacSequenceAction(
                              actions: [
                                StacCustomSetValueAction(
                                  key: 'isIndividualSelected',
                                  value: true,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isLegalSelected',
                                  value: false,
                                ),
                              ],
                            ),
                            child: StacContainer(
                              padding: StacEdgeInsets.symmetric(vertical: 12),
                              decoration: StacBoxDecoration(
                                color:
                                    '{{isIndividualSelected ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
                                borderRadius: StacBorderRadius.all(8),
                                border: StacBorder.all(
                                  color:
                                      '{{isIndividualSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
                                  width: 1,
                                ),
                              ),
                              child: StacCenter(
                                child: StacText(
                                  data:
                                      '{{appStrings.promissory.receiverTypeIndividual}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color:
                                        '{{isIndividualSelected ? appColors.current.primary.onPrimary : appColors.current.text.title}}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        StacSizedBox(width: 8),
                        // Legal Button
                        StacExpanded(
                          child: StacGestureDetector(
                            onTap: StacSequenceAction(
                              actions: [
                                StacCustomSetValueAction(
                                  key: 'isLegalSelected',
                                  value: true,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isIndividualSelected',
                                  value: false,
                                ),
                              ],
                            ),
                            child: StacContainer(
                              padding: StacEdgeInsets.symmetric(vertical: 12),
                              decoration: StacBoxDecoration(
                                color:
                                    '{{isLegalSelected ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
                                borderRadius: StacBorderRadius.all(8),
                                border: StacBorder.all(
                                  color:
                                      '{{isLegalSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
                                  width: 1,
                                ),
                              ),
                              child: StacCenter(
                                child: StacText(
                                  data:
                                      '{{appStrings.promissory.receiverTypeLegal}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color:
                                        '{{isLegalSelected ? appColors.current.primary.onPrimary : appColors.current.text.title}}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 16),

                    // Individual Form Fields
                    // National Code Field
                    StacText(
                      data: '{{appStrings.promissory.nationalCode}}',
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
                        hintText:
                            '{{appStrings.promissory.enterReceiverNationalCode}}',
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
                          'message':
                              '{{appStrings.promissory.nationalCodeError}}',
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
                      data: '{{appStrings.promissory.mobileNumber}}',
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
                        hintText:
                            '{{appStrings.promissory.enterReceiverMobile}}',
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
                          'message':
                              '{{appStrings.promissory.mobileNumberError}}',
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
                      data: '{{appStrings.promissory.birthdate}}',
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
                          hintText:
                              '{{appStrings.promissory.selectReceiverBirthdate}}',
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
                            message:
                                '{{appStrings.promissory.selectBirthdateError}}',
                          ),
                        ],
                      ),
                    ),
                    StacSizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Continue Button (With Real API Call and Loading State)
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isReceiverFormValid',
                'loadingKey': 'receiver.isLoading',
                'onPressed': {
                  'actionType': 'sequence',
                  'actions': [
                    // Set loading state to true
                    {
                      'actionType': 'setValue',
                      'values': [
                        {'key': 'receiver.isLoading', 'value': true},
                        {'key': 'receiver.error', 'value': null},
                      ],
                    },
                    // Copy form values into registry for use in URL templating
                    {
                      'actionType': 'setValue',
                      'values': [
                        {
                          'key': 'receiver.nationalCode',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_national_code',
                          },
                        },
                        {
                          'key': 'form.receiver_national_code',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_national_code',
                          },
                        },
                        {
                          'key': 'receiver.mobile',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_mobile',
                          },
                        },
                        {
                          'key': 'form.receiver_mobile',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_mobile',
                          },
                        },
                        {
                          'key': 'receiver.birthDate',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_birthdate',
                          },
                        },
                        {
                          'key': 'form.receiver_birthdate',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_birthdate',
                          },
                        },
                        {
                          'key': 'receiver.birthDateCompact',
                          'value': "{{replace(receiver.birthDate,'/','')}}"
                        },
                      ],
                    },
                    // Call identity API (real) then navigate on success
                    {
                      'actionType': 'networkRequest',
                      'url':
                          'http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/identity/{{receiver.nationalCode}}/{{receiver.birthDateCompact}}',
                      'method': 'get',
                      'headers': {
                        'accept': '*/*',
                        'app-platform': 'android',
                        'app-store': 'application/json',
                        'app-version': '456',
                        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                        'serviceauthorization':
                            'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                        'authorization': '{{auth.accessToken}}',
                      },
                      'results': [
                        {
                          'statusCode': 200,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiverIdentity.raw',
                                    'value': '{{data.data}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.name',
                                    'value': '{{data.data.name}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.family',
                                    'value': '{{data.data.family}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.fullName',
                                    'value':
                                        '{{data.data.name}} {{data.data.family}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.fatherName',
                                    'value': '{{data.data.fatherName}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.gender',
                                    'value': '{{data.data.gender}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.nationalId',
                                    'value': '{{data.data.nationalId}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'navigate',
                                'widgetType':
                                    'promissory_real_data', // Navigate to Real Data Screen
                                'navigationStyle': 'push',
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': 422,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiver.error',
                                    'value':
                                        '{{appStrings.promissory.invalidDataError}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.invalidDataErrorDetail}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': 401,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.sessionExpiredError}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': -1, // Fallback for any other errors
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiver.error',
                                    'value':
                                        '{{appStrings.promissory.serverConnectionError}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.serverConnectionErrorDetail}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                      ],
                    },
                  ],
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
    if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
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

import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_login_form')
StacWidget promissoryRealLoginForm() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isLoginFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.loginDynamic}}',
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.all(16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data: '{{appStrings.promissory.enterInfoBelow}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 24),

                    // Mobile Number
                    StacText(
                      data: '{{appStrings.promissory.issuerPhoneNumber}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'mobile_number',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 11,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.mobileExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'phone',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message':
                              '{{appStrings.promissory.mobileFormatError}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // National Code
                    StacText(
                      data: '{{appStrings.promissory.nationalCode}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'national_code',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 10,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText:
                            '{{appStrings.promissory.nationalCode10Digit}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message':
                              '{{appStrings.promissory.nationalCodeLengthError}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // GPay Token
                    StacText(
                      data: 'GPay Token',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'gpay_token',
                      'textDirection': 'ltr',
                      'textAlign': 'left',
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.gpayTokenExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'text',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'.+',
                          'message':
                              '{{appStrings.promissory.gpayTokenRequired}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // CIF
                    StacText(
                      data: 'CIF',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'cif',
                      'textDirection': 'ltr',
                      'textAlign': 'left',
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.cifExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'text',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'.+',
                          'message': '{{appStrings.promissory.cifRequired}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Birth Date (Using Date Picker Action)
                    StacText(
                      data: '{{appStrings.promissory.birthdate}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacGestureDetector(
                      onTap: StacPersianDatePickerAction(
                        formFieldId: 'birthdate',
                        firstDate: '1300/01/01',
                        lastDate: '1450/12/29',
                        onDateSelected: StacValidateFieldsAction(
                          resultKey: 'isLoginFormValid',
                          fields: [
                            {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                            {'id': 'national_code', 'rule': r'^\d{10}$'},
                            {'id': 'gpay_token', 'rule': r'.+'},
                            {'id': 'cif', 'rule': r'.+'},
                            {'id': 'birthdate', 'rule': r'.+'},
                          ],
                        ).toJson(),
                      ),
                      child: StacTextFormField(
                        id: 'birthdate',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: '{{appStrings.promissory.birthdate}}',
                          filled: false,
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
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
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: r'.+',
                            message:
                                '{{appStrings.promissory.birthdateRequired}}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isLoginFormValid',
                'onPressed': StacSequenceAction(
                  actions: [
                    // Copy form values to use in body
                    StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'login.mobile',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'mobile_number',
                          }).toJson(),
                        },
                        {
                          'key': 'login.nationalCode',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'national_code',
                          }).toJson(),
                        },
                        {
                          'key': 'login.gpayToken',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'gpay_token',
                          }).toJson(),
                        },
                        {
                          'key': 'login.cif',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'cif',
                          }).toJson(),
                        },
                        {
                          'key': 'login.birthDate',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'birthdate',
                          }).toJson(),
                        },
                        // Format birthdate: remove slashes
                        {
                          'key': 'login.birthDateClean',
                          'value': '{{replace(login.birthDate,"/","")}}',
                        },
                      ],
                    ),
                    StacNetworkRequestAction(
                      url:
                          'http://192.168.107.22:8280/api/digitalbanking/logins/v1.0/tobank/users',
                      method: 'post',
                      headers: {
                        'accept': '*/*',
                        'app-platform': 'android',
                        'app-store': 'application/json',
                        'app-version': '456',
                        'authorization':
                            'Bearer null', // As in original service
                        'content-type': 'application/json',
                        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                        'serviceauthorization':
                            'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                      },
                      data: {
                        'nationalId': '{{login.nationalCode}}',
                        'mobileNumber': '{{login.mobile}}',
                        'gpayToken': '{{login.gpayToken}}',
                        'birthDate': '{{login.birthDateClean}}',
                        'cif': '{{login.cif}}',
                      },
                      results: [
                        {
                          'statusCode': 200,
                          'action': StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                values: [
                                  {
                                    'key': 'auth.accessToken',
                                    'value': '{{data.access_token}}',
                                  },
                                  {
                                    'key': 'userData.nationalCode',
                                    'value': '{{login.nationalCode}}',
                                  },
                                ],
                              ),
                              StacRawJsonAction({
                                'actionType': 'showSnackBar',
                                'content': {
                                  'type': 'text',
                                  'data':
                                      '{{appStrings.promissory.loginSuccess}}',
                                },
                              }),
                              StacRawJsonAction({
                                'actionType': 'navigate',
                                'widgetType': 'promissory_real_receiver',
                                'navigationStyle': 'push',
                              }),
                            ],
                          ),
                        },
                        {
                          'statusCode': 'default',
                          'action': StacRawJsonAction({
                            'actionType': 'showSnackBar',
                            'content': {
                              'type': 'text',
                              'data': '{{appStrings.promissory.loginError}}',
                            },
                          }),
                        },
                      ],
                    ),
                  ],
                ),
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.loginSaveToken}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
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

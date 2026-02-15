import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_data')
StacWidget promissoryRealData() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isDataFormValid', 'value': false},
        {'key': 'isIdentityLoading', 'value': false},
        {'key': 'isOnDemand', 'value': false},
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
                        StacContainer(
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
                                data: 'اطلاعات دریافت‌کننده',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 12),
                              _buildInfoRow(
                                label: 'کد ملی', value: '{{form.receiver_national_code}}',
                              ),
                              StacSizedBox(height: 8),
                              _buildInfoRow(label: 'شماره موبایل', value: '{{form.receiver_mobile}}'),
                              StacSizedBox(height: 8),
                              _buildInfoRow(
                                label: 'نام و نام خانوادگی',
                                value: '{{receiverIdentity.fullName}}',
                              ),
                            ],
                          ),
                        ),
                        StacSizedBox(height: 24),
                        StacContainer(
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
                                data: 'اطلاعات سفته',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 16),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data: 'مبلغ تعهد',
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
                                      fontSize: 13,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.subtitle}}',
                                    ),
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              StacRawJsonWidget({
                                'type': 'textFormField',
                                'id': 'promissory_amount',
                                'textDirection': 'rtl',
                                'textAlign': 'right',
                                'decoration': StacInputDecoration(
                                  hintText: '{{appStrings.promissory.enterAmountt}}',
                                  hintStyle: StacTextStyle(
                                    fontSize: 12,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.subtitle}}',
                                  ),
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ).toJson(),
                                'keyboardType': 'number',
                                'inputFormatters': [
                                  {'type': 'allow', 'rule': '[0-9]'},
                                ],
                                'validatorRules': [
                                  {
                                    'rule': r'^\d+$',
                                    'message': '{{appStrings.promissory.amountRequired}}',
                                  },
                                ],
                                'onChanged': _getFullValidationAction().toJson(),
                              }),
                              StacSizedBox(height: 16),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data: 'تاریخ پرداخت سفته',
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
                                        'activeColor': '{{appColors.current.secondary.color}}',
                                        'onChanged': _getFullValidationAction().toJson(),
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              StacRawJsonWidget({
                                'type': 'visibility',
                                'visible': '{{!isOnDemand}}',
                                'child': StacGestureDetector(
                                  onTap: StacPersianDatePickerAction(
                                    formFieldId: 'promissory_due_date',
                                    firstDate: '1403/01/01',
                                    lastDate: '1450/12/29',
                                    onDateSelected: _getFullValidationAction().toJson(),
                                  ),
                                  child: StacTextFormField(
                                    id: 'promissory_due_date',
                                    readOnly: true,
                                    enabled: false,
                                    style: StacCustomTextStyle(
                                      fontSize: 13,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                    textDirection: StacTextDirection.rtl,
                                    textAlign: StacTextAlign.right,
                                    decoration: StacInputDecoration(
                                      hintText: '{{appStrings.promissory.selectDate}}',
                                      hintStyle: StacTextStyle(
                                        fontSize: 12,
                                        fontWeight: StacFontWeight.w600,
                                        color: '{{appColors.current.text.hint}}',
                                      ),
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
                                        message: '{{appStrings.promissory.dueDateRequired}}',
                                      ),
                                    ],
                                  ),
                                ).toJson(),
                              }),
                              StacSizedBox(height: 16),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacExpanded(
                                    child: StacText(
                                      data: 'امکان انتقال به شخص ثالث',
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
                                    'activeColor': '{{appColors.current.secondary.color}}',
                                  }),
                                ],
                              ),
                              StacSizedBox(height: 16),
                              StacText(
                                data: '{{appStrings.promissory.paymentPlaceOptional}}',
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
                                minLines: 3,
                                maxLines: 5,
                                decoration: StacInputDecoration(
                                  hintText: '{{appStrings.promissory.paymentPlaceHint}}',
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              StacSizedBox(height: 16),
                              StacText(
                                data: '{{appStrings.promissory.amountOptionalSuffix}}',
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
                                minLines: 3,
                                maxLines: 5,
                                decoration: StacInputDecoration(
                                  hintText: '{{appStrings.promissory.descriptionHint}}',
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              StacSizedBox(height: 16),
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
                    'enabledKey': 'isDataFormValid',
                    'onPressed': StacSequenceAction(
                      actions: [
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
                          value: StacGetFormValueAction(id: 'promissory_payment_place'),
                        ),
                        StacCustomSetValueAction(
                          key: 'receiver.birthDateCompact',
                          value: "{{replace(receiver.birthDate,'/','')}}",
                        ),
                        StacCustomSetValueAction(
                          key: 'isIdentityLoading',
                          value: true,
                        ),
                        StacNetworkRequestAction(
                          url:
                              'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/fees?amount={{form.promissory_amount}}',
                          method: 'get',
                          headers: {
                            'accept': 'application/json',
                            'authorization': '{{auth.accessToken}}',
                          },
                          results: [
                            {
                              'statusCode': 200,
                              'action': StacSequenceAction(
                                actions: [
                                  StacCustomSetValueAction(
                                    values: [
                                      {
                                        'key': 'promissory.fees.stampFee',
                                        'value': '{{data_payload.stampFee}}',
                                      },
                                      {
                                        'key': 'promissory.fees.wage',
                                        'value': '{{data_payload.wage}}',
                                      },
                                      {
                                        'key': 'promissory.fees.total',
                                        'value': '{{data_payload.total}}',
                                      },
                                      {
                                        'key': 'isIdentityLoading',
                                        'value': false,
                                      },
                                    ],
                                  ),
                                  StacRawJsonAction({
                                    'actionType': 'navigate',
                                    'widgetType': 'promissory_real_confirm',
                                    'navigationStyle': 'push',
                                  }),
                                ],
                              ).toJson(),
                            },
                            {
                              'statusCode': -1,
                              'action': StacSequenceAction(
                                actions: [
                                  StacCustomSetValueAction(
                                    key: 'isIdentityLoading',
                                    value: false,
                                  ),
                                  StacRawJsonAction({
                                    'actionType': 'showDialog',
                                    'widget': StacAlertDialog(
                                      title: StacText(data: 'خطا'),
                                      content: StacText(
                                        data:
                                            'خطا در دریافت اطلاعات کارمزد. لطفا مجددا تلاش کنید.',
                                      ),
                                      actions: [
                                        StacTextButton(
                                          onPressed: StacRawJsonAction({
                                            'actionType': 'closeDialog',
                                          }),
                                          child: StacText(data: 'باشه'),
                                        ),
                                      ],
                                    ).toJson(),
                                  }),
                                ],
                              ).toJson(),
                            },
                          ],
                        ),
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

StacValidateFieldsAction _getFullValidationAction() {
  final fields = <Map<String, dynamic>>[
    {'id': 'promissory_amount', 'rule': r'^\d+$'},
    {
      'id': 'promissory_due_date',
      'rule': r'^\d{4}/\d{2}/\d{2}$',
      'optional': 'isOnDemand'
    },
  ];
  return StacValidateFieldsAction(
    resultKey: 'isDataFormValid',
    fields: fields,
  );
}

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

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

class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);
  @override
  String get actionType => json['actionType'] as String;
  @override
  Map<String, dynamic> toJson() => json;
}

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

class StacValidateFieldsAction extends StacAction {
  final String resultKey;
  final List<Map<String, dynamic>> fields;
  const StacValidateFieldsAction({required this.resultKey, required this.fields});
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

class StacPersianDatePickerAction extends StacAction {
  final String formFieldId;
  final String? firstDate;
  final String? lastDate;
  final dynamic onDateSelected;
  const StacPersianDatePickerAction({
    required this.formFieldId,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
  });
  @override
  String get actionType => 'persianDatePicker';
  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      if (firstDate != null) 'firstDate': firstDate,
      if (lastDate != null) 'lastDate': lastDate,
      if (onDateSelected != null)
        'onDateSelected': onDateSelected is StacAction
            ? (onDateSelected as StacAction).toJson()
            : onDateSelected,
    };
  }
}

class StacGetFormValueAction extends StacAction {
  final String id;
  const StacGetFormValueAction({required this.id});
  @override
  String get actionType => 'getFormValue';
  @override
  Map<String, dynamic> toJson() {
    return {'actionType': 'getFormValue', 'id': id};
  }
}

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

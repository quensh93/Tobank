import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'login_real_validation')
StacWidget promissoryRealValidation() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isValidationFormValid', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'اعتبار سنجی',
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
                    StacText(
                      data:
                          'کاربر گرامی، پیرو دستورالعمل بانک مرکزی در راستای اعتبارسنجی کاربران، شماره همراه، کد ملی و تاریخ تولد خود را بصورت صحیح وارد نمایید. لطفا شماره همراهی را وارد نمایید که مالک سیم‌کارت آن هستید.',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 12,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 16),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'validation_mobile',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'keyboardType': 'phone',
                      'decoration': StacInputDecoration(
                        hintText: 'شماره همراه خود را وارد نمایید',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'}
                      ],
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message': 'شماره همراه نامعتبر است',
                        }
                      ],
                      'onChanged': StacCustomSetValueAction(
                        key: 'isValidationFormValid',
                        value:
                            '{{matches(value, "^09\\\\d{9}\$") && matches(form.validation_national, "^\\\\d{10}\$") && matches(form.validation_birthdate, "^\\\\d{4}/\\\\d{2}/\\\\d{2}\$")}}',
                      ).toJson(),
                    }),
                    StacSizedBox(height: 12),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'validation_national',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'keyboardType': 'number',
                      'decoration': StacInputDecoration(
                        hintText: 'کد ملی خود را بدون خط تیره وارد نمایید',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'}
                      ],
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message': 'کد ملی نامعتبر است',
                        }
                      ],
                      'onChanged': StacCustomSetValueAction(
                        key: 'isValidationFormValid',
                        value:
                            '{{matches(form.validation_mobile, "^09\\\\d{9}\$") && matches(value, "^\\\\d{10}\$") && matches(form.validation_birthdate, "^\\\\d{4}/\\\\d{2}/\\\\d{2}\$")}}',
                      ).toJson(),
                    }),
                    StacSizedBox(height: 12),
                    StacGestureDetector(
                      onTap: StacPersianDatePickerAction(
                        formFieldId: 'validation_birthdate',
                        firstDate: '1300/01/01',
                        lastDate: '1500/12/29',
                        onDateSelected: StacCustomSetValueAction(
                          key: 'isValidationFormValid',
                          value:
                              '{{matches(form.validation_mobile, "^09\\\\d{9}\$") && matches(form.validation_national, "^\\\\d{10}\$") && matches(value, "^\\\\d{4}/\\\\d{2}/\\\\d{2}\$")}}',
                        ),
                      ),
                      child: StacTextFormField(
                        id: 'validation_birthdate',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: 'تاریخ تولد خود را انتخاب نمایید',
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
                            message: 'تاریخ تولد الزامی است',
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
                'enabledKey': 'isValidationFormValid',
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_real_intro',
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
                  data: 'ورود و ذخیره توکن',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
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

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
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

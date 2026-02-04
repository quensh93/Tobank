import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Payment Method Page
///
/// This screen allows users to select payment method:
/// 1. Wallet payment
/// 2. Deposit payment
/// 3. Internet Gateway payment
///
/// Reference: docs/promissory_docs/request_promissory_select_payment_bottom_sheet.dart
@StacScreen(screenName: 'promissory_payment')
StacWidget promissoryPayment() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isWalletSelected', value: false),
        StacCustomSetValueAction(key: 'isDepositSelected', value: false),
        StacCustomSetValueAction(key: 'selectedPaymentMethod', value: ''),
        StacCustomSetValueAction(key: 'isPayEnabled', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.paymentTitle}}',
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
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  // Issuance summary and payable amount
                  StacColumn(
                    children: [
                      StacContainer(
                        decoration: StacBoxDecoration(
                          color:
                              '{{appColors.current.background.surfaceContainer}}',
                          borderRadius: StacBorderRadius.all(40),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 0.5,
                          ),
                        ),
                        padding: StacEdgeInsets.all(12),
                        child: StacImage(
                          src: 'assets/icons/ic_promissory_request.svg',
                          imageType: StacImageType.asset,
                          width: 40,
                          height: 40,
                          color: '{{appColors.current.primary.color}}',
                        ),
                      ),
                      StacSizedBox(height: 12),
                      StacText(
                        data: '{{appStrings.promissory.issuanceTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 20),
                      StacRow(
                        textDirection: StacTextDirection.rtl,
                        mainAxisAlignment: StacMainAxisAlignment.spaceAround,
                        children: [
                          StacText(
                            data: '{{appStrings.promissory.payableAmount}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w500,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacRow(
                            textDirection: StacTextDirection.ltr,
                            children: [
                              StacText(
                                data: '{{appData.totalAmount}}',
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w900,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(width: 4),
                              StacText(
                                data: '{{appStrings.common.rial}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  StacSizedBox(height: 16),
                  // Fee breakdown card
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    child: StacColumn(
                      children: [
                        _buildKVRow(
                          '{{appStrings.promissory.stampDuty}}',
                          '{{appData.taxAmount}} {{appStrings.common.rial}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildKVRow(
                          '{{appStrings.promissory.issuanceFee}}',
                          '{{appData.feeAmount}} {{appStrings.common.rial}}',
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Payment Methods Title
                  StacText(
                    data: '{{appStrings.promissory.paymentMethod}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Wallet Payment Option
                  _buildPaymentOption(
                    id: 'wallet',
                    isSelectedVar: 'isWalletSelected',
                    activeColor:
                        'appColors.current.error.color', // Removed braces
                    icon: 'assets/icons/ic_wallet.svg',
                    title: '{{appStrings.promissory.walletPayment}}',
                    subtitle:
                        '{{wallet.balance}} {{appStrings.common.rial}}',
                  ),
                  StacSizedBox(height: 12),

                  // Deposit Payment Option
                  _buildPaymentOption(
                    id: 'deposit',
                    isSelectedVar: 'isDepositSelected',
                    icon: 'assets/icons/ic_branch.svg',
                    title: '{{appStrings.promissory.depositPayment}}',

                  ),
                  StacSizedBox(height: 12),

                  // Navigate to deposit selection when tapping deposit option
                ],
              ),
            ),
          ),
          // Pay Button (Wallet Action - Default)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 0 : 88}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': StacDialogAction(
                  widget: StacAlertDialog(
                    title: StacText(
                      data: '{{appStrings.promissory.payConfirmTitle}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    content: StacText(
                      data: '{{appStrings.promissory.payConfirmMessage}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    actions: [
                      StacTextButton(
                        onPressed: StacRawJsonAction({
                          'actionType': 'closeDialog',
                        }),
                        child: StacText(
                          data: '{{appStrings.common.cancel}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                      StacTextButton(
                        onPressed: StacSequenceAction(
                          actions: [
                            StacRawJsonAction({'actionType': 'closeDialog'}),
                            {
                              'actionType': 'navigate',
                              'widgetType': 'promissory_sign',
                              'navigationStyle': 'pushReplacement',
                            },
                          ],
                        ),
                        child: StacText(
                          data: '{{appStrings.common.confirm}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                    ],
                  ).toJson(),
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
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
          // Pay Button (Deposit Action)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 88 : 0}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_deposit_select',
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
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
        ],
      ),
    ),
  );
}

/// Helper: KV row (rtl label, ltr value)
StacWidget _buildKVRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacExpanded(
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 8),
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

/// Helper: Payment option card
StacWidget _buildPaymentOption({
  required String id,
  required String icon,
  required String title,
   String subtitle = '',
  String? isSelectedVar,
  String activeColor = 'appColors.current.primary.color', // Removed braces
}) {
  return StacGestureDetector(
    onTap: id == 'deposit'
        ? StacSequenceAction(
            actions: [
              StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
              StacCustomSetValueAction(key: 'isPayEnabled', value: true),
              StacCustomSetValueAction(key: 'isWalletSelected', value: false),
              if (isSelectedVar != null)
                StacCustomSetValueAction(key: isSelectedVar, value: true),
            ],
          )
        : StacSequenceAction(
            actions: [
              StacCustomSetValueAction(key: 'selectedPaymentMethod', value: id),
              StacCustomSetValueAction(key: 'isPayEnabled', value: true),
              StacCustomSetValueAction(key: 'isDepositSelected', value: false),
              if (isSelectedVar != null)
                StacCustomSetValueAction(key: isSelectedVar, value: true),
            ],
          ),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: isSelectedVar != null
              ? '{{$isSelectedVar ? $activeColor : appColors.current.input.borderEnabled}}'
              : '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Icon
          StacImage(
            src: icon,
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
            color: '{{appColors.current.primary.color}}',
          ),
          StacSizedBox(width: 6),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 12),
          // Text
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.start,
              children: [

                StacSizedBox(height: 4),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ],
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
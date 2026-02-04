import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Rules Page
///
/// This screen displays the rules and terms for promissory note issuance.
/// Users must read the rules content (loaded from API), check the acceptance
/// checkbox, and press Continue to proceed.
///
/// Reference: docs/promissory_docs/request_promissory_rule_page.dart
@StacScreen(screenName: 'promissory_rules')
StacWidget promissoryRules() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isRulesAccepted', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.rulesTitle}}',
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
          StacSizedBox(height: 16),
          // Rules Card with Scrollable Content
          StacExpanded(
            child: StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 16),
              child: StacContainer(
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.background.surfaceContainer}}',
                  borderRadius: StacBorderRadius.all(12),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1,
                  ),
                ),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    // Title
                    StacPadding(
                      padding: StacEdgeInsets.all(16),
                      child: StacText(
                        data: '{{appStrings.promissory.rulesCardTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                    // Divider
                    StacContainer(
                      height: 1,
                      color: '{{appColors.current.input.borderEnabled}}',
                    ),
                    // Scrollable Content
                    StacExpanded(
                      child: StacSingleChildScrollView(
                        padding: StacEdgeInsets.all(16),
                        child: StacText(
                          data: '{{appStrings.promissory.rulesContent}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            height: 1.8,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StacSizedBox(height: 24),
          // Checkbox Row
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacContainer(
              color: 'transparent',
              padding: StacEdgeInsets.symmetric(vertical: 8),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  // Custom Checkbox
                  StacGestureDetector(
                    onTap: StacRawJsonAction({
                      'actionType': 'setValue',
                      'key': 'isRulesAccepted',
                      'value': '{{isRulesAccepted ? false : true}}',
                    }),
                    child: StacContainer(
                      width: 24,
                      height: 24,
                      decoration: StacBoxDecoration(
                        color:
                            '{{isRulesAccepted ? appColors.current.primary.color : "transparent"}}',
                        borderRadius: StacBorderRadius.all(6),
                        border: StacBorder.all(
                          color:
                              '{{isRulesAccepted ? appColors.current.primary.color : appColors.current.text.subtitle}}',
                          width: 2,
                        ),
                      ),
                      child: StacCenter(
                        child: StacRawJsonWidget({
                          'type': 'opacity',
                          'opacity': '{{isRulesAccepted ? 1.0 : 0.0}}',
                          'child': StacImage(
                            src: 'assets/icons/ic_check.svg',
                            color: '#FFFFFF',
                            width: 16,
                            height: 16,
                          ).toJson(),
                        }),
                      ),
                    ),
                  ),
                  StacSizedBox(width: 12),
                  // Label
                  StacExpanded(
                    child: StacGestureDetector(
                      onTap: StacRawJsonAction({
                        'actionType': 'setValue',
                        'key': 'isRulesAccepted',
                        'value': '{{isRulesAccepted ? false : true}}',
                      }),
                      child: StacText(
                        data: '{{appStrings.promissory.acceptRulesLabel}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          height: 1.4,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacSizedBox(height: 24),
          // Continue Button
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': 'isRulesAccepted',
              // 'enabled': false, // Removed hardcoded false
              'onPressed': {
                'actionType': 'navigate',
                'widgetType': 'request_promissory_deposit',
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
          StacSizedBox(height: 16),
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
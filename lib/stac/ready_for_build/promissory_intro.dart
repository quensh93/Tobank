import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Intro Screen
///
/// This is the main entry point for the promissory (سفته) feature.
/// It shows two tabs:
/// 1. Promissory Services (خدمات سفته) - Actions like issuing promissory
/// 2. My Promissory Notes (سفته‌های من) - List of user's promissory notes
///
/// Reference: docs/promissory_docs/promissory_screen.dart
@StacScreen(screenName: 'promissory_intro')
StacWidget promissoryIntro() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.title}}',
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
      children: [
        // Tab Selector Row
        StacSizedBox(height: 16),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                // Promissory Services Tab (Active)
                StacExpanded(
                  child: StacContainer(
                    padding: StacEdgeInsets.symmetric(vertical: 12),
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.primary.color}}',
                      borderRadius: StacBorderRadius.all(8),
                    ),
                    child: StacCenter(
                      child: StacText(
                        data: '{{appStrings.promissory.servicesTab}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.primary.onPrimary}}',
                        ),
                      ),
                    ),
                  ),
                ),
                // My Promissory Tab (Inactive - Coming Soon)
                StacExpanded(
                  child: StacGestureDetector(
                    onTap: StacRawJsonAction({
                      'actionType': 'showResult',
                      'title': '{{appStrings.common.comingSoon}}',
                      'content': '{{appStrings.promissory.myNotesComingSoon}}',
                    }),
                    child: StacContainer(
                      padding: StacEdgeInsets.symmetric(vertical: 12),
                      child: StacCenter(
                        child: StacText(
                          data: '{{appStrings.promissory.myNotesTab}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        StacSizedBox(height: 16),

        StacSizedBox(height: 16),

        // Section Header Box (Electronic Promissory)
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: '{{appStrings.promissory.title}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
        ),
        StacSizedBox(height: 12),

        // Services Content Area
        StacExpanded(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                // Request Promissory Card
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_request.svg',
                  title: '{{appStrings.promissory.requestPromissory}}',
                  description:
                      '{{appStrings.promissory.requestPromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'navigate',
                    'widgetType': 'promissory_rules',
                    'navigationStyle': 'push',
                  }),
                ),
                StacSizedBox(height: 12),

                // Guarantee Promissory Card
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_guarantee.svg',
                  title: '{{appStrings.promissory.guaranteePromissory}}',
                  description:
                      '{{appStrings.promissory.guaranteePromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'showResult',
                    'title': '{{appStrings.common.comingSoon}}',
                    'content': '{{appStrings.promissory.comingSoonMessage}}',
                  }),
                ),
                StacSizedBox(height: 12),

                // View Promissory Card (Inquiry)
                _buildServiceCard(
                  icon: 'assets/icons/ic_promissory_inquiry.svg',
                  title: '{{appStrings.promissory.viewPromissory}}',
                  description: '{{appStrings.promissory.viewPromissoryDesc}}',
                  onTap: StacRawJsonAction({
                    'actionType': 'showResult',
                    'title': '{{appStrings.common.comingSoon}}',
                    'content': '{{appStrings.promissory.comingSoonMessage}}',
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Helper to build a service card
StacWidget _buildServiceCard({
  required String icon,
  required String title,
  required String description,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Icon Container (Start/Right)
          StacContainer(
            width: 48,
            height: 48,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.primary.color}}20',
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacCenter(
              child: StacImage(
                src: icon,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.primary.color}}',
              ),
            ),
          ),
          StacSizedBox(width: 12),
          // Text Content (End/Left)
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 4),
                StacText(
                  data: description,
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

/// Custom class to support alias text styles (same pattern as in login_flow_linear_login.dart)





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
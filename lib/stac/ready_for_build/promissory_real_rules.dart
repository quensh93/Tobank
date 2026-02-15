import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_rules')
StacWidget promissoryRealRules() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: const [
        {'key': 'isRulesAccepted', 'value': false},
        {'key': 'isSanaLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.requestPromissory}}',
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
                    StacContainer(
                      height: 1,
                      color: '{{appColors.current.input.borderEnabled}}',
                    ),
                    StacExpanded(
                      child: StacSingleChildScrollView(
                        padding: StacEdgeInsets.all(16),
                        child: StacText(
                          data:
                              '{{appStrings.promissory.rulesContentPromissory}}',
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
          StacSizedBox(height: 20),
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: StacContainer(
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(8),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              padding: StacEdgeInsets.symmetric(vertical: 16),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacSizedBox(width: 8),
                  StacGestureDetector(
                    onTap: StacRawJsonAction({
                      'actionType': 'setValue',
                      'key': 'isRulesAccepted',
                      'value': '{{isRulesAccepted ? false : true}}',
                    }),
                    child: StacContainer(
                      width: 21,
                      height: 21,
                      decoration: StacBoxDecoration(
                        color:
                            '{{isRulesAccepted ? appColors.current.secondary.color : "transparent"}}',
                        borderRadius: StacBorderRadius.all(3),
                        border: StacBorder.all(
                          color:
                              '{{isRulesAccepted ? appColors.current.secondary.color : appColors.current.text.subtitle}}',
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
                            width: 19,
                            height: 19,
                          ).toJson(),
                        }),
                      ),
                    ),
                  ),
                  StacSizedBox(width: 12),
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
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': 'isRulesAccepted',
              'loadingKey': 'isSanaLoading',
              'onPressed': {
                'actionType': 'sequence',
                'actions': [
                  {
                    'actionType': 'setValue',
                    'key': 'isSanaLoading',
                    'value': true,
                  },
                  {
                    'actionType': 'networkRequest',
                    'url':
                        'http://192.168.107.22:8280/api/digitalbanking/governance/v1.0/sana/{{userData.nationalCode}}/1',
                    'method': 'get',
                    'headers': {
                      'accept': 'application/json',
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
                              'key': 'isSanaLoading',
                              'value': false,
                            },
                            {
                              'actionType': 'navigate',
                              'widgetType': 'promissory_real_issuer',
                              'navigationStyle': 'push',
                            },
                          ],
                        },
                      },
                      {
                        'statusCode': 500,
                        'action': {
                          'actionType': 'sequence',
                          'actions': [
                            {
                              'actionType': 'setValue',
                              'key': 'isSanaLoading',
                              'value': false,
                            },
                            {
                              'actionType': 'showSnackBar',
                              'backgroundColor': '#D32F2F',
                              'content': {
                                'type': 'text',
                                'data': 'خطای سرور رخ داده است',
                                'style': {
                                  'type': 'custom',
                                  'color': '#FFFFFF',
                                  'fontSize': 14,
                                },
                              },
                            },
                          ],
                        },
                      },
                      {
                        'statusCode': -1,
                        'action': {
                          'actionType': 'sequence',
                          'actions': [
                            {
                              'actionType': 'setValue',
                              'key': 'isSanaLoading',
                              'value': false,
                            },
                            {
                              'actionType': 'showSnackBar',
                              'backgroundColor': '#D32F2F',
                              'content': {
                                'type': 'text',
                                'data':
                                    '{{data.status.message.0 ?? "خطایی رخ داده است"}}',
                                'style': {
                                  'type': 'custom',
                                  'color': '#FFFFFF',
                                  'fontSize': 14,
                                },
                              },
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
          StacSizedBox(height: 16),
        ],
      ),
    ),
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

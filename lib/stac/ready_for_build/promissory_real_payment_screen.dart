import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_payment')
StacWidget promissoryRealPayment() {
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
                  StacColumn(
                    children: [
                      StacContainer(
                        decoration: StacBoxDecoration(
                          color: '{{appColors.current.background.surfaceContainer}}',
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
                            textDirection: StacTextDirection.rtl,
                            children: [
                              StacText(
                                data: '{{promissory.fees.total}}',
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
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    child: StacColumn(
                      children: [
                        StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacExpanded(
                              child: StacText(
                                data: '{{appStrings.promissory.stampDuty}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  color: '{{appColors.current.text.subtitle}}',
                                ),
                              ),
                            ),
                            StacSizedBox(width: 8),
                            StacText(
                              data: '{{promissory.fees.stampFee}} {{appStrings.common.rial}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.text.title}}',
                              ),
                            ),
                          ],
                        ),
                        StacSizedBox(height: 16),
                        StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacExpanded(
                              child: StacText(
                                data: '{{appStrings.promissory.issuanceFee}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  color: '{{appColors.current.text.subtitle}}',
                                ),
                              ),
                            ),
                            StacSizedBox(width: 8),
                            StacText(
                              data: '{{promissory.fees.wage}} {{appStrings.common.rial}}',
                              textDirection: StacTextDirection.rtl,
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
                  StacSizedBox(height: 16),
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
                  StacGestureDetector(
                    onTap: StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'selectedPaymentMethod',
                          value: 'wallet',
                        ),
                        StacCustomSetValueAction(
                          key: 'isPayEnabled',
                          value: true,
                        ),
                        StacCustomSetValueAction(
                          key: 'isDepositSelected',
                          value: false,
                        ),
                        StacCustomSetValueAction(
                          key: 'isWalletSelected',
                          value: true,
                        ),
                      ],
                    ),
                    child: StacContainer(
                      padding: StacEdgeInsets.all(16),
                      decoration: StacBoxDecoration(
                        color:
                            '{{isWalletSelected ? appColors.current.lightSecondery.color : appColors.current.background.surfaceContainer}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color:
                              '{{isWalletSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacRow(
                        textDirection: StacTextDirection.rtl,
                        children: [
                          StacContainer(
                            decoration: StacBoxDecoration(
                                color: '{{appColors.current.background.surfaceContainer}}',
                                borderRadius: StacBorderRadius.all(25)),
                            child: StacImage(
                              src: 'assets/icons/ic_wallet.svg',
                              imageType: StacImageType.asset,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          StacSizedBox(width: 6),
                          StacText(
                            data: '{{appStrings.promissory.walletPayment}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(width: 12),
                          StacExpanded(
                            child: StacColumn(
                              crossAxisAlignment: StacCrossAxisAlignment.start,
                              children: [
                                StacSizedBox(height: 4),
                                StacText(
                                  data: '{{wallet.balance}} {{appStrings.common.rial}}',
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
                  ),
                  StacSizedBox(height: 12),
                  StacGestureDetector(
                    onTap: StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'selectedPaymentMethod',
                          value: 'deposit',
                        ),
                        StacCustomSetValueAction(
                          key: 'isPayEnabled',
                          value: true,
                        ),
                        StacCustomSetValueAction(
                          key: 'isWalletSelected',
                          value: false,
                        ),
                        StacCustomSetValueAction(
                          key: 'isDepositSelected',
                          value: true,
                        ),
                      ],
                    ),
                    child: StacContainer(
                      padding: StacEdgeInsets.all(16),
                      decoration: StacBoxDecoration(
                        color:
                            '{{isDepositSelected ? appColors.current.lightSecondery.color : appColors.current.background.surfaceContainer}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color:
                              '{{isDepositSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacRow(
                        textDirection: StacTextDirection.rtl,
                        children: [
                          StacContainer(
                            decoration: StacBoxDecoration(
                                color: '{{appColors.current.background.surfaceContainer}}',
                                borderRadius: StacBorderRadius.all(25)),
                            child: StacImage(
                              src: 'assets/icons/ic_gateway.svg',
                              imageType: StacImageType.asset,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          StacSizedBox(width: 6),
                          StacText(
                            data: '{{appStrings.promissory.depositPayment}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(width: 12),
                          StacExpanded(
                            child: StacColumn(
                              crossAxisAlignment: StacCrossAxisAlignment.start,
                              children: [
                                StacSizedBox(height: 4),
                                StacText(
                                  data: '',
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
                  ),
                  StacSizedBox(height: 12),
                ],
              ),
            ),
          ),
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
                'onPressed': StacRawJsonAction({
                  'actionType': 'showDialog',
                  'widget': {
                    'type': 'alertDialog',
                    'title': {
                      'type': 'column',
                      'mainAxisAlignment': 'center',
                      'children': [
                        {
                          'type': 'container',
                          'width': 48,
                          'height': 48,
                          'child': {
                            'type': 'image',
                            'src': 'assets/icons/ic_info.svg',
                            'imageType': 'asset',
                            'width': 12,
                            'height': 12,
                            'color': '{{appColors.current.primary.color}}'
                          }
                        },
                        {'type': 'sizedBox', 'height': 12},
                        {
                          'type': 'text',
                          'data': '{{appStrings.promissory.payConfirmMessage}}',
                          'textDirection': 'rtl',
                          'textAlign': 'center',
                          'style': {
                            'type': 'custom',
                            'fontSize': 16,
                            'fontWeight': 'bold',
                            'color': '{{appColors.current.text.title}}'
                          }
                        }
                      ]
                    },
                    'content': {
                      'type': 'text',
                      'data': '{{appStrings.promissory.signConfirmationMessage}}',
                      'textDirection': 'rtl',
                      'textAlign': 'center',
                      'style': {
                        'type': 'custom',
                        'fontSize': 14,
                        'color': '{{appColors.current.text.subtitle}}'
                      }
                    },
                    'actions': [
                      {
                        'type': 'container',
                        'decoration': StacBoxDecoration(
                          borderRadius: StacBorderRadius.all(12),
                          border: StacBorder.all(color: '#000000', width: 0.8),
                        ).toJson(),
                        'child': {
                          'type': 'elevatedButton',
                          'onPressed': {'actionType': 'closeDialog'},
                          'style': StacButtonStyle(
                            foregroundColor: '{{appColors.current.text.title}}',
                            fixedSize: StacSize(120, 44),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.all(12),
                            ),
                            elevation: 0,
                          ).toJson(),
                          'child': {
                            'type': 'text',
                            'data': '{{appStrings.common.cancel}}',
                            'textDirection': 'rtl',
                            'style': {
                              'type': 'custom',
                              'fontSize': 16,
                              'fontWeight': 'bold',
                              'color': '{{appColors.current.text.title}}'
                            }
                          }
                        }
                      },
                      {
                        'type': 'elevatedButton',
                        'onPressed': {
                          'actionType': 'sequence',
                          'actions': [
                            {'actionType': 'closeDialog'},
                            {
                              'actionType': 'navigate',
                              'widgetType': 'promissory_real_sign',
                              'navigationStyle': 'pushReplacement'
                            }
                          ]
                        },
                        'style': StacButtonStyle(
                          backgroundColor: '{{appColors.current.primary.color}}',
                          foregroundColor: '{{appColors.current.primary.onPrimary}}',
                          fixedSize: StacSize(120, 44),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(12),
                          ),
                          elevation: 0,
                        ).toJson(),
                        'child': {
                          'type': 'text',
                          'data': '{{appStrings.common.confirm}}',
                          'textDirection': 'rtl',
                          'style': {
                            'type': 'custom',
                            'fontSize': 16,
                            'fontWeight': 'bold',
                            'color': '{{appColors.current.primary.onPrimary}}'
                          }
                        }
                      }
                    ]
                  }
                }).toJson(),
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
                  'widgetType': 'promissory_real_payment_deposits',
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

String _fmt(String? value) {
  final s = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
  if (s.isEmpty) return '0';
  final buffer = StringBuffer();
  var count = 0;
  for (var i = s.length - 1; i >= 0; i--) {
    buffer.write(s[i]);
    count++;
    if (i > 0 && count % 3 == 0) {
      buffer.write('.');
    }
  }
  return buffer.toString().split('').reversed.join();
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

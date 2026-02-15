import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_sign')
StacWidget promissoryRealSign() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isSigning', value: false),
        StacCustomSetValueAction(key: 'signPage', value: '1'),
        StacCustomSetValueAction(key: 'signX', value: '100'),
        StacCustomSetValueAction(key: 'signY', value: '200'),
        StacCustomSetValueAction(key: 'signWidth', value: '150'),
        StacCustomSetValueAction(key: 'signHeight', value: '50'),
        StacCustomSetValueAction(
          key: 'form.promissory_request_id',
          value: '{{form.promissory_request_id ?? "REQ-" + now()}}',
        ),
        StacNetworkRequestAction(
          url:
              'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/{{form.unsigned_pdf_id}}/download/base64',
          method: 'get',
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json',
            'app-platform': 'android',
            'app-store': 'application/json',
            'app-version': '456',
            'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
            'serviceauthorization':
                'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
            'authorization': '{{auth.accessToken}}',
          },
          results: [
            {
              'statusCode': 200,
              'action': StacCustomSetValueAction(
                values: [
                  {
                    'key': 'form.unsigned_pdf',
                    'value': '{{data.data.base64}}',
                  },
                ],
              ).toJson(),
            },
            {
              'statusCode': -1,
              'action': StacRawJsonAction({
                'actionType': 'log',
                'message': 'DEBUG: PDF Fetch Failed',
              }),
            },
          ],
        ),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.signTitle}}',
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
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacCenter(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacContainer(
                      width: 999999,
                      height: 500,
                      child: StacCenter(
                        child: StacColumn(
                          mainAxisAlignment: StacMainAxisAlignment.center,
                          children: [
                            StacImage(
                              src: 'assets/icons/sign-pdf.svg',
                              imageType: StacImageType.asset,
                              width: 145,
                              height: 145,
                            ),
                            StacSizedBox(height: 16),
                            StacText(
                              data:
                                  '{{appStrings.promissory.signInstructionsDetail}}',
                              textDirection: StacTextDirection.rtl,
                              textAlign: StacTextAlign.center,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabled': true,
              'loadingKey': 'isSigning',
              'onPressed': {
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
                        'decoration': {},
                        'child': {
                          'type': 'image',
                          'src': 'assets/icons/ic_info.svg',
                          'imageType': 'asset',
                          'width': 12,
                          'height': 12,
                          'color': '{{appColors.current.primary.color}}',
                        },
                      },
                      {'type': 'sizedBox', 'height': 12},
                      {
                        'type': 'text',
                        'data': '{{appStrings.promissory.signTitledialog}}',
                        'textDirection': 'rtl',
                        'textAlign': 'center',
                        'style': {
                          'type': 'custom',
                          'fontSize': 16,
                          'fontWeight': 'bold',
                          'color': '{{appColors.current.text.title}}',
                        },
                      },
                    ],
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
                            'color': '{{appColors.current.text.title}}',
                          },
                        },
                      },
                    },
                    {
                      'type': 'elevatedButton',
                      'onPressed': {
                        'actionType': 'sequence',
                        'actions': [
                          {'actionType': 'closeDialog'},
                          StacPromissorySignAction(
                            unsignedContract: '{{form.unsigned_pdf}}',
                            signLocation: {
                              'x': 450,
                              'y': 450,
                              'width': 150,
                              'height': 50,
                              'x_ios': 450,
                              'y_ios': 450,
                              'width_ios': 150,
                              'height_ios': 50,
                              'page': 0,
                            },
                            promissoryTitle: 'سفته',
                            onSuccess: {
                              'actionType': 'sequence',
                              'actions': [
                                {
                                  'actionType': 'setValue',
                                  'key': 'isSigning',
                                  'value': true,
                                },
                                {
                                  'actionType': 'networkRequest',
                                  'url':
                                      'http://192.168.107.22:8280/api/digitalbanking/files/v1.0/promissory/upload/base64',
                                  'method': 'post',
                                  'headers': {
                                    'accept': '*/*',
                                    'app-platform': 'android',
                                    'app-store': 'application/json',
                                    'app-version': '456',
                                    'device-uuid':
                                        '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                                    'serviceauthorization':
                                        'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                                    'authorization': '{{auth.accessToken}}',
                                  },
                                  'data': {
                                    'fileName': 'promisorry.pdf',
                                    'contentType': 'application/pdf',
                                    'base64': '{{form.signed_pdf}}',
                                  },
                                  'results': [
                                    {
                                      'statusCode': 200,
                                      'action': {
                                        'actionType': 'sequence',
                                        'actions': [
                                          {
                                            'actionType': 'networkRequest',
                                            'url':
                                                'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/finalize/{{form.promissory_id}}',
                                            'method': 'post',
                                            'headers': {
                                              'accept': '*/*',
                                              'app-platform': 'android',
                                              'app-store': 'application/json',
                                              'app-version': '456',
                                              'device-uuid':
                                                  '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                                              'serviceauthorization':
                                                  'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                                              'authorization':
                                                  '{{auth.accessToken}}',
                                            },
                                            'data': {
                                              'signedPdfId': '{{data_payload.id}}',
                                            },
                                            'results': [
                                              {
                                                'statusCode': 200,
                                                'action': {
                                                  'actionType': 'sequence',
                                                  'actions': [
                                                    {
                                                      'actionType': 'setValue',
                                                      'key': 'isSigning',
                                                      'value': false,
                                                    },
                                                    {
                                                      'actionType': 'setValue',
                                                      'values': [
                                                        {
                                                          'key': 'promissoryId',
                                                          'value':
                                                              '{{data.data.promissoryId}}',
                                                        },
                                                        {
                                                          'key':
                                                              'transactionAmount',
                                                          'value':
                                                              '{{form.promissory_amount}}',
                                                        },
                                                        {
                                                          'key':
                                                              'transactionTime',
                                                          'value':
                                                              '{{form.promissory_due_date}}',
                                                        },
                                                        {
                                                          'key':
                                                              'serverSignedPdfId',
                                                          'value':
                                                              '{{data.data.serverSignedPdfId}}',
                                                        },
                                                        {
                                                          'key': 'requestId',
                                                          'value':
                                                              '{{data.data.requestId}}',
                                                        },
                                                        {
                                                          'key':
                                                              'trackingNumber',
                                                          'value':
                                                              '{{data.data.trackingNumber}}',
                                                        },
                                                      ],
                                                    },
                                                    {
                                                      'actionType': 'navigate',
                                                      'widgetType':
                                                          'promissory_real_success',
                                                      'navigationStyle':
                                                          'pushReplacement',
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
                                                      'key': 'isSigning',
                                                      'value': false,
                                                    },
                                                    {
                                                      'actionType':
                                                          'showSnackBar',
                                                      'content': {
                                                        'type': 'text',
                                                        'data':
                                                            'finalize failed',
                                                      },
                                                    },
                                                  ],
                                                },
                                              },
                                            ],
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
                                            'key': 'isSigning',
                                            'value': false,
                                          },
                                          {
                                            'actionType': 'showSnackBar',
                                            'content': {
                                              'type': 'text',
                                              'data': 'upload failed',
                                            },
                                          },
                                        ],
                                      },
                                    },
                                  ],
                                },
                              ],
                            },
                            onFailure: {
                              'actionType': 'showSnackBar',
                              'content': {
                                'type': 'text',
                                'data': '{{appStrings.promissory.signError}}',
                              },
                            },
                          ).toJson(),
                        ],
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
                          'color': '{{appColors.current.primary.onPrimary}}',
                        },
                      },
                    },
                  ],
                },
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
                data: 'امضا سفته',
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

class StacNetworkRequestAction extends StacAction {
  final String url;
  final String method;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? results;
  const StacNetworkRequestAction({
    required this.url,
    required this.method,
    this.headers,
    this.data,
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
      if (headers != null) 'headers': headers,
      if (data != null) 'data': data,
      if (results != null) 'results': results,
    };
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

class StacPromissorySignAction extends StacAction {
  final String unsignedContract;
  final Map<String, dynamic> signLocation;
  final String promissoryTitle;
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;
  const StacPromissorySignAction({
    required this.unsignedContract,
    required this.signLocation,
    required this.promissoryTitle,
    this.onSuccess,
    this.onFailure,
  });
  @override
  String get actionType => 'promissorySign';
  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'promissorySign',
      'unsignedContract': unsignedContract,
      'signLocation': signLocation,
      'promissoryTitle': promissoryTitle,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onFailure != null) 'onFailure': onFailure,
    };
  }
}

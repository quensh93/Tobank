import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_payment_deposits')
StacWidget promissoryRealPaymentDeposits() {
  final fetchDepositsAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'deposits.isLoaded', 'value': false},
          {'key': 'deposits.rawData', 'value': null},
          {'key': 'deposits.error', 'value': null},
          {'key': 'isDraftLoading', 'value': false},
        ],
      ),
      StacNetworkRequestAction(
        url:
            'http://192.168.107.22:8280/api/digitalbanking/deposits/v1.0/customer/{{userData.nationalCode}}',
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
              values: const [
                {
                  'key': 'deposits.rawData',
                  'value': '{{data_payload.deposits}}',
                },
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.error', 'value': null},
              ],
            ).toJson(),
          },
          {
            'statusCode': 403,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Access forbidden. Please check your permissions.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 401,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Authentication failed. Please login again.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 520,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value':
                      'Server Error (520): Unknown Response from Gateway. Please try again later.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': 500,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': 'Internal Server Error. Please try again later.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': -1,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'deposits.isLoaded', 'value': true},
                {'key': 'deposits.rawData', 'value': null},
                {
                  'key': 'deposits.error',
                  'value': '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  return StacStatefulWidget(
    onInit: fetchDepositsAction,
    child: StacRawJsonWidget({
      'type': 'promissory_real_deposits_list',
      'loadingKey': 'isDraftLoading',
      'onContinue': {
        'actionType': 'sequence',
        'actions': [
          {'actionType': 'setValue', 'key': 'isDraftLoading', 'value': true},
          {'actionType': 'setValue', 'key': 'hasSelection', 'value': true},
          {
            'actionType': 'networkRequest',
            'url':
                'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/draft',
            'method': 'post',
            'headers': {
              'accept': 'application/json',
              'authorization': '{{auth.accessToken}}',
              'content-type': 'application/json',
            },
            'data': {
              'issuerType': 'I',
              'sourceAccount': '{{selectedDeposit.depositNumber}}',
              'issuerBirthDate': "{{replace(userData.birthDate, '/', '')}}",
              'issuerNN': '{{userData.nationalCode}}',
              'issuerSanaCheck': true,
              'issuerCellphone': '{{removeLeadingZero(userData.mobile)}}',
              'issuerFullName': '{{userData.fullName}}',
              'issuerAccountNumber': '{{selectedDeposit.depositIban}}',
              'issuerAddress': '{{userData.address}}',
              'issuerPostalCode': '{{userData.postalCode}}',
              'recipientType': 'I',
              'recipientBirthDate': "{{replace(receiver.birthDate, '/', '')}}",
              'recipientNationalId': '{{receiver.nationalCode}}',
              'recipientCellphone': '{{removeLeadingZero(receiver.mobile)}}',
              'recipientFullName': '{{receiverIdentity.fullName}}',
              'paymentPlace': 'تهران، آرشام',
              'amount': '{{toInt(form.promissory_amount)}}',
              'dueDate': "{{replace(form.promissory_due_date, '/', '')}}",
              'description': '{{form.description}}',
              'transferable': true,
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
                        {'key': 'isDraftLoading', 'value': false},
                        {'key': 'hasSelection', 'value': true},
                        {
                          'key': 'form.unsigned_pdf_id',
                          'value': '{{data_payload.unSignedPdfId}}',
                        },
                        {
                          'key': 'form.promissory_id',
                          'value': '{{data_payload.id}}',
                        },
                      ],
                    },
                    {
                      'actionType': 'navigate',
                      'widgetType': 'promissory_real_sign',
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
                        {'key': 'isDraftLoading', 'value': false},
                        {'key': 'hasSelection', 'value': true},
                      ],
                    },
                    {
                      'actionType': 'showSnackBar',
                      'backgroundColor': '#D32F2F',
                      'content': {
                        'type': 'text',
                        'data': '{{data.status.message.0}}',
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
                      'values': [
                        {'key': 'isDraftLoading', 'value': false},
                        {'key': 'hasSelection', 'value': true},
                      ],
                    },
                    {
                      'actionType': 'showSnackBar',
                      'backgroundColor': '#D32F2F',
                      'content': {
                        'type': 'text',
                        'data': '{{data.status.message.0}}',
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
      'onRetry': fetchDepositsAction.toJson(),
    }),
  );
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

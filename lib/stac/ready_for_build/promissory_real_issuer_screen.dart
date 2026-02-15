import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_issuer')
StacWidget promissoryRealIssuer() {
  final fetchAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'issuer.isLoaded', 'value': false},
          {'key': 'issuer.error', 'value': null},
        ],
      ),
      StacNetworkRequestAction(
        url:
            'http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/info/{{userData.nationalCode}}',
        method: 'get',
        headers: {
          'accept': '*/*',
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
                  'key': 'userData.nationalCode',
                  'value': '{{data.data.nationalCode}}',
                },
                {
                  'key': 'userData.contactNumber',
                  'value': '{{data.data.contactNumber}}',
                },
                {
                  'key': 'userData.mobile',
                  'value': '{{data.data.cellphoneNumber}}',
                },
                {'key': 'userData.lastName', 'value': '{{data.data.lastName}}'},
                {
                  'key': 'userData.fatherName',
                  'value': '{{data.data.fatherName}}',
                },
                {
                  'key': 'userData.fullName',
                  'value': '{{data.data.firstName}} {{data.data.lastName}}',
                },
                {
                  'key': 'userData.birthDate',
                  'value': '{{data.data.birthDate}}',
                },
                {
                  'key': 'userData.postalCode',
                  'value': '{{data.data.postCode}}',
                },
                {'key': 'userData.address', 'value': '{{data.data.address}}'},
                {
                  'key': 'selectedDeposit.depositIban',
                  'value': '{{form.selected_shaba_number}}',
                },
                {'key': 'issuer.isLoaded', 'value': true},
                {'key': 'issuer.error', 'value': null},
              ],
            ).toJson(),
          },
          {
            'statusCode': 401,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'issuer.isLoaded', 'value': true},
                {
                  'key': 'issuer.error',
                  'value': 'Authentication failed. Please login again.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': -1,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'issuer.isLoaded', 'value': true},
                {
                  'key': 'issuer.error',
                  'value':
                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  return StacStatefulWidget(
    onInit: fetchAction,
    child: StacRawJsonWidget({
      'type': 'promissory_real_issuer_view',
      'onContinue': {
        'actionType': 'navigate',
        'widgetType': 'promissory_real_receiver',
        'navigationStyle': 'push',
      },
      'onRetry': fetchAction.toJson(),
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

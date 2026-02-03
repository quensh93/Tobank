import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

@StacScreen(screenName: 'promissory_real_payment_deposits')
StacWidget promissoryRealPaymentDeposits() {
  final fetchDepositsAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'deposits.isLoaded', 'value': false},
          {'key': 'deposits.rawData', 'value': null},
          {'key': 'deposits.error', 'value': null},
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
    onInit: fetchDepositsAction,
    child: StacRawJsonWidget({
      'type': 'promissory_real_deposits_list',
      'onContinue': {
        'actionType': 'navigate',
        'widgetType': 'promissory_real_sign',
        'navigationStyle': 'push',
      },
      'onRetry': fetchDepositsAction.toJson(),
    }),
  );
}

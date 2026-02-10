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
      'loadingKey': 'isDraftLoading',
      'onContinue': {
        'actionType': 'sequence',
        'actions': [
          {'actionType': 'setValue', 'key': 'isDraftLoading', 'value': true},
          {'actionType': 'setValue', 'key': 'hasSelection', 'value': false},
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

import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Issuer Information Screen
///
/// This screen displays the issuer (صادرکننده) information.
/// It uses a custom parser (promissory_real_issuer_view) that handles:
/// - Loading state (shows spinner while fetching data)
/// - Error state (shows error message with retry button)
/// - Success state (shows issuer data)
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
            'statusCode': -1, // Fallback for network errors/timeouts
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

  // Use the custom parser that handles loading/error/success states
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

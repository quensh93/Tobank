import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';
import '../../promissory/dart/request_promissory_deposit_page.dart';

/// Promissory Flow - Real Deposits Selection Page
///
/// This screen fetches deposits from the real API and displays them for selection.
/// Uses pure STAC Dart syntax with networkRequest action to fetch data.
///
/// Reference: lib/stac/tobank/flows/promissory/dart/request_promissory_deposit_page.dart
@StacScreen(screenName: 'promissory_real_deposits')
StacWidget promissoryRealDeposits() {
  // Use nested StacStatefulWidget to make child reactive
  // Outer widget handles the network request
  // Inner widget rebuilds when registry changes
  return StacStatefulWidget(
    // Fetch deposits when screen loads using standard networkRequest action
    // Note: userData.nationalCode and auth.accessToken should be in registry from login
    onInit: StacNetworkRequestAction(
      url: 'http://192.168.107.22:8280/api/digitalbanking/deposits/v1.0/customer/{{userData.nationalCode}}',
      method: 'get',
      headers: {
        'accept': '*/*',
        'app-platform': 'android',
        'app-store': 'application/json',
        'app-version': '456',
        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
        'serviceauthorization': 'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
        'authorization': 'Bearer {{auth.accessToken}}',
      },
      results: [
        {
          'statusCode': 200,
          'action': StacCustomSetValueAction(
            values: [
              // Store deposits list in registry
              // The API returns: { "data": [ { "depositNumber": "...", "depositTitle": "...", "depositIban": "..." } ] }
              // We transform it to the format expected by requestPromissoryDepositPage
              // Format: [ { "id": "...", "title": "...", "depositNumber": "...", "shabaNumber": "..." } ]
              // Note: The transformation happens in _buildDepositsContent which reads from registry
              {'key': 'deposits.rawData', 'value': '{{data.data}}'},
              // Also store a flag to indicate deposits are loaded
              {'key': 'deposits.isLoaded', 'value': true},
            ],
          ).toJson(),
        },
        {
          'statusCode': 403,
          'action': StacRawJsonAction({
            'actionType': 'log',
            'message': 'Access forbidden. Please check your permissions.',
          }).toJson(),
        },
        {
          'statusCode': 401,
          'action': StacRawJsonAction({
            'actionType': 'log',
            'message': 'Authentication failed. Please login again.',
          }).toJson(),
        },
      ],
    ),
    // The child will be re-parsed on each rebuild by StatefulWidgetParser
    // The key is that requestPromissoryDepositPage() returns a StacStatefulWidget
    // that rebuilds when registry changes, and its child reads from registry
    child: requestPromissoryDepositPage(),
  );
}

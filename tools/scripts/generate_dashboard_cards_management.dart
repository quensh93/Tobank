import 'dart:convert';

import 'package:tobank_sdui/stac/tobank/flows/dashboard/dart/cards_management_screen.dart';

// JSON flow must use assetPath, not widgetType.
// Dart source uses widgetType (correct for Dart flow).
// This generator converts navigate-action widgetType → assetPath in output.
const _widgetTypeToAssetPath = <String, String>{
  'dashboard_cards_management':
      'lib/stac/tobank/flows/dashboard/json/dashboard_cards_management.json',
  'dashboard_card_edit':
      'lib/stac/tobank/flows/dashboard/json/dashboard_card_edit.json',
  'dashboard_card_balance':
      'lib/stac/tobank/flows/dashboard/json/dashboard_card_balance.json',
  'dashboard_wallet_transfer_receipt':
      'lib/stac/tobank/flows/dashboard/json/dashboard_wallet_transfer_receipt.json',
  'dashboard_primary_pin_get':
      'lib/stac/tobank/flows/dashboard/json/dashboard_primary_pin_get.json',
  'dashboard_primary_pin_change':
      'lib/stac/tobank/flows/dashboard/json/dashboard_primary_pin_change.json',
  'dashboard_secondary_pin_get':
      'lib/stac/tobank/flows/dashboard/json/dashboard_secondary_pin_get.json',
  'dashboard_secondary_pin_change':
      'lib/stac/tobank/flows/dashboard/json/dashboard_secondary_pin_change.json',
  'dashboard_card_reissue_request':
      'lib/stac/tobank/flows/dashboard/json/dashboard_card_reissue_request.json',
};

dynamic _convertNavigateActions(dynamic node) {
  if (node is Map<String, dynamic>) {
    if (node['actionType'] == 'navigate' && node.containsKey('widgetType')) {
      final widgetType = node['widgetType'] as String?;
      if (widgetType != null && _widgetTypeToAssetPath.containsKey(widgetType)) {
        final result = Map<String, dynamic>.from(node);
        result.remove('widgetType');
        result['assetPath'] = _widgetTypeToAssetPath[widgetType];
        return result.map((k, v) => MapEntry(k, _convertNavigateActions(v)));
      }
    }
    return node.map((k, v) => MapEntry(k, _convertNavigateActions(v)));
  }
  if (node is List) {
    return node.map(_convertNavigateActions).toList();
  }
  return node;
}

void main() {
  const encoder = JsonEncoder.withIndent('  ');
  final raw = dashboardCardsManagement().toJson();
  final converted = _convertNavigateActions(raw);
  print(encoder.convert(converted));
}

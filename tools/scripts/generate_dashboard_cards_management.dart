import 'dart:convert';

import 'package:tobank_sdui/stac/tobank/flows/dashboard/dart/cards_management_screen.dart';

void main() {
  const encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert(dashboardCardsManagement().toJson()));
}

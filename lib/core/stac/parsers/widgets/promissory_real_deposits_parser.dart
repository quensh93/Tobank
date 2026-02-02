import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_deposits_screen.dart';

class PromissoryRealDepositsParser extends StacParser<Map<String, dynamic>> {
  const PromissoryRealDepositsParser();

  @override
  String get type => 'promissory_real_deposits';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return const PromissoryRealDepositsScreen();
  }
}

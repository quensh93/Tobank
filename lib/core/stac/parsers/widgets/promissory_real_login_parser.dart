import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_login_screen.dart';

class PromissoryRealLoginParser extends StacParser<Map<String, dynamic>> {
  const PromissoryRealLoginParser();

  @override
  String get type => 'promissory_real_login_form';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return const PromissoryRealLoginScreen();
  }
}

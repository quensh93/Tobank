import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';
import '../../../../stac/tobank/flows/promissory_real/dart/promissory_real_screen.dart';

class PromissoryRealLoaderParser extends StacParser<Map<String, dynamic>> {
  const PromissoryRealLoaderParser();

  @override
  String get type => 'promissory_real_loader';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return const PromissoryRealLoaderScreen();
  }
}

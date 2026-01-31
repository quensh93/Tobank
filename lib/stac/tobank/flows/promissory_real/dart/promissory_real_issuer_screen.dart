import 'package:stac_core/stac_core.dart';
import '../../promissory/dart/promissory_issuer.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';

/// Promissory Real Flow - Issuer Information Screen
///
/// This screen displays the issuer (صادرکننده) information.
/// It fetches customer info from API when the screen loads using onInit action.
///
/// Data is loaded from API and displayed:
/// 1. Issuer Information Card (national code, mobile, name, IBAN)
/// 2. Residence Information Card (postal code, address)
@StacScreen(screenName: 'promissory_real_issuer')
StacWidget promissoryRealIssuer() {
  return StacStatefulWidget(
    // Fetch customer info when screen loads
    onInit: StacRawJsonAction({
      'actionType': 'promissory_fetch_customer_info',
    }),
    child: promissoryIssuer(),
  );
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}


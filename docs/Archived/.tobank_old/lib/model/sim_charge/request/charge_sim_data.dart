import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class ChargeSimData extends ApiRequestModel {
  String? phoneNumber;
  String? operatorName;
  int? chargeType;
  String? chargeTypeString;
  int? amount;
  PaymentType? paymentType;
  String? clientRef;
  int? discount;
  String? wallet;

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'wallet': wallet,
        'mobile_number': phoneNumber,
        'charge_type': chargeType,
        'operator': operatorName,
        'client_ref': clientRef,
        'discount': discount,
      };
}

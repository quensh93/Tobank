import '../../../service/core/api_request_model.dart';

class InternetPlanRequestData extends ApiRequestModel {
  String phoneNumber;
  String operatorName;
  int wallet;
  String clientRef;
  int discount;
  int priceWithTax;
  int chargeType;

  InternetPlanRequestData({
    required this.phoneNumber,
    required this.operatorName,
    required this.wallet,
    required this.clientRef,
    required this.discount,
    required this.priceWithTax,
    required this.chargeType,
  });

  @override
  Map<String, dynamic> toJson() => {
        'amount': priceWithTax,
        'wallet': wallet.toString(),
        'mobile_number': phoneNumber,
        'charge_type': chargeType,
        'operator': operatorName,
        'callback': '',
        'client_ref': clientRef,
        'discount': discount,
      };
}

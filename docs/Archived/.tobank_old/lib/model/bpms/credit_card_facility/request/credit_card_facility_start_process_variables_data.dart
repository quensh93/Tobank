import '../../request/start_process_request_data.dart';

class CreditCardFacilityStartProcessVariables extends StartProcessRequestVariables {
  CreditCardFacilityStartProcessVariables({
    required this.branchCode,
    required this.requestAmount,
    required this.customerNumber,
    required this.paymentCount,
  });

  String branchCode;
  String requestAmount;
  String customerNumber;
  String paymentCount;

  @override
  Map<String, dynamic> toJson() => {
        'branchCode': branchCode,
        'requestAmount': requestAmount,
        'customerNumber': customerNumber,
        'paymentCount': paymentCount,
      };
}

import '../../request/start_process_request_data.dart';

class MarriageLoanStartProcessVariables extends StartProcessRequestVariables {
  MarriageLoanStartProcessVariables({
    required this.branchCode,
    required this.requestAmount,
    required this.customerNumber,
    required this.cbiTrackingNumber,
    required this.veteran,
  });

  String branchCode;
  String requestAmount;
  String customerNumber;
  String cbiTrackingNumber;
  bool veteran;

  @override
  Map<String, dynamic> toJson() => {
        'branchCode': branchCode,
        'requestAmount': requestAmount,
        'customerNumber': customerNumber,
        'cbiTrackingNumber': cbiTrackingNumber,
        'veteran': veteran,
      };
}

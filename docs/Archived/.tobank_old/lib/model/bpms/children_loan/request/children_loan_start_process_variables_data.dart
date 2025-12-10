import '../../request/start_process_request_data.dart';

class ChildrenLoanStartProcessVariables extends StartProcessRequestVariables {
  ChildrenLoanStartProcessVariables({
    required this.branchCode,
    required this.requestAmount,
    required this.customerNumber,
    required this.cbiTrackingNumber,
    required this.childrenCount,
  });

  String branchCode;
  String requestAmount;
  String customerNumber;
  String cbiTrackingNumber;
  String childrenCount;

  @override
  Map<String, dynamic> toJson() => {
        'branchCode': branchCode,
        'requestAmount': requestAmount,
        'customerNumber': customerNumber,
        'cbiTrackingNumber': cbiTrackingNumber,
        'childrenCount': childrenCount
      };
}

import '../../request/start_process_request_data.dart';

class MicroLendingLoanStartProcessVariables extends StartProcessRequestVariables {
  MicroLendingLoanStartProcessVariables({
    required this.branchCode,
    required this.requestAmount,
    required this.customerNumber,
  });

  String branchCode;
  String requestAmount;
  String customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'branchCode': branchCode,
        'requestAmount': requestAmount,
        'customerNumber': customerNumber,
      };
}

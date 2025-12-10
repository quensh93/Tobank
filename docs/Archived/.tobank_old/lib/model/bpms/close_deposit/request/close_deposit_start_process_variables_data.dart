import '../../request/start_process_request_data.dart';

class CloseDepositStartProcessVariables extends StartProcessRequestVariables {
  CloseDepositStartProcessVariables({
    required this.customerNumber,
    required this.sourceDeposit,
    required this.destinationDeposit,
  });

  String customerNumber;
  String sourceDeposit;
  String? destinationDeposit;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'sourceDeposit': sourceDeposit,
        'destinationDeposit': destinationDeposit,
      };
}

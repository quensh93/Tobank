import '../../request/start_process_request_data.dart';

class ModernBankingStartProcessVariables extends StartProcessRequestVariables {
  ModernBankingStartProcessVariables({
    required this.customerNumber,
  });

  String customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
      };
}

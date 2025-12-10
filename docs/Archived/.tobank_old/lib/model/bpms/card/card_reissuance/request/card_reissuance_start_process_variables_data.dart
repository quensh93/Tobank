import '../../../common/bpms_address.dart';
import '../../../request/start_process_request_data.dart';

class ReIssueCardStartProcessVariables extends StartProcessRequestVariables {
  ReIssueCardStartProcessVariables({
    required this.customerNumber,
    required this.customerDepositNumber,
    required this.pan,
    required this.customerAddress,
    this.cardTemplateId,
  });

  String customerNumber;
  String customerDepositNumber;
  String pan;
  BPMSAddress customerAddress;
  String? cardTemplateId;

  @override
  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'customerDepositNumber': customerDepositNumber,
        'pan': pan,
        'customerAddress': customerAddress.toJson(),
        'cardTemplateId': cardTemplateId,
      };
}

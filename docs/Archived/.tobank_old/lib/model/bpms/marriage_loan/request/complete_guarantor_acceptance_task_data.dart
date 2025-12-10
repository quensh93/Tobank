import '../../request/complete_task_request_data.dart';

class CompleteGuarantorAcceptanceTaskData extends CompleteTaskRequestData {
  CompleteGuarantorAcceptanceTaskData({
    required this.guarantorAcceptedGuarantee,
    required this.guarantorCustomerNumber,
  });

  bool guarantorAcceptedGuarantee;
  String guarantorCustomerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'guarantorAcceptedGuarantee': guarantorAcceptedGuarantee,
        'guarantorCustomerNumber': guarantorCustomerNumber,
      };
}

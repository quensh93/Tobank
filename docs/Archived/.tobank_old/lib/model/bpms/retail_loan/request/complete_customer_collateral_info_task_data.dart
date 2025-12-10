import '../../request/complete_task_request_data.dart';

class TaskDataCustomerCollateralInfo extends CompleteTaskRequestData {
  TaskDataCustomerCollateralInfo({
    required this.customerNationalCode,
    required this.promissoryAmount,
    required this.promissoryId,
    required this.promissoryDueDate,
  });

  String customerNationalCode;
  int promissoryAmount;
  String promissoryId;
  int? promissoryDueDate;

  @override
  Map<String, dynamic> toJson() => {
        'customerNationalCode': customerNationalCode,
        'promissoryAmount': promissoryAmount,
        'promissoryId': promissoryId,
        'promissoryDueDate': promissoryDueDate,
      };
}

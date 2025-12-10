import '../../request/complete_task_request_data.dart';

class CompleteCloseLongTermDepositTaskData extends CompleteTaskRequestData {
  CompleteCloseLongTermDepositTaskData({
    required this.depositClosingType,
    required this.depositPartAmount,
  });

  String depositClosingType;
  String? depositPartAmount;

  @override
  Map<String, dynamic> toJson() => {
        'depositClosingType': depositClosingType,
        'depositPartAmount': depositPartAmount,
      };
}

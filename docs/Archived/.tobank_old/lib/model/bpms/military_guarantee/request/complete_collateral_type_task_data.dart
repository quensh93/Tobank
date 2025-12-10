import '../../request/complete_task_request_data.dart';

class CompleteCollateralTypeTaskData extends CompleteTaskRequestData {
  CompleteCollateralTypeTaskData({
    required this.cashDeposit,
    required this.collateralDeposit,
    required this.collateralAmount,
  });

  String cashDeposit;
  String collateralDeposit;
  String collateralAmount;

  @override
  Map<String, dynamic> toJson() => {
        'cashDeposit': cashDeposit,
        'collateralDeposit': collateralDeposit,
        'collateralAmount': collateralAmount,
      };
}

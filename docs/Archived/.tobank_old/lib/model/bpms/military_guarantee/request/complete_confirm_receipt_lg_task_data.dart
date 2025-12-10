import '../../request/complete_task_request_data.dart';

class CompleteConfirmReceiptLGTaskData extends CompleteTaskRequestData {
  CompleteConfirmReceiptLGTaskData({
    required this.confirmReceipt,
  });

  bool confirmReceipt;

  @override
  Map<String, dynamic> toJson() => {
        'confirmReceipt': confirmReceipt,
      };
}

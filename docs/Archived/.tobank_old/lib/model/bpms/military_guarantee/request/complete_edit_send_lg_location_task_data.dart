import '../../common/bpms_address.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEditSendLGLocationTaskData extends CompleteTaskRequestData {
  CompleteEditSendLGLocationTaskData({
    required this.sendLGAddress,
  });

  BPMSAddress sendLGAddress;

  @override
  Map<String, dynamic> toJson() => {
        'sendLGAddress': sendLGAddress.toJson(),
      };
}

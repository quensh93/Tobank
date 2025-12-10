import '../../common/bpms_address.dart';
import '../../request/complete_task_request_data.dart';

class CompleteEditAddressTaskData extends CompleteTaskRequestData {
  CompleteEditAddressTaskData({
    required this.sendLGAddress,
  });

  BPMSAddress sendLGAddress;

  @override
  Map<String, dynamic> toJson() => {
        'sendLGAddress': sendLGAddress.toJson(),
      };
}

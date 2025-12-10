import '../../../common/bpms_address.dart';
import '../../../request/complete_task_request_data.dart';

class CompleteGetNewAddressFromApplicantTaskData extends CompleteTaskRequestData {
  CompleteGetNewAddressFromApplicantTaskData({
    required this.customerAddress,
  });

  BPMSAddress customerAddress;

  @override
  Map<String, dynamic> toJson() => {
        'customerAddress': customerAddress.toJson(),
      };
}

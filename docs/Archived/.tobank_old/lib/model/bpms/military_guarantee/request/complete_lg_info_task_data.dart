import '../../common/bpms_address.dart';
import '../../request/complete_task_request_data.dart';

class CompleteLGInfoTaskData extends CompleteTaskRequestData {
  CompleteLGInfoTaskData({
    required this.lGAmount,
    required this.letterNumber,
    required this.letterDate,
    required this.lGDueDate,
    required this.beneficiaryName,
    required this.beneficiaryNationalCode,
    required this.beneficiaryPhone,
    required this.beneficiaryAddress,
  });

  double lGAmount;
  String letterNumber;
  int letterDate;
  int lGDueDate;
  String beneficiaryName;
  String beneficiaryNationalCode;
  String beneficiaryPhone;
  BPMSAddress beneficiaryAddress;

  @override
  Map<String, dynamic> toJson() => {
        'lGAmount': lGAmount,
        'letterNumber': letterNumber,
        'letterDate': letterDate,
        'lGDueDate': lGDueDate,
        'beneficiaryName': beneficiaryName,
        'beneficiaryNationalCode': beneficiaryNationalCode,
        'beneficiaryPhone': beneficiaryPhone,
        'beneficiaryAddress': beneficiaryAddress.toJson(),
      };
}

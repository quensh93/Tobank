import '../../common/bpms_address.dart';
import '../../request/start_process_request_data.dart';

class MilitaryGuaranteeStartProcessVariables extends StartProcessRequestVariables {
  MilitaryGuaranteeStartProcessVariables({
    required this.customerNumber,
    required this.isApplicantSameGuarantee,
    this.guaranteeNationalCode,
    this.guaranteeBirthDate,
    this.guaranteeMobile,
    this.guaranteeFirstName,
    this.guaranteeLastName,
    this.guaranteeFatherName,
    this.guaranteeBookNumber,
    this.guaranteeOfficeName,
    this.guaranteeAddress,
    this.applicantAddress,
  });

  String customerNumber;
  bool isApplicantSameGuarantee;
  String? guaranteeNationalCode;
  int? guaranteeBirthDate;
  String? guaranteeMobile;
  String? guaranteeFirstName;
  String? guaranteeLastName;
  String? guaranteeFatherName;
  String? guaranteeBookNumber;
  String? guaranteeOfficeName;
  BPMSAddress? guaranteeAddress;
  BPMSAddress? applicantAddress;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> tempJson = {};

    tempJson['customerNumber'] = customerNumber;
    tempJson['isApplicantSameGuarantee'] = isApplicantSameGuarantee;
    tempJson['applicantAddress'] = applicantAddress?.toJson();

    if (!isApplicantSameGuarantee) {
      tempJson['guaranteeNationalCode'] = guaranteeNationalCode;
      tempJson['guaranteeBirthDate'] = guaranteeBirthDate;
      tempJson['guaranteeMobile'] = guaranteeMobile;
      tempJson['guaranteeFirstName'] = guaranteeFirstName;
      tempJson['guaranteeLastName'] = guaranteeLastName;
      tempJson['guaranteeFatherName'] = guaranteeFatherName;
      tempJson['guaranteeBookNumber'] = guaranteeBookNumber;
      tempJson['guaranteeOfficeName'] = guaranteeOfficeName;
      tempJson['guaranteeAddress'] = guaranteeAddress?.toJson();
    }

    return tempJson;
  }
}

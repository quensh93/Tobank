import '../../../service/core/api_request_model.dart';

class CheckPersonalInfoRequestData extends ApiRequestModel {
  CheckPersonalInfoRequestData({
    required this.trackingNumber,
    required this.nationalCode,
    required this.birthDate,
    required this.nationalIdTrackingNumber,
    required this.checkIdentificationData,
    required this.checkBadCredit,
    required this.checkBankCIF,
  });

  String trackingNumber;
  String nationalCode;
  int birthDate;
  String? nationalIdTrackingNumber;
  bool checkIdentificationData;
  bool checkBadCredit;
  bool checkBankCIF;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'nationalCode': nationalCode,
        'birthDate': birthDate,
        'nationalIdTrackingNumber': nationalIdTrackingNumber,
        'checkIdentificationData': checkIdentificationData,
        'checkBadCredit': checkBadCredit,
        'checkBankCIF': checkBankCIF,
      };
}

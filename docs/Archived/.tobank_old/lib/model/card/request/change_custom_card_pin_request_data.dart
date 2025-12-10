import '../../../service/core/api_request_model.dart';

class ChangeCustomCardPinRequestData extends ApiRequestModel {
  ChangeCustomCardPinRequestData({
    this.trackingNumber,
    this.customerNumber,
    this.pan,
    this.pinType,
    this.oldPin,
    this.newPin,
  });

  String? trackingNumber;
  String? customerNumber;
  String? pan;
  int? pinType;
  String? oldPin;
  String? newPin;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'pan': pan,
        'pinType': pinType,
        'oldPin': oldPin,
        'newPin': newPin,
      };
}

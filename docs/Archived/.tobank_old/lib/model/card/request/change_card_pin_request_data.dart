import '../../../service/core/api_request_model.dart';

class ChangeCardPinRequest extends ApiRequestModel {
  ChangeCardPinRequest({
    required this.trackingNumber,
    required this.pan,
    required this.pinType,
    required this.customerNumber,
  });

  String trackingNumber;
  String pan;
  int pinType;
  String customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'pan': pan,
        'pinType': pinType,
        'customerNumber': customerNumber,
      };
}

import '../../../service/core/api_request_model.dart';

class CardBlockRequestData extends ApiRequestModel {
  CardBlockRequestData({
    this.trackingNumber,
    this.customerNumber,
    this.pan,
    this.blockingReason,
  });

  String? trackingNumber;
  String? customerNumber;
  String? pan;
  int? blockingReason;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'pan': pan,
        'blockingReason': blockingReason,
      };
}

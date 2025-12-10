import '../../../service/core/api_request_model.dart';

class TrackingInquiryRequest extends ApiRequestModel {
  TrackingInquiryRequest({
    this.chequeId,
    this.chequeRegistrationRequestId,
  });

  String? chequeId;
  String? chequeRegistrationRequestId;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
        'chequeRegistrationRequestId': chequeRegistrationRequestId,
      };
}

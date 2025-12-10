import '../../../service/core/api_request_model.dart';

class ReceiverInquiryRequest extends ApiRequestModel {
  ReceiverInquiryRequest({
    this.nationalId,
    this.chequeId,
    this.chequeInquiryRequestId,
    this.personType,
  });

  String? nationalId;
  String? chequeId;
  String? chequeInquiryRequestId;
  int? personType;

  @override
  Map<String, dynamic> toJson() => {
        'nationalId': nationalId,
        'chequeId': chequeId,
        'chequeInquiryRequestId': chequeInquiryRequestId,
        'personType': personType,
      };
}

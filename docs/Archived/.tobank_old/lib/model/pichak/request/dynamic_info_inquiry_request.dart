import '../../../service/core/api_request_model.dart';

class DynamicInfoInquiryRequest extends ApiRequestModel {
  DynamicInfoInquiryRequest({
    this.chequeId,
  });

  String? chequeId;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
      };
}

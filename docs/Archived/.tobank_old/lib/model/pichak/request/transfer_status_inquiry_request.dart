import '../../../service/core/api_request_model.dart';

class TransferStatusInquiryRequest extends ApiRequestModel {
  TransferStatusInquiryRequest({
    this.chequeId,
  });

  String? chequeId;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
      };
}

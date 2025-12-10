import '../../../service/core/api_request_model.dart';

class ConfirmationRequest extends ApiRequestModel {
  ConfirmationRequest({
    this.chequeId,
    this.chequeInquiryRequestId,
    this.accepted,
    this.rejectionReasons,
  });

  String? chequeId;
  String? chequeInquiryRequestId;
  bool? accepted;
  List<int?>? rejectionReasons;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': chequeId,
        'chequeInquiryRequestId': chequeInquiryRequestId,
        'accepted': accepted,
        'rejectionReasons': rejectionReasons == null ? null : List<dynamic>.from(rejectionReasons!.map((x) => x)),
      };
}

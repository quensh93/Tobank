import '../../../service/core/api_request_model.dart';

class PromissoryInquiryRequestData extends ApiRequestModel {
  PromissoryInquiryRequestData({
    required this.nationalNumber,
    required this.promissoryId,
  });

  String nationalNumber;
  String promissoryId;

  @override
  Map<String, dynamic> toJson() => {
        'nationalNumber': nationalNumber,
        'promissoryId': promissoryId,
      };
}

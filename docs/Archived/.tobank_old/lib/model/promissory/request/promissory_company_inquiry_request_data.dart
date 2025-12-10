import '../../../service/core/api_request_model.dart';

class PromissoryCompanyInquiryRequestData extends ApiRequestModel {
  PromissoryCompanyInquiryRequestData({
    required this.nationalId,
  });

  String nationalId;

  @override
  Map<String, dynamic> toJson() => {
        'national_id': nationalId,
      };
}

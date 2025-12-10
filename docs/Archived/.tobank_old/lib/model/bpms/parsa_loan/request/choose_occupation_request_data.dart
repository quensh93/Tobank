import '../../../../service/core/api_request_model.dart';

class ChooseOccupationRequestData extends ApiRequestModel {
  int? jobType;

  ChooseOccupationRequestData({
    this.jobType,
  });

  @override
  Map<String, dynamic> toJson() => {
        'job_type': jobType,
      };
}

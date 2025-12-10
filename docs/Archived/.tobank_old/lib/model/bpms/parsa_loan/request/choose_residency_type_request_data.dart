import '../../../../service/core/api_request_model.dart';

class ChooseResidencyTypeRequestData extends ApiRequestModel {
  String? residencyType;

  ChooseResidencyTypeRequestData({
    this.residencyType,
  });

  @override
  Map<String, dynamic> toJson() => {
        'residency_type': residencyType,
      };
}

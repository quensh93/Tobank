import '../../../../service/core/api_request_model.dart';

class ChooseBranchRequestData extends ApiRequestModel {
  int? branchCode;

  ChooseBranchRequestData({
    this.branchCode,
  });

  @override
  Map<String, dynamic> toJson() => {
        'branch_code': branchCode,
      };
}

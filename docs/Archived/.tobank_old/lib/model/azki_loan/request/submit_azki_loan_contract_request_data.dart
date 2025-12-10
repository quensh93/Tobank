import '../../../service/core/api_request_model.dart';

class SubmitAzkiLoanContractRequestModel extends ApiRequestModel {
  SubmitAzkiLoanContractRequestModel({
    required this.signedContract,
  });

  String signedContract;

  @override
  Map<String, dynamic> toJson() => {
        'signed_contract': signedContract,
      };
}

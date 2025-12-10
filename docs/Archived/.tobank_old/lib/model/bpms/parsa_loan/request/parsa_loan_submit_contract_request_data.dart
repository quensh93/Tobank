import '../../../../service/core/api_request_model.dart';

class ParsaLoanSubmitContractRequestData extends ApiRequestModel {
  String? signedContract;

  ParsaLoanSubmitContractRequestData({
    this.signedContract,
  });

  @override
  Map<String, dynamic> toJson() => {
        'signed_contract': signedContract,
      };
}

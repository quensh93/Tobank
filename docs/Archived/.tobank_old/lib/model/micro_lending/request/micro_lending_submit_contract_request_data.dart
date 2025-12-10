import '../../../service/core/api_request_model.dart';

class MicroLendingSubmitContractRequest extends ApiRequestModel {
  String signedContract;

  MicroLendingSubmitContractRequest({
    required this.signedContract,
  });

  @override
  Map<String, dynamic> toJson() => {
        'signed_contract': signedContract,
      };
}

import '../../../service/core/api_request_model.dart';

class SubmitAzkiLoanCollateralPromissoryRequest extends ApiRequestModel {
  SubmitAzkiLoanCollateralPromissoryRequest({
    required this.promissoryId,
    required this.azkiLoanId,
  });

  String promissoryId;
  int azkiLoanId;

  @override
  Map<String, dynamic> toJson() => {
        'promissory_id': promissoryId,
        'azki_loan_id': azkiLoanId,
      };
}

import '../../../../service/core/api_request_model.dart';

class ParsaLoanSubmitPromissoryRequestData extends ApiRequestModel {
  String? promissoryId;
  int? loanId;

  ParsaLoanSubmitPromissoryRequestData({
    this.promissoryId,
    this.loanId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'promissory_id': promissoryId,
        'loan_id': loanId,
      };
}

import '../../../../service/core/api_request_model.dart';

class ParsaLoanSubmitPlanRequestData extends ApiRequestModel {
  int? maxPrice;
  int? month;
  double? rate;

  ParsaLoanSubmitPlanRequestData({
    this.maxPrice,
    this.month,
    this.rate,
  });

  @override
  Map<String, dynamic> toJson() => {
        'max_price': maxPrice,
        'month': month,
        'rate': rate,
      };
}

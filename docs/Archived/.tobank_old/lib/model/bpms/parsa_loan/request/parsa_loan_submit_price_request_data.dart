import '../../../../service/core/api_request_model.dart';

class ParsaLoanSubmitPriceRequestData extends ApiRequestModel {
  int? price;

  ParsaLoanSubmitPriceRequestData({
    this.price,
  });

  @override
  Map<String, dynamic> toJson() => {
        'price': price,
      };
}

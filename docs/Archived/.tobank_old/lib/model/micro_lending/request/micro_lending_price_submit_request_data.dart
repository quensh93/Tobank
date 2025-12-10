import '../../../service/core/api_request_model.dart';

class MicroLendingSubmitPriceAndDurationRequest extends ApiRequestModel {
  int price;
  int months;

  MicroLendingSubmitPriceAndDurationRequest({
    required this.price,
    required this.months,
  });

  @override
  Map<String, dynamic> toJson() => {
        'price': price,
        'months': months,
      };
}

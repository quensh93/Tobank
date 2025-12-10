import '../../../service/core/api_request_model.dart';

class EditUserCardDataRequest extends ApiRequestModel {
  EditUserCardDataRequest({
    this.title,
    this.cardExpMonth,
    this.cardExpYear,
    this.isDefault = false,
  });

  int? id;
  String? title;
  String? cardExpMonth;
  String? cardExpYear;
  bool? isDefault = false;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'card_exp_month': cardExpMonth,
        'card_exp_year': cardExpYear,
        'is_default': isDefault,
      };
}

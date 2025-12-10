import '../../../service/core/api_request_model.dart';

class UpdateDepositRequest extends ApiRequestModel {
  UpdateDepositRequest({
    this.id,
    this.iban,
    this.accountNumber,
    this.title,
  });

  int? id;
  String? iban;
  String? accountNumber;
  String? title;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'iban': iban,
        'account_number': accountNumber,
        'title': title,
      };
}

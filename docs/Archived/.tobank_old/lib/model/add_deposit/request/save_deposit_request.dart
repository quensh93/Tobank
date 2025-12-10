
import '../../../service/core/api_request_model.dart';

class SaveDepositRequest extends ApiRequestModel {
  SaveDepositRequest({
    this.iban,
    this.accountNumber,
    this.title,
  });

  String? iban;
  String? accountNumber;
  String? title;

  @override
  Map<String, dynamic> toJson() => {
        'iban': iban,
        'account_number': accountNumber,
        'title': title,
      };
}

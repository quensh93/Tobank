import '../../../service/core/api_request_model.dart';

class EditNotebookCardDataRequest extends ApiRequestModel {
  EditNotebookCardDataRequest({
    this.id,
    this.cardNumber,
    this.title,
  });

  int? id;
  String? cardNumber;
  String? title;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'card_number': cardNumber,
      };
}

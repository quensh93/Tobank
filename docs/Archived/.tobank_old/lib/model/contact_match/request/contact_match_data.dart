import '../../../service/core/api_request_model.dart';

class ContactMatchData extends ApiRequestModel {
  ContactMatchData({
    this.contacts,
  });

  List<String?>? contacts;
  
  @override
  Map<String, dynamic> toJson() => {
        'contacts': List<dynamic>.from(contacts!.map((x) => x)),
      };
}

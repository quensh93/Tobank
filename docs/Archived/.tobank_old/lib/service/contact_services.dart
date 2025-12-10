import 'dart:async';
import '../model/contact_match/request/contact_match_data.dart';
import '../model/contact_match/response/list_contact_match_response_data.dart';
import 'core/api_core.dart';

class ContactServices {
  ContactServices._();

  static Future<ApiResult<(ListContactMatchResponseData, int), ApiException>> matchContactsRequest({
    required ContactMatchData contactMatchData,
  }) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.matchContacts,
      data: contactMatchData,
      modelFromJson: (responseBody, statusCode) => ListContactMatchResponseData.fromJson(responseBody),
    );
  }
}

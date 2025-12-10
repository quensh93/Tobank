import '../model/customer_referrals/request/customer_referrals_request_data.dart';
import '../model/customer_referrals/response/customer_referrals_response_data.dart';
import 'core/api_core.dart';

class CustomerReferralsServices {
  CustomerReferralsServices._();

  static Future<ApiResult<(CustomerReferralsResponse, int), ApiException>> getCustomerReferrals({
    required CustomerReferralsRequest customerReferralsRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getCustomerReferrers,
        data: customerReferralsRequest,
        modelFromJson: (responseBody, statusCode) => CustomerReferralsResponse.fromJson(responseBody));
  }
}

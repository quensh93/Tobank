import '../model/address/request/address_inquiry_request_data.dart';
import '../model/address/request/update_address_request_data.dart';
import '../model/address/response/address_inquiry_response_data.dart';
import '../model/address/response/update_address_response_data.dart';
import 'core/api_core.dart';

class UpdateAddressServices {
  UpdateAddressServices._();

  static Future<ApiResult<(AddressInquiryResponseData, int), ApiException>> addressInquiryRequest({
    required AddressInquiryRequestData addressInquiryRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryAddress,
        data: addressInquiryRequestData,
        modelFromJson: (responseBody, statusCode) => AddressInquiryResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(UpdateAddressResponseData, int), ApiException>> updateAddressRequest({
    required UpdateAddressRequestData updateAddressRequestData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateAddress,
        data: updateAddressRequestData,
        modelFromJson: (responseBody, statusCode) => UpdateAddressResponseData.fromJson(responseBody));
  }
}

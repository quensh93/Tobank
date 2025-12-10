
import '../../../service/core/api_request_model.dart';

class AddressInquiryRequestData extends ApiRequestModel {
  AddressInquiryRequestData({
    this.postalCode,
    this.isProviderRequired,
  });

  String? postalCode;
  bool? isProviderRequired;

  @override
  Map<String, dynamic> toJson() => {
        'PostalCode': postalCode,
        'isProviderRequired': isProviderRequired,
      };
}

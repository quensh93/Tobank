
import '../../../service/core/api_request_model.dart';

class CardIssuanceTemplateRequest extends ApiRequestModel {
  CardIssuanceTemplateRequest({
    required this.trackingNumber,
    required this.customerNumber,
    required this.depositNumber,
  });

  String trackingNumber;
  String customerNumber;
  String depositNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'customerNumber': customerNumber,
        'depositNumber': depositNumber,
      };
}

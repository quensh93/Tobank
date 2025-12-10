import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class TransferWalletData extends ApiRequestModel {
  String? destinationNumber;
  int? amount;
  PaymentType? paymentType;
  int? isProfile;
  String? clientRef;
  String? description;

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'dst_mobile': destinationNumber,
        'client_ref': clientRef,
        'description': description,
      };
}

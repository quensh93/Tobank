import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class PromissoryEndorsementRequestData extends ApiRequestModel {
  PromissoryEndorsementRequestData({
    this.ownerNn,
    this.ownerCellphone,
    this.ownerAccountNumber,
    this.ownerAddress,
    this.ownerSanaCheck,
    this.recipientType,
    this.recipientNn,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.description,
    this.promissoryId,
  });

  String? ownerNn;
  String? ownerCellphone;
  String? ownerAccountNumber;
  String? ownerAddress;
  bool? ownerSanaCheck;
  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientFullName;
  String? recipientCellphone;
  String? paymentPlace;
  String? description;
  String? promissoryId;

  @override
  Map<String, dynamic> toJson() => {
        'ownerNN': ownerNn,
        'ownerCellphone': ownerCellphone,
        'ownerAccountNumber': ownerAccountNumber,
        'ownerAddress': ownerAddress,
        'ownerSanaCheck': ownerSanaCheck,
        'recipientType': recipientType?.jsonValue,
        'recipientNN': recipientNn,
        'recipientCellphone': recipientCellphone,
        'recipientFullName': recipientFullName,
        'paymentPlace': paymentPlace,
        'description': description,
        'promissoryId': promissoryId,
      };
}

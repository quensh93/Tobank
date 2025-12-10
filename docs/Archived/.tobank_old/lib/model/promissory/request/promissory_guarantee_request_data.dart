import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class PromissoryGuaranteeRequestData extends ApiRequestModel {
  PromissoryGuaranteeRequestData({
    this.guaranteeType,
    this.guaranteeNn,
    this.guaranteeCellphone,
    this.guaranteeFullName,
    this.guaranteeAccountNumber,
    this.guaranteeAddress,
    this.guaranteeSanaCheck,
    this.paymentPlace,
    this.description,
    this.nationalNumber,
    this.promissoryId,
  });

  PromissoryCustomerType? guaranteeType;
  String? guaranteeNn;
  String? guaranteeCellphone;
  String? guaranteeFullName;
  String? guaranteeAccountNumber;
  String? guaranteeAddress;
  bool? guaranteeSanaCheck;
  String? paymentPlace;
  String? description;
  String? nationalNumber;
  String? promissoryId;

  @override
  Map<String, dynamic> toJson() => {
        'guaranteeType': guaranteeType?.jsonValue,
        'guaranteeNN': guaranteeNn,
        'guaranteeCellphone': guaranteeCellphone,
        'guaranteeFullName': guaranteeFullName,
        'guaranteeAccountNumber': guaranteeAccountNumber,
        'guaranteeAddress': guaranteeAddress,
        'guaranteeSanaCheck': guaranteeSanaCheck,
        'description': description,
        'paymentPlace': paymentPlace,
        'nationalNumber': nationalNumber,
        'promissoryId': promissoryId,
      };
}

import '../../../service/core/api_request_model.dart';
import '../../../util/enums_constants.dart';

class PromissoryRequestData extends ApiRequestModel {
  PromissoryRequestData({
    this.issuerType,
    this.issuerNn,
    this.issuerCellphone,
    this.issuerFullName,
    this.issuerAccountNumber,
    this.issuerAddress,
    this.issuerPostalCode,
    this.issuerSanaCheck,
    this.recipientType,
    this.recipientNn,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.amount,
    this.dueDate,
    this.description,
    this.transferable,
    this.loanType,
  });

  PromissoryCustomerType? issuerType;
  String? issuerNn;
  String? issuerCellphone;
  String? issuerFullName;
  String? issuerAccountNumber;
  String? issuerAddress;
  String? issuerPostalCode;
  bool? issuerSanaCheck;
  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientCellphone;
  String? recipientFullName;
  String? paymentPlace;
  int? amount;
  String? dueDate;
  String? description;
  bool? transferable;
  String? loanType;

  @override
  Map<String, dynamic> toJson() => {
        'issuerType': issuerType?.jsonValue,
        'issuerNN': issuerNn,
        'issuerCellphone': issuerCellphone,
        'issuerFullName': issuerFullName,
        'issuerAccountNumber': issuerAccountNumber,
        'issuerAddress': issuerAddress,
        'issuerPostalCode': issuerPostalCode,
        'issuerSanaCheck': issuerSanaCheck,
        'recipientType': recipientType?.jsonValue,
        'recipientNN': recipientNn,
        'recipientCellphone': recipientCellphone,
        'recipientFullName': recipientFullName,
        'paymentPlace': paymentPlace,
        'amount': amount,
        'dueDate': dueDate,
        'description': description,
        'transferable': transferable,
        'loanType': loanType,
      };
}

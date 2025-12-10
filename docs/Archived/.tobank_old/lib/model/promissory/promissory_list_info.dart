import '../../util/enums_constants.dart';

class PromissoryListInfo {
  PromissoryListInfo({
    this.role,
    this.promissoryId,
    this.issuerType,
    this.issuerNn,
    this.issuerCellphone,
    this.issuerFullName,
    this.issuerAccountNumber,
    this.issuerAddress,
    this.recipientType,
    this.recipientNn,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.amount,
    this.remainingAmount,
    this.dueDate,
    this.paymentId,
    this.description,
    this.creationDate,
    this.creationTime,
    this.agentName,
    this.state,
    this.transferable,
    this.isEndorsed,
    this.isGuaranteed,
  });

  PromissoryRoleType? role;
  String? promissoryId;
  PromissoryCustomerType? issuerType;
  String? issuerNn;
  String? issuerCellphone;
  String? issuerFullName;
  String? issuerAccountNumber;
  String? issuerAddress;

  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientCellphone;
  String? recipientFullName;

  String? paymentPlace;
  int? amount;
  int? remainingAmount;
  String? dueDate;
  String? paymentId;
  String? description;

  String? creationDate;
  String? creationTime;
  String? agentName;
  PromissoryStateType? state;
  bool? transferable;

  bool? isEndorsed;
  bool? isGuaranteed;

  PromissoryListInfo.fromJson(Map<String, dynamic> json) : 
        role = json['role'] != null ? PromissoryRoleType.fromJsonValue(json['role']) : null,
        promissoryId = json['promissoryId'],
        issuerNn = json['issuerNN'],
        issuerType = json['issuerType'] != null ? PromissoryCustomerType.fromJsonValue(json['issuerType']) : null,
        issuerCellphone = json['issuerCellphone'],
        issuerFullName = json['issuerFullName'],
        issuerAccountNumber = json['issuerAccountNumber'],
        issuerAddress = json['issuerAddress'],
        recipientType = json['recipientType'] != null ? PromissoryCustomerType.fromJsonValue(json['recipientType']) : null,
        recipientNn = json['recipientNN'],
        recipientCellphone = json['recipientCellphone'],
        recipientFullName = json['recipientFullName'],
        paymentPlace = json['paymentPlace'],
        amount = json['amount'],
        remainingAmount = json['remainingAmount'],
        dueDate = json['dueDate'],
        paymentId = json['paymentId'],
        description = json['description'],
        creationDate = json['creationDate'],
        creationTime = json['creationTime'],
        agentName = json['agentName'],
        state = json['state'] != null ? PromissoryStateType.fromJsonValue(json['state']) : null,
        transferable = json['transferable'],
        isEndorsed = json['isEndorsed'],
        isGuaranteed = json['isGuaranteed'];
}

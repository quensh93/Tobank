import '../../util/enums_constants.dart';

class PromissorySingleInfo {
  PromissorySingleInfo({
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
    this.enAgentName,
    this.state,
    this.tpn,
    this.transferable,
    this.promissoryId,
    this.guarantors,
    this.endorsements,
    this.settlements,
    this.isEndorsed,
    this.isGuaranteed,
  });

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
  String? enAgentName;
  PromissoryStateType? state;
  bool? transferable;
  String? tpn;

  String? promissoryId;

  List<Guarantor>? guarantors;
  List<Endorsement>? endorsements;
  List<Settlement>? settlements;

  bool? isEndorsed;
  bool? isGuaranteed;

  factory PromissorySingleInfo.fromJson(Map<String, dynamic> json) => PromissorySingleInfo(
        issuerType: json['issuerType'] != null ? PromissoryCustomerType.fromJsonValue(json['issuerType']) : null,
        issuerNn: json['issuerNN'],
        issuerCellphone: json['issuerCellphone'],
        issuerFullName: json['issuerFullName'],
        issuerAccountNumber: json['issuerAccountNumber'],
        issuerAddress: json['issuerAddress'],
        recipientType:
            json['recipientType'] != null ? PromissoryCustomerType.fromJsonValue(json['recipientType']) : null,
        recipientNn: json['recipientNN'],
        recipientCellphone: json['recipientCellphone'],
        recipientFullName: json['recipientFullName'],
        paymentPlace: json['paymentPlace'],
        amount: json['amount'],
        remainingAmount: json['remainingAmount'],
        dueDate: json['dueDate'],
        paymentId: json['paymentId'],
        description: json['description'],
        creationDate: json['creationDate'],
        creationTime: json['creationTime'],
        agentName: json['agentName'],
        enAgentName: json['enAgentName'],
        state: json['state'] != null ? PromissoryStateType.fromJsonValue(json['state']) : null,
        tpn: json['tpn'],
        transferable: json['transferable'],
        promissoryId: json['promissoryId'],
        guarantors: json['guarantors'] == null
            ? null
            : List<Guarantor>.from(json['guarantors'].map((x) => Guarantor.fromJson(x))),
        endorsements: json['endorsements'] == null
            ? null
            : List<Endorsement>.from(json['endorsements'].map((x) => Endorsement.fromJson(x))),
        settlements: json['settlements'] == null
            ? null
            : List<Settlement>.from(json['settlements'].map((x) => Settlement.fromJson(x))),
        isEndorsed: json['isEndorsed'],
        isGuaranteed: json['isGuaranteed'],
      );
}

class Guarantor {
  Guarantor({
    this.guaranteeType,
    this.guaranteeNn,
    this.guaranteeCellphone,
    this.guaranteeAccountNumber,
    this.guaranteeFullName,
    this.guaranteeAddress,
    this.paymentPlace,
    this.description,
    this.creationDate,
    this.creationTime,
  });

  PromissoryCustomerType? guaranteeType;
  String? guaranteeNn;
  String? guaranteeCellphone;
  String? guaranteeAccountNumber;
  String? guaranteeFullName;
  String? guaranteeAddress;

  String? paymentPlace;
  String? description;
  String? creationDate;
  String? creationTime;

  factory Guarantor.fromJson(Map<String, dynamic> json) => Guarantor(
        guaranteeType:
            json['guaranteeType'] != null ? PromissoryCustomerType.fromJsonValue(json['guaranteeType']) : null,
        guaranteeNn: json['guaranteeNN'],
        guaranteeCellphone: json['guaranteeCellphone'],
        guaranteeAccountNumber: json['guaranteeAccountNumber'],
        guaranteeFullName: json['guaranteeFullName'],
        guaranteeAddress: json['guaranteeAddress'],
        paymentPlace: json['paymentPlace'],
        description: json['description'],
        creationDate: json['creationDate'],
        creationTime: json['creationTime'],
      );
}

class Endorsement {
  Endorsement({
    this.ownerType,
    this.ownerNn,
    this.ownerFullName,
    this.ownerCellphone,
    this.ownerAddress,
    this.ownerAccountNumber,
    this.recipientType,
    this.recipientNN,
    this.recipientCellphone,
    this.recipientFullName,
    this.paymentPlace,
    this.description,
    this.creationDate,
    this.creationTime,
  });

  PromissoryCustomerType? ownerType;
  String? ownerNn;
  String? ownerFullName;
  String? ownerCellphone;
  String? ownerAddress;
  String? ownerAccountNumber;

  PromissoryCustomerType? recipientType;
  String? recipientNN;
  String? recipientCellphone;
  String? recipientFullName;

  String? paymentPlace;
  String? description;
  String? creationDate;
  String? creationTime;

  factory Endorsement.fromJson(Map<String, dynamic> json) => Endorsement(
        ownerType: json['ownerType'] != null ? PromissoryCustomerType.fromJsonValue(json['ownerType']) : null,
        ownerNn: json['ownerNN'],
        ownerCellphone: json['ownerCellphone'],
        ownerFullName: json['ownerFullName'],
        ownerAccountNumber: json['ownerAccountNumber'],
        ownerAddress: json['ownerAddress'],
        recipientType:
            json['recipientType'] != null ? PromissoryCustomerType.fromJsonValue(json['recipientType']) : null,
        recipientNN: json['recipientNN'],
        recipientCellphone: json['recipientCellphone'],
        recipientFullName: json['recipientFullName'],
        paymentPlace: json['paymentPlace'],
        description: json['description'],
        creationDate: json['creationDate'],
        creationTime: json['creationTime'],
      );
}

class Settlement {
  Settlement({
    this.settlementAmount,
    this.docType,
    this.number,
    this.creationDate,
    this.creationTime,
  });

  String? settlementAmount;
  PromissoryDocType? docType;
  String? number;
  String? creationDate;
  String? creationTime;

  factory Settlement.fromJson(Map<String, dynamic> json) => Settlement(
        settlementAmount: json['settlementAmount'],
        docType: json['settlementType'] != null ? PromissoryDocType.fromJsonValue(json['settlementType']) : null,
        number: json['number'],
        creationDate: json['creationDate'],
        creationTime: json['creationTime'],
      );
}

import '../../../service/core/api_request_model.dart';

class TransferRequestData extends ApiRequestModel {
  TransferRequestData({
    this.trackingNumber,
    this.sourceDepositNumber,
    this.destinationIban,
    this.amount,
    this.referenceNumber,
    this.approvalCode,
    this.preferredTransferType,
    this.localDescription,
    this.transactionDescription,
    this.receiverFirstName,
    this.receiverLastName,
    this.purpose,
    this.customerNumber,
  });

  String? trackingNumber;
  String? sourceDepositNumber;
  String? destinationIban;
  int? amount;
  String? referenceNumber;
  String? approvalCode;
  int? preferredTransferType;
  String? localDescription;
  String? transactionDescription;
  String? receiverFirstName;
  String? receiverLastName;
  int? purpose;
  String? customerNumber;

  @override
  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'sourceDepositNumber': sourceDepositNumber,
        'destinationIban': destinationIban,
        'amount': amount,
        'referenceNumber': referenceNumber,
        'approvalCode': approvalCode,
        'preferredTransferType': preferredTransferType,
        'localDescription': localDescription,
        'transactionDescription': transactionDescription,
        'receiverFirstName': receiverFirstName,
        'receiverLastName': receiverLastName,
        'purpose': purpose,
        'customerNumber': customerNumber
      };
}

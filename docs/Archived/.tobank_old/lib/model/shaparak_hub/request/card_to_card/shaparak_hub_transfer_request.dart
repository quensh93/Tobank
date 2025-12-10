import '../../../../service/core/api_request_model.dart';

class ShaparakHubTransferRequest extends ApiRequestModel {
  ShaparakHubTransferRequest({
    this.sourcePan,
    this.destinationPan,
    this.amount,
    this.bankName,
    this.expiryDate,
    this.cvv2,
    this.approvalCode,
    this.sourceCard,
    this.destinationCardHolderName,
    this.sourceDescription,
    this.transactionId,
    this.registrationDate,
    this.category,
  });

  String? sourcePan;
  String? destinationPan;
  int? amount;
  String? bankName;
  String? expiryDate;
  String? cvv2;
  String? approvalCode;
  String? sourceCard;
  String? destinationCardHolderName;
  String? sourceDescription;
  String? transactionId;
  int? registrationDate;
  String? saveDestinationCard;
  String? category = 'tsm';

  @override
  Map<String, dynamic> toJson() => {
        'sourcePan': sourcePan,
        'destinationPAN': destinationPan,
        'amount': amount,
        'bankName': bankName,
        'expiryDate': expiryDate,
        'cvv2': cvv2,
        'approvalCode': approvalCode,
        'src_card': sourceCard,
        'dst_card_fullname': destinationCardHolderName,
        'src_comment': sourceDescription,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'save_dst_card': saveDestinationCard,
        'category': category,
      };
}

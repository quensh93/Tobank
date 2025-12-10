import '../../../service/core/api_request_model.dart';
import '../response/dynamic_info_inquiry_response.dart';
import '../response/receiver_inquiry_response.dart';
import 'dynamic_info_inquiry_request.dart';

class TransferRequest extends ApiRequestModel {
  TransferRequest({
    this.accepted,
    this.reason,
  });

  List<ReceiverInquiryResponse>? receiverInquiryResponseList;
  DynamicInfoInquiryRequest? dynamicInfoInquiryRequest;
  DynamicInfoInquiryResponse? dynamicInfoInquiryResponse;
  bool? accepted;
  bool transferReversal = false;
  String? reason;

  @override
  Map<String, dynamic> toJson() => {
        'chequeId': dynamicInfoInquiryRequest?.chequeId,
        'chequeInquiryRequestId': dynamicInfoInquiryResponse?.requestId,
        'chequeReceivers': transferReversal ? null : List<dynamic>.from(receiverInquiryResponseList!.map((x) => x.toJson())),
        'accepted': accepted,
        'description': dynamicInfoInquiryResponse?.description,
        'toIban': null,
        'reason': reason,
        'transferReversal': transferReversal,
      };
}

class ChequeReceiver {
  ChequeReceiver({
    this.fullName,
    this.personType,
    this.nationalId,
    this.shahabId,
  });

  String? fullName;
  int? personType;
  String? nationalId;
  String? shahabId;

  factory ChequeReceiver.fromJson(Map<String, dynamic> json) => ChequeReceiver(
        fullName: json['fullName'],
        personType: json['personType'],
        nationalId: json['nationalId'],
        shahabId: json['shahabId'],
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'personType': personType,
        'nationalId': nationalId,
        'shahabId': shahabId,
      };
}

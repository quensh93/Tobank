import '../../../service/core/api_request_model.dart';
import '../../../util/date_converter_util.dart';
import '../response/receiver_inquiry_response.dart';
import '../response/static_info_inquiry_response.dart';
import 'static_info_inquiry_request.dart';

class RegistrationRequest extends ApiRequestModel {
  RegistrationRequest({
    this.amount,
    this.dueDate,
    this.description,
    this.toIban,
    this.receiverInquiryResponseList,
    this.reason,
  });

  StaticInfoInquiryResponse? staticInfoInquiryResponse;
  StaticInfoInquiryRequest? staticInfoInquiryRequest;
  List<ReceiverInquiryResponse>? receiverInquiryResponseList = [];
  int? amount;
  String? dueDate;
  String? description;
  dynamic toIban;
  String? chequeName;
  String? reason;

  @override
  Map<String, dynamic> toJson() => {
        'bankCode': staticInfoInquiryResponse?.bankCode,
        'amount': amount,
        'seriesNo': staticInfoInquiryResponse?.seriesNo,
        'dueDate': dueDate == null
            ? null
            : DateConverterUtil.getTimestampFromJalali(
                    date: dueDate!.replaceAll('-', '/'), extendDuration: const Duration(hours: 2))
                .toString(),
        'description': description,
        'chequeMedia': staticInfoInquiryRequest?.selectedCheckMaterialData!.id,
        'serialNo': staticInfoInquiryResponse?.serialNo,
        'branchCode': staticInfoInquiryResponse?.branchCode,
        'toIban': toIban,
        'chequeReceivers': receiverInquiryResponseList == null
            ? null
            : List<dynamic>.from(receiverInquiryResponseList!.map((x) => x.toJson())),
        'chequeType': staticInfoInquiryRequest?.selectedCheckTypeData!.id,
        'chequeId': staticInfoInquiryRequest?.chequeId,
        'chequeInquiryRequestId': staticInfoInquiryResponse?.requestId,
        'fromIban': staticInfoInquiryResponse?.fromIban,
        'currency': 1,
        'reason': reason
      };
}

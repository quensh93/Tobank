import '../../common/error_response_data.dart';

class CardOwnerResponseData {
  CardOwnerResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseData;

  factory CardOwnerResponseData.fromJson(Map<String, dynamic> json) => CardOwnerResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.data,
    this.isSuccess,
    this.message,
    this.messageCode,
    this.refNumber,
    this.transactionId,
  });

  String? data;
  bool? isSuccess;
  String? message;
  int? messageCode;
  int? refNumber;
  String? transactionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json['data'],
        isSuccess: json['is_success'],
        message: json['message'],
        messageCode: json['message_code'],
        refNumber: json['ref_number'],
        transactionId: json['transaction_id'],
      );
}

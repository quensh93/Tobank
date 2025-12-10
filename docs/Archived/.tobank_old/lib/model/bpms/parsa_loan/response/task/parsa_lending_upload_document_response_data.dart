class ParsaLendingUploadDocumentResponseData {
  String? message;
  bool? success;
  Data? data;

  ParsaLendingUploadDocumentResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory ParsaLendingUploadDocumentResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLendingUploadDocumentResponseData(
        message: json['message'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  String? id;

  Data({
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

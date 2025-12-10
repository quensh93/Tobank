class PromissoryEndorsementFinalizeResponse {
  PromissoryEndorsementFinalizeResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory PromissoryEndorsementFinalizeResponse.fromJson(Map<String, dynamic> json) =>
      PromissoryEndorsementFinalizeResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.multiSignedPdf,
  });

  String? multiSignedPdf;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        multiSignedPdf: json['multiSignedPdf'],
      );
}

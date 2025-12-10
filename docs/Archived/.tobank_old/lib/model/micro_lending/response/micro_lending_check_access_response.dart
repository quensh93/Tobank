class MicroLendingCheckAccessResponse {
  MicroLendingCheckAccessResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingCheckAccessResponse.fromJson(Map<String, dynamic> json) => MicroLendingCheckAccessResponse(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.access,
  });

  bool? access;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        access: json['access'],
      );
}

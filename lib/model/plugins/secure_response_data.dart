class SecureResponseData {
  int? statusCode;
  String? message;
  String? data;
  bool? isSuccess;

  SecureResponseData({
    this.statusCode,
    this.message,
    this.data,
    this.isSuccess,
  });

  factory SecureResponseData.fromJson(Map<String, dynamic> json) =>
      SecureResponseData(
        statusCode: json['statusCode'],
        message: json['message'],
        data: json['data'],
        isSuccess: json['isSuccess'],
      );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'message': message,
    'data': data,
    'isSuccess': isSuccess,
  };
}

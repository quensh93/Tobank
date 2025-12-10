class ParsaLoanSubmitPriceResponseData {
  dynamic data;
  bool? success;
  String? message;

  ParsaLoanSubmitPriceResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory ParsaLoanSubmitPriceResponseData.fromJson(Map<String, dynamic> json) => ParsaLoanSubmitPriceResponseData(
        data: json['data'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'success': success,
        'message': message,
      };
}

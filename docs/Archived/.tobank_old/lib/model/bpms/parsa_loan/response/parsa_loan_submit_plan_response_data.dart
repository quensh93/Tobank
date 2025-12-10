class ParsaLoanSubmitPlanResponseData {
  dynamic data;
  bool? success;
  String? message;

  ParsaLoanSubmitPlanResponseData({
    this.data,
    this.success,
    this.message,
  });

  factory ParsaLoanSubmitPlanResponseData.fromJson(Map<String, dynamic> json) => ParsaLoanSubmitPlanResponseData(
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

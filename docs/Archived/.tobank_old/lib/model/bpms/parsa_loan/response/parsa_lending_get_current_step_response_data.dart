import '../parsa_lending_config.dart';

class ParsaLendingGetCurrentStepResponseData {
  ParsaLendingGetCurrentStepResponseData({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory ParsaLendingGetCurrentStepResponseData.fromJson(Map<String, dynamic> json) =>
      ParsaLendingGetCurrentStepResponseData(
        data: Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );
}

class Data {
  Data({
    this.step,
    this.config,
  });

  String? step;
  ParsaLendingConfig? config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        step: json['step'],
        config: ParsaLendingConfig.fromJson(json['config']),
      );
}

import '../micro_lending_config.dart';

class MicroLendingGetCurrentStepResponse {
  MicroLendingGetCurrentStepResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory MicroLendingGetCurrentStepResponse.fromJson(Map<String, dynamic> json) => MicroLendingGetCurrentStepResponse(
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
  MicroLendingConfig? config;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        step: json['step'],
        config: MicroLendingConfig.fromJson(json['config']),
      );
}

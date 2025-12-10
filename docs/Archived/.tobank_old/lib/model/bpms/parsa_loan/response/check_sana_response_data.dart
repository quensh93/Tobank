import 'dart:convert';

CheckSanaResponseData checkSanaResponseDataFromJson(String str) => CheckSanaResponseData.fromJson(json.decode(str));

String checkSanaResponseDataToJson(CheckSanaResponseData data) => json.encode(data.toJson());

class CheckSanaResponseData {
  String? message;
  bool? success;
  Data? data;

  CheckSanaResponseData({
    this.message,
    this.success,
    this.data,
  });

  factory CheckSanaResponseData.fromJson(Map<String, dynamic> json) => CheckSanaResponseData(
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
  LoanDetailCheckSana? loanDetail;

  Data({
    this.loanDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        loanDetail: json['loan_detail'] == null ? null : LoanDetailCheckSana.fromJson(json['loan_detail']),
      );

  Map<String, dynamic> toJson() => {
        'loan_detail': loanDetail?.toJson(),
      };
}

class LoanDetailCheckSana {
  int? id;
  String? loanType;
  bool? sana;
  dynamic samat;
  dynamic notBlockList;
  dynamic noReturnedCheck;
  dynamic cbsRiskScore;
  String? step;
  dynamic requestedPrice;
  String? deposit;
  dynamic months;
  bool? isActive;

  LoanDetailCheckSana({
    this.id,
    this.loanType,
    this.sana,
    this.samat,
    this.notBlockList,
    this.noReturnedCheck,
    this.cbsRiskScore,
    this.step,
    this.requestedPrice,
    this.deposit,
    this.months,
    this.isActive,
  });

  factory LoanDetailCheckSana.fromJson(Map<String, dynamic> json) => LoanDetailCheckSana(
        id: json['id'],
        loanType: json['loan_type'],
        sana: json['sana'],
        samat: json['samat'],
        notBlockList: json['not_block_list'],
        noReturnedCheck: json['no_returned_check'],
        cbsRiskScore: json['cbs_risk_score'],
        step: json['step'],
        requestedPrice: json['requested_price'],
        deposit: json['deposit'],
        months: json['months'],
        isActive: json['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'loan_type': loanType,
        'sana': sana,
        'samat': samat,
        'not_block_list': notBlockList,
        'no_returned_check': noReturnedCheck,
        'cbs_risk_score': cbsRiskScore,
        'step': step,
        'requested_price': requestedPrice,
        'deposit': deposit,
        'months': months,
        'is_active': isActive,
      };
}

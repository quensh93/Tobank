class LoanDetail {
  int? id;
  String? loanType;
  String? step;
  int? requestedPrice;
  String? signedAt;
  String? expiredAt;
  String? deposit;
  int? months;
  String? unsignedContract;
  String? multiSignedContract;
  bool? isPayed;
  bool? isActive;
  bool? isRejected;
  Extra? extra;
  String? cbsRiskScore;

  LoanDetail({
    this.id,
    this.loanType,
    this.step,
    this.requestedPrice,
    this.signedAt,
    this.expiredAt,
    this.deposit,
    this.months,
    this.unsignedContract,
    this.multiSignedContract,
    this.isPayed,
    this.isActive,
    this.isRejected,
    this.cbsRiskScore,
    this.extra,
  });

  factory LoanDetail.fromJson(Map<String, dynamic> json) => LoanDetail(
        id: json['id'],
        loanType: json['loan_type'],
        step: json['step'],
        requestedPrice: json['requested_price'],
        signedAt: json['signed_at'],
        expiredAt: json['expired_at'],
        deposit: json['deposit'],
        months: json['months'],
        unsignedContract: json['unsigned_contract'],
        multiSignedContract: json['multi_signed_contract'],
        isPayed: json['is_payed'],
        isActive: json['is_active'],
        isRejected: json['is_rejected'],
        extra: json['extra'] == null ? null : Extra.fromJson(json['extra']),
        cbsRiskScore: json['cbs_risk_score'],
      );
}

class Extra {
  int? minPrice;
  int? maxPrice;
  bool? sana;
  bool? samat;
  bool? notBlockList;
  bool? noReturnedCheck;
  String? cbsRiskScore;
  int? totalAmountLoanReceived;
  List<DepositAverageAmountMonth>? depositAverageAmount2Months;
  List<DepositAverageAmountMonth>? depositAverageAmount3Months;
  List<DepositAverageAmountMonth>? depositAverageAmount4Months;
  List<DepositAverageAmountMonth>? depositAverageAmount5Months;
  List<DepositAverageAmountMonth>? depositAverageAmount6Months;
  List<DepositAverageAmountMonth>? depositAverageAmount7Months;
  List<DepositAverageAmountMonth>? depositAverageAmount8Months;
  List<DepositAverageAmountMonth>? depositAverageAmount9Months;
  List<DepositAverageAmountMonth>? depositAverageAmount10Months;
  List<DepositAverageAmountMonth>? depositAverageAmount11Months;
  List<DepositAverageAmountMonth>? depositAverageAmount12Months;
  List<ApproveLoan>? approveLoan;
  List<MicroLendingDurationOption>? options;
  int? shownPrice;

  Extra({
    this.minPrice,
    this.maxPrice,
    this.sana,
    this.samat,
    this.notBlockList,
    this.noReturnedCheck,
    this.cbsRiskScore,
    this.totalAmountLoanReceived,
    this.depositAverageAmount2Months,
    this.depositAverageAmount3Months,
    this.depositAverageAmount4Months,
    this.depositAverageAmount5Months,
    this.depositAverageAmount6Months,
    this.depositAverageAmount7Months,
    this.depositAverageAmount8Months,
    this.depositAverageAmount9Months,
    this.depositAverageAmount10Months,
    this.depositAverageAmount11Months,
    this.depositAverageAmount12Months,
    this.approveLoan,
    this.options,
    this.shownPrice,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        minPrice: json['min_price'],
        maxPrice: json['max_price'],
        sana: json['sana'],
        samat: json['samat'],
        notBlockList: json['not_block_list'],
        noReturnedCheck: json['no_returned_check'],
        cbsRiskScore: json['cbs_risk_score'],
        totalAmountLoanReceived: json['total_amount_loan_received'],
        depositAverageAmount2Months: json['deposit_average_amount_2_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_2_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount3Months: json['deposit_average_amount_3_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_3_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount4Months: json['deposit_average_amount_4_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_4_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount5Months: json['deposit_average_amount_5_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_5_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount6Months: json['deposit_average_amount_6_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_6_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount7Months: json['deposit_average_amount_7_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_7_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount8Months: json['deposit_average_amount_8_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_8_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount9Months: json['deposit_average_amount_9_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_9_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount10Months: json['deposit_average_amount_10_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_10_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount11Months: json['deposit_average_amount_11_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_11_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        depositAverageAmount12Months: json['deposit_average_amount_12_months'] == null
            ? []
            : List<DepositAverageAmountMonth>.from(
                json['deposit_average_amount_12_months']!.map((x) => DepositAverageAmountMonth.fromJson(x))),
        options: json['options'] == null
            ? []
            : List<MicroLendingDurationOption>.from(
                json['options']!.map((x) => MicroLendingDurationOption.fromJson(x))),
        approveLoan: json['approve_loan'] == null
            ? []
            : List<ApproveLoan>.from(json['approve_loan']!.map((x) => ApproveLoan.fromJson(x))),
        shownPrice: json['shown_price'],
      );
}

class ApproveLoan {
  int? totalAmount;
  int? paybackPeriod;
  double? rate;

  ApproveLoan({
    this.totalAmount,
    this.paybackPeriod,
    this.rate,
  });

  factory ApproveLoan.fromJson(Map<String, dynamic> json) => ApproveLoan(
        totalAmount: json['total_amount'],
        paybackPeriod: json['payback_period'],
        rate: json['rate']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'total_amount': totalAmount,
        'payback_period': paybackPeriod,
        'rate': rate,
      };
}

class DepositAverageAmountMonth {
  RateInfo? rateInfo;
  MonthInfo? monthInfo;
  int? maxPrice;
  int? profitValue;
  int? feeValue;
  int? installmentValue;

  DepositAverageAmountMonth({
    this.rateInfo,
    this.monthInfo,
    this.maxPrice,
    this.profitValue,
    this.feeValue,
    this.installmentValue,
  });

  factory DepositAverageAmountMonth.fromJson(Map<String, dynamic> json) => DepositAverageAmountMonth(
        rateInfo: json['rate_info'] == null ? null : RateInfo.fromJson(json['rate_info']),
        monthInfo: json['month_info'] == null ? null : MonthInfo.fromJson(json['month_info']),
        maxPrice: json['max_price'],
        profitValue: json['profit_value'],
        feeValue: json['fee_value'],
        installmentValue: json['installment_value'],
      );

  Map<String, dynamic> toJson() => {
        'rate_info': rateInfo?.toJson(),
        'month_info': monthInfo?.toJson(),
        'max_price': maxPrice,
        'profit_value': profitValue,
        'fee_value': feeValue,
        'installment_value': installmentValue,
      };
}

class MonthInfo {
  String? faTitle;
  int? monthNumber;

  MonthInfo({
    this.faTitle,
    this.monthNumber,
  });

  factory MonthInfo.fromJson(Map<String, dynamic> json) => MonthInfo(
        faTitle: json['fa_title'],
        monthNumber: json['month_number'],
      );

  Map<String, dynamic> toJson() => {
        'fa_title': faTitle,
        'month_number': monthNumber,
      };
}

class RateInfo {
  String? faTitle;
  double? percentNumber;

  RateInfo({
    this.faTitle,
    this.percentNumber,
  });

  factory RateInfo.fromJson(Map<String, dynamic> json) => RateInfo(
        faTitle: json['fa_title'],
        percentNumber: json['percent_number']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'fa_title': faTitle,
        'percent_number': percentNumber,
      };
}

class MicroLendingDurationOption {
  String? faTitle;
  bool? isActive;
  int? monthNumber;

  MicroLendingDurationOption({
    this.faTitle,
    this.isActive,
    this.monthNumber,
  });

  factory MicroLendingDurationOption.fromJson(Map<String, dynamic> json) => MicroLendingDurationOption(
        faTitle: json['fa_title'],
        isActive: json['is_active'],
        monthNumber: json['month_number'],
      );
}

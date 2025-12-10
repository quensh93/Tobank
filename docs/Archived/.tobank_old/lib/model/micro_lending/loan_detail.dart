class LoanDetail {
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

  LoanDetail({
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
    this.extra,
  });

  factory LoanDetail.fromJson(Map<String, dynamic> json) => LoanDetail(
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
  List<DepositAverageMinimumAmountList>? depositAverageMinimumAmountList;
  List<MicroLendingDurationOption>? options;

  Extra({
    this.minPrice,
    this.maxPrice,
    this.sana,
    this.samat,
    this.notBlockList,
    this.noReturnedCheck,
    this.cbsRiskScore,
    this.depositAverageMinimumAmountList,
    this.options,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        minPrice: json['min_price'],
        maxPrice: json['max_price'],
        sana: json['sana'],
        samat: json['samat'],
        notBlockList: json['not_block_list'],
        noReturnedCheck: json['no_returned_check'],
        cbsRiskScore: json['cbs_risk_score'],
        depositAverageMinimumAmountList: json['deposit_average_minimum_amount_list'] == null
            ? []
            : List<DepositAverageMinimumAmountList>.from(
                json['deposit_average_minimum_amount_list']!.map((x) => DepositAverageMinimumAmountList.fromJson(x))),
        options: json['options'] == null
            ? []
            : List<MicroLendingDurationOption>.from(
                json['options']!.map((x) => MicroLendingDurationOption.fromJson(x))),
      );
}

class DepositAverageMinimumAmountList {
  String? title;
  int? depositAverageMinimumAmount;

  DepositAverageMinimumAmountList({
    this.title,
    this.depositAverageMinimumAmount,
  });

  factory DepositAverageMinimumAmountList.fromJson(Map<String, dynamic> json) => DepositAverageMinimumAmountList(
        title: json['title'],
        depositAverageMinimumAmount: json['deposit_average_minimum_amount'],
      );
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

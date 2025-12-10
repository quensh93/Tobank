class ChargeAndPackagePaymentPlanEntity {
  final String? state;
  final String? message;
  final String? errorCode;
  final String? result;
  final String? transactionId;
  final int referenceNumber;
  final int? provider;
  final bool suspend;
  final bool chargeSuccess;

  const ChargeAndPackagePaymentPlanEntity({
    required this.referenceNumber,
    required this.suspend,
    required this.chargeSuccess,
    this.state,
    this.message,
    this.errorCode,
    this.result,
    this.transactionId,
    this.provider,
  });

  factory ChargeAndPackagePaymentPlanEntity.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackagePaymentPlanEntity(
      state: json['state']!=null? json['state'] as String:null,
      message: json['message'] !=null? json['message'] as String:null,
      errorCode: json['errorCode']!=null? json['errorCode'] as String? ?? '':null,
      result:json['result']!=null ? json['result'] as String:null,
      transactionId:json['transactionId']!=null? json['transactionId'] as String:null,
      referenceNumber: json['reference_number'] as int,
      provider:json['provider'] !=null ? json['provider'] as int:null,
      suspend: json['suspend'] as bool,
      chargeSuccess: json['chargeSuccess'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'message': message,
      'errorCode': errorCode,
      'result': result,
      'transactionId': transactionId,
      'referenceNumber': referenceNumber,
      'provider': provider,
      'suspend': suspend,
      'chargeSuccess': chargeSuccess,
    };
  }

  @override
  String toString() {
    return 'ChargeAndPackagePaymentPlanEntity(\n'
        'state: "$state"\n'
        'message: "$message"\n'
        'errorCode: "$errorCode"\n'
        'result: "$result"\n'
        'transactionId: "$transactionId"\n'
        'referenceNumber: "$referenceNumber"\n'
        'provider: $provider\n'
        'suspend: $suspend\n'
        'chargeSuccess: $chargeSuccess\n'
        ')';
  }
}
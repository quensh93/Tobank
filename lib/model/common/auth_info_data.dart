class AuthInfoData {
  final String? mobile;
  final String? nationalCode;

  AuthInfoData({this.mobile, this.nationalCode});

  factory AuthInfoData.fromJson(Map<String, dynamic> json) {
    return AuthInfoData(
      mobile: json['mobile'] as String?,
      nationalCode: json['nationalCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mobile': mobile, 'nationalCode': nationalCode};
  }
}

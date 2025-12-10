import '../common/sign_document_data.dart';

class MicroLendingConfig {
  MicroLendingConfig({
    this.price,
    this.expirationDuration,
    this.inquiryReasonText,
    this.loanRate,
    this.signLocation,
  });

  int? price;
  int? expirationDuration;
  String? inquiryReasonText;
  double? loanRate;
  List<SignLocation>? signLocation;

  factory MicroLendingConfig.fromJson(Map<String, dynamic> json) => MicroLendingConfig(
        price: json['price'],
        expirationDuration: json['expiration_duration'],
        inquiryReasonText: json['inquiry_reason_text'],
        loanRate: json['loan_rate'],
        signLocation: json['sign_location'] == null
            ? []
            : List<SignLocation>.from(json['sign_location']!.map((x) => SignLocation.fromJson(x))),
      );
}

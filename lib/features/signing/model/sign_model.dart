class SignModel {
  SignModel({this.sign, this.traceID, this.provider});

  String? sign;
  String? traceID;
  String? provider; // '0' for ZoomId, '1' for Yekta
}

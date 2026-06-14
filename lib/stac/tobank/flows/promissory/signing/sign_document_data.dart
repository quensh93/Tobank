class SignDocumentData {
  final String documentBase64;
  final String reason;
  final List<SignLocation> signLocations;

  SignDocumentData({
    required this.documentBase64,
    required this.reason,
    required this.signLocations,
  });
}

class SignRect {
  final double x;
  final double y;
  final double height;
  final double width;

  SignRect({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
  });

  factory SignRect.fromJson(Map<String, dynamic> json) => SignRect(
    x: (json['x'] as num).toDouble(),
    y: (json['y'] as num).toDouble(),
    width: (json['width'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'width': width,
    'height': height,
  };
}

class SignLocation {
  SignRect? web;
  SignRect android;
  SignRect ios;
  int signPageIndex;
  bool digitalSignatureRequired;

  SignLocation({
    required this.android,
    required this.ios,
    required this.signPageIndex,
    required this.digitalSignatureRequired,
    this.web,
  });

  factory SignLocation.fromJson(Map<String, dynamic> json) => SignLocation(
    android: SignRect.fromJson(json['android']),
    ios: SignRect.fromJson(json['ios']),
    signPageIndex: json['sign_page_index'] ?? 0,
    digitalSignatureRequired: json['digital_signature_required'] ?? true,
    web: json['web'] != null ? SignRect.fromJson(json['web']) : null,
  );

  Map<String, dynamic> toJson() => {
    'android': android.toJson(),
    'ios': ios.toJson(),
    'web': web?.toJson(),
    'sign_page_index': signPageIndex,
    'digital_signature_required': digitalSignatureRequired,
  };
}

import 'package:get/get.dart';

import '../../controller/main/main_controller.dart';
import '../promissory/response/promissory_asset_response_data.dart';

class SignDocumentData {
  final String documentBase64;
  final String reason;
  final List<SignLocation> signLocations;

  SignDocumentData({
    required this.documentBase64,
    required this.reason,
    required this.signLocations,
  });

  factory SignDocumentData.fromPromissoryMainController(
      {required String documentBase64}) {
    final mainController = Get.find<MainController>();
    final SignCoordination signCoordination =
        mainController.promissoryAssetResponseData!.data!.signCoordination!;

    final androidSignRect = SignRect(
        x: signCoordination.x!.toDouble(),
        y: signCoordination.y!.toDouble(),
        height: signCoordination.height!.toDouble(),
        width: signCoordination.width!.toDouble());

    final iOSSignRect = SignRect(
        x: signCoordination.xIOS!.toDouble(),
        y: signCoordination.yIOS!.toDouble(),
        height: signCoordination.heightIOS!.toDouble(),
        width: signCoordination.widthIOS!.toDouble());

    final List<SignLocation> signLocations = [
      SignLocation(
          android: androidSignRect,
          ios: iOSSignRect,
          signPageIndex: signCoordination.page!,
          digitalSignatureRequired: true)
    ];

    return SignDocumentData(
      documentBase64: documentBase64,
      reason: 'Promissory',
      signLocations: signLocations,
    );
  }
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
        x: json['x'],
        y: json['y'],
        width: json['width'],
        height: json['height'],
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
        signPageIndex: json['sign_page_index'],
        digitalSignatureRequired: json['digital_signature_required'] ?? true,
        web: json['web'] != null ? SignRect.fromJson(json['web']) : null,
      );

  Map<String, dynamic> toJson() => {
        'android': android.toJson(),
        'ios': ios.toJson(),
        'web': web?.toJson() ?? '',
        'sign_page_index': signPageIndex,
        'digital_signature_required': digitalSignatureRequired,
      };
}

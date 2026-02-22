import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'secure_response_data.dart';

class SecurePlugin {
  SecurePlugin._();

  static String prefix = 'TOBANK';
  static String suffix = 'Ekyc-Key';
  static const MethodChannel _channel = MethodChannel('secure_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<SecureResponseData> isEnroll(
      {required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('isEnroll', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> generateKeys({
    required String phoneNumber,
    required String nameEnglish,
  }) async {
    final String result =
        await _channel.invokeMethod('generateKeys', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
      'nameEnglish': nameEnglish,
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> signText(
      {required String plainText, required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('signText', <String, dynamic>{
      'plainText': plainText,
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> signBytes(
      {required Uint8List bytesData, required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('signBytes', <String, dynamic>{
      'bytesData': bytesData,
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> getPublicKey(
      {required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('getPublicKey', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> removeKey(
      {required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('removeKey', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> verifyData(
      {required String plainText,
      required String signedText,
      required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('verifyData', <String, dynamic>{
      'plainText': plainText,
      'signedText': signedText,
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> verifyBytes({
    required Uint8List bytesData,
    required String signedText,
    required String phoneNumber,
  }) async {
    final String result =
        await _channel.invokeMethod('verifyBytes', <String, dynamic>{
      'bytesData': bytesData,
      'signedText': signedText,
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> newSignPdf({
    required String phoneNumber,
    required String pdfBase64,
    required String signatureBase64,
    required int signatureX,
    required int signatureY,
    required int signatureWidth,
    required int signatureHeight,
    required int signaturePage,
    required String cert,
    String? name,
    String? location,
    String? reason,
    String? signatureNameFamily,
  }) async {
    final String result =
        await _channel.invokeMethod('newSignPdf', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
      'pdfBase64': pdfBase64,
      'signatureBase64': signatureBase64,
      'signatureX': signatureX,
      'signatureY': signatureY,
      'signatureWidth': signatureWidth,
      'signatureHeight': signatureHeight,
      'signaturePage': signaturePage,
      'cert': cert,
      'name': name,
      'location': location,
      'reason': reason,
      'signatureNameFamily': signatureNameFamily,
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }

  static Future<SecureResponseData> getPrivateKey(
      {required String phoneNumber}) async {
    final String result =
        await _channel.invokeMethod('getPrivateKey', <String, dynamic>{
      'phoneNumber': '$prefix-$phoneNumber-$suffix',
    });
    final SecureResponseData secureResponseData =
        SecureResponseData.fromJson(jsonDecode(result));
    return secureResponseData;
  }
}

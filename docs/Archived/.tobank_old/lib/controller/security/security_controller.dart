import 'dart:convert';
import 'package:universal_io/io.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_plugin.dart';

import '../../util/app_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class SecurityController extends GetxController {
  MainController mainController = Get.find();
  TextEditingController textFieldController = TextEditingController();

  Future<void> checkIsEnroll() async {
    final response = await SecurePlugin.isEnroll(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    if (response.isSuccess == true) {
      textFieldController.text = 'is Enroll';
    } else {
      textFieldController.text = 'not Enroll';
    }
  }

  /// Generates encryption keys using SecurePlugin and updates the UI.
  Future<void> generateKeys() async {
    final response = await SecurePlugin.generateKeys(
        phoneNumber: mainController.keyAliasModelList.first.keyAlias, nameEnglish: 'First Name En Last Name En');
    textFieldController.text = response.data ?? '-';
  }

  /// Signs a predefined text using SecurePlugin and updates the UI.
  Future<void> signText() async {
    const String text = 'TOBANK';
    final response =
        await SecurePlugin.signText(plainText: text, phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    textFieldController.text = response.data ?? '-';
  }

  Future<void> removeKey() async {
    final response = await SecurePlugin.removeKey(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    if (response.isSuccess == true) {
      textFieldController.text = 'key removed';
    } else {
      textFieldController.text = 'key not found';
    }
  }

  Future<void> verifyData() async {
    const String text = 'TOBANK';
    final response = await SecurePlugin.verifyData(
        plainText: text,
        signedText: textFieldController.text,
        phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    if (response.isSuccess == true) {
      textFieldController.text = 'is verify';
    } else {
      textFieldController.text = 'not verify';
    }
  }

  /// Signs a byte array using SecurePlugin and updates the UI.
  Future<void> signBytes() async {
    final List<int> data = [102, 111, 114, 116, 121, 45, 116, 119, 111, 0];
    final Uint8List bytes = Uint8List.fromList(data);
    final response =
        await SecurePlugin.signBytes(bytesData: bytes, phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    textFieldController.text = response.data ?? '-';
  }

  /// Verifies a digital signature of a byte array using SecurePlugin and updates the UI.
  Future<void> verifyBytes() async {
    final List<int> data = [102, 111, 114, 116, 121, 45, 116, 119, 111, 0];
    final Uint8List bytes = Uint8List.fromList(data);
    final response = await SecurePlugin.verifyBytes(
        bytesData: bytes,
        signedText: textFieldController.text,
        phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    if (response.isSuccess == true) {
      textFieldController.text = 'is verify';
    } else {
      textFieldController.text = 'not verify';
    }
  }

  /// Digitally signs a PDF document using SecurePlugin and updates the UI.
  Future<void> signPDF() async {
    final String? certificate = await StorageUtil.getAuthenticateCertificateModel();
    final String? signatureBase64 = await StorageUtil.getBase64UserSignatureImage();
    const int x = 50;
    const int y = 50;
    const int height = 100;
    const int width = 100;
    const int page = 1;
    final Directory directory = Directory('/storage/emulated/0/documents');
    final String path = '${directory.path}/Document.pdf';
    final File file = File(path);
    final List<int> imageBytes = file.readAsBytesSync();
    final String base64Image = base64Encode(imageBytes);
    final a = await SecurePlugin.newSignPdf(
      phoneNumber: mainController.keyAliasModelList.first.keyAlias,
      pdfBase64: base64Image,
      cert: certificate ?? '',
      signatureBase64: signatureBase64 ?? '',
      signatureX: x,
      signatureY: y,
      signatureWidth: width,
      signatureHeight: height,
      signaturePage: page,
      signatureNameFamily: '',
    );
    AppUtil.printResponse(a.data);
    textFieldController.text = a.data ?? '';
  }

  Future<void> getPublicKey() async {
    final response = await SecurePlugin.getPublicKey(phoneNumber: mainController.keyAliasModelList.first.keyAlias);
    if (response.isSuccess == true) {
      textFieldController.text = response.data ?? '';
    } else {
      textFieldController.text = response.message ?? '';
    }
  }
}

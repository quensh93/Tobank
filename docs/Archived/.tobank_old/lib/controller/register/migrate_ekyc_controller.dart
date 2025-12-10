import 'dart:async';
import 'dart:convert';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointycastle/asn1/asn1_object.dart';
import 'package:pointycastle/asn1/primitives/asn1_bit_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_ia5_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_null.dart';
import 'package:pointycastle/asn1/primitives/asn1_object_identifier.dart';
import 'package:pointycastle/asn1/primitives/asn1_octet_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_printable_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asn1/primitives/asn1_set.dart';
import 'package:pointycastle/asn1/primitives/asn1_utf8_string.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_io/io.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom_id/zoom_id.dart';

import '../../model/authentication/kyc/request/renew_certificate_request_data.dart';
import '../../model/authentication/kyc/response/renew_certificate_response_data.dart';
import '../../service/authentication/kyc_services.dart';
import '../../service/core/api_core.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

// TODO move to authorization section

class MigrateEkycController extends GetxController {
  MainController mainController = Get.find();
  PageController pageController = PageController();

  TextEditingController englishNameEditingController = TextEditingController();
  TextEditingController englishFamilyTextEditingController = TextEditingController();
  TextEditingController jobTextEditingController = TextEditingController();
  TextEditingController homePhoneNumberTextEditingController = TextEditingController();

  bool isEnglishFirstNameValidate = true;
  bool isEnglishLastNameValidate = true;
  bool isHomePhoneNumberValidate = true;
  bool isJobValidate = true;

  Future<bool> backPress() {
    return Future.value(true);
  }

  bool isLoading = false;

  /// Migrates EKYC data after validating input and device security.
  Future<void> migrateEkyc() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final bool? isDeviceSecure = await AppUtil.isDeviceSecure();
    if (isDeviceSecure == true) {
      AppUtil.hideKeyboard(Get.context!);
      bool isValid = true;
      if (englishNameEditingController.text.trim().isNotEmpty) {
        isEnglishFirstNameValidate = true;
      } else {
        isEnglishFirstNameValidate = false;
        isValid = false;
      }
      if (englishFamilyTextEditingController.text.trim().isNotEmpty) {
        isEnglishLastNameValidate = true;
      } else {
        isEnglishLastNameValidate = false;
        isValid = false;
      }
      if (jobTextEditingController.text.trim().isNotEmpty) {
        isJobValidate = true;
      } else {
        isJobValidate = false;
        isValid = false;
      }
      if (homePhoneNumberTextEditingController.text.trim().length == Constants.phoneNumberLength &&
          homePhoneNumberTextEditingController.text.trim()[0] == '0') {
        isHomePhoneNumberValidate = true;
      } else {
        isHomePhoneNumberValidate = false;
        isValid = false;
      }
      update();
      if (isValid) {
        _migrateEkycRequest();
      }
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.no_security_method,
      );
    }
  }

  /// Generates RSA keys, creates a CSR (Certificate Signing Request),
  /// and sends a request to renew the certificate using the generated CSR.
  Future<void> _migrateEkycRequest() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    final Map<String, String> csrAttributes = {
      'CN': '${englishNameEditingController.text.trim()} ${englishFamilyTextEditingController.text.trim()}',
      'O': 'Non-Governmental',
      'OU': 'ToBank',
      'C': 'IR',
      'T': locale.user,
      'G': mainController.authInfoData!.firstName!,
      'SN': mainController.authInfoData!.lastName!,
      'SERIALNUMBER': mainController.authInfoData!.nationalCode!,
    };
    String publicKey = '';
    // TODO pass rsa key size
    final SecureResponseData secureKeysResponse = await SecurePlugin.generateKeys(
        phoneNumber: mainController.authInfoData!.mobile!,
        nameEnglish: '${englishNameEditingController.text.trim()} ${englishFamilyTextEditingController.text.trim()}');
    if (secureKeysResponse.isSuccess ?? false) {
      publicKey = secureKeysResponse.data!;
    } else {
      SnackBarUtil.showSnackBar(title: locale.error, message: locale.error_in_saving);

      await Sentry.captureMessage('generate key error',
          params: [
            {'status code': secureKeysResponse.statusCode},
            {'message': secureKeysResponse.message},
          ],
          level: SentryLevel.warning);
      return;
    }

    publicKey = '-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END PUBLIC KEY-----';
    final rsaPublicKey = CryptoUtils.rsaPublicKeyFromPem(publicKey);
    var csr = await generateRsaCsrPem(csrAttributes, rsaPublicKey);

    if (csr == '') {
      SnackBarUtil.showSnackBar(title: locale.error, message: locale.error_in_digital_signature);
      return;
    }

    csr = csr
        .replaceAll('-----BEGIN CERTIFICATE REQUEST-----', '')
        .replaceAll('-----END CERTIFICATE REQUEST-----', '')
        .replaceAll('\n', '')
        .replaceAll('\r', '')
        .trim();

    final RenewCertificateRequestData renewCertificateRequestData = RenewCertificateRequestData(
      trackingNumber: const Uuid().v4(),
      nationalCode: mainController.authInfoData!.nationalCode!,
      globalFirstName: null,
      globalLastName: null,
      occupation: jobTextEditingController.text,
      email: null,
      landLineNumber: homePhoneNumberTextEditingController.text,
      certificateRequestData: csr,
      destinationProvider: '1', // yekta
    );

    isLoading = true;
    update();
    KycServices.renewCertificate(
      renewCertificateRequestData: renewCertificateRequestData,
    ).then((result) async {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final RenewCertificateResponseData response, _)):
          // logout zoom id
          if (Platform.isIOS) {
            ZoomId.logOutIos(mainController.authInfoData!.mobile!);
          } else {
            if (AppUtil.isProduction()) {
              ZoomId.logOutAndroid(
                license: mainController.authInfoData!.zoomIdLicenseAndroid ?? Constants.zoomIdLicense,
                nationalId: mainController.authInfoData!.nationalCode!,
                phone: mainController.authInfoData!.mobile!,
              );
            }
          }

          mainController.appEKycProvider = EKycProvider.yekta;
          mainController.update();
          await StorageUtil.setAuthenticateCertificateModel(response.data!.certificate);
          Get.back();
          SnackBarUtil.showSnackBar(
            title: locale.announcement,
            message: locale.authentication_update_success,
          );
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  static final _validRsaSigner = ['SHA-1', 'SHA-224', 'SHA-256', 'SHA-384', 'SHA-512'];

  /// Encodes a Distinguished Name (DN) into an ASN.1 object.
  ///
  /// This function takes a map representing the DN, where keys are attribute
  /// types (e.g., 'CN', 'O', 'C') and values are the corresponding attribute
  /// values. It constructs an ASN.1 sequence representing the DN.
  static ASN1Object encodeDN(Map<String, String> dn) {
    final distinguishedName = ASN1Sequence();
    dn.forEach((name, value) {
      final oid = ASN1ObjectIdentifier.fromName(name);

      ASN1Object ovalue;
      switch (name.toUpperCase()) {
        case 'C':
          ovalue = ASN1PrintableString(stringValue: value);
          break;
        case 'CN':
        case 'O':
        case 'L':
        case 'S':
        default:
          ovalue = ASN1UTF8String(utf8StringValue: value);
          break;
      }

      final pair = ASN1Sequence();
      pair.add(oid);
      pair.add(ovalue);

      final pairset = ASN1Set();
      pairset.add(pair);

      distinguishedName.add(pairset);
    });

    return distinguishedName;
  }

  /// Creates an ASN.1 sequence representing an RSA public key block.
  static ASN1Sequence _makePublicKeyBlock(RSAPublicKey publicKey) {
    final blockEncryptionType = ASN1Sequence();
    blockEncryptionType.add(ASN1ObjectIdentifier.fromName('rsaEncryption'));
    blockEncryptionType.add(ASN1Null());

    final publicKeySequence = ASN1Sequence();
    publicKeySequence.add(ASN1Integer(publicKey.modulus));
    publicKeySequence.add(ASN1Integer(publicKey.exponent));

    final blockPublicKey = ASN1BitString(stringValues: publicKeySequence.encode());

    final outer = ASN1Sequence();
    outer.add(blockEncryptionType);
    outer.add(blockPublicKey);

    return outer;
  }

  /// Retrieves the Object Identifier (OID) for a given signing algorithm.
  static String _getOiForSigningAlgorithm(String algorithm, {bool ecc = false}) {
    switch (algorithm) {
      case 'SHA-1':
        return ecc ? 'ecdsaWithSHA1' : 'sha1WithRSAEncryption';
      case 'SHA-224':
        return ecc ? 'ecdsaWithSHA224' : 'sha224WithRSAEncryption';
      case 'SHA-256':
        return ecc ? 'ecdsaWithSHA256' : 'sha256WithRSAEncryption';
      case 'SHA-384':
        return ecc ? 'ecdsaWithSHA384' : 'sha384WithRSAEncryption';
      case 'SHA-512':
        return ecc ? 'ecdsaWithSHA512' : 'sha512WithRSAEncryption';
      default:
        return ecc ? 'ecdsaWithSHA256' : 'sha256WithRSAEncryption';
    }
  }

  /// Generates a Certificate Signing Request (CSR) in PEM format for an RSA key.
  Future<String> generateRsaCsrPem(Map<String, String> attributes, RSAPublicKey publicKey,
      {List<String>? san, String signingAlgorithm = 'SHA-256'}) async {
    if (!_validRsaSigner.contains(signingAlgorithm)) {
      ArgumentError('Signingalgorithm $signingAlgorithm not supported!');
    }
    final encodedDN = encodeDN(attributes);

    final blockDN = ASN1Sequence();
    blockDN.add(ASN1Integer(BigInt.from(0)));
    blockDN.add(encodedDN);
    blockDN.add(_makePublicKeyBlock(publicKey));

    // Check if extensions are needed
    if (san != null && san.isNotEmpty) {
      final outerBlockExt = ASN1Sequence();
      outerBlockExt.add(ASN1ObjectIdentifier.fromName('extensionRequest'));

      final setExt = ASN1Set();

      final innerBlockExt = ASN1Sequence();

      final sanExtSeq = ASN1Sequence();
      sanExtSeq.add(ASN1ObjectIdentifier.fromName('subjectAltName'));
      final sanSeq = ASN1Sequence();
      for (final s in san) {
        final sanIa5 = ASN1IA5String(stringValue: s, tag: 0x82);
        sanSeq.add(sanIa5);
      }
      final octet = ASN1OctetString(octets: sanSeq.encode());
      sanExtSeq.add(octet);

      innerBlockExt.add(sanExtSeq);

      setExt.add(innerBlockExt);

      outerBlockExt.add(setExt);

      final asn1Null = ASN1OctetString(tag: 0xA0, octets: outerBlockExt.encode());
      //asn1Null.valueBytes = outerBlockExt.encode();
      blockDN.add(asn1Null);
    } else {
      blockDN.add(ASN1Null(tag: 0xA0)); // let's call this WTF
    }

    final blockProtocol = ASN1Sequence();
    blockProtocol.add(ASN1ObjectIdentifier.fromName(_getOiForSigningAlgorithm(signingAlgorithm)));
    blockProtocol.add(ASN1Null());

    // TODO use Function for sign text
    final signResponse = await SecurePlugin.signBytes(
        bytesData: blockDN.encode(), phoneNumber: mainController.keyAliasModelList.first.keyAlias);

    if (!(signResponse.isSuccess ?? false)) {
      if (signResponse.statusCode != 10) {
        await Sentry.captureMessage('sign csr error',
            params: [
              {'status code': signResponse.statusCode},
              {'message': signResponse.message},
            ],
            level: SentryLevel.warning);
      }

      return Future.value('');
    }

    final outer = ASN1Sequence();
    outer.add(blockDN);
    outer.add(blockProtocol);
    outer.add(ASN1BitString(stringValues: base64.decode(signResponse.data!)));
    final chunks = StringUtils.chunk(base64.encode(outer.encode()), 64);
    return chunks.join('\r\n');
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}

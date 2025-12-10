import 'dart:async';
import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
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
///secure_plugin
import 'package:secure_plugin/secure_plugin.dart';
///secure_plugin
import 'package:secure_plugin/secure_response_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../util/secure_web_plugin.dart';
import '../authentication_register_controller.dart';

extension CsrSecurityFlowMethods on AuthenticationRegisterController {
  /// The list of valid RSA signing algorithms supported by the system
  static final _validRsaSigner = [
    'SHA-1',
    'SHA-224',
    'SHA-256',
    'SHA-384',
    'SHA-512'
  ];

  /// Encodes a Distinguished Name (DN) as an ASN.1 object.
  /// Takes a map of DN attributes and returns the encoded ASN.1 sequence.
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

  /// Creates an ASN.1 sequence representing the public key block of a CSR.
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

  /// Retrieves the appropriate Object Identifier (OID) for a given signing algorithm.
  /// Supports both RSA and ECC algorithms.
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

  /// Generates a Certificate Signing Request (CSR) in PEM format for an RSA key pair.
  /// Handles both web and mobile platforms with appropriate security measures.
  Future<String> generateRsaCsrPem(
      Map<String, String> attributes,
      RSAPublicKey publicKey, {
        List<String>? san,
        String signingAlgorithm = 'SHA-256'
      }) async {
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

      final asn1Null = ASN1OctetString(
          tag: 0xA0,
          octets: outerBlockExt.encode()
      );
      blockDN.add(asn1Null);
    } else {
      blockDN.add(ASN1Null(tag: 0xA0));
    }

    final blockProtocol = ASN1Sequence();
    blockProtocol.add(ASN1ObjectIdentifier.fromName(
        _getOiForSigningAlgorithm(signingAlgorithm)
    ));
    blockProtocol.add(ASN1Null(tag: 0x05)); // Changed tag to 0x05 for NULL

    if (kIsWeb) {
      try {
        // Get the bytes to sign
        final bytesToSign = blockDN.encode();
        print("🔵 bytesToSign length: ${bytesToSign.length}");

        // Sign the data
        String? signResponse = await SecureWebPlugin.signByteData(bytesToSign);
        if (signResponse == null || signResponse.isEmpty) {
          print("🔴 Error: Empty signature response");
          return '';
        }
        print("🔵 signature length: ${signResponse.length}");

        // Create the final ASN.1 structure
        final outer = ASN1Sequence();
        outer.add(blockDN);
        outer.add(blockProtocol);

        // Decode the base64 signature and add it as a BIT STRING
        final signatureBytes = base64.decode(signResponse);
        outer.add(ASN1BitString(stringValues: signatureBytes));

        // Encode the entire structure and format as PEM
        final csrBytes = outer.encode();
        final csrBase64 = base64.encode(csrBytes);
        final chunks = StringUtils.chunk(csrBase64, 64);

        return '-----BEGIN CERTIFICATE REQUEST-----\n${chunks.join('\n')}\n-----END CERTIFICATE REQUEST-----';
      } catch (e) {
        print("🔴 Error in CSR generation: $e");
        return '';
      }
    } else {
      // Keeping the working non-web implementation exactly as is
      SecureResponseData signResponse = await SecurePlugin.signBytes(
          bytesData: blockDN.encode(),
          phoneNumber: mainController.keyAliasModelList.first.keyAlias
      );

      if (!(signResponse.isSuccess ?? false)) {
        if (signResponse.statusCode != 10) {
          await Sentry.captureMessage('sign csr error',
              params: [
                {'status code': signResponse.statusCode},
                {'message': signResponse.message},
              ],
              level: SentryLevel.warning
          );
        }
        return '';
      }

      final outer = ASN1Sequence();
      outer.add(blockDN);
      outer.add(blockProtocol);
      outer.add(ASN1BitString(stringValues: base64.decode(signResponse.data!)));
      final chunks = StringUtils.chunk(base64.encode(outer.encode()), 64);
      return '-----BEGIN CERTIFICATE REQUEST-----\n${chunks.join('\n')}\n-----END CERTIFICATE REQUEST-----';
    }
  }
}
import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:pointycastle/asn1.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CertificateUtil {
  CertificateUtil._();

  static final _validRsaSigner = ['SHA-1', 'SHA-224', 'SHA-256', 'SHA-384', 'SHA-512'];

  static Future<String> generateRsaCsrPem(Map<String, String> attributes, RSAPublicKey publicKey, String keyAlias,
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

    final signResponse = await SecurePlugin.signBytes(bytesData: blockDN.encode(), phoneNumber: keyAlias);

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
}

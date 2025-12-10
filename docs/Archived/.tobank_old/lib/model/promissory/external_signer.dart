import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ExternalSigner extends IPdfExternalSigner {
  RSAPrivateKey rsaPrivateKey;

  ExternalSigner({required this.rsaPrivateKey});

  @override
  Future<SignerResult?> sign(List<int> message) async {
    final signedBytes = CryptoUtils.rsaSign(rsaPrivateKey, Uint8List.fromList(message));
    return SignerResult(signedBytes.toList());
  }
}

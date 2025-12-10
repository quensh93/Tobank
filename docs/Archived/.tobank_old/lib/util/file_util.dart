import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class FileUtil {
  static final FileUtil _instance = FileUtil._internal();

  late Directory tempDir;

  factory FileUtil() {
    return _instance;
  }

  FileUtil._internal();

  Future<void> init() async {
    ///TODO-MERGE
    if(!kIsWeb){
      tempDir = await getTemporaryDirectory();
    }

  }

  Future<String> writeAsBytesMultiSignedPDF({
    required String source,
  }) async {
    final String path = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}-MultiSignedPDF.pdf';
    await File(path).writeAsBytes(base64Decode(source).toList());
    return path;
  }

  Future<String> writeAsBytesContractPDF({
    required List<int> bytes,
    required String name,
  }) async {
    final String path = '${tempDir.path}/$name Contract - ${DateTime.now().millisecondsSinceEpoch}.pdf';
    await File(path).writeAsBytes(bytes);
    return path;
  }

  Future<String> writeAsBytesFile({
    required List<int> bytes,
    required String name,
  }) async {
    final String path = '${tempDir.path}/$name';
    await File(path).writeAsBytes(bytes);
    return path;
  }

  Future<void> shareContractPDF({
    required List<int> bytes,
    required String name,
    String? title,
  }) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String output = await writeAsBytesContractPDF(
      bytes: bytes,
      name: name,
    );
    title ??= locale.contract_file;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(output)], subject: title);
    } else {
      Share.shareXFiles([XFile(output)], text: title);
    }
  }

  Future<void> shareFile({
    required List<int> bytes,
    required String name,
    String? title,
  }) async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String output = await writeAsBytesFile(
      bytes: bytes,
      name: name,
    );
    title ??= locale.contract_file;
    if (Platform.isIOS) {
      Share.shareXFiles([XFile(output)], subject: title);
    } else {
      Share.shareXFiles([XFile(output)], text: title);
    }
  }

  String generateImageUuidJpgPath() => '${tempDir.path}/image-${const Uuid().v4()}.jpg';

  String generateImagePngPath() => '${tempDir.path}/image.png';

  String generateSignaturePath() => '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}-signature.png';
}

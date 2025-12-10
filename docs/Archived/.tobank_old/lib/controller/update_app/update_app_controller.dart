import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/other/app_version_data.dart';
import '../../util/app_util.dart';
import '../main/main_controller.dart';

class UpdateAppController extends GetxController {
  UpdateAppController({required this.appVersionData});

  MainController mainController = Get.find();

  AppVersionData appVersionData;

  Future<void> launchURL() async {
    AppUtil.launchInBrowser(url: appVersionData.data!.landingpage!.link!);
  }

  String getUpdateButtonText() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
     final String text = locale.download_new_version;
    final String version = appVersionData.data?.app?.version ?? '';
    if (version.isEmpty) {
      return text;
    } else {
      return '$text ($version)';
    }
  }
}

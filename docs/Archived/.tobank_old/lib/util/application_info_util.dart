import 'package:package_info_plus/package_info_plus.dart';


class ApplicationInfoUtil {
  static final ApplicationInfoUtil _instance = ApplicationInfoUtil._internal();

  String applicationId = '';
  String appVersion = '';

  factory ApplicationInfoUtil() {
    return _instance;
  }

  ApplicationInfoUtil._internal();

  Future<void> init() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    applicationId = packageInfo.packageName;
    appVersion = packageInfo.version;
  }
}

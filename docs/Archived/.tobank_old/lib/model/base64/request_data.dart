import '../../util/app_util.dart';

class RequestData {
  String? data;

  Map<String, dynamic> toJson() => {
        AppUtil.getRandomString(26): data,
      };
}

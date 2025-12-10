import 'package:universal_io/io.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../controller/main/main_controller.dart';
import '../model/other/request/firebase_token_data.dart';
import '../model/profile/response/error_fcm_token_response_data.dart';
import '../service/core/api_core.dart';
import '../service/profile_services.dart';
import 'storage_util.dart';

class FirebaseNotifications {
  MainController mainController = Get.find();
  /// todo: add later to pwa
  // Function(RemoteMessage message) returnData;
  // late FirebaseMessaging _firebaseMessaging;

  // FirebaseNotifications(this.returnData);

  void setUpFirebase() {
    // _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
  }

  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) await iOSPermission();

    // _firebaseMessaging.getToken().then((token) {
    //   if (token != mainController.authInfoData!.fcmToken) {
    //     if (Platform.isIOS) {
    //       _submitToken(token, 'ios');
    //     } else {
    //       _submitToken(token, 'android');
    //     }
    //   }
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   returnData(message);
    // });
  }

  Future<void> iOSPermission() async {
    // await _firebaseMessaging.requestPermission();
    //
    // await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    //   alert: true, // Required to display a heads up notification
    //   badge: true,
    //   sound: true,
    // );
  }

  void _submitToken(String? fcmToken, String deviceType) {
    final FirebaseTokenData firebaseTokenData = FirebaseTokenData();
    firebaseTokenData.name = 'GardeshPayApp';
    firebaseTokenData.deviceId = mainController.authInfoData!.uuid;
    firebaseTokenData.registrationId = fcmToken.toString();
    firebaseTokenData.type = deviceType;
    ProfileServices.submitFirebaseTokenRequest(
      firebaseTokenData: firebaseTokenData,
    ).then((result) async {
      switch (result) {
        case Success(value: _):
          mainController.authInfoData!.fcmToken = fcmToken.toString();
          mainController.update();
          await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
        case Failure(exception: final ApiException<ErrorFcmTokenResponseData> apiException):
          if (apiException.errorResponse?.code != null && apiException.errorResponse?.code == 3057) {
            mainController.authInfoData!.fcmToken = fcmToken.toString();
            mainController.update();
            await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);
          }
        case Failure(exception: _):
          break;
      }
    });
  }
}

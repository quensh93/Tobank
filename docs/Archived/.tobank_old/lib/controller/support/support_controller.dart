import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../model/profile/request/update_goftino_id_request_data.dart';
import '../../service/core/api_core.dart';
import '../../service/profile_services.dart';
import '../../util/app_util.dart';
import '../../util/application_info_util.dart';
import '../../util/enums_constants.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class SupportController extends GetxController {
  MainController mainController = Get.find();
  InAppWebViewController? webViewController;
  String ekycProvider = '';
  String deviceName = '';
  String nickName = '';
  InAppWebViewSettings? settings;
  UserScript? userScript;
  bool isInited = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    nickName = mainController.authInfoData!.mobile!;
    if (mainController.authInfoData!.firstName != null &&
        mainController.authInfoData!.firstName!.isNotEmpty &&
        mainController.authInfoData!.lastName != null &&
        mainController.authInfoData!.lastName!.isNotEmpty) {
      nickName = '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    }
    if (mainController.appEKycProvider == EKycProvider.zoomId) {
      ekycProvider = 'GSS';
    } else if (mainController.appEKycProvider == EKycProvider.yekta) {
      ekycProvider = 'Yekta';
    } else {
      ekycProvider = 'none';
    }
    settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true,
      useShouldOverrideUrlLoading: true,
    );

    await _getDeviceDetails();

    isInited = await StorageUtil.getGoftinoInitialized();

    userScript = UserScript(source: isReadyEvent(), injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START);

    update();
  }

  /// Retrieves device details such as manufacturer and model.
  ///
  /// This function uses the `device_info_plus` package to retrieve device-specific
  /// information, such as the manufacturer and model. It handles platform differences between
  /// Android and iOS and stores the retrieved device name in the `deviceName` variable.
  Future<void> _getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        deviceName = '${build.manufacturer} ${build.model}';
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        deviceName = data.utsname.machine;
      }
    } on PlatformException {
      AppUtil.printResponse('Platform exception');
    }
  }

  String goftinoEmbedUrl() {
    return 'https://www.goftino.com/c/qUwupD';
  }

  String isReadyEvent() {
    final String isReadyEvent = """
      window.addEventListener('goftino_ready', async function () {
        if ($isInited) {
            Goftino.setUser({
                name: '$nickName',
                about: 'NN: ${(mainController.authInfoData!.nationalCode ?? 'NONE')} - EKYC: $ekycProvider - D: $deviceName - V: ${ApplicationInfoUtil().appVersion}',
                phone: '${mainController.authInfoData!.mobile!}',
                forceUpdate: true
            });
        } else {
            if (${mainController.authInfoData!.goftinoId != null}) {
                Goftino.setUserId('${mainController.authInfoData!.goftinoId}', function (callback) {
                    window.flutter_inappwebview
                        .callHandler('handlerGoftinoInit');
                });
            } else {
                Goftino.setUser({
                  name: '$nickName',
                  about: 'NN: ${(mainController.authInfoData!.nationalCode ?? 'NONE')} - EKYC: $ekycProvider - D: $deviceName - V: ${ApplicationInfoUtil().appVersion}',
                  phone: '${mainController.authInfoData!.mobile!}',
                  forceUpdate: true
                });
                var userId = await Goftino.getUserId();
                window.flutter_inappwebview
                    .callHandler('handlerGoftinoId', userId);
            }
        }
      });
    """;
    return isReadyEvent;
  }

  /// Determines whether to override the loading of a URLin the WebView.
  ///
  /// This function is called whenever the WebView attempts to load a new URL. It checks the URL's
  /// scheme and host to determine whether the app should handle the navigation or allow the WebView
  /// to proceed with loading the URL. If the URL's scheme is one of the specified schemes and the
  /// host is not 'www.goftino.com', it launches the URL in an external browser and cancels the
  /// WebView's navigation. Otherwise, it allows the WebView to load the URL.
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url;
    final url = uri.toString();

    if (uri!.host != 'www.goftino.com') {
      if ([
        'http',
        'https',
        'tel',
        'mailto',
        'file',
        'chrome',
        'data',
        'javascript',
      ].contains(uri.scheme)) {
        AppUtil.launchInBrowser(url: url);
        return NavigationActionPolicy.CANCEL;
      }
    }

    return NavigationActionPolicy.ALLOW;
  }

  void setWebViewController(InAppWebViewController webViewController) {
    this.webViewController = webViewController;

    webViewController.addJavaScriptHandler(
        handlerName: 'handlerGoftinoId',
        callback: (args) {
          final goftinoId = args[0] as String;
          AppUtil.printResponse(goftinoId);
          _updateGoftinoIdRequest(goftinoId);
        });

    webViewController.addJavaScriptHandler(
        handlerName: 'handlerGoftinoInit',
        callback: (args) async {
          isInited = true;
          await StorageUtil.setGoftinoInitialized(true);

          update();

          userScript = UserScript(source: isReadyEvent(), injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START);

          await webViewController.removeAllUserScripts();
          await webViewController.addUserScript(userScript: userScript!);
          await webViewController.reload();
        });
  }

  /// Updates the Goftino ID for the user and reloads theWebView.
  ///
  /// This function sends a request to update the user's Goftino ID on the server.
  /// If the request is successful, it updates the Goftino ID in the `mainController`, stores it in
  /// secure storage, marks Goftino as initialized, updates the UI, injects a user script into
  /// the WebView, and reloads the WebView.
  void _updateGoftinoIdRequest(String goftinoId) {
    final updateGoftinoIdRequest = UpdateGoftinoIdRequest(
      goftinoId: goftinoId,
    );

    ProfileServices.updateGoftinoIdRequest(
      updateGoftinoIdRequest: updateGoftinoIdRequest,
    ).then(
          (result) async {
        switch (result) {
          case Success(value: _):
            mainController.authInfoData!.goftinoId = goftinoId;
            await StorageUtil.setAuthInfoDataSecureStorage(mainController.authInfoData!);

            isInited = true;
            await StorageUtil.setGoftinoInitialized(true);

            update();

            userScript = UserScript(source: isReadyEvent(), injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START);

            await webViewController!.removeAllUserScripts();
            await webViewController!.addUserScript(userScript: userScript!);
            await webViewController!.reload();
          case Failure(exception: _):
            break;
        }
      },
    );
  }
}

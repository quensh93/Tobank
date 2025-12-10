import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/daran/response/daran_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/daran_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class DaranController extends GetxController with WidgetsBindingObserver {
  MainController mainController = Get.find();
  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: false,
  );

  PullToRefreshController? pullToRefreshController;
  int progress = 0;

  String? errorTitle = '';

  bool hasError = false;

  bool isLoading = false;

  PageController pageController = PageController();

  DaranResponseData? daranResponseData;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // Only initialize pull-to-refresh controller on non-web platforms
    if (!kIsWeb) {
      try {
        pullToRefreshController = PullToRefreshController(
          settings: PullToRefreshSettings(
            color: Colors.blue,
          ),
          onRefresh: () async {
            if (Platform.isAndroid) {
              webViewController?.reload();
            } else if (Platform.isIOS) {
              webViewController?.loadUrl(
                  urlRequest: URLRequest(url: await webViewController?.getUrl())
              );
            }
          },
        );
      } catch (e) {
        print("Error initializing PullToRefreshController: $e");
        // Continue without pull-to-refresh functionality
      }
    }

    getDaranRequest();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Handles changes in the app's lifecycle state,
  /// potentially reloading the web view when the app resumes.
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (isInBrowser) {
      if (state == AppLifecycleState.resumed) {
        Timer(Constants.duration200, () {
          webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri.uri(Uri.parse(getHomeUrl()))));
        });
        isInBrowser = false;
      }
    }
  }

  String getUrl() {
    return daranResponseData!.data!.result!;
  }

  String getHomeUrl() {
    return 'https://tobank.azkisarmayeh.com/saving/';
  }

  Future<NavigationActionPolicy> overrodeUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url!;
    if (uri.host.contains('shaparak.ir') ||
        uri.host.contains('payping.ir') ||
        uri.host.contains('payment-stage.azkisarmayeh.com')) {
      AppUtil.launchInBrowser(url: uri.toString());
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else if (uri.host.contains('sejam.ir')) {
      AppUtil.launchInBrowser(url: uri.toString());
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else if (uri.host.contains('azkisarmayeh.com') || uri.host.contains('fund1-amitispm.ir')) {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.CANCEL;
    }
  }

  /// Handles the back press action,
  /// potentially navigating back in a web view or closing the current screen.
  Future<void> onBackPressed(bool didPop) async {
    if (didPop) {
      return;
    }
    if (webViewController != null && await webViewController!.canGoBack()) {
      final webHistory = await webViewController!.getCopyBackForwardList();
      if (webHistory?.currentIndex == 1) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        webViewController!.goBack();
      }
    } else {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  /// Sends a request to get Daran data, updates the UI,
  /// and potentially navigates to a specific page or shows an error message.
  void getDaranRequest() { //locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    DaranServices.getDaranRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final DaranResponseData response, int _)):
          daranResponseData = response;
          update();
          AppUtil.gotoPageController(
            pageController: pageController,
            page: 1,
            isClosed: isClosed,
          );
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
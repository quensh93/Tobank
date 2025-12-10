import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/customer_club/response/customer_club_web_view_link_response.dart';
import '../../model/other/response/other_item_data.dart';
import '../../service/core/api_core.dart';
import '../../service/customer_club_services.dart';
import '../../service/other_services.dart';
import '../../util/app_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class CustomerClubController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;

  OtherItemData? otherItemData;

  String? errorTitle = '';
  bool hasError = false;

  PageController pageController = PageController();

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: true,
  );

  PullToRefreshController? pullToRefreshController;
  int progress = 0;

  CustomerClubWebViewResponseData? customerClubWebViewResponseData;

  @override
  void onInit() {
    super.onInit();
    getShcc();

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
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  String getUrl() {
    return customerClubWebViewResponseData!.data!.link!;
  }

  /// Handles the back press action,
  /// potentially navigating back in a webView or closing the current screen.
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

  /// Sends a request to get the customer club webView link
  void _getCustomerClubWebviewLinkRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    CustomerClubServices.getCustomerClubWebViewLinkRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final CustomerClubWebViewResponseData response, int _)):
          customerClubWebViewResponseData = response;
          update();
          AppUtil.nextPageController(pageController, isClosed);
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

  /// Sends a request to get SHCC data, updates the UI,
  /// and potentially calls [_getCustomerClubWebviewLinkRequest] or shows an error message.
  Future<void> getShcc() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    OtherServices.getShccRequest().then((result) {
      switch (result) {
        case Success(value: (final OtherItemData response, int _)):
          otherItemData = response;
          update();
          _getCustomerClubWebviewLinkRequest();
        case Failure(exception: final ApiException apiException):
          isLoading = false;
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

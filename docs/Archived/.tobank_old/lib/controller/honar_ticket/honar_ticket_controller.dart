import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';

class HonarTicketController extends GetxController with WidgetsBindingObserver {
  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: true,
    cacheMode: CacheMode.LOAD_NO_CACHE,
  );

  late PullToRefreshController pullToRefreshController;
  int progress = 0;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (isInBrowser) {
      if (state == AppLifecycleState.resumed) {
        Timer(Constants.duration200, () {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://www.honarticket.com/receipts'))));
        });
        isInBrowser = false;
      }
    }
  }

  String startedUtl() {
    return 'https://www.honarticket.com/ali.gh2';
  }

  // Overrides the URL loading behavior of the WebView.
  Future<NavigationActionPolicy> overrodeUrlLoading(NavigationAction navigationAction) async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final uri = navigationAction.request.url!;
    AppUtil.printResponse(uri.toString());
    if (uri.host.contains('pdf-tools.zirbana.com')) {
      AppUtil.launchInBrowser(url: uri.toString());
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else if (uri.toString().contains('payment.zirbana.com')) {
      DialogUtil.showDialogMessage(
          buildContext: Get.context!,
          message: locale.redirecting_to_browser_for_payment,
          description: locale.return_to_app_after_payment,
          positiveMessage: locale.confirmation,
          negativeMessage: locale.cancel_laghv,
          positiveFunction: () {
            Get.back(closeOverlays: true);
            AppUtil.launchInBrowser(url: uri.toString());
          },
          negativeFunction: () {
            Get.back(closeOverlays: true);
          });
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else {
      if (uri.host.contains('honarticket.com')) {
        return NavigationActionPolicy.ALLOW;
      } else {
        return NavigationActionPolicy.CANCEL;
      }
    }
  }

  /// Handles the back button press event.
  ///
  /// If the WebView can go back, it navigates back to the previous page.
  /// Otherwise, it pops the current screen from the navigation stack.
  Future<void> onBackPressed(bool didPop) async {
    if (didPop) {
      return;
    }
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
    } else {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }
}

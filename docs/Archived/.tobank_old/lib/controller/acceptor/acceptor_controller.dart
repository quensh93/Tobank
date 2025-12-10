import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../../util/constants.dart';

class AcceptorController extends GetxController with WidgetsBindingObserver {
  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true,
      useShouldOverrideUrlLoading: false,
      cacheMode: CacheMode.LOAD_NO_CACHE);

  late PullToRefreshController? pullToRefreshController;
  int progress = 0;

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
              webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
            }
          },
        );
      } catch (e) {
        print("Error initializing PullToRefreshController: $e");
        pullToRefreshController = null;
      }
    } else {
      // For web platform, set to null
      pullToRefreshController = null;
    }
  }

  /// Overrides the `didChangeAppLifecycleState` method to handle app lifecycle changes, specifically for web views in a browser environment.
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (isInBrowser) {
      if (state == AppLifecycleState.resumed) {
        Timer(Constants.duration200, () {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://my.gardeshpay.ir/wallet'))));
        });
        isInBrowser = false;
      }
    }
  }

  String acceptorUrl() {
    return 'https://my.gardeshpay.ir/';
  }

  /// Determines the navigation action policy for web view URL loading,
  /// handlingPDF files, payment redirects, and specific domains.
  Future<NavigationActionPolicy> overrodeUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url!;
    AppUtil.printResponse(uri.toString());
    if (uri.toString().endsWith('.pdf')) {
      AppUtil.launchInBrowser(url: uri.toString());
      return NavigationActionPolicy.CANCEL;
    } else if (uri.toString().contains('https://ipg.gardeshpay.ir/v1/provider/payment/redirect/')) {
      AppUtil.launchInBrowser(url: uri.toString());
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else {
      if (uri.host.contains('gardeshpay.ir') || uri.host.contains('gardeshpay.com') || uri.host.contains('tobank.ir')) {
        return NavigationActionPolicy.ALLOW;
      } else {
        return NavigationActionPolicy.CANCEL;
      }
    }
  }

  /// Handles the back button press, navigating back in the web view if possible,
  /// otherwise popping the current screen.
  /// Handles the back button press, navigating back in the web view if possible,
  /// otherwise popping the current screen.
  Future<void> onBackPressed(bool didPop) async {
    if (didPop) {
      return;
    }

    if (kIsWeb) {
      // For web platform, just pop the navigator since canGoBack is not supported
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    } else {
      // Only try to use canGoBack on non-web platforms
      try {
        if (await webViewController!.canGoBack()) {
          webViewController!.goBack();
        } else {
          final NavigatorState navigator = Navigator.of(Get.context!);
          navigator.pop();
        }
      } catch (e) {
        // Handle any errors and fallback to popping the navigator
        print("Error navigating back: $e");
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      }
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }
}

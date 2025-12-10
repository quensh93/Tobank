import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class InternalWebViewController extends GetxController with WidgetsBindingObserver {
  String url;
  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: false,
    cacheMode: CacheMode.LOAD_NO_CACHE,
  );

  late PullToRefreshController pullToRefreshController;
  int progress = 0;

  InternalWebViewController({required this.url});

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

  // Handles back navigation within the WebView screen.
  void setProgress(int progress) {
    this.progress = progress;
    update();
  }
}

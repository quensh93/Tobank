import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../util/enums_constants.dart';

class HelperController extends GetxController {
  HelperController({required this.helperType});

  final HelperType helperType;

  GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  int progress = 0;

  InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    supportZoom: false,
    useShouldOverrideUrlLoading: true,
  );

  @override
  void onInit() {
    super.onInit();

    // Initialize pull-to-refresh controller
    if(!kIsWeb){
      pullToRefreshController = PullToRefreshController(
        settings: PullToRefreshSettings(
          color: Colors.blue,
        ),
        onRefresh: () async {
          if (webViewController != null) {
            final url = await webViewController!.getUrl();
            if (url != null) {
              webViewController!.loadUrl(
                urlRequest: URLRequest(url: url),
              );
            }
          }
        },
      );
    }

  }

  String getHelperTitle() {
    return helperType.title;
  }

  String getUrl() {
    return helperType.url;
  }

  void setProgress(int progressValue) {
    progress = progressValue;
    update(); // Notify GetX to rebuild
  }



// You can add other methods from DaranController as needed,
// such as onBackPressed for handling back navigation within the web view.
}

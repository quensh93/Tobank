import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChildrenLoanAmountDetailController extends GetxController {
  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  late WebViewController webViewController;
  int progress = 0;

  @override
  void onInit() {
    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Get.isDarkMode ? Get.context!.theme.colorScheme.surface : Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            this.progress = progress;
            update();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            final uri = request.url;
            if (uri.contains('tobank')) {
              return NavigationDecision.navigate;
            } else {
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(getConditionUrl()));
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<NavigationActionPolicy> overrodeUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url!;
    if (uri.host.contains('tobank.com')) {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.CANCEL;
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  String getConditionUrl() {
    return 'https://tobank.ir/app/children-loan-amount-conditions';
  }
}

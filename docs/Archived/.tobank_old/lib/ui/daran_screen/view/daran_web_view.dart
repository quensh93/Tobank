import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../controller/daran/daran_controller.dart';

class DaranWebView extends StatelessWidget {
  const DaranWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DaranController>(builder: (carnivalController) {
      return Stack(
        children: [
          InAppWebView(
            key: carnivalController.webViewKey,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
              Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
              ),
            ),
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(carnivalController.getUrl())),
            ),
            pullToRefreshController: carnivalController.pullToRefreshController,
            initialSettings: carnivalController.settings,
            onWebViewCreated: (InAppWebViewController inAppWebViewController) {
              carnivalController.webViewController = inAppWebViewController;
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
            },
            onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
            shouldOverrideUrlLoading: (inAppWebViewController, navigationAction) async {
              return await carnivalController.overrodeUrlLoading(navigationAction);
            },
            onReceivedError: (controller, request, error) {
              carnivalController.pullToRefreshController?.endRefreshing();
            },
            onProgressChanged: (controller, progress) {
              carnivalController.setProgress(progress);
              if (progress == 100) {
                carnivalController.pullToRefreshController?.endRefreshing();
              }
            },
          ),
          if (!kIsWeb && carnivalController.progress < 100)
            const Align(
              child: CircularProgressIndicator(),
            )
          else
            Container(),
        ],
      );
    });
  }
}
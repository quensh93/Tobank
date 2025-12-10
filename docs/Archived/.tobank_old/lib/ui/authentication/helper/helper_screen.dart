import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/helper/helper_controller.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';

class HelperScreen extends StatelessWidget {
  const HelperScreen({
    required this.helperType,
    super.key,
  });

  final HelperType helperType;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    print("⭕ HelperScreen");
    return GetBuilder<HelperController>(
        init: HelperController(helperType: helperType),
        builder: (helperController) {
          return Scaffold(
            body: SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        helperController.getHelperTitle(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            InAppWebView(
                              key: helperController.webViewKey,
                              gestureRecognizers:
                                  <Factory<OneSequenceGestureRecognizer>>{}
                                    ..add(
                                      Factory<VerticalDragGestureRecognizer>(
                                        () => VerticalDragGestureRecognizer(),
                                      ),
                                    ),
                              initialUrlRequest: URLRequest(
                                url: WebUri.uri(
                                    Uri.parse(helperController.getUrl())),
                              ),
                              pullToRefreshController:
                                  helperController.pullToRefreshController,
                              initialSettings: helperController.settings,
                              onWebViewCreated: (InAppWebViewController
                                  inAppWebViewController) {
                                helperController.webViewController =
                                    inAppWebViewController;
                              },
                              onPermissionRequest: (controller, request) async {
                                return PermissionResponse(
                                  action: PermissionResponseAction.GRANT,
                                  resources: [],
                                );
                              },
                              onLoadStop: (InAppWebViewController controller,
                                  Uri? url) async {
                                helperController.pullToRefreshController
                                    ?.endRefreshing();
                              },
                              onReceivedError: (controller, request, error) {
                                helperController.pullToRefreshController
                                    ?.endRefreshing();
                                debugPrint('Error: $error');
                              },
                              onProgressChanged: (controller, progress) {
                                helperController.setProgress(progress);
                                if (progress == 100) {
                                  helperController.pullToRefreshController
                                      ?.endRefreshing();
                                }
                              },
                            ),
                            if (!kIsWeb && helperController.progress < 100)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                            else
                              Container(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ),
                            child: Text(
                              locale.understood_button,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

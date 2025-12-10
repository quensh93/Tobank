import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/internal_web_view/internal_web_view_controller.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class InternalWebViewScreen extends StatelessWidget {
  final String? screenTitle;
  final String url;

  const InternalWebViewScreen({required this.url, super.key, this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternalWebViewController>(
      init: InternalWebViewController(url: url),
      builder: (iranTicController) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: iranTicController.onBackPressed,
            child: Scaffold(
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    HeaderWidget(
                      title: screenTitle != null ? screenTitle! : '',
                      showSupportButton: false,
                      returnFunction: () {
                        iranTicController.onBackPressed(false);
                      },
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            key: iranTicController.webViewKey,
                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                                Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer(),
                                ),
                              ),
                            initialUrlRequest: URLRequest(
                              url: WebUri.uri(Uri.parse(iranTicController.url)),
                            ),
                            pullToRefreshController: iranTicController.pullToRefreshController,
                            initialSettings: iranTicController.settings,
                            onWebViewCreated: (InAppWebViewController inAppWebViewController) {
                              iranTicController.webViewController = inAppWebViewController;
                            },
                            onPermissionRequest: (controller, request) async {
                              return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
                            },
                            onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                            onReceivedError: (controller, request, error) {
                              iranTicController.pullToRefreshController.endRefreshing();
                            },
                            onProgressChanged: (controller, progress) {
                              iranTicController.setProgress(progress);
                              if (progress == 100) {
                                iranTicController.pullToRefreshController.endRefreshing();
                              }
                            },
                          ),
                          if (iranTicController.progress < 100)
                            const Align(
                              child: CircularProgressIndicator(),
                            )
                          else
                            const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    required this.title,
    super.key,
    this.returnFunction,
    this.hideBackButton,
    this.showSupportButton = true,
  });

  final String title;
  final Function? returnFunction;
  final bool? hideBackButton;
  final bool showSupportButton;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;    return Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 48,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (returnFunction != null) {
                    returnFunction!();
                  } else {
                    Get.back();
                  }
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgIcon(
                      SvgIcons.back,
                      colorFilter: ColorFilter.mode(context.theme.textTheme.displayLarge!.color!, BlendMode.srcIn),
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40.0,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      locale.close,
                      style: context.theme.textTheme.bodyLarge,
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

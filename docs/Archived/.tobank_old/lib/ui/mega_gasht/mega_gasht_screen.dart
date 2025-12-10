import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/mega_gasht/mega_gasht_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class MegaGashtScreen extends StatelessWidget {
  const MegaGashtScreen({
    super.key,
    this.menuItemData,
  });

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<MegaGashtController>(
      init: MegaGashtController(),
      builder: (megaGashtController) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: megaGashtController.onBackPressed,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    MegaGashtHeaderWidget(
                      title: menuItemData != null ? menuItemData!.title! : locale.travel_services,
                      showSupportButton: false,
                      returnFunction: () {
                        megaGashtController.onBackPressed(false);
                      },
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            key: megaGashtController.webViewKey,
                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                                Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer(),
                                ),
                              ),
                            initialUrlRequest: URLRequest(
                              url: WebUri.uri(Uri.parse(megaGashtController.baseUrl())),
                            ),
                            pullToRefreshController: megaGashtController.pullToRefreshController,
                            initialSettings: megaGashtController.settings,
                            onWebViewCreated: (InAppWebViewController inAppWebViewController) {
                              megaGashtController.webViewController = inAppWebViewController;
                            },
                            onPermissionRequest: (controller, request) async {
                              return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
                            },
                            onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                            shouldOverrideUrlLoading: (inAppWebViewController, navigationAction) async {
                              return await megaGashtController.overrideUrlLoading(navigationAction);
                            },
                            onUpdateVisitedHistory: (controller, url, androidIsReload) {
                              megaGashtController.onUpdateVisitedHistory(url);
                            },
                            onReceivedError: (controller, request, error) {
                              megaGashtController.pullToRefreshController?.endRefreshing();
                            },
                            onProgressChanged: (controller, progress) {
                              megaGashtController.setProgress(progress);
                              if (progress == 100) {
                                megaGashtController.pullToRefreshController?.endRefreshing();
                              }
                            },
                          ),
                          if (!kIsWeb && megaGashtController.progress < 100)
                            const Align(
                              child: CircularProgressIndicator(),
                            )
                          else
                            Container(),
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

class MegaGashtHeaderWidget extends StatelessWidget {
  const MegaGashtHeaderWidget({
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
    final locale = AppLocalizations.of(context)!;
    return Column(
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

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../controller/honar_ticket/honar_ticket_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
class HonarTicketScreen extends StatelessWidget {
  final MenuItemData? menuItemData;

  const HonarTicketScreen({super.key, this.menuItemData});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<HonarTicketController>(
      init: HonarTicketController(),
      builder: (honarTicketController) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: honarTicketController.onBackPressed,
            child: Scaffold(
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    HeaderWidget(
                      title: menuItemData != null ? menuItemData!.title! : locale.honar_ticket,
                      showSupportButton: false,
                      returnFunction: () {
                        honarTicketController.onBackPressed(false);
                      },
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            key: honarTicketController.webViewKey,
                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                                Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer(),
                                ),
                              ),
                            initialUrlRequest: URLRequest(
                              url: WebUri.uri(Uri.parse(honarTicketController.startedUtl())),
                            ),
                            pullToRefreshController: honarTicketController.pullToRefreshController,
                            initialSettings: honarTicketController.settings,
                            onWebViewCreated: (InAppWebViewController inAppWebViewController) {
                              honarTicketController.webViewController = inAppWebViewController;
                            },
                            onPermissionRequest: (controller, request) async {
                              return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
                            },
                            onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                            shouldOverrideUrlLoading: (inAppWebViewController, navigationAction) async {
                              return await honarTicketController.overrodeUrlLoading(navigationAction);
                            },
                            onReceivedError: (controller, request, error) {
                              honarTicketController.pullToRefreshController.endRefreshing();
                            },
                            onProgressChanged: (controller, progress) {
                              honarTicketController.setProgress(progress);
                              if (progress == 100) {
                                honarTicketController.pullToRefreshController.endRefreshing();
                              }
                            },
                          ),
                          if (honarTicketController.progress < 100)
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

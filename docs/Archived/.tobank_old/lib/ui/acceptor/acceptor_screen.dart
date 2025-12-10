import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/acceptor/acceptor_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class AcceptorScreen extends StatelessWidget {
  final MenuItemData? menuItemData;

  const AcceptorScreen({super.key, this.menuItemData});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AcceptorController>(
      init: AcceptorController(),
      builder: (acceptorController) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: acceptorController.onBackPressed,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    AcceptorHeaderWidget(
                      title: menuItemData != null ? menuItemData!.title! :locale.gardesh_pay,
                      showSupportButton: false,
                      returnFunction: () {
                        acceptorController.onBackPressed(false);
                      },
                    ),
                    Expanded(
                      child: _buildWebViewContent(acceptorController),
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

  Widget _buildWebViewContent(AcceptorController acceptorController) {
    // For web platform, handle the X-Frame-Options issue
    if (kIsWeb) {
      return _buildWebPlatformView(acceptorController);
    } else {
      // For mobile platforms, use the standard InAppWebView
      return _buildMobilePlatformView(acceptorController);
    }
  }

  Widget _buildWebPlatformView(AcceptorController acceptorController) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    // On web platform, we'll show a message and a button to open in a new tab
    // This avoids the X-Frame-Options issue
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.security,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              locale.gardesh_pay_site_cannot_displayed_security,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              locale.to_view_site_press_button_open_new_page,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              html.window.open(acceptorController.acceptorUrl(), '_blank');
            },
            icon: Icon(Icons.open_in_new),
            label: Text(locale.open_gardesh_pay_in_new_tab),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePlatformView(AcceptorController acceptorController) {
    return Stack(
      children: [
        InAppWebView(
          key: acceptorController.webViewKey,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ),
          ),
          initialUrlRequest: URLRequest(
            url: WebUri.uri(Uri.parse(acceptorController.acceptorUrl())),
          ),
          pullToRefreshController: acceptorController.pullToRefreshController,
          initialSettings: acceptorController.settings,
          onWebViewCreated: (InAppWebViewController inAppWebViewController) {
            acceptorController.webViewController = inAppWebViewController;
          },
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
          },
          onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
          shouldOverrideUrlLoading: (inAppWebViewController, navigationAction) async {
            return await acceptorController.overrodeUrlLoading(navigationAction);
          },
          onReceivedError: (controller, request, error) {
            acceptorController.pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            acceptorController.setProgress(progress);
            if (progress == 100) {
              acceptorController.pullToRefreshController?.endRefreshing();
            }
          },
        ),
        if (acceptorController.progress < 100)
          const Align(
            child: CircularProgressIndicator(),
          )
        else
          const SizedBox(
            height: 0,
            width: 0,
          ),
      ],
    );
  }
}

class AcceptorHeaderWidget extends StatelessWidget {
  const AcceptorHeaderWidget({
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (hideBackButton != null)
                const SizedBox(
                  height: 32.0,
                  width: 32.0,
                )
              else
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  const EdgeInsets.only(left: 8.0),
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
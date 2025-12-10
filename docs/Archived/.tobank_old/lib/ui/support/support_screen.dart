import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/support/support_controller.dart';
import '../../util/app_util.dart';
import '../common/main_header_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<SupportController>(
            init: SupportController(),
            builder: (controller) {
              return Column(
                children: [
                  MainHeaderWidget(
                    title: locale.support,
                    showSupportButton: false,
                  ),
                  Expanded(
                    child: controller.userScript == null
                        ? Container(
                        constraints: const BoxConstraints(minHeight: 200),
                        child: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(context.theme.colorScheme.secondary))))
                        : InAppWebView(
                      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                        Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer(),
                        ),
                      ),
                      initialUrlRequest: URLRequest(
                        url: WebUri.uri(Uri.parse(controller.goftinoEmbedUrl())),
                      ),
                      initialSettings: controller.settings,
                      onWebViewCreated: (InAppWebViewController inAppWebViewController) {
                        controller.setWebViewController(inAppWebViewController);
                      },
                      onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                      onLoadStart: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                      initialUserScripts: UnmodifiableListView<UserScript>([controller.userScript!]),
                      onConsoleMessage: (controller, message) {
                        AppUtil.printResponse(message.message);
                      },
                      shouldOverrideUrlLoading: (inAppWebViewController, navigationAction) async {
                        return await controller.shouldOverrideUrlLoading(navigationAction);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/customer_club/customer_club_controller.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';

class CustomerClubWebViewPage extends StatelessWidget {
  const CustomerClubWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CustomerClubController>(builder: (customerClubController) {
      return Stack(
        children: [
          if (customerClubController.mainController.walletDetailData!.data!.havadary == true) ...[
            InAppWebView(
              key: customerClubController.webViewKey,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                ),
              ),
              initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(customerClubController.getUrl())),
              ),
              pullToRefreshController: customerClubController.pullToRefreshController,
              initialSettings: customerClubController.settings,
              onWebViewCreated: (InAppWebViewController inAppWebViewController) {
                customerClubController.webViewController = inAppWebViewController;
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
              },
              onReceivedError: (controller, request, error) {
                customerClubController.pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                customerClubController.setProgress(progress);
                if (progress == 100) {
                  customerClubController.pullToRefreshController?.endRefreshing();
                }
              },
            ),
            if (!kIsWeb && customerClubController.progress < 100)
              const Align(
                child: CircularProgressIndicator(),
              )
          ] else
            Column(
              children: [
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                           locale.dear_user_not_member_tobank_customer_club,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            AppUtil.getContents(customerClubController.otherItemData!.data!.data!.content!),
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0)
              ],
            ),
        ],
      );
    });
  }
}
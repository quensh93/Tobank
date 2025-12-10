import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '/widget/button/continue_button_widget.dart';

class BPMSConditionPage extends StatelessWidget {
  final Function callback;
  final InAppWebViewController? webViewController;
  final GlobalKey webViewKey;
  final int progress;
  final Function(int) setProgress;
  final String conditionUrl;
  final InAppWebViewSettings settings;
  final bool isLoading;

  const BPMSConditionPage({
    required this.callback,
    required this.webViewController,
    required this.webViewKey,
    required this.progress,
    required this.setProgress,
    required this.conditionUrl,
    required this.settings,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform:
                    InAppWebViewOptions(useShouldOverrideUrlLoading: false),
                  ),
                  key: webViewKey,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                      Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer(),
                      ),
                    ),
                  initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(conditionUrl)),
                  ),
                  initialSettings: settings,
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(action: PermissionResponseAction.GRANT, resources: []);
                  },
                  onProgressChanged: (controller, progress) {
                    print("🔴 web progress : $progress");
                    setProgress(progress);
                  },
                  onLoadStop: (InAppWebViewController inAppWebViewController, Uri? url) async {},
                ),
                if (!kIsWeb && progress < 100)
                  const Align(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          ContinueButtonWidget(
            callback: callback,
            isLoading: isLoading,
            buttonTitle: locale.next_step,
          ),
        ],
      ),
    );
  }
}

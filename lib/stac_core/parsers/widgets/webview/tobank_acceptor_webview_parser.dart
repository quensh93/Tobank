import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/helpers/logger.dart';
import '../../../registry/custom_component_registry.dart';

class TobankAcceptorWebViewModel {
  const TobankAcceptorWebViewModel({
    this.initialUrl = 'https://my.gardeshpay.ir/',
    this.onResumeUrl = 'https://my.gardeshpay.ir/wallet',
    this.paymentRedirectPrefix =
        'https://ipg.gardeshpay.ir/v1/provider/payment/redirect/',
  });

  final String initialUrl;
  final String onResumeUrl;
  final String paymentRedirectPrefix;

  factory TobankAcceptorWebViewModel.fromJson(Map<String, dynamic> json) {
    return TobankAcceptorWebViewModel(
      initialUrl: json['initialUrl'] as String? ?? 'https://my.gardeshpay.ir/',
      onResumeUrl:
          json['onResumeUrl'] as String? ?? 'https://my.gardeshpay.ir/wallet',
      paymentRedirectPrefix:
          json['paymentRedirectPrefix'] as String? ??
          'https://ipg.gardeshpay.ir/v1/provider/payment/redirect/',
    );
  }
}

class TobankAcceptorWebViewParser extends StacParser<TobankAcceptorWebViewModel> {
  const TobankAcceptorWebViewParser();

  @override
  String get type => 'tobankAcceptorWebView';

  @override
  TobankAcceptorWebViewModel getModel(Map<String, dynamic> json) =>
      TobankAcceptorWebViewModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankAcceptorWebViewModel model) {
    AppLogger.dc(
      LogCategory.stacWidget,
      'AcceptorWebView parse: initialUrl=${model.initialUrl}, onResumeUrl=${model.onResumeUrl}',
    );
    return _TobankAcceptorWebView(model: model);
  }
}

class TobankAcceptorBackActionParser
    extends StacActionParser<StacTobankAcceptorBackAction> {
  const TobankAcceptorBackActionParser();

  @override
  String get actionType => 'tobankAcceptorBack';

  @override
  StacTobankAcceptorBackAction getModel(Map<String, dynamic> json) =>
      const StacTobankAcceptorBackAction();

  @override
  FutureOr<void> onCall(
    BuildContext context,
    StacTobankAcceptorBackAction model,
  ) {
    return TobankAcceptorWebViewBridge.goBackOrPop(context);
  }
}

class TobankAcceptorWebViewBridge {
  static _TobankAcceptorWebViewState? _activeState;

  static void _register(_TobankAcceptorWebViewState state) {
    _activeState = state;
  }

  static void _unregister(_TobankAcceptorWebViewState state) {
    if (_activeState == state) {
      _activeState = null;
    }
  }

  static Future<void> goBackOrPop(BuildContext context) async {
    final handled = await _activeState?.goBackOrPop(context) ?? false;
    if (!handled && context.mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

class _TobankAcceptorWebView extends StatefulWidget {
  const _TobankAcceptorWebView({required this.model});

  final TobankAcceptorWebViewModel model;

  @override
  State<_TobankAcceptorWebView> createState() => _TobankAcceptorWebViewState();
}

class _TobankAcceptorWebViewState extends State<_TobankAcceptorWebView>
    with WidgetsBindingObserver {
  WebViewController? _controller;
  int _progress = 0;
  bool _isInBrowser = false;

  @override
  void initState() {
    super.initState();
    TobankAcceptorWebViewBridge._register(this);
    WidgetsBinding.instance.addObserver(this);

    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: _setProgress,
            onPageStarted: (_) => _setProgress(0),
            onPageFinished: (_) => _setProgress(100),
            onNavigationRequest: _handleNavigationRequest,
            onWebResourceError: (error) {
              AppLogger.ec(
                LogCategory.network,
                'Acceptor WebView resource error: code=${error.errorCode}, type=${error.errorType}, url=${error.url}, description=${error.description}',
              );
              _setProgress(100);
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.model.initialUrl));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    TobankAcceptorWebViewBridge._unregister(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isInBrowser || state != AppLifecycleState.resumed) return;

    Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _controller?.loadRequest(Uri.parse(widget.model.onResumeUrl));
      _isInBrowser = false;
    });
  }

  Future<bool> goBackOrPop(BuildContext context) async {
    final controller = _controller;
    if (controller != null && await controller.canGoBack()) {
      await controller.goBack();
      return true;
    }

    if (context.mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return true;
    }

    return false;
  }

  void _setProgress(int progress) {
    if (!mounted) return;
    setState(() {
      _progress = progress.clamp(0, 100);
    });
  }

  FutureOr<NavigationDecision> _handleNavigationRequest(
    NavigationRequest request,
  ) async {
    final uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.prevent;

    if (_isPdf(uri) || _isTelOrMail(uri)) {
      await _launchExternal(uri);
      return NavigationDecision.prevent;
    }

    if (request.url.startsWith(widget.model.paymentRedirectPrefix)) {
      await _launchExternal(uri);
      _isInBrowser = true;
      return NavigationDecision.prevent;
    }

    if (uri.host == 'my.gardeshpay.ir') {
      return NavigationDecision.navigate;
    }

    return NavigationDecision.prevent;
  }

  bool _isPdf(Uri uri) => uri.path.toLowerCase().endsWith('.pdf');

  bool _isTelOrMail(Uri uri) => uri.scheme == 'tel' || uri.scheme == 'mailto';

  Future<void> _launchExternal(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        unawaited(goBackOrPop(context));
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: kIsWeb
                ? _AcceptorWebIframe(url: widget.model.initialUrl)
                : (_controller != null
                      ? WebViewWidget(controller: _controller!)
                      : const SizedBox.shrink()),
          ),
          if (!kIsWeb && _progress < 100)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.transparent,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

class _AcceptorWebIframe extends StatelessWidget {
  const _AcceptorWebIframe({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      tagName: 'iframe',
      onElementCreated: (Object element) {
        final dynamic el = element;
        el.src = url;
        el.style.border = '0';
        el.style.width = '100%';
        el.style.height = '100%';
        el.style.backgroundColor = 'white';
      },
    );
  }
}

void registerTobankAcceptorWebViewParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankAcceptorWebViewParser(),
  );
  CustomComponentRegistry.instance.registerAction(
    const TobankAcceptorBackActionParser(),
  );
}


import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/helpers/logger.dart';
import '../../../registry/custom_component_registry.dart';

class TobankMegaGashtWebViewModel {
  const TobankMegaGashtWebViewModel({
    this.initialUrl = 'https://on.megagasht.com/',
    this.onResumeUrl = 'https://on.megagasht.com/Panel-Dashboard.bc',
  });

  final String initialUrl;
  final String onResumeUrl;

  factory TobankMegaGashtWebViewModel.fromJson(Map<String, dynamic> json) {
    return TobankMegaGashtWebViewModel(
      initialUrl: json['initialUrl'] as String? ?? 'https://on.megagasht.com/',
      onResumeUrl:
          json['onResumeUrl'] as String? ??
          'https://on.megagasht.com/Panel-Dashboard.bc',
    );
  }
}

class TobankMegaGashtWebViewParser
    extends StacParser<TobankMegaGashtWebViewModel> {
  const TobankMegaGashtWebViewParser();

  @override
  String get type => 'tobankMegaGashtWebView';

  @override
  TobankMegaGashtWebViewModel getModel(Map<String, dynamic> json) =>
      TobankMegaGashtWebViewModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankMegaGashtWebViewModel model) {
    AppLogger.dc(
      LogCategory.stacWidget,
      'MegaGashtWebView parse: initialUrl=${model.initialUrl}, onResumeUrl=${model.onResumeUrl}',
    );
    return _TobankMegaGashtWebView(model: model);
  }
}

class TobankMegaGashtBackActionParser
    extends StacActionParser<StacTobankMegaGashtBackAction> {
  const TobankMegaGashtBackActionParser();

  @override
  String get actionType => 'tobankMegaGashtBack';

  @override
  StacTobankMegaGashtBackAction getModel(Map<String, dynamic> json) =>
      const StacTobankMegaGashtBackAction();

  @override
  FutureOr<void> onCall(
    BuildContext context,
    StacTobankMegaGashtBackAction model,
  ) {
    AppLogger.dc(
      LogCategory.stacAction,
      'MegaGashtBackAction: requested webview back-or-pop',
    );
    return TobankMegaGashtWebViewBridge.goBackOrPop(context);
  }
}

class TobankMegaGashtWebViewBridge {
  static _TobankMegaGashtWebViewState? _activeState;

  static void register(_TobankMegaGashtWebViewState state) {
    AppLogger.dc(
      LogCategory.stacWidget,
      'MegaGashtWebViewBridge: registered active webview state',
    );
    _activeState = state;
  }

  static void unregister(_TobankMegaGashtWebViewState state) {
    if (_activeState == state) {
      AppLogger.dc(
        LogCategory.stacWidget,
        'MegaGashtWebViewBridge: unregistered active webview state',
      );
      _activeState = null;
    }
  }

  static Future<void> goBackOrPop(BuildContext context) async {
    final handled = await _activeState?.goBackOrPop(context) ?? false;
    AppLogger.dc(
      LogCategory.stacNavigation,
      'MegaGashtBackAction: activeStateHandled=$handled, contextMounted=${context.mounted}',
    );
    if (!handled && context.mounted && Navigator.of(context).canPop()) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        'MegaGashtBackAction: fallback Navigator.pop()',
      );
      Navigator.of(context).pop();
    }
  }
}

class _TobankMegaGashtWebView extends StatefulWidget {
  const _TobankMegaGashtWebView({required this.model});

  final TobankMegaGashtWebViewModel model;

  @override
  State<_TobankMegaGashtWebView> createState() =>
      _TobankMegaGashtWebViewState();
}

class _TobankMegaGashtWebViewState extends State<_TobankMegaGashtWebView>
    with WidgetsBindingObserver {
  WebViewController? _controller;
  int _progress = 0;
  int _lastLoggedProgressBucket = -1;
  bool _shouldLaunchBrowser = false;
  bool _isInBrowser = false;

  @override
  void initState() {
    super.initState();
    TobankMegaGashtWebViewBridge.register(this);
    WidgetsBinding.instance.addObserver(this);

    AppLogger.ic(
      LogCategory.stacNavigation,
      'MegaGashtWebView init: initialUrl=${widget.model.initialUrl}',
    );

    if (!kIsWeb) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: _setProgress,
            onPageStarted: _handlePageStarted,
            onPageFinished: _handlePageFinished,
            onNavigationRequest: _handleNavigationRequest,
            onUrlChange: _handleUrlChange,
            onHttpError: _handleHttpError,
            onWebResourceError: _handleWebResourceError,
          ),
        )
        ..loadRequest(Uri.parse(widget.model.initialUrl));
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView request initial: GET ${widget.model.initialUrl}',
      );
    } else {
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView web iframe request: GET ${widget.model.initialUrl}',
      );
    }
  }

  @override
  void dispose() {
    AppLogger.dc(LogCategory.stacWidget, 'MegaGashtWebView dispose');
    WidgetsBinding.instance.removeObserver(this);
    TobankMegaGashtWebViewBridge.unregister(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isInBrowser || state != AppLifecycleState.resumed) return;

    AppLogger.ic(
      LogCategory.stacNavigation,
      'MegaGasht lifecycle resumed after external browser; reloading ${widget.model.onResumeUrl}',
    );

    Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView request resume: GET ${widget.model.onResumeUrl}',
      );
      _controller?.loadRequest(Uri.parse(widget.model.onResumeUrl));
      _isInBrowser = false;
    });
  }

  Future<bool> goBackOrPop(BuildContext context) async {
    final controller = _controller;
    if (controller != null && await controller.canGoBack()) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        'MegaGasht back: webview canGoBack=true, calling goBack()',
      );
      await controller.goBack();
      return true;
    }

    if (context.mounted && Navigator.of(context).canPop()) {
      AppLogger.dc(
        LogCategory.stacNavigation,
        'MegaGasht back: webview canGoBack=false, popping page',
      );
      Navigator.of(context).pop();
      return true;
    }

    AppLogger.wc(
      LogCategory.stacNavigation,
      'MegaGasht back: no webview history and Navigator cannot pop',
    );
    return false;
  }

  void _setProgress(int progress) {
    if (!mounted) return;
    final nextProgress = progress.clamp(0, 100);
    final bucket = nextProgress == 100 ? 100 : nextProgress ~/ 25;
    if (bucket != _lastLoggedProgressBucket) {
      _lastLoggedProgressBucket = bucket;
      AppLogger.dc(
        LogCategory.network,
        'MegaGasht WebView progress: $nextProgress%',
      );
    }
    setState(() {
      _progress = nextProgress;
    });
  }

  void _handlePageStarted(String url) {
    AppLogger.ic(LogCategory.network, 'MegaGasht WebView load started: $url');
    _setProgress(0);
    _updateShouldLaunchBrowser(Uri.tryParse(url));
  }

  void _handlePageFinished(String url) {
    AppLogger.ic(LogCategory.network, 'MegaGasht WebView load finished: $url');
    _setProgress(100);
    unawaited(_logLoadedPageSnapshot(url));
  }

  Future<void> _logLoadedPageSnapshot(String finishedUrl) async {
    final controller = _controller;
    if (controller == null) return;

    try {
      final currentUrl = await controller.currentUrl();
      final title = await controller.getTitle();
      final readyState = await controller.runJavaScriptReturningResult(
        'document.readyState',
      );

      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView page snapshot: finishedUrl=$finishedUrl, currentUrl=$currentUrl, title=$title, readyState=$readyState',
        null,
        null,
        true,
      );
    } catch (e, stackTrace) {
      AppLogger.wc(
        LogCategory.network,
        'MegaGasht WebView page snapshot failed: finishedUrl=$finishedUrl',
        e,
        stackTrace,
      );
    }
  }

  void _handleUrlChange(UrlChange change) {
    AppLogger.dc(
      LogCategory.network,
      'MegaGasht WebView url changed: ${change.url}',
    );
    _updateShouldLaunchBrowser(Uri.tryParse(change.url ?? ''));
  }

  void _handleHttpError(HttpResponseError error) {
    final requestUrl = error.request?.uri.toString();
    final responseUrl = error.response?.uri.toString();
    final statusCode = error.response?.statusCode;
    final headers = error.response?.headers;

    AppLogger.wc(
      LogCategory.network,
      'MegaGasht WebView HTTP error: status=$statusCode, request=$requestUrl, response=$responseUrl, headers=$headers',
      null,
      null,
      true,
    );
  }

  void _handleWebResourceError(WebResourceError error) {
    AppLogger.ec(
      LogCategory.network,
      'MegaGasht WebView resource error: code=${error.errorCode}, type=${error.errorType}, url=${error.url}, description=${error.description}',
    );
    _setProgress(100);
  }

  FutureOr<NavigationDecision> _handleNavigationRequest(
    NavigationRequest request,
  ) async {
    AppLogger.ic(
      LogCategory.network,
      'MegaGasht WebView navigation request: url=${request.url}, isMainFrame=${request.isMainFrame}',
    );

    final uri = Uri.tryParse(request.url);
    if (uri == null) {
      AppLogger.wc(
        LogCategory.network,
        'MegaGasht WebView navigation prevented: invalid url=${request.url}',
      );
      return NavigationDecision.prevent;
    }

    if (_isInvoicePdf(uri)) {
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView invoice PDF intercepted: $uri',
      );
      await _launchExternal(uri, reason: 'invoicePdf');
      return NavigationDecision.prevent;
    }

    if (_isTelOrMail(uri)) {
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView tel/mail intercepted: $uri',
      );
      await _launchExternal(uri);
      return NavigationDecision.prevent;
    }

    if (uri.host == 'on.megagasht.com') {
      _updateShouldLaunchBrowser(uri);
      AppLogger.dc(
        LogCategory.network,
        'MegaGasht WebView navigation allowed: same host, shouldLaunchBrowser=$_shouldLaunchBrowser, url=$uri',
      );
      return NavigationDecision.navigate;
    }

    if (_shouldLaunchBrowser) {
      AppLogger.ic(
        LogCategory.network,
        'MegaGasht WebView external launch after final page: $uri',
      );
      await _launchExternal(uri, reason: 'postFinalExternal');
      _isInBrowser = true;
    } else {
      AppLogger.wc(
        LogCategory.network,
        'MegaGasht WebView navigation prevented: external url without final-page flag, url=$uri',
      );
    }

    return NavigationDecision.prevent;
  }

  bool _isInvoicePdf(Uri uri) => uri.path.contains('InvoicePdf');

  bool _isTelOrMail(Uri uri) => uri.scheme == 'tel' || uri.scheme == 'mailto';

  Future<void> _launchExternal(Uri uri, {String reason = 'external'}) async {
    AppLogger.ic(
      LogCategory.network,
      'MegaGasht external launch request: reason=$reason, url=$uri',
    );
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    AppLogger.ic(
      LogCategory.network,
      'MegaGasht external launch response: launched=$launched, reason=$reason, url=$uri',
    );
  }

  void _updateShouldLaunchBrowser(Uri? uri) {
    if (uri == null) return;

    final nextValue = _finalUrls.contains(uri.toString());
    if (nextValue != _shouldLaunchBrowser) {
      AppLogger.ic(
        LogCategory.stacNavigation,
        'MegaGasht final-url flag changed: shouldLaunchBrowser=$nextValue, url=$uri',
      );
    }
    _shouldLaunchBrowser = nextValue;
  }

  static const Set<String> _finalUrls = {
    'https://on.megagasht.com/Client_Final_Oneway.bc',
    'https://on.megagasht.com/Client_Final_btb.bc',
    'https://on.megagasht.com/Client_Final_Hotel.bc',
    'https://on.megagasht.com/Client_Final_fh.bc',
    'https://on.megagasht.com/Client_Final_Tour.bc',
    'https://on.megagasht.com/Client_Final_Insurance.bc',
  };

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
                ? _MegaGashtWebIframe(url: widget.model.initialUrl)
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

class _MegaGashtWebIframe extends StatelessWidget {
  const _MegaGashtWebIframe({required this.url});

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

void registerTobankMegaGashtWebViewParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankMegaGashtWebViewParser(),
  );
  CustomComponentRegistry.instance.registerAction(
    const TobankMegaGashtBackActionParser(),
  );
}


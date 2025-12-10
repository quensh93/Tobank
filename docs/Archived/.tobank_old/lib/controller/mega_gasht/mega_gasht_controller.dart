import 'dart:async';
import 'dart:isolate';
import 'package:universal_io/io.dart';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '/controller/main/main_controller.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/file_util.dart';

class MegaGashtController extends GetxController with WidgetsBindingObserver {
  MainController mainController = Get.find();

  bool isInBrowser = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    useShouldOverrideUrlLoading: true,
  );

  late PullToRefreshController? pullToRefreshController;
  int progress = 0;

  bool shouldLaunchBrowser = false;
  final ReceivePort _port = ReceivePort();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // Only initialize pull-to-refresh controller on non-web platforms
    if (!kIsWeb) {
      try {
        pullToRefreshController = PullToRefreshController(
          settings: PullToRefreshSettings(
            color: Colors.blue,
          ),
          onRefresh: () async {
            if (Platform.isAndroid) {
              webViewController?.reload();
            } else if (Platform.isIOS) {
              webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
            }
          },
        );
      } catch (e) {
        print("Error initializing PullToRefreshController: $e");
      }

      // Only use IsolateNameServer on non-web platforms
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {});

      // Initialize FlutterDownloader only on non-web platforms
      FlutterDownloader.registerCallback(downloadCallback);
    } else {
      // Web-specific initialization here if needed
      pullToRefreshController = null;
    }
  }

  @override
  void onClose() {
    if (!kIsWeb) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.onClose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, progress]);
  }

  /// Handles changes in the app's lifecycle state.
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (isInBrowser) {
      if (state == AppLifecycleState.resumed) {
        Timer(Constants.duration200, () {
          webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri.uri(Uri.parse(getOnResumeUrl()))));
        });
        isInBrowser = false;
      }
    }
  }

  String baseUrl() {
    return 'https://on.megagasht.com/';
  }

  String getOnResumeUrl() {
    return 'https://on.megagasht.com/Panel-Dashboard.bc';
  }

  /// Overrides the default behavior for handling URL loading in the WebView.
  Future<NavigationActionPolicy> overrideUrlLoading(NavigationAction navigationAction) async {
    final uri = navigationAction.request.url!;
    if (uri.path.contains('InvoicePdf')) {
      await downloadFile(
        uri.toString(),
      );
      return NavigationActionPolicy.CANCEL;
    } else if (uri.host == 'on.megagasht.com') {
      shouldLaunchBrowser = false;
      return NavigationActionPolicy.ALLOW;
    } else if (shouldLaunchBrowser) {
      AppUtil.launchInBrowser(url: uri.toString());
      isInBrowser = true;
      return NavigationActionPolicy.CANCEL;
    } else if (uri.toString().contains('tel:') || uri.toString().contains('mailto:')) {
      AppUtil.launchInBrowser(url: uri.toString());
      return NavigationActionPolicy.CANCEL;
    } else {
      return NavigationActionPolicy.CANCEL;
    }
  }

  /// Handles the back button press event.
  Future<void> onBackPressed(bool didPop) async {
    if (didPop) {
      return;
    }
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
    } else {
      final NavigatorState navigator = Navigator.of(Get.context!);
      navigator.pop();
    }
  }

  void setProgress(int progress) {
    this.progress = progress;
    update();
  }

  void onUpdateVisitedHistory(Uri? url) {
    if (url.toString() == 'https://on.megagasht.com/Client_Final_Oneway.bc' ||
        url.toString() == 'https://on.megagasht.com/Client_Final_btb.bc' ||
        url.toString() == 'https://on.megagasht.com/Client_Final_Hotel.bc' ||
        url.toString() == 'https://on.megagasht.com/Client_Final_fh.bc' ||
        url.toString() == 'https://on.megagasht.com/Client_Final_Tour.bc' ||
        url.toString() == 'https://on.megagasht.com/Client_Final_Insurance.bc') {
      shouldLaunchBrowser = true;
    }
  }

  /// Downloads a file from the given URL.
  Future<void> downloadFile(String url, [String? suggestedFilename]) async {
    var hasStoragePermission = await Permission.storage.isGranted;
    if (!hasStoragePermission) {
      final status = await Permission.storage.request();
      hasStoragePermission = status.isGranted;
    }
    if (hasStoragePermission) {
      await FlutterDownloader.enqueue(
          url: url,
          headers: {},
          savedDir: FileUtil().tempDir.path,
          saveInPublicStorage: true,
          fileName: suggestedFilename ?? 'InvoicePdf-${DateTime.now()}.pdf');
    }
  }
}

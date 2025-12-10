import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../main/main_controller.dart';

class PayBrowserController extends GetxController {
  bool isEnable = false;

  PayBrowserController({
    required this.url,
    required this.returnDataFunction,
  });

  MainController mainController = Get.find();

  final String url;
  final Function? returnDataFunction;
  StreamSubscription? _sub;
  Timer? timer;
  int counter = 10;

  @override
  Future<void> onInit() async {
    await initPlatformStateForStringUniLinks();
    if (url.isNotEmpty) {
      _startTimer();
      mainController.getToPayment = true;
      mainController.update();
      AppUtil.launchInBrowser(url: url);
    }
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _sub?.cancel();
    super.onClose();
  }

  /// An implementation using a [String] link
  Future<void> initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    final appLinks = AppLinks();
    _sub = appLinks.uriLinkStream.listen((Uri? link) {
      if (link != null) {
        _handleReturnedLink(link);
      }
    }, onError: (Object err) {
      AppUtil.printResponse('error:$err');
    });
  }

  void _handleReturnedLink(Uri link) {
    final uri = link;
    AppUtil.printResponse(uri.toString());
    Timer(Constants.duration500, () {
      returnDataFunction!();
    });
  }

  /// Start the timer with an initial counter value of 60 seconds.
  void _startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (counter < 1) {
        isEnable = true;
        update();
        timer.cancel();
      } else {
        counter = counter - 1;
      }
    });
  }
}

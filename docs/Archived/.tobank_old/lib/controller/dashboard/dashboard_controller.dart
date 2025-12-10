import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/tobank_services/tobank_services_controller.dart';
import '../../model/common/banner_ids_data.dart';
import '../../model/notification/response/notification_message_data.dart';
import '../../model/other/app_version_data.dart';
import '../../service/app_version_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/dashboard_screen/widget/check_login_bottom_sheet.dart';
import '../../ui/facility/facility_screen.dart';
import '../../ui/launcher/launcher_screen.dart';
import '../../ui/tobank_services/tobank_services_screen.dart';
import '../../util/app_util.dart';
import '../../util/application_info_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/firebase_notification_handler.dart';
import '../facility/facility_controller.dart';
import '../main/main_controller.dart';

class DashboardController extends GetxController with WidgetsBindingObserver {
  MainController mainController = Get.find();
  static const String eventName = 'Dashboard_Click_Event';
  int currentIndex = 0;
  PageController pageController = PageController();
  bool _isDialogOpen = false;
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String homeEventName = 'Home_Click_Event';
  bool isLoading = true;

  StreamSubscription<List<ConnectivityResult>>? subscription;
  late AppVersionData appVersionData;

  BannerIdsData? bannerIdsData;

  int selectedTab = 0;

  bool appExited = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initNotification();
    _checkAppVersion();
    AppUtil.checkCertificateExpire(certificateCheckType: CertificateCheckType.dashboard);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (mainController.getToBackgroundAt != null) {
        final Duration timeUntilResume = DateTime.now().difference(mainController.getToBackgroundAt!);
        if (timeUntilResume >
                Duration(
                    seconds: mainController.getToPayment
                        ? mainController.paymentTimeForRecheckPass
                        : mainController.backgroundTimeForRecheckPass!) ||
            appExited) {
          if (!mainController.isOpenCheckLoginBottomSheet) {
            _showCheckLoginBottomSheet();
          }
          appExited = false;
          update();
        }
        mainController.getToPayment = false;
        mainController.getToBackgroundAt = null;
        mainController.update();
      }
    } else if (state == AppLifecycleState.paused) {
      mainController.getToBackgroundAt = DateTime.now();
      mainController.update();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _checkAppVersion() {
    if (mainController.noConnection) {
      subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
        if (result.isNotEmpty && result[0] != ConnectivityResult.none) {
          mainController.noConnection = false;
          _getAppVersionRequest();
        }
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    subscription?.cancel();
    Timer(Constants.duration200, () {
      if (mainController.overlayContext != null) {
        OverlaySupportEntry.of(mainController.overlayContext!)?.dismiss();
      }
    });
    Get.closeAllSnackbars();
  }

  /// Retrieves the latest app version information from the server
  void _getAppVersionRequest() {
    final String platform = Platform.isAndroid ? 'redesign-android' : 'redesign-ios';
    AppVersionServices.getAppVersion(platform).then((result) {
      switch (result) {
        case Success(value: (final AppVersionData response, int _)):
          appVersionData = response;
          _checkVersion();
        case Failure(exception: ApiException _):
          break;
      }
    });
  }

  void _checkVersion() {
    if (AppUtil.getVersionCode(appVersionData.data!.app!.version!) >
        AppUtil.getVersionCode(ApplicationInfoUtil().appVersion)) {
      if ((appVersionData.data!.app!.forcingUpdate != null && appVersionData.data!.app!.forcingUpdate!) ||
          (appVersionData.data!.app!.showUpdate != null && appVersionData.data!.app!.showUpdate!)) {
        _restartApp();
      }
    }
  }

  ///
  /// create new instance of [FirebaseNotifications] with user token
  Future<void> _initNotification() async {
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
        'notification-id-gp-notif', 'TOBANK',
        description: 'TOBANK Channel', importance: Importance.max);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
    /// todo: add later to pwa
    // FirebaseNotifications((message) {
    //   showNotificationDialog(message.data);
    // }).setUpFirebase();
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  /// parse data fields from [message] parameter as [NotificationMessageData]
  /// instance
  ///
  /// if dialog is open, first close it & show new one
  void showNotificationDialog(Map<String, dynamic> message) {
    try {
      final NotificationMessageData data = NotificationMessageData();
      data.header = message['header'];
      data.description = message['description'];
      data.type = message['type'];
      data.id = message['id'];
      if (_isDialogOpen) {
        Get.back();
        Timer(Constants.duration200, () {
          _showNewNotificationDialog(data);
        });
      } else {
        _showNewNotificationDialog(data);
      }
    } on Exception catch (error) {
      AppUtil.printResponse('error:$error');
    }
  }

  //// Show notification dialog with data that provide from firebase messaging
  void _showNewNotificationDialog(NotificationMessageData data) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    _isDialogOpen = true;
    DialogUtil.showDialogNotification(
      context: Get.context!,
      header: data.header ?? '',
      description: data.description ?? '',
      positiveMessage: locale.close,
      positiveFunction: () {
        _isDialogOpen = false;
        Get.back();
      },
    ).then((response) {
      _isDialogOpen = false;
    });
  }

  Future<void> onBackPressed(bool didPop, result) async {
    if (didPop) {
      return;
    }
    if (pageController.page != 0) {
      currentIndex = 0;
      update();
      pageController.animateToPage(currentIndex, duration: Constants.duration100, curve: Curves.ease);
    } else {
      final bool? result = await DialogUtil.showExitMessageDialog(Get.context!);
      if (result == true) {
        appExited = result ?? false;
        update();
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }
  }

  Future<void> showFacilityScreen() async {
    Get.to(
      () => const FacilityScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FacilityController());
      }),
    );
  }

  void _restartApp() {
    Get.offAll(() => const LauncherScreen());
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
    AppUtil.gotoPageController(pageController: pageController, page: currentIndex, isClosed: isClosed);
  }

  void showTobankServicesScreen() {
    Get.to(
      () => const TobankServicesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TobankServicesController());
      }),
    );
  }

  Future<void> _showCheckLoginBottomSheet() async {
    mainController.isOpenCheckLoginBottomSheet = true;
    mainController.update();
    await showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const CheckLoginBottomSheet(),
      ),
    );
    mainController.isOpenCheckLoginBottomSheet = false;
    mainController.update();
  }
}

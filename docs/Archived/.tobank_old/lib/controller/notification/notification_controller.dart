import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/notification/request/notification_set_read_request_data.dart';
import '../../model/notification/response/list_notification_data.dart';
import '../../service/core/api_core.dart';
import '../../service/notification_services.dart';
import '../../ui/notification/widget/notification_detail_bottom_sheet.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class NotificationController extends GetxController {
  MainController mainController = Get.find();
  List<NotificationData> notificationNormalDataList = [];
  List<NotificationData> notificationUpdateDataList = [];
  PageController pageController = PageController();
  NotificationType currentNotificationType = NotificationType.normal;
  PageController updatePageController = PageController();
  PageController normalPageController = PageController();
  bool isLoading = false;
  bool isDeleteLoading = false;

  String errorTitle = '';

  bool hasError = false;

  @override
  void onInit() {
    getNotificationsRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void _nextPage(int page) {
    if (currentNotificationType == NotificationType.normal) {
      AppUtil.changePageController(pageController: normalPageController, page: page, isClosed: isClosed);
    } else {
      AppUtil.changePageController(pageController: updatePageController, page: page, isClosed: isClosed);
    }
  }

  void _nextPageMain(int page) {
    AppUtil.changePageController(pageController: pageController, page: page, isClosed: isClosed);
  }

  /// Get data of [ListNotificationData] from server request
  Future<void> getNotificationsRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    String type;
    String category;
    if (Platform.isAndroid) {
      type = 'android';
    } else {
      type = 'ios';
    }
    if (currentNotificationType == NotificationType.normal) {
      category = 'notify';
    } else {
      category = 'app-update';
    }

    hasError = false;
    isLoading = true;
    update();

    NotificationServices.getNotificationRequest(
      type: type,
      category: category,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ListNotificationData response, int _)):
          if (currentNotificationType == NotificationType.normal) {
            notificationNormalDataList = response.data ?? [];
          } else {
            notificationUpdateDataList = response.data ?? [];
          }
          update();
          _nextPage(1);
        case Failure(exception: final ApiException apiException):
          hasError = true;
          errorTitle = apiException.displayMessage;
          update();
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setNotificationType(NotificationType notificationType) {
    currentNotificationType = notificationType;
    update();
    if (notificationType == NotificationType.normal) {
      _nextPageMain(0);
    } else {
      _nextPageMain(1);
    }
    Timer(Constants.duration200, () {
      getNotificationsRequest();
    });
  }

  void showNotificationDataBottomSheet({
    required NotificationData notificationData,
  }) {
    if (isClosed) {
      return;
    }
    if (!notificationData.isRead!) {
      _setReadNotificationRequest(notificationData);
    }
    showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: NotificationDetailBottomSheet(
          notificationData: notificationData,
          notificationType: currentNotificationType,
          deleteDataFunction: (notificationData) {
            showDeleteNotificationDialog(notificationData);
          },
        ),
      ),
    );
  }

  void _setReadNotificationRequest(NotificationData notificationData) {
    final NotificationSetReadRequest notificationSetReadRequest = NotificationSetReadRequest(isRead: true);

    NotificationServices.notificationReadRequest(
      notificationId: notificationData.id!,
      notificationSetReadRequest: notificationSetReadRequest,
    ).then((result) {
      switch (result) {
        case Success(value: _):
          _updateIsRead(notificationData);
        case Failure(exception: _):
          break;
      }
    });
  }

  void _updateIsRead(NotificationData notificationData) {
    if (currentNotificationType == NotificationType.normal) {
      int index = 0;
      for (final NotificationData item in notificationNormalDataList) {
        if (item.id == notificationData.id) {
          if( notificationNormalDataList[index].isRead==null || notificationNormalDataList[index].isRead==false ){
            mainController.walletDetailData!.data!.unreadMessageCount = mainController.walletDetailData!.data!.unreadMessageCount! - 1;
          }
          notificationNormalDataList[index].isRead = true;

          break;
        }
        index++;
      }
    } else {
      int index = 0;
      for (final NotificationData item in notificationUpdateDataList) {
        if (item.id == notificationData.id) {
          if( notificationUpdateDataList[index].isRead==null || notificationUpdateDataList[index].isRead==false ){
            mainController.walletDetailData!.data!.unreadMessageCount = mainController.walletDetailData!.data!.unreadMessageCount! - 1;
          }
          notificationUpdateDataList[index].isRead = true;
          break;
        }
        index++;
      }
    }
    update();
  }

  void showDeleteNotificationDialog(NotificationData notificationData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.delete_notification,
        description: locale.delete_notification_confirmation,
        positiveMessage: locale.delete,
        negativeMessage: locale.cancel,
        positiveFunction: () {
          Get.back(closeOverlays: true);
          _deleteNotificationRequest(notificationData);
        },
        negativeFunction: () {
          Get.back(closeOverlays: true);
        });
  }

  void _deleteNotificationRequest(NotificationData notificationData) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isDeleteLoading = true;
    update();

    NotificationServices.deleteNotificationRequest(
      notificationData: notificationData,
    ).then((result) {
      isDeleteLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          SnackBarUtil.showSuccessSnackBar(locale.notification_deleted_successfully);
          _nextPage(0);
          getNotificationsRequest();
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}

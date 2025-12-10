import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/notification/response/list_notification_data.dart';
import '../../../util/enums_constants.dart';
import '../../../util/persian_date.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';

class NotificationDetailBottomSheet extends StatelessWidget {
  const NotificationDetailBottomSheet({
    required this.notificationData,
    required this.notificationType,
    required this.deleteDataFunction,
    super.key,
  });

  final NotificationData notificationData;
  final NotificationType notificationType;
  final Function(NotificationData notificationData) deleteDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    final PersianDate persianDate = PersianDate();
    final String? persianDateString =
        persianDate.parseToFormat(notificationData.date.toString().split('+')[0], 'd MM yyyy - HH:nn');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  notificationData.title ?? '',
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  notificationData.description ?? '',
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  notificationData.message ?? '',
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  persianDateString ?? '',
                  style: const TextStyle(
                    color: ThemeUtil.hintColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    Get.back();
                  },
                  isLoading: false,
                  buttonTitle:locale.return_,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

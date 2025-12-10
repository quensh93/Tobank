import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/notification/response/list_notification_data.dart';
import '../../../util/persian_date.dart';
import '../../../util/theme/theme_util.dart';

class NotificationUpdateItemWidget extends StatelessWidget {
  const NotificationUpdateItemWidget({
    required this.notificationData,
    required this.returnDataFunction,
    super.key,
  });

  final NotificationData notificationData;
  final Function(NotificationData notificationData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    final PersianDate persianDate = PersianDate();
    final String persianDateString =
        persianDate.parseToFormat(notificationData.date.toString().split('+')[0], 'd MM yyyy - HH:nn');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          returnDataFunction(notificationData);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notificationData.isRead!)
                    Container()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 8.0,
                          width: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                      ],
                    ),
                  Flexible(
                    child: Text(
                      notificationData.title ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                notificationData.description ?? '',
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
                persianDateString,
                style: TextStyle(
                  color: ThemeUtil.textSubtitleColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

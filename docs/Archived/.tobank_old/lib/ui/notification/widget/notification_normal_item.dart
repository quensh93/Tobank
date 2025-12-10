import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../model/notification/response/list_notification_data.dart';
import '../../../util/persian_date.dart';
import '../../../util/theme/theme_util.dart';

class NotificationNormalItemWidget extends StatelessWidget {
  const NotificationNormalItemWidget({
    required this.notificationData,
    required this.returnDataFunction,
    required this.deleteDataFunction,
    super.key,
  });

  final NotificationData notificationData;
  final Function(NotificationData notificationData) returnDataFunction;
  final Function(NotificationData notificationData) deleteDataFunction;

  @override
  Widget build(BuildContext context) {
    final PersianDate persianDate = PersianDate();
    final String? persianDateString =
        persianDate.parseToFormat(notificationData.date.toString().split('+')[0], 'd MM yyyy - HH:nn');
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(8.0)),
            onPressed: (context) {
              deleteDataFunction(notificationData);
            },
            backgroundColor: context.theme.colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
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
                  children: [
                    if (notificationData.isRead!)
                      Container()
                    else
                      Row(
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
                          )
                        ],
                      ),
                    Flexible(
                      child: Text(
                        notificationData.title ?? '',
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
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
                  persianDateString ?? '',
                  style: const TextStyle(
                    color: ThemeUtil.hintColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

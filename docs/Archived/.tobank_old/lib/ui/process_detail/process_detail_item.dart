import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/bpms/response/process_detail_response_data.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/theme/theme_util.dart';
import '../common/key_value_widget.dart';

class ProcessDetailItem extends StatelessWidget {
  const ProcessDetailItem({
    required this.processTask,
    super.key,
  });

  final ProcessTask processTask;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      processTask.name ?? '',
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: processTask.deleteReason == 'completed'
                          ? ThemeUtil.successColor.withOpacity(0.15)
                          : context.theme.colorScheme.secondary.withOpacity(0.15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _getTaskStatus(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: processTask.deleteReason == 'completed'
                              ? ThemeUtil.successColor
                              : context.theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                KeyValueWidget(
                    keyString: locale.creation_time,
                    valueString: DateConverterUtil.getJalaliDateTimeFromTimestamp(processTask.startTime!)),
                if (processTask.deleteReason != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      KeyValueWidget(
                          keyString: locale.completion_time,
                          valueString: DateConverterUtil.getJalaliDateTimeFromTimestamp(processTask.endTime!)),
                      if (processTask.variables?.description != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            const SizedBox(height: 16.0),
                            Text(
                              locale.description,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              processTask.variables!.description!,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            )
                          ],
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTaskStatus() {
    if (processTask.deleteReason == 'completed') {
//locale
      final locale = AppLocalizations.of(Get.context!)!;
      return locale.task_status_completed ;
    } else {
//locale
      final locale = AppLocalizations.of(Get.context!)!;
      return locale.task_status_pending;
    }
  }
}

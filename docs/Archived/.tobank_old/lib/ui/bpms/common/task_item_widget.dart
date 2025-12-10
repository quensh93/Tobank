import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    required this.taskListItem,
    required this.selectedTaskListItem,
    required this.isLoading,
    required this.startTaskFunction,
    super.key,
  });

  final bool isLoading;
  final Task taskListItem;
  final Task? selectedTaskListItem;
  final Function startTaskFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                taskListItem.name ?? '',
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      locale.waiting_to_complete_status,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!isLoading) {
                      startTaskFunction();
                    }
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: selectedTaskListItem != null && selectedTaskListItem!.id == taskListItem.id && isLoading
                      ? SpinKitFadingCircle(
                          itemBuilder: (_, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.theme.iconTheme.color,
                              ),
                            );
                          },
                          size: 24.0,
                        )
                      : Row(
                          children: [
                            Text(
                              locale.complete,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: context.theme.iconTheme.color,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Card(
                              margin: EdgeInsets.zero,
                              elevation: 1,
                              shadowColor: Colors.transparent,
                              child: SvgIcon(
                                SvgIcons.arrowLeft,
                                colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

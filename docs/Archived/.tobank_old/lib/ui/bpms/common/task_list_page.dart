import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../controller/bpms/task_list_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import 'task_item_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    required this.taskListControllerTag,
    super.key,
    this.description,
    this.showBackButton = false,
    this.showBottomSheet = false,
    this.returnBackFunction,
  });

  final String taskListControllerTag;
  final String? description;
  final bool showBackButton;
  final bool showBottomSheet;
  final Function? returnBackFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<TaskListController>(
        init: Get.find<TaskListController>(tag: taskListControllerTag),
        global: false,
        autoRemove: false,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              if (showBottomSheet)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 36,
                            height: 4,
                            decoration: BoxDecoration(
                                color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                  ],
                )
              else
                Container(),
              if (description != null)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        description ?? '',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                )
              else
                Container(),
              Expanded(
                child: controller.taskList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                            height: 180,
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            locale.no_open_process,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        itemBuilder: (context, index) {
                          return TaskItemWidget(
                            taskListItem: controller.taskList[index],
                            isLoading: controller.isLoading,
                            startTaskFunction: () {
                              if (!controller.isLoading) {
                                controller.getTaskDataRequestRequest(controller.taskList[index]);
                              }
                            },
                            selectedTaskListItem: controller.selectedTaskListItem,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16.0,
                          );
                        },
                        itemCount: controller.taskList.length),
              ),
              const SizedBox(
                height: 8.0,
              ),
              if (showBackButton)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ContinueButtonWidget(
                        callback: () {
                          if (returnBackFunction != null) {
                            returnBackFunction!();
                          }
                        },
                        isLoading: false,
                        buttonTitle: locale.return_,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                )
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}

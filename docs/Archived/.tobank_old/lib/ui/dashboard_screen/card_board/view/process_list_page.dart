import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/customer_tasks/customer_tasks_controller.dart';
import '../../../../util/theme/theme_util.dart';
import 'process_item_widget.dart';

class ProcessListPage extends StatelessWidget {
  const ProcessListPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CustomerTasksController>(
        builder: (controller) {
          return EasyRefresh(
            controller: controller.refreshController,
            header: MaterialHeader(
              color: ThemeUtil.textTitleColor,
            ),
            onRefresh: () {
              controller.refreshTaskList(shouldUpdateCustomerStatus: false);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controller.tasksByProcessIds.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                          height: 180,
                        ),
                        const SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            locale.request_checking_message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.tasksByProcessIds.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        itemBuilder: (context, index) {
                          final taskList = controller.tasksByProcessIds[index];
                          final sampleTask = taskList.first;
                          return ProcessItemWidget(
                            sampleTask: sampleTask,
                            onTapContinue: () => controller.onTapContinue(taskList: taskList),
                            onTapDetail: () => controller.showProcessDetailScreen(sampleTask.processInstanceId!),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}

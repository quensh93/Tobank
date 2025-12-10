import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/dashboard/process_controller.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../process_item_widget.dart';

class ProcessListPage extends StatelessWidget {
  const ProcessListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ProcessController>(builder: (controller) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: () {
                    controller.setRequestStatusFilter(RequestStatusFilter.all);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: controller.currentRequestStatusFilter == RequestStatusFilter.all
                          ? context.theme.colorScheme.secondary.withOpacity(0.15)
                          : Colors.transparent,
                      border: Border.all(
                          color: controller.currentRequestStatusFilter == RequestStatusFilter.all
                              ? context.theme.colorScheme.secondary
                              : context.theme.dividerColor),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          locale.all,
                          style: TextStyle(
                              color: controller.currentRequestStatusFilter == RequestStatusFilter.all
                                  ? context.theme.colorScheme.secondary
                                  : ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: () {
                    controller.setRequestStatusFilter(RequestStatusFilter.open);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: controller.currentRequestStatusFilter == RequestStatusFilter.open
                            ? context.theme.colorScheme.secondary.withOpacity(0.15)
                            : Colors.transparent,
                        border: Border.all(
                            color: controller.currentRequestStatusFilter == RequestStatusFilter.open
                                ? context.theme.colorScheme.secondary
                                : context.theme.dividerColor)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          locale.open_requests,
                          style: TextStyle(
                              color: controller.currentRequestStatusFilter == RequestStatusFilter.open
                                  ? context.theme.colorScheme.secondary
                                  : ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: () {
                    controller.setRequestStatusFilter(RequestStatusFilter.close);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: controller.currentRequestStatusFilter == RequestStatusFilter.close
                            ? context.theme.colorScheme.secondary.withOpacity(0.15)
                            : Colors.transparent,
                        border: Border.all(
                            color: controller.currentRequestStatusFilter == RequestStatusFilter.close
                                ? context.theme.colorScheme.secondary
                                : context.theme.dividerColor)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 12.0,
                        ),
                        child: Text(
                          locale.closed_requests,
                          style: TextStyle(
                              color: controller.currentRequestStatusFilter == RequestStatusFilter.close
                                  ? context.theme.colorScheme.secondary
                                  : ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: controller.processInstances.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                          height: 180,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Text(
                         locale.no_items_found,
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
                        return ProcessItemWidget(
                          processInstance: controller.processInstances[index],
                          detailButtonTitle: locale.detail,
                          shareFunction: (processInstance) {},
                          showDetailButton: true,
                          detailFunction: (processInstance) {
                            controller.showProcessDetailScreen(processInstance);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: controller.processInstances.length)),
        ],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/internet_plan/internet_plan_controller.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../widget/internet_plan_filter_item.dart';
import '../widget/internet_plan_item.dart';

class InternetPlanPage extends StatelessWidget {
  const InternetPlanPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<InternetPlanController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InternetPlanFilterItemWidget(
                  internetPlanFilterData: DataConstants.getInternetPlanFilterData()[index],
                  selectedInternetPlanFilterDataList: controller.selectedInternetPlanFilterDataList,
                  returnDataFunction: (internetPlanFilterData) {
                    controller.setInternetPlanFilterData(internetPlanFilterData);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8.0,
                );
              },
              itemCount: DataConstants.getInternetPlanFilterData().length,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: controller.dataPlanLists.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                          height: 180,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.no_packages_found_with_selected_filter,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    shrinkWrap: true,
                    itemCount: controller.dataPlanLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InternetPlanItemWidget(
                        dataPlanList: controller.dataPlanLists[index],
                        selectedId: controller.selectedId,
                        isLoading: controller.isLoading,
                        returnDataFunction: (dataPlanList) {
                          controller.setSelectedDataPlanList(dataPlanList);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }
}

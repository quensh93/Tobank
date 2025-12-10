import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_reportes/cbs_reports_controller.dart';
import '../../../../util/theme/theme_util.dart';
import 'view/cbs_report_type_widget.dart';

class CBSReportsScreen extends StatelessWidget {
  const CBSReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CBSReportsController>(
        init: CBSReportsController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  children: [
                    CBSReportTypeWidget(
                      callback: controller.filterAll,
                      title: locale.all,
                      isSelected: controller.filterTypeValue == 0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    CBSReportTypeWidget(
                      callback: controller.filterMyOwn,
                      title:locale.myself,
                      isSelected: controller.filterTypeValue == 1,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    CBSReportTypeWidget(
                      callback: controller.filterOthers,
                      title: locale.others,
                      isSelected: controller.filterTypeValue == 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    EasyRefresh(
                      controller: controller.refreshController,
                      header: MaterialHeader(
                        color: ThemeUtil.textTitleColor,
                      ),
                      refreshOnStart: true,
                      onRefresh: () {
                        controller.onRefresh();
                      },
                      child: controller.isEmptyTransaction()
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  locale.no_items_found,
                                  style: TextStyle(
                                      color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              controller: controller.scrollControllerTransaction,
                              itemCount: controller.transactionItemWidgetList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return controller.transactionItemWidgetList[index];
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 16.0,
                                );
                              },
                            ),
                    ),
                    if (controller.isLoading)
                      SpinKitFadingCircle(
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.iconTheme.color,
                            ),
                          );
                        },
                        size: 40.0,
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

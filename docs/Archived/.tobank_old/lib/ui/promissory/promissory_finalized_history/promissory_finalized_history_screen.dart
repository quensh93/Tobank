import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_finalized_history_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/custom_app_bar.dart';
import 'widget/promissory_finalized_history_item_widget.dart';

class PromissoryFinalizedHistoryScreen extends StatelessWidget {
  const PromissoryFinalizedHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissoryFinalizedHistoryController>(
        init: PromissoryFinalizedHistoryController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPress,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.my_promissory,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  locale.completed_promissory_notes,
                                  style: ThemeUtil.titleStyle,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.showFilterBottomSheet();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: Get.isDarkMode
                                          ? context.theme.colorScheme.surface
                                          : context.theme.colorScheme.surface.withOpacity(0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 16.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          SvgIcon(
                                            SvgIcons.filter,
                                            colorFilter:
                                                ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            locale.filter,
                                            style: TextStyle(
                                              color: context.theme.iconTheme.color!,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                EasyRefresh(
                                  controller: controller.refreshController,
                                  header: MaterialHeader(
                                    color: ThemeUtil.textTitleColor,
                                  ),
                                  onRefresh: () {
                                    controller.onRefresh();
                                  },
                                  child: controller.hasError && controller.page == 1
                                      ? Container()
                                      : controller.promissoryInfoList.isEmpty && !controller.isLoading
                                          ? Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Image.asset(
                                                    Get.isDarkMode
                                                        ? 'assets/images/empty_list_dark.png'
                                                        : 'assets/images/empty_list.png',
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
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : ListView.separated(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              controller: controller.scrollController,
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                              itemBuilder: (context, index) {
                                                final promissoryInfo = controller.promissoryInfoList[index];
                                                return PromissoryFinalizedHistoryItemWidget(
                                                  promissoryInfo: promissoryInfo,
                                                  returnDataFunction: (promissoryInfo) {
                                                    controller.showPromissoryServicesBottomSheet(promissoryInfo);
                                                  },
                                                );
                                              },
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(
                                                  height: 16.0,
                                                );
                                              },
                                              itemCount: controller.promissoryInfoList.length,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

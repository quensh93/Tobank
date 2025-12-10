import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/promissory/collateral_promissory/collateral_promissory_controller.dart';
import '../../../../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../../../../model/promissory/collateral_promissory/collateral_promissory_request_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'select_collateral_promissory_item_widget.dart';

class SelectCollateralPromissoryBottomSheet extends StatelessWidget {
  const SelectCollateralPromissoryBottomSheet({
    required this.collateralPromissoryRequestData,
    required this.returnDataFunction,
    super.key,
  });

  final CollateralPromissoryRequestData collateralPromissoryRequestData;
  final Function(CollateralPromissoryPublishResultData? collateralPromissoryPublishResultData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CollateralPromissoryController>(
            init: CollateralPromissoryController(
              collateralPromissoryRequestData: collateralPromissoryRequestData,
              returnDataFunction: returnDataFunction,
            ),
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xffcccccc),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    height: 350,
                    child: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        VirtualBranchLoadingPage(
                          controller.errorTitle,
                          hasError: controller.hasError,
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          isLoading: controller.isLoading,
                          retryFunction: () {
                            controller.getMyFullDetailedPromissoryRequest();
                          },
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(locale.select_service_you_want,
                                textAlign: TextAlign.start, style: ThemeUtil.titleStyle),
                            const SizedBox(
                              height: 24.0,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SelectCollateralPromissoryItemWidget(
                                    selectPromissoryCollateralData:
                                        controller.selectPromissoryCollateralDataList[index],
                                    returnDataFunction: (selectPromissoryCollateralData) {
                                      Get.back();
                                      controller.handlePromissoryActionEvent(selectPromissoryCollateralData.eventId);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 16.0,
                                  );
                                },
                                itemCount: controller.selectPromissoryCollateralDataList.length),
                            const SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

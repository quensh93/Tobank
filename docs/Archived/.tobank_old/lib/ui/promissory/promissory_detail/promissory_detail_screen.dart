import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_detail_controller.dart';
import '../../../../model/promissory/promissory_single_info.dart';
import '../../../../util/enums_constants.dart';
import '../../common/custom_app_bar.dart';
import '../../common/selector_item_widget.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'page/promissory_detail_page.dart';
import 'page/promissory_endorsement_page.dart';
import 'page/promissory_guarantee_page.dart';
import 'page/promissory_settlements_page.dart';

class PromissoryDetailScreen extends StatelessWidget {
  const PromissoryDetailScreen({
    required this.promissoryId,
    required this.promissoryInfo,
    required this.issuerNn,
    super.key,
  });

  final String promissoryId;
  final PromissorySingleInfo? promissoryInfo;
  final String? issuerNn;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryDetailController>(
      init: PromissoryDetailController(
        promissoryId: promissoryId,
        promissoryInfo: promissoryInfo,
        issuerNn: issuerNn,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.deposit_detail,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    if (!controller.isGetInfoLoading || !controller.hasError) ...[
                      const SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        shadowColor: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.detail,
                                isSelected: controller.promissoryDetailType == PromissoryDetailType.detail,
                                callBack: () {
                                  controller.showDetailPage();
                                },
                              ),
                            ),
                            Container(
                              height: 24.0,
                              width: 2.0,
                              color: context.theme.dividerColor,
                            ),
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.transfers,
                                isSelected: controller.promissoryDetailType == PromissoryDetailType.transfer,
                                callBack: () {
                                  controller.showTransferPage();
                                },
                              ),
                            ),
                            Container(
                              height: 24.0,
                              width: 2.0,
                              color: context.theme.dividerColor,
                            ),
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.guarantors,
                                isSelected: controller.promissoryDetailType == PromissoryDetailType.guarantee,
                                callBack: () {
                                  controller.showGuaranteePage();
                                },
                              ),
                            ),
                            Container(
                              height: 24.0,
                              width: 2.0,
                              color: context.theme.dividerColor,
                            ),
                            Expanded(
                              child: SelectorItemWidget(
                                title: locale.settlements,
                                isSelected: controller.promissoryDetailType == PromissoryDetailType.settlements,
                                callBack: () {
                                  controller.showSettlementsPage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isGetInfoLoading,
                            retryFunction: () {
                              controller.promissoryInquiryRequest();
                            },
                          ),
                          const PromissoryDetailPage(),
                          const PromissoryEndorsementPage(),
                          const PromissoryGuaranteePage(),
                          const PromissorySettlementsPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

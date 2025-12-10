import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/collateral_promissory/collateral_promissory_select_finalized_publish_controller.dart';
import '../../../../../model/promissory/collateral_promissory/collateral_promissory_publish_result_data.dart';
import '../../../../../model/promissory/promissory_list_info_detailed.dart';
import '../../../../../util/enums_constants.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/virtual_branch_loading_page.dart';
import 'page/collateral_promissory_select_finalized_publish_page.dart';

class CollateralPromissoryFinalizedPublishScreen extends StatelessWidget {
  const CollateralPromissoryFinalizedPublishScreen({
    required this.promissoryListInfoDetailList,
    required this.resultCallback,
    super.key,
  });

  final List<PromissoryListInfoDetail> promissoryListInfoDetailList;
  final void Function(CollateralPromissoryPublishResultData collateralPromissoryPublishResultData) resultCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<CollateralPromissorySelectFinalizedPublishController>(
          init: CollateralPromissorySelectFinalizedPublishController(
            promissoryListInfoDetailList: promissoryListInfoDetailList,
            resultCallback: resultCallback,
          ),
          builder: (controller) {
            return PopScope(
              canPop: false,
              onPopInvoked: controller.onBackPress,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.select_finalized_promissory_title,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const CollateralPromissorySelectFinalizedPublishPage(),
                            VirtualBranchLoadingPage(
                              controller.errorTitle,
                              hasError: controller.hasError,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              isLoading: controller.isLoading,
                              retryFunction: () {
                                controller.fetchPdfDocumentRequest(
                                    promissoryId: controller.selectedPromissory!.promissoryId!,
                                    docType: PromissoryDocType.publish.jsonValue);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/promissory/collateral_promissory/collateral_promissory_select_finalized_publish_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../widget/select_finalized_published_promissory_item_widget.dart';

class CollateralPromissorySelectFinalizedPublishPage extends StatelessWidget {
  const CollateralPromissorySelectFinalizedPublishPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CollateralPromissorySelectFinalizedPublishController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              Text(
                locale.select_finalized_promissory_note,
                style: ThemeUtil.titleStyle,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemBuilder: (context, index) {
                    return SelectFinalizedPublishedPromissoryItemWidget(
                      promissory: controller.promissoryListInfoDetailList[index],
                      selectedPromissory: controller.selectedPromissory,
                      setSelectedPromissoryFunction: (promissory) {
                        controller.setSelectedPromissory(promissory);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: controller.promissoryListInfoDetailList.length,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateSelectPromissory();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.choose_promissory_note,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../widget/safe_box_item_widget.dart';

class AddSafeBoxListPage extends StatelessWidget {
  const AddSafeBoxListPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AddSafeBoxController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${locale.branch_list_title} ${controller.getSelectedBranchData()}',
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemBuilder: (context, index) {
                  return SafeBoxItemWidget(
                    fund: controller.selectedBranchResult!.funds![index],
                    selectedFund: controller.selectedFund,
                    returnDataFunction: (value) {
                      controller.setSelectedFund(value);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16.0,
                  );
                },
                itemCount: controller.selectedBranchResult!.funds!.length),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContinueButtonWidget(
                  callback: () {
                    controller.validateThirdPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                  isEnabled: controller.selectedFund != null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      );
    });
  }
}

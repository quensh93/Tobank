import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/parsa_loan/parsa_loan_branch_info_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import 'branch_item_widget.dart';

class ParsaLoanSelectBranchBottomSheet extends StatelessWidget {
  const ParsaLoanSelectBranchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ParsaLoanBranchInfoController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  height: 48.0,
                  child: TextField(
                    onChanged: (value) {
                      controller.searchBankBranch();
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (term) {
                      controller.searchBankBranch();
                    },
                    controller: controller.searchBranchController,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: locale.search_branch,
                      hintStyle: ThemeUtil.hintStyle,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/icons/ic_search.svg',
                        ),
                      ),
                      suffixIcon: TextFieldClearIconWidget(
                        isVisible: controller.searchBranchController.text.isNotEmpty,
                        clearFunction: () {
                          controller.searchBranchController.clear();
                          controller.searchBankBranch();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text(locale.branch_agent, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.bankBranchListData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BankBranchItemWidget(
                        bankBranchListData: controller.bankBranchListData[index],
                        returnDataFunction: (bankBranchListData) {
                          controller.setSelectedBankBranch(bankBranchListData);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

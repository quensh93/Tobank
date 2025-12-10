import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_branch_info_controller.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class ParsaLoanSelectBranchPage extends StatelessWidget {
  const ParsaLoanSelectBranchPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanBranchInfoController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale.select_branch_agent_note,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    locale.branch_agent,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      if (!controller.isBranchFixed) {
                        controller.openSelectBranchBottomSheet();
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: controller.branchNameController,
                        keyboardType: TextInputType.text,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        readOnly: true,
                        enabled: controller.isBranchFixed ? false : true,
                        enableInteractiveSelection: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: locale.select_branch_agent,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
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
                          suffixIcon: controller.isBranchFixed
                              ? null
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateSelectBranchPage();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle: locale.continue_label,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        );
      },
    );
  }
}

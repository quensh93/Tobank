import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_add_warranty_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/text_field_error_widget.dart';
import '../warranty_item_widget.dart';

class MarriageLoanWarrantyPage extends StatelessWidget {
  const MarriageLoanWarrantyPage({
    required this.pageIndex,
    super.key,
  });

  final int pageIndex;

  String getTitle(MarriageLoanProcedureAddWarrantyController controller) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    var tempTitle = locale.warranty_title;
    if (pageIndex == 0) {
      tempTitle += locale.applicant_title;
    } else {
      tempTitle += locale.guarantor_with_customer_number(AppUtil.getPersianNumbers(controller.collaterals[pageIndex].customerNumber));
    }
    return tempTitle;
  }

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureAddWarrantyController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(getTitle(controller), style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: () {
                    controller.toggleShowWarrantyList();
                  },
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                controller.selectedWarrantyData == null
                                    ? locale.warranty_select_message
                                    : controller.selectedWarrantyData!.title,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: controller.selectedWarrantyData == null
                                        ? ThemeUtil.textSubtitleColor
                                        : ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: controller.isShowWarrantyList
                              ? Icon(
                                  Icons.keyboard_arrow_up,
                                  color: context.theme.colorScheme.secondary,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: context.theme.colorScheme.secondary,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                if (controller.isShowWarrantyList)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(8),
                        ),
                        color: context.theme.colorScheme.surface),
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return WarrantyItemWidget(
                          warrantyData: pageIndex == 0
                              ? AppUtil.getApplicantWarrantyList()[index]
                              : AppUtil.getGuaranteeWarrantyList()[index],
                          returnDataFunction: (selectedWarrantyData) {
                            controller.setWarrantyData(selectedWarrantyData);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                      itemCount: pageIndex == 0
                          ? AppUtil.getApplicantWarrantyList().length
                          : AppUtil.getGuaranteeWarrantyList().length,
                    ),
                  )
                else
                  Container(),
                TextFieldErrorWidget(
                  isValid: controller.isSelectedWarrantyDataValid,
                  errorText: locale.warranty_error_message,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                controller.getWarrantyWidget(pageIndex),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateWarrantyPage(pageIndex);
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

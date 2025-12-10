import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_guarantee_confirm_controller.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/date_converter_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/ui/dotted_line_widget.dart';
import '../../../../common/detail_item_widget.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
class MarriageLoanProcedureGuaranteeConfirmPage extends StatelessWidget {
  const MarriageLoanProcedureGuaranteeConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureGuaranteeConfirmController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(locale.guarantee_request_message, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DetailItemWidget(
                          title: locale.customer_number_applicant,
                          value: controller.processDetailResponse.data!.process!.variables!.initiator!,
                          showCopyIcon: false,
                          isSecure: false,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(
                          color: context.theme.dividerColor,
                        ),
                        const SizedBox(height: 16.0),
                         DetailItemWidget(
                          title: locale.loan_type,
                          value: locale.marriage_loan_,
                          showCopyIcon: false,
                          isSecure: false,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(
                          color: context.theme.dividerColor,
                        ),
                        const SizedBox(height: 16.0),
                        DetailItemWidget(
                          title: locale.loan_amount,
                          value: AppUtil.formatMoney(
                              controller.processDetailResponse.data!.process!.variables!.requestAmount!),
                          showCopyIcon: false,
                          isSecure: false,
                          valueTextDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(
                          color: context.theme.dividerColor,
                        ),
                        const SizedBox(height: 16.0),
                        DetailItemWidget(
                          title: locale.request_date,
                          value: DateConverterUtil.getJalaliFromTimestamp(
                              controller.processDetailResponse.data!.process!.startTime!),
                          valueTextDirection: TextDirection.rtl,
                          showCopyIcon: false,
                          isSecure: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateConfirmPage(isConfirm: true);
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_request_button,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.validateConfirmPage(isConfirm: false);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: context.theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ThemeUtil.primaryColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          locale.reject_request_button,
                          style: TextStyle(
                            color: ThemeUtil.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

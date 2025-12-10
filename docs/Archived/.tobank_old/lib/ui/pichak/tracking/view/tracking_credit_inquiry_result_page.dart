import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/tracking_credit_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../model/pichak/check_block_status_data.dart';
import '../../../../model/pichak/check_status_data.dart';
import '../../../../model/pichak/guarantee_status_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class TrackingInquiryResultPage extends StatelessWidget {
  const TrackingInquiryResultPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TrackingCreditController>(builder: (controller) {
      CheckStatusData checkStatusData;
      checkStatusData = DataConstants.getCheckStatusList()
          .where((element) => element.id == controller.trackingInquiryResponse.chequeStatus)
          .first;
      final CheckBlockStatusData checkBlockStatusData = DataConstants.getCheckBlockStatusList()
          .where((element) => element.id == controller.trackingInquiryResponse.blockStatus)
          .first;
      final BankData? bankData = AppUtil.getBankData(controller.trackingInquiryResponse.bankCode);
      final GuaranteeStatusData guaranteeStatusData =
          AppUtil.getGuaranteeStatusData(controller.trackingInquiryResponse.guaranteeStatus.toString())!;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 0,
                shadowColor: Colors.transparent,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.cheque_inquiry_details,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_status,
                        valueString: checkStatusData.title!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.guarantee_status,
                        valueString: guaranteeStatusData.title!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.block_status,
                        valueString: checkBlockStatusData.title!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.saayad_id_title,
                        valueString: controller.trackingInquiryResponse.chequeId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.iban_attached_to_cheque,
                        valueString: controller.trackingInquiryResponse.fromIban,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.bank_and_branch_code,
                        valueString: bankData != null
                            ? '${bankData.title!} - ${controller.trackingInquiryResponse.branchCode!}'
                            : '${locale.bank_} ${controller.trackingInquiryResponse.bankCode!} - ${controller.trackingInquiryResponse.branchCode!}',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.due_date,
                        valueString:
                            DateConverterUtil.getJalaliFromTimestamp(controller.trackingInquiryResponse.dueDate!),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_amount,
                        valueString: AppUtil.formatMoney(controller.trackingInquiryResponse.amount),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_owner_name,
                        valueString: controller.trackingInquiryResponse.chequeReceivers![0].fullName!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_owner_national_number,
                        valueString: controller.trackingInquiryResponse.chequeReceivers![0].nationalId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.regard_or_about_or_paid_for,
                        valueString: controller.reason,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      KeyValueWidget(
                        keyString: locale.cheque_description,
                        valueString: controller.trackingInquiryResponse.description!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  Get.back();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.return_to_saayadi_system,
              ),
            ],
          ),
        ),
      );
    });
  }
}

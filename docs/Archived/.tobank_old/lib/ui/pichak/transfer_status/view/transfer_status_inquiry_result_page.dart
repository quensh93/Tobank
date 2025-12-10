import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/transfer_status_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../model/pichak/check_block_status_data.dart';
import '../../../../model/pichak/check_status_data.dart';
import '../../../../model/pichak/guarantee_status_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../owner_item_widget.dart';

class TransferStatusInquiryResultPage extends StatelessWidget {
  const TransferStatusInquiryResultPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<TransferStatusController>(builder: (controller) {
      CheckStatusData checkStatusData;
      checkStatusData = DataConstants.getCheckStatusList()
          .where((element) => element.id == controller.transferStatusInquiryResponse.chequeStatus)
          .first;
      final CheckBlockStatusData checkBlockStatusData = DataConstants.getCheckBlockStatusList()
          .where((element) => element.id == controller.transferStatusInquiryResponse.blockStatus)
          .first;
      final BankData? bankData = AppUtil.getBankData(controller.transferStatusInquiryResponse.bankCode);
      final GuaranteeStatusData guaranteeStatusData =
          AppUtil.getGuaranteeStatusData(controller.transferStatusInquiryResponse.guaranteeStatus.toString())!;
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
                    children: [
                      Text(
                        checkStatusData.title!,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.saayad_id_error,
                        valueString: checkBlockStatusData.title!,
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
                        keyString: locale.saayad_id_title,
                        valueString: controller.transferStatusInquiryResponse.chequeId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.iban_attached_to_cheque,
                        valueString: controller.transferStatusInquiryResponse.fromIban,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.bank_and_branch_code,
                        valueString: bankData != null
                            ? '${bankData.title!} - ${controller.transferStatusInquiryResponse.branchCode!}'
                            : '${locale.bank_} ${controller.transferStatusInquiryResponse.bankCode!} - ${controller.transferStatusInquiryResponse.branchCode!}',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.due_date,
                        valueString:
                            DateConverterUtil.getJalaliFromTimestamp(controller.transferStatusInquiryResponse.dueDate!),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.amount,
                        valueString: locale.amount_format(AppUtil.formatMoney(controller.transferStatusInquiryResponse.amount)),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_description,
                        valueString: controller.transferStatusInquiryResponse.description!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.cheque_holders,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.transferStatusInquiryResponse.chequeHolders!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OwnerItemWidget(
                            chequeHolder: controller.transferStatusInquiryResponse.chequeHolders![index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

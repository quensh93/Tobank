import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_transfer_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../widget/receiver_item_widget.dart';
import '../widget/static_receiver_item_widget.dart';

class CheckTransferConfirmPage extends StatelessWidget {
  final bool transferReversal;
  const CheckTransferConfirmPage({required this.transferReversal, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckTransferController>(builder: (controller) {
      final BankData? bankData = AppUtil.getBankData(controller.transferRequest.dynamicInfoInquiryResponse!.bankCode);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.cheque_inquiry_details,
                        style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.saayad_id_title,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.chequeId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_serial,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.serialNo,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString:locale.shaba_number,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.fromIban,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.bank_code_title,
                        valueString: bankData != null
                            ? '${bankData.title!} ${controller.transferRequest.dynamicInfoInquiryResponse!.bankCode!}'
                            : controller.transferRequest.dynamicInfoInquiryResponse!.bankCode,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.branch_code_title,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.branchCode,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.due_date,
                        valueString: DateConverterUtil.getJalaliFromTimestamp(
                            controller.transferRequest.dynamicInfoInquiryResponse!.dueDate!),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.amount,
                        valueString:
                            locale.amount_format(AppUtil.formatMoney(controller.transferRequest.dynamicInfoInquiryResponse!.amount)),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_type,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.chequeType == 1
                            ? locale.cheque_type_normal
                            : controller.transferRequest.dynamicInfoInquiryResponse!.chequeType == 2
                                ? locale.cheque_type_bank
                                : locale.cheque_type_secure,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.physical_type_of_cheque,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.chequeMedia == 1
                            ? locale.cheque_media_physical
                            : locale.cheque_media_digital,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                       KeyValueWidget(
                        keyString: locale.currency_type,
                        valueString:locale.rial,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.regard_or_about_or_paid_for,
                        valueString: controller.selectedReasonType?.faTitle ?? '-',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_description,
                        valueString: controller.transferRequest.dynamicInfoInquiryResponse!.description!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      Visibility(
                        visible: !transferReversal,
                          child: Column(
                            children: [
                              Text(
                                locale.current_cheque_owners,
                                textAlign: TextAlign.right,
                                style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.transferRequest.dynamicInfoInquiryResponse!.chequeReceivers!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final chequeReceiver =
                                  controller.transferRequest.dynamicInfoInquiryResponse!.chequeReceivers![index];
                                  return StaticReceiverItemWidget(checkReceiver: chequeReceiver);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 8);
                                },
                              )
                            ],
                          )
                      ),
                      Visibility(
                          visible: transferReversal,
                          child: Text(
                            locale.transfer_reversal_hint,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                          )
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !transferReversal,
                  child: Column(
                    children: [
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
                                locale.new_cheque_recipients,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Divider(thickness: 1),
                              const SizedBox(height: 8.0),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ReceiverItemWidget(
                                      receiverInquiryResponse: controller.transferRequest.receiverInquiryResponseList![index],
                                      deleteFunction: (receiverData) {
                                        controller.deleteReceiverData(receiverData);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 16.0,
                                    );
                                  },
                                  itemCount: controller.transferRequest.receiverInquiryResponseList?.length??0),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.transferCheckRequest(transferReversal);
                },
                isLoading: controller.isLoading,
                buttonTitle: transferReversal ? locale.cheque_transfer_reversal : locale.final_cheque_transfer,
              ),
            ],
          ),
        ),
      );
    });
  }
}

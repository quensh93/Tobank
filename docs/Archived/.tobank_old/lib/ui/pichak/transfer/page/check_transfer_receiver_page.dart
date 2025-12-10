import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_transfer_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../model/pichak/guarantee_status_data.dart';
import '../../../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../../../util/app_util.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../../../common/text_field_error_widget.dart';
import '../../submit/widget/receiver_item_widget.dart';

class CheckTransferReceiverPage extends StatelessWidget {
  final bool transferReversal;
  const CheckTransferReceiverPage({required this.transferReversal, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckTransferController>(builder: (controller) {
      final BankData? bankData = AppUtil.getBankData(controller.transferRequest.dynamicInfoInquiryResponse!.bankCode);
      final GuaranteeStatusData guaranteeStatusData = AppUtil.getGuaranteeStatusData(
          controller.transferRequest.dynamicInfoInquiryResponse!.guaranteeStatus.toString())!;
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
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
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
                        keyString: locale.shaba_number,
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
                        keyString: locale.guarantee_status,
                        valueString: guaranteeStatusData.title!,
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
                        keyString:locale.cheque_amount,
                        valueString:
                            locale.amount_format(AppUtil.formatMoney(controller.transferRequest.dynamicInfoInquiryResponse!.amount)),
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
                      Text(
                        locale.reason_type_note,
                        textAlign: TextAlign.right,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            value: controller.selectedReasonType,
                            hint: Text(
                              locale.select_reason_type,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            items: controller.reasonTypeListResponse.data!.map((ReasonType item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.faTitle ?? '',
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (ReasonType? newValue) {
                              controller.setSelectedReasonType(newValue!);
                            },
                          ),
                        ),
                      ),
                      TextFieldErrorWidget(
                        isValid: controller.isReasonTypeValid,
                        errorText: locale.select_reason_type,
                      ),
                      const SizedBox(height: 16.0),
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
                          final chequeReceivers =
                              controller.transferRequest.dynamicInfoInquiryResponse!.chequeReceivers![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chequeReceivers.fullName!,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    locale.national_code_title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0),
                                  ),
                                  Text(
                                    chequeReceivers.nationalId!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 8);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Visibility(
                visible: !transferReversal,
                  child: Column(
                    children: [
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
                          itemCount: controller.transferRequest.receiverInquiryResponseList!.length),
                      const SizedBox(
                        height: 16.0,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          controller.showAddReceiverBottomSheet();
                        },
                        child: Row(
                          children: [
                            SvgIcon(
                              SvgIcons.addPlus,
                              colorFilter: ColorFilter.mode(ThemeUtil.textTitleColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8.0),
                            Text(locale.add_new_cheque_recipient,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Visibility(
                  visible: transferReversal,
                  child: TextField(
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: 'IranYekan',
                    ),
                    controller: controller.chequeDescriptionController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    textDirection: TextDirection.ltr,
                    onChanged: (value) {
                      controller.update();
                    },
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: false,
                      hintText: locale.enter_cheque_description,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isChequeDescriptionValid ? null : locale.cheque_description_error,
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
                    ),
                  )
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validate(transferReversal);
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
            ],
          ),
        ),
      );
    });
  }
}

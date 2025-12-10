import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_submit_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../model/pichak/customer_type_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class CheckSubmitChequeDetailPage extends StatelessWidget {
  const CheckSubmitChequeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckSubmitController>(builder: (controller) {
      final BankData? bankData =
          AppUtil.getBankData(controller.registrationRequest.staticInfoInquiryResponse!.bankCode);
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString:locale.saayad_id_title,
                        valueString: controller.registrationRequest.staticInfoInquiryRequest!.chequeId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_series,
                        valueString: controller.registrationRequest.staticInfoInquiryResponse!.seriesNo,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_serial,
                        valueString: controller.registrationRequest.staticInfoInquiryResponse!.serialNo,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.shaba_number,
                        valueString: controller.registrationRequest.staticInfoInquiryResponse!.fromIban,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.bank_code_title,
                        valueString: bankData != null
                            ? '${bankData.title!} ${controller.registrationRequest.staticInfoInquiryResponse!.bankCode!}'
                            : controller.registrationRequest.staticInfoInquiryResponse!.bankCode,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.branch_code_title,
                        valueString: controller.registrationRequest.staticInfoInquiryResponse!.branchCode,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                       KeyValueWidget(
                        keyString: locale.currency_type,
                        valueString: locale.rial,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      Text(
                        locale.cheque_owners,
                        style:
                            TextStyle(color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.registrationRequest.staticInfoInquiryResponse!.accountOwners!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CustomerTypeData customerTypeData = DataConstants.getCustomerTypeDataList()
                              .where((element) =>
                                  element.id ==
                                  controller
                                      .registrationRequest.staticInfoInquiryResponse!.accountOwners![index].personType)
                              .first;
                          return Row(
                            children: [
                              Text(
                                controller
                                    .registrationRequest.staticInfoInquiryResponse!.accountOwners![index].fullName!,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              Text(
                                customerTypeData.title!,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      Text(
                        locale.cheque_endorsers,
                        style:
                            TextStyle(color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.registrationRequest.staticInfoInquiryResponse!.signers!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CustomerTypeData customerTypeData = DataConstants.getCustomerTypeDataList()
                              .where((element) =>
                                  element.id ==
                                  controller.registrationRequest.staticInfoInquiryResponse!.signers![index].personType)
                              .first;
                          return Row(
                            children: [
                              Text(
                                controller.registrationRequest.staticInfoInquiryResponse!.signers![index].fullName!,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                              Text(
                                customerTypeData.title!,
                                style: TextStyle(
                                    color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                              ),
                            ],
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
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.getReasonTypes();
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

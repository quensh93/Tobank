import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_submit_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../widget/static_receiver_item_widget.dart';

class CheckSubmitConfirmPage extends StatelessWidget {
  const CheckSubmitConfirmPage({super.key});

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
                        style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.saayad_id_title,
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
                        keyString: locale.cheque_type,
                        valueString:
                            controller.registrationRequest.staticInfoInquiryRequest!.selectedCheckTypeData!.title!,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                       KeyValueWidget(
                        keyString:locale.physical_cheque_type,
                        valueString: locale.paper_cheque,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                       KeyValueWidget(
                        keyString:locale.currency_type,
                        valueString: locale.rial,
                      ),
                    ],
                  ),
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(locale.cheque_and_recivers_details,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              )),
                          InkWell(
                            onTap: () {
                              AppUtil.previousPageController(controller.pageController, controller.isClosed);
                            },
                            borderRadius: BorderRadius.circular(4.0),
                            child: SvgIcon(
                              SvgIcons.editAccountImage,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_amount,
                        valueString: AppUtil.formatMoney(controller.registrationRequest.amount),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.due_date,
                        valueString: controller.registrationRequest.dueDate,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString:locale.regard_or_about_or_paid_for,
                        valueString: controller.selectedReasonType?.faTitle ?? '-',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString:locale.cheque_description,
                        valueString: controller.registrationRequest.description ?? '',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      Text(locale.cheque_recivers,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(height: 16.0),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return StaticReceiverItemWidget(
                              receiverInquiryResponse:
                                  controller.registrationRequest.receiverInquiryResponseList![index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemCount: controller.registrationRequest.receiverInquiryResponseList!.length),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.registerChequeRequest();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.final_cheque_registration,
              ),
            ],
          ),
        ),
      );
    });
  }
}

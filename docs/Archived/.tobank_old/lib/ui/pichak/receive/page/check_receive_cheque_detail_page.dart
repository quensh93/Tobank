import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_receive_controller.dart';
import '../../../../model/pichak/bank_data.dart';
import '../../../../model/pichak/check_block_status_data.dart';
import '../../../../model/pichak/check_status_data.dart';
import '../../../../model/pichak/guarantee_status_data.dart';
import '../../../../util/app_util.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../widget/static_receiver_item_widget.dart';

class CheckReceiveChequeDetailPage extends StatelessWidget {
  const CheckReceiveChequeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckReceiveController>(builder: (controller) {
      CheckStatusData checkStatusData;
      checkStatusData = DataConstants.getCheckStatusList()
          .where((element) => element.id == controller.dynamicInfoInquiryResponse.chequeStatus)
          .first;
      final CheckBlockStatusData checkBlockStatusData = DataConstants.getCheckBlockStatusList()
          .where((element) => element.id == controller.dynamicInfoInquiryResponse.blockStatus)
          .first;
      final BankData? bankData = AppUtil.getBankData(controller.dynamicInfoInquiryResponse.bankCode);
      final GuaranteeStatusData guaranteeStatusData =
          AppUtil.getGuaranteeStatusData(controller.dynamicInfoInquiryResponse.guaranteeStatus.toString())!;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                        valueString: controller.dynamicInfoInquiryResponse.chequeId,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.iban_attached_to_cheque,
                        valueString: controller.dynamicInfoInquiryResponse.fromIban,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.bank_and_branch_code,
                        valueString: bankData != null
                            ? '${bankData.title!} - ${controller.dynamicInfoInquiryResponse.branchCode!}'
                            : '${locale.bank_} ${controller.dynamicInfoInquiryResponse.bankCode!} - ${controller.dynamicInfoInquiryResponse.branchCode!}',
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.due_date,
                        valueString:
                            DateConverterUtil.getJalaliFromTimestamp(controller.dynamicInfoInquiryResponse.dueDate!),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.amount,
                        valueString: AppUtil.formatMoney(controller.dynamicInfoInquiryResponse.amount),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.regard_or_about_or_paid_for,
                        valueString: controller.reason,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.cheque_description,
                        valueString: controller.dynamicInfoInquiryResponse.description!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.cheque_receiver,
                            style:
                                TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                          if (controller.isShowReceivers)
                            InkWell(
                              onTap: () {
                                controller.toggleReceiverShow();
                              },
                              borderRadius: BorderRadius.circular(24.0),
                              child: SvgIcon(
                                SvgIcons.arrowCircleUp,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                size: 24.0,
                              ),
                            )
                          else
                            InkWell(
                              onTap: () {
                                controller.toggleReceiverShow();
                              },
                              borderRadius: BorderRadius.circular(24.0),
                              child: SvgIcon(
                                SvgIcons.arrowCircleDown,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                size: 24.0,
                              ),
                            ),
                        ],
                      ),
                      if (!controller.isShowReceivers)
                        Container()
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20.0),
                            MySeparator(color: context.theme.dividerColor),
                            const SizedBox(height: 16.0),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.dynamicInfoInquiryResponse.chequeReceivers!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final chequeReceivers = controller.dynamicInfoInquiryResponse.chequeReceivers![index];
                                return StaticReceiverItemWidget(checkReceiver: chequeReceivers);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 16.0),
                                    MySeparator(color: context.theme.dividerColor),
                                    const SizedBox(height: 16.0),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              if (checkStatusData.id == 7 || checkStatusData.id == 8)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.showCheckReceiveDenyBottomSheet();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: context.theme.iconTheme.color!,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: controller.isLoadingReject
                                    ? SpinKitFadingCircle(
                                        itemBuilder: (_, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: context.theme.iconTheme.color,
                                            ),
                                          );
                                        },
                                        size: 24.0,
                                      )
                                    : Text(
                                        locale.reject_cheque,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: context.theme.iconTheme.color,
                                          fontSize: 16.0,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: ContinueButtonWidget(
                            isLoading: controller.isLoading,
                            callback: () {
                              controller.validate();
                            },
                            buttonTitle: locale.confirm_cheque_receive,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Container(),
            ],
          ),
        ),
      );
    });
  }
}

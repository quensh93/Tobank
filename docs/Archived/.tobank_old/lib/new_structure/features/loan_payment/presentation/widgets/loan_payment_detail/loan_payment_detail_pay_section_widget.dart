import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/installment_details_entity.dart';
import '../../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/entities/payment_data.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/buttons/main_text_field.dart';
import '../../../../../core/widgets/seek_bars/custum_seek_bar.dart';
import '../../../../select_payment/presentation/pages/select_payment_list_main_page.dart';

class LoanPaymentDetailPaySectionWidget extends StatefulWidget {
  final String fileNumber;
  final LoanDetailsEntity detailData;

  const LoanPaymentDetailPaySectionWidget({
    required this.fileNumber,
    required this.detailData,
    super.key,
  });

  @override
  State<LoanPaymentDetailPaySectionWidget> createState() => _LoanPaymentDetailPaySectionWidgetState();
}

class _LoanPaymentDetailPaySectionWidgetState extends State<LoanPaymentDetailPaySectionWidget> {
  PaymentType selectedPaymentType = PaymentType.installmentPayment;
  final TextEditingController desiredAmountController = TextEditingController();
  bool getDesiredAmountInCount = false;
  bool disablePayButton = false;
  final FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Text(locale.payment_type,
              textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleMedium),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              paymentTypeWidget(
                title: PaymentType.installmentPayment.getString(context),
                paymentType: PaymentType.installmentPayment,
              ),
              paymentTypeWidget(
                title: PaymentType.loanSettlement.getString(context),
                paymentType: PaymentType.loanSettlement,
              ),
              paymentTypeWidget(
                title: PaymentType.desiredAmount.getString(context),
                paymentType: PaymentType.desiredAmount,
              ),
            ],
          ),
          const SizedBox(height: 26),
          detailSectionWidget(paymentType: selectedPaymentType, data: widget.detailData),
          MainButton(
            onTap: () {
              textFocusNode.unfocus();
              payButton(data: widget.detailData);
            },
            disable: disablePayButton,
            title: locale.payment_button,
          ),
        ],
      ),
    );
  }

  Widget detailSectionWidget({required PaymentType paymentType, required LoanDetailsEntity data}) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (paymentType) {
      case PaymentType.desiredAmount:
        return Column(
          children: [
            if (!getDesiredAmountInCount)
              MainTextField(
                onChanged: () {
                  setState(() {
                    if (desiredAmountController.text != '') {
                      if (getDesiredAmountInCount) {
                        if ((data.installmentsPaidNumber +
                                int.parse(desiredAmountController.text.replaceAll('.', ''))) <=
                            data.installments.length) {
                          disablePayButton = false;
                        } else {
                          disablePayButton = true;
                        }
                      } else {
                        if (int.parse(desiredAmountController.text.replaceAll('.', '')) <=
                          (data.payableAmount)) {
                          disablePayButton = false;
                        } else {
                          disablePayButton = true;
                        }
                      }
                    } else {
                      disablePayButton = true;
                    }
                  });
                },
                focusNode: textFocusNode,
                hasSeparator: !getDesiredAmountInCount,
                hasPersianAmount: !getDesiredAmountInCount,
                hasRialBadge: !getDesiredAmountInCount,
                hasError: disablePayButton && desiredAmountController.text != '',
                errorText: getDesiredAmountInCount
                    ? locale.the_number_installments_requested_exceeds_allowed_limit
                    : locale.requested_amount_exceeds_allowed_limit,
                hintText: getDesiredAmountInCount ? locale.installments_number : locale.desired_amount,
                textController: desiredAmountController,
                borderColor:
                    disablePayButton ? MainTheme.of(context).primary : MainTheme.of(context).surfaceContainer,
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.installment_number,
                        style: MainTheme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        desiredAmountController.text == '' ? '0' : desiredAmountController.text,
                        style: MainTheme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomSeekBar(
                    onChanged: (index) {
                      setState(() {
                        if (index == 0) {
                          desiredAmountController.text = '';
                          disablePayButton = true;
                        } else {
                          desiredAmountController.text = index.toString();
                          disablePayButton = false;
                        }
                      });
                    },
                    activeTrackHeight: 10,
                    inactiveTrackHeight: 6,
                    thumbSize: 24,
                    initialValue: 0,
                    max: data.installments.length - data.installmentsPaidNumber,
                    min: 0,
                    activeTrackColor: MainTheme.of(context).secondary,
                    inactiveTrackColor: MainTheme.of(context).onSurfaceVariant,
                    thumbColor: MainTheme.of(context).onSecondary,
                  ),
                ],
              ),
            const SizedBox(height: 32),
            InkWell(
              onTap: () {
                setState(() {
                  desiredAmountController.text = '';
                  disablePayButton = true;
                  getDesiredAmountInCount = !getDesiredAmountInCount;
                });
              },
              splashColor: Colors.transparent,
              child: Center(
                child: Text(
                    getDesiredAmountInCount
                        ? locale.change_to_number_desired_amount
                        : locale.change_to_number_installments,
                    textAlign: TextAlign.center,
                    style: MainTheme.of(context)
                        .textTheme
                        .titleSmall
                        .copyWith(color: MainTheme.of(context).primary)),
              ),
            ),
            Divider(
              height: 48,
              thickness: 1,
              color: MainTheme.of(context).onSurface,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.payable_amount,
                    textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleSmall),
                Text(locale.amount_format(AppUtil.formatMoney(getDesireAmount(data: data))),
                    textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 26),
          ],
        );
      case PaymentType.loanSettlement:
        return Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'بدهی مانده',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: ThemeUtil.textTitleColor,
            //         fontSize: 16,
            //         fontFamily: 'IranYekan',
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     Text(
            //       '${AppUtil.formatMoney(data.payableAmount)} ریال',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: ThemeUtil.textTitleColor,
            //         fontSize: 16,
            //         fontFamily: 'IranYekan',
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 24),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'بخشودگی سود',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Color(0xFF039855),
            //         fontSize: 16,
            //         fontFamily: 'IranYekan',
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     Text(
            //       '0 ریال',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Color(0xFF039855),
            //         fontSize: 16,
            //         fontFamily: 'IranYekan',
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
            // Divider(
            //   height: 48,
            //   thickness: 1,
            //   color: context.theme.dividerColor,
            // ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(locale.payable_amount,
                    textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleSmall),
                Text(locale.amount_format(AppUtil.formatMoney(data.payableAmount)),
                    textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 31),
          ],
        );
      case PaymentType.installmentPayment:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(((data.installmentsPaidNumber + 1) ==data.installments.length)?'${locale.installment_} ${locale.final_}':'${locale.installment_} ${data.installmentsPaidNumber + 1}',
                    textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleMedium),
                Text(
                    locale.amount_format(
                        AppUtil.formatMoney(getAmount(thisData: data.installments[data.installmentsPaidNumber],data: data))),
                    textAlign: TextAlign.center,
                    style: MainTheme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 41),
          ],
        );
    }
  }

  Widget paymentTypeWidget({required String title, required PaymentType paymentType}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentType = paymentType;
          if (selectedPaymentType == PaymentType.desiredAmount) {
            getDesiredAmountInCount = false;
            disablePayButton = true;
            desiredAmountController.text = '';
          } else {
            getDesiredAmountInCount = false;
            disablePayButton = false;
            desiredAmountController.text = '';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: selectedPaymentType == paymentType
                    ? const Color(0xFF00BABA)
                    : context.theme.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.titleSmall.copyWith(
                  color:
                      selectedPaymentType == paymentType ? const Color(0xFF00BABA) : ThemeUtil.textTitleColor,
                )),
      ),
    );
  }

  void payButton({required LoanDetailsEntity data}) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    int amount = 0;
    String title = '';

    switch (selectedPaymentType) {
      case PaymentType.desiredAmount:
        amount = getDesireAmount(data: data);
        title = '';
      case PaymentType.installmentPayment:
        amount = getAmount(thisData: data.installments[data.installmentsPaidNumber],data: data);
        title = '${locale.installment_} ${data.installmentsPaidNumber + 1}';
      case PaymentType.loanSettlement:
        amount = (data.payableAmount);
        title = locale.loan_settlement;
    }

    showMainBottomSheet(
        context: context,
        bottomSheetWidget: SelectPaymentListMainPage(
          paymentData: PaymentData(
            title: title,
            paymentType: PaymentListType.myselfLoan,
            data: InstallmentPaymentPlanParams(
              paymentType: selectedPaymentType,
              amount: amount,
              fileNumber: widget.fileNumber,
              depositNumber: '',
            ),
          ),
        ));
  }

  int getDesireAmount({required LoanDetailsEntity data}) {
    int amount = 0;
    if (desiredAmountController.text != '' && !disablePayButton) {
      if (getDesiredAmountInCount) {
        if(data.installments.length - data.installmentsPaidNumber == int.parse(desiredAmountController.text.replaceAll('.', ''))){
          amount = data.payableAmount;
        }else{
          for (int i = (data.installmentsPaidNumber);
              i < (data.installmentsPaidNumber + int.parse(desiredAmountController.text.replaceAll('.', '')));
              i++) {
            amount = amount +
                int.parse(data.installments[i].installmentPenalty) +
                int.parse(data.installments[i].remainingAmount);
          }
        }
      } else {
        amount = int.parse(desiredAmountController.text.replaceAll('.', ''));
      }
    }

    return amount;
  }
}

int getAmount({required LoanDetailsEntity data,required InstallmentDetailsEntity thisData}) {
  if((data.installmentsPaidNumber + 1) ==data.installments.length){
    return data.payableAmount;
  }
  final int amount = thisData.isPayed
      ? (int.parse(thisData.amount))
      : (int.parse(thisData.installmentPenalty) + int.parse(thisData.remainingAmount));
  return amount;
}

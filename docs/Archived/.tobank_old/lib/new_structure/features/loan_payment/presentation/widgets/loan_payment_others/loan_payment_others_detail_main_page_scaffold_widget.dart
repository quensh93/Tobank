import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../widget/ui/dotted_separator_widget.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/entities/payment_data.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/buttons/main_text_field.dart';
import '../../../../select_payment/presentation/pages/select_payment_list_main_page.dart';

class LoanPaymentOthersDetailMainPageScaffoldWidget extends StatefulWidget {
  final LoanDetailsEntity detailsData;
  final String nationalCode;

  const LoanPaymentOthersDetailMainPageScaffoldWidget({
    required this.detailsData,
    required this.nationalCode,
    super.key,
  });

  @override
  State<LoanPaymentOthersDetailMainPageScaffoldWidget> createState() =>
      _LoanPaymentOthersDetailMainPageScaffoldWidgetState();
}

class _LoanPaymentOthersDetailMainPageScaffoldWidgetState
    extends State<LoanPaymentOthersDetailMainPageScaffoldWidget> {
  final TextEditingController amountController = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: MainTheme.of(context).surface,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.facility_number,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.bodyLarge
                            .copyWith(color: MainTheme.of(context).surfaceContainerHigh),
                      ),
                      Text(
                        widget.detailsData.fileNumber,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: DottedSeparatorWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.loan_type,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.bodyLarge
                            .copyWith(color: MainTheme.of(context).surfaceContainerHigh),
                      ),
                      Text(
                        widget.detailsData.title.split('-').length > 1
                            ? widget.detailsData.title.split('-')[1]
                            : '',
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: DottedSeparatorWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.receiver,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.bodyLarge
                            .copyWith(color: MainTheme.of(context).surfaceContainerHigh),
                      ),
                      Text(
                        widget.detailsData.title.split('-')[0],
                        textAlign: TextAlign.right,
                        style:MainTheme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.enter_desired_amount,
                    textAlign: TextAlign.right,
                    style: MainTheme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  MainTextField(
                    onChanged: () {
                      setState(() {
                        if (int.parse(amountController.text.replaceAll('.', '')) >
                            (widget.detailsData.payableAmount)) {
                          hasError = true;
                        } else {
                          hasError = false;
                        }
                      });
                    },
                    hasSeparator: true,
                    hintText: locale.desired_amount,
                    hasRialBadge: true,
                    hasPersianAmount: true,
                    errorText: locale.amount_entered_exceeds_facility_limit,
                    hasError: hasError,
                    textController: amountController,
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    onTap: () {
                      showMainBottomSheet(
                          context: context,
                          bottomSheetWidget: SelectPaymentListMainPage(
                            paymentData: PaymentData(
                              data: InstallmentPaymentPlanParams(
                                paymentType: PaymentType.desiredAmount,
                                amount: int.parse(amountController.text.replaceAll('.', '')),
                                fileNumber: widget.detailsData.fileNumber,
                                depositNumber: '',
                              ),
                              paymentType: PaymentListType.othersLoan,
                              title: '',
                            ),
                          ));
                    },
                    disable: (!(amountController.text != '')) || hasError,
                    title: locale.payment_button,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

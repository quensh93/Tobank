import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'installment_payment_list_main')
StacWidget installmentPaymentListMain() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title:
          '{{appStrings.generated.installment_payment.installment_payment_list_main.title}}',
      showSupport: true,
      showBack: true,
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        children: [
          _loanCard(
            data: const _LoanCardData(
              title:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.terms}}',
              due:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.next_payment_day}}',
              appBarTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.terms_loan}}',
              approvedAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.rial}}',
              paidSummary:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.payment}}',
              settledAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value}}',
              debtAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value_text}}',
              settlementPayableAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value_label}}',
              nextInstallmentTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_message}}',
              nextInstallmentAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value_message}}',
              historyDate:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.date_value}}',
              progress: 0.9091,
              totalInstallments: 44,
              totalInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_text}}',
              paidInstallments: 40,
              remainingInstallments: 4,
              remainingInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_item}}',
            ),
            warning:
                '{{appStrings.generated.installment_payment.installment_payment_list_main.payment_until_day_description}}',
          ),
          StacSizedBox(height: 16),
          _loanCard(
            data: const _LoanCardData(
              title:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value}}',
              due:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.next_payment_day_message}}',
              appBarTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.loan}}',
              approvedAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.rial_message}}',
              paidSummary:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.payment_message}}',
              settledAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value_item}}',
              debtAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.amount_value_alt}}',
              settlementPayableAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial}}',
              nextInstallmentTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_label}}',
              nextInstallmentAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial_option}}',
              historyDate:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.date_value_text}}',
              progress: 0.6389,
              totalInstallments: 36,
              totalInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_alt}}',
              paidInstallments: 23,
              remainingInstallments: 13,
              remainingInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.remaining_installment_count}}',
            ),
            warning:
                '{{appStrings.generated.installment_payment.installment_payment_list_main.payment_until_day_description_message}}',
          ),
          StacSizedBox(height: 16),
          _loanCard(
            data: const _LoanCardData(
              title:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value}}',
              due:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.next_payment_day_label}}',
              appBarTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.loan}}',
              approvedAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.rial_label}}',
              paidSummary:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.payment_label}}',
              settledAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial_message}}',
              debtAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial_label}}',
              settlementPayableAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial_theme}}',
              nextInstallmentTitle:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.number_value_description}}',
              nextInstallmentAmount:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.sample_amount_rial_sample}}',
              historyDate:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.date_value_label}}',
              progress: 0.6,
              totalInstallments: 30,
              totalInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.paid_installment_count}}',
              paidInstallments: 18,
              remainingInstallments: 12,
              remainingInstallmentsLabel:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.overdue_installment_count}}',
            ),
            warning:
                '{{appStrings.generated.installment_payment.installment_payment_list_main.payment_until_day_description_label}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _loanCard({required _LoanCardData data, required String warning}) {
  const warningColor = '#7A828F';

  return StacContainer(
    decoration: StacBoxDecoration(
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacImage(
              src: 'assets/icons/loan_list_item_light.svg',
              imageType: StacImageType.asset,
              width: 45,
              height: 45,
            ),
          ),
          StacSizedBox(height: 7),
          StacText(
            data: data.title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: data.due,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  values: [
                    {
                      'key': 'loanDetail.appBarTitle',
                      'value': data.appBarTitle,
                    },
                    {
                      'key': 'loanDetail.approvedAmount',
                      'value': data.approvedAmount,
                    },
                    {
                      'key': 'loanDetail.paidSummary',
                      'value': data.paidSummary,
                    },
                    {
                      'key': 'loanDetail.settledAmount',
                      'value': data.settledAmount,
                    },
                    {'key': 'loanDetail.debtAmount', 'value': data.debtAmount},
                    {
                      'key': 'loanDetail.nextInstallmentTitle',
                      'value': data.nextInstallmentTitle,
                    },
                    {
                      'key': 'loanDetail.nextInstallmentAmount',
                      'value': data.nextInstallmentAmount,
                    },
                    {
                      'key': 'loanDetail.settlementPayableAmount',
                      'value': data.settlementPayableAmount,
                    },
                    {
                      'key': 'loanDetail.historyDate',
                      'value': data.historyDate,
                    },
                    {'key': 'loanDetail.progress', 'value': data.progress},
                    {
                      'key': 'loanDetail.totalInstallments',
                      'value': data.totalInstallments,
                    },
                    {
                      'key': 'loanDetail.totalInstallmentsLabel',
                      'value': data.totalInstallmentsLabel,
                    },
                    {
                      'key': 'loanDetail.paidInstallments',
                      'value': data.paidInstallments,
                    },
                    {
                      'key': 'loanDetail.remainingInstallments',
                      'value': data.remainingInstallments,
                    },
                    {
                      'key': 'loanDetail.remainingInstallmentsLabel',
                      'value': data.remainingInstallmentsLabel,
                    },
                    {'key': 'loanDetail.showUnpaidInstallments', 'value': true},
                  ],
                ),
                NavigationAction(
                  fileName: 'installment_payment_detail_main',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 20),
              backgroundColor: '#E31C3D',
              foregroundColor: '#FFFFFF',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(6),
              ),
            ),
            child: StacText(
              data:
                  '{{appStrings.generated.installment_payment.installment_payment_list_main.details}}',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacContainer(
            decoration: StacBoxDecoration(
              border: StacBorder.all(color: warningColor, width: 1),
              borderRadius: StacBorderRadius.all(8),
            ),
            padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: StacRow(
              crossAxisAlignment: StacCrossAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.alert}}',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: warningColor,
                ),
                StacSizedBox(width: 8),
                StacExpanded(
                  child: StacText(
                    data: warning,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    maxLines: 2,
                    style: StacTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _LoanCardData {
  final String title;
  final String due;
  final String appBarTitle;
  final String approvedAmount;
  final String paidSummary;
  final String settledAmount;
  final String debtAmount;
  final String settlementPayableAmount;
  final String nextInstallmentTitle;
  final String nextInstallmentAmount;
  final String historyDate;
  final double progress;
  final int totalInstallments;
  final String totalInstallmentsLabel;
  final int paidInstallments;
  final int remainingInstallments;
  final String remainingInstallmentsLabel;

  const _LoanCardData({
    required this.title,
    required this.due,
    required this.appBarTitle,
    required this.approvedAmount,
    required this.paidSummary,
    required this.settledAmount,
    required this.debtAmount,
    required this.settlementPayableAmount,
    required this.nextInstallmentTitle,
    required this.nextInstallmentAmount,
    required this.historyDate,
    required this.progress,
    required this.totalInstallments,
    required this.totalInstallmentsLabel,
    required this.paidInstallments,
    required this.remainingInstallments,
    required this.remainingInstallmentsLabel,
  });
}

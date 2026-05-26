import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'installment_payment_list_main')
StacWidget installmentPaymentListMain() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: 'پرداخت اقساط خود',
      showSupport: true,
      showBack: true,
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        children: [
          _loanCard(
            data: const _LoanCardData(
              title: 'مراجعه مستاجران حایز شرایط',
              due: 'پرداخت بعدی: ۹ روز بعد',
              appBarTitle: 'وام مراجعه مستاجران حایز شرایط',
              approvedAmount: '۱,۰۰۰,۰۰۰,۰۰۰ ریال',
              paidSummary: '۴۰ از ۴۴ قسط پرداخت شده',
              settledAmount: '۱,۱۱۷,۳۷۲,۰۰۰',
              debtAmount: '۴۰۶,۲۳۳,۶۴۵',
              settlementPayableAmount: '۳۶۶,۹۶۳,۳۱۵',
              nextInstallmentTitle: 'قسط ۴۵',
              nextInstallmentAmount: '۲۵,۳۱۳,۰۰۰',
              historyDate: '۱۴۰۵/۰۳/۱۲',
              progress: 0.9091,
              totalInstallments: 44,
              totalInstallmentsLabel: '۴۴',
              paidInstallments: 40,
              remainingInstallments: 4,
              remainingInstallmentsLabel: '۴',
            ),
            warning:
                'مهلت پرداخت بدون جریمه دیرکرد برای قسط ۴۵ تا پایان روز ۱۲ خرداد ۱۴۰۵ می‌باشد',
          ),
          StacSizedBox(height: 16),
          _loanCard(
            data: const _LoanCardData(
              title: 'قرض الحسنه طرح پارسا (۲ درصدی) - توبانک',
              due: 'پرداخت بعدی: ۲۰ روز بعد',
              appBarTitle: 'وام قرض الحسنه طرح پارسا (۲ درصدی) - توبانک',
              approvedAmount: '۷۵۰,۰۰۰,۰۰۰ ریال',
              paidSummary: '۲۳ از ۳۶ قسط پرداخت شده',
              settledAmount: '۸۴۱,۵۰۰,۰۰۰',
              debtAmount: '۱۹۸,۵۰۰,۰۰۰',
              settlementPayableAmount: '۱۸۱,۲۴۰,۰۰۰',
              nextInstallmentTitle: 'قسط ۱۳',
              nextInstallmentAmount: '۱۸,۴۸۰,۰۰۰',
              historyDate: '۱۴۰۵/۰۳/۲۳',
              progress: 0.6389,
              totalInstallments: 36,
              totalInstallmentsLabel: '۳۶',
              paidInstallments: 23,
              remainingInstallments: 13,
              remainingInstallmentsLabel: '۱۳',
            ),
            warning:
                'مهلت پرداخت بدون جریمه دیرکرد برای قسط ۱۳ تا پایان روز ۲۳ خرداد ۱۴۰۵ می‌باشد',
          ),
          StacSizedBox(height: 16),
          _loanCard(
            data: const _LoanCardData(
              title: 'قرض الحسنه طرح پارسا (۲ درصدی) - توبانک',
              due: 'پرداخت بعدی: ۳۰ روز بعد',
              appBarTitle: 'وام قرض الحسنه طرح پارسا (۲ درصدی) - توبانک',
              approvedAmount: '۶۰۰,۰۰۰,۰۰۰ ریال',
              paidSummary: '۱۸ از ۳۰ قسط پرداخت شده',
              settledAmount: '۶۷۳,۲۰۰,۰۰۰',
              debtAmount: '۱۵۶,۸۰۰,۰۰۰',
              settlementPayableAmount: '۱۴۴,۳۷۰,۰۰۰',
              nextInstallmentTitle: 'قسط ۱۲',
              nextInstallmentAmount: '۱۷,۳۰۰,۰۰۰',
              historyDate: '۱۴۰۵/۰۳/۲۷',
              progress: 0.6,
              totalInstallments: 30,
              totalInstallmentsLabel: '۳۰',
              paidInstallments: 18,
              remainingInstallments: 12,
              remainingInstallmentsLabel: '۱۲',
            ),
            warning:
                'مهلت پرداخت بدون جریمه دیرکرد برای قسط ۱۲ تا پایان روز ۲۷ خرداد ۱۴۰۵ می‌باشد',
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
                const StacNavigateAction(
                  routeName: 'installment_payment_detail_main',
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
              data: 'مشاهده جزئیات',
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

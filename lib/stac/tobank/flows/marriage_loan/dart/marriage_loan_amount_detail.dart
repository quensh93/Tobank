import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'marriage_loan_amount_detail')
StacWidget marriageLoanAmountDetailScreen() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title:
          '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.title}}',
      showBack: true,
      showSupport: true,
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(top: 8, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: StacText(
              data:
                  '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.subtitle}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 20),
          _amountCard(
            loanAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.loan_amount_300}}',
            promissoryAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.promissory_amount_476}}',
            duration:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.duration_120}}',
            description:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.description_300}}',
          ),
          StacSizedBox(height: 24),
          _amountCard(
            loanAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.loan_amount_350}}',
            promissoryAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.promissory_amount_556}}',
            duration:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.duration_120}}',
            description:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.description_350}}',
          ),
          StacSizedBox(height: 24),
          _amountCard(
            loanAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.loan_amount_600}}',
            promissoryAmount:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.promissory_amount_952}}',
            duration:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.duration_120}}',
            description:
                '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.description_600}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _amountCard({
  required String loanAmount,
  required String promissoryAmount,
  required String duration,
  required String description,
}) {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 16),
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 18),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _amountRow(
          '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.loan_amount_label}}',
          loanAmount,
        ),
        StacSizedBox(height: 18),
        _amountRow(
          '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.promissory_amount_label}}',
          promissoryAmount,
        ),
        StacSizedBox(height: 18),
        _amountRow(
          '{{appStrings.generated.marriage_loan.marriage_loan_amount_detail.duration_label}}',
          duration,
        ),
        StacSizedBox(height: 20),
        StacText(
          data: description,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            height: 1.9,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _amountRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

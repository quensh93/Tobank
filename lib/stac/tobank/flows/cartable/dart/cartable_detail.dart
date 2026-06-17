import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'cartable_detail')
StacWidget cartableRealDetail() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.generated.cartable.cartable_detail.title}}',
      ),
      body: StacSingleChildScrollView(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: _buildDetailContent(),
      ),
    ),
  );
}

StacWidget _buildDetailContent() {
  return StacCustomVisibility(
    visible: '[[crDetailVariantChildLoan]]',
    child: _buildChildLoanDetail().toJson(),
    replacement: StacCustomVisibility(
      visible: '[[crDetailVariantCompleteDocsDone]]',
      child: _buildCompletedDocsDetail().toJson(),
      replacement: StacCustomVisibility(
        visible: '[[crDetailVariantCompleteDocsEmpty]]',
        child: _buildEmptyDocsDetail().toJson(),
        replacement: _buildMarriageLoanDetail().toJson(),
      ).toJson(),
    ).toJson(),
  );
}

StacWidget _buildMarriageLoanDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title: '{{appStrings.generated.cartable.cartable_detail.loan}}',
        startAt: '{{appStrings.generated.cartable.cartable_detail.date_value}}',
        status: '{{appStrings.generated.cartable.cartable_detail.open_status}}',
        amount: '{{appStrings.generated.cartable.cartable_detail.rial}}',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title: '{{appStrings.generated.cartable.cartable_detail.information}}',
        badgeTitle:
            '{{appStrings.generated.cartable.cartable_detail.completed_status}}',
        isCompleted: true,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_text}}',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title: '{{appStrings.generated.cartable.cartable_detail.documents}}',
        badgeTitle:
            '{{appStrings.generated.cartable.cartable_detail.completed_status}}',
        isCompleted: true,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_label}}',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title:
            '{{appStrings.generated.cartable.cartable_detail.information_place}}',
        badgeTitle:
            '{{appStrings.generated.cartable.cartable_detail.completed_status}}',
        isCompleted: true,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_label}}',
      ),
    ],
  );
}

StacWidget _buildChildLoanDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title: '{{appStrings.generated.cartable.cartable_detail.child_loan}}',
        startAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_message}}',
        status: '{{appStrings.generated.cartable.cartable_detail.package}}',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title: '{{appStrings.generated.cartable.cartable_detail.documents}}',
        badgeTitle:
            '{{appStrings.generated.child_loan.child_loan_task_list.complete}}',
        isCompleted: false,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_message}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_item}}',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title:
            '{{appStrings.generated.cartable.cartable_detail.information_place}}',
        badgeTitle:
            '{{appStrings.generated.child_loan.child_loan_task_list.complete}}',
        isCompleted: false,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_message}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_item}}',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title:
            '{{appStrings.generated.cartable.cartable_detail.information_child}}',
        badgeTitle:
            '{{appStrings.generated.child_loan.child_loan_task_list.complete}}',
        isCompleted: false,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_message}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_item}}',
      ),
    ],
  );
}

StacWidget _buildCompletedDocsDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title:
            '{{appStrings.generated.cartable.cartable_detail.documents_complete}}',
        startAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_alt}}',
        status: '{{appStrings.generated.cartable.cartable_detail.package}}',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title:
            '{{appStrings.generated.cartable.cartable_detail.documents_customer}}',
        badgeTitle:
            '{{appStrings.generated.cartable.cartable_detail.completed_status}}',
        isCompleted: true,
        createdAt:
            '{{appStrings.generated.cartable.cartable_detail.date_value_alt}}',
        completedAt:
            '{{appStrings.generated.cartable.cartable_detail.sample_datetime}}',
      ),
    ],
  );
}

StacWidget _buildEmptyDocsDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title:
            '{{appStrings.generated.cartable.cartable_detail.documents_complete}}',
        startAt:
            '{{appStrings.generated.cartable.cartable_detail.sample_datetime_option}}',
        status: '{{appStrings.generated.cartable.cartable_detail.package}}',
      ),
    ],
  );
}

StacWidget _buildSummarySection({
  required String title,
  required String startAt,
  required String status,
  String? amount,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.title}}',
          fontWeight: StacFontWeight.w700,
          fontSize: 16,
        ),
      ),
      StacSizedBox(height: 20),
      _buildSummaryRow(
        label: '{{appStrings.generated.cartable.cartable_detail.process}}',
        value: startAt,
      ),
      StacSizedBox(height: 14),
      _buildSummaryRow(
        label:
            '{{appStrings.generated.cartable.cartable_detail.status_process}}',
        value: status,
      ),
      if (amount != null) ...[
        StacSizedBox(height: 14),
        _buildSummaryRow(
          label:
              '{{appStrings.generated.cartable.cartable_detail.loan_amount}}',
          value: amount,
        ),
      ],
    ],
  );
}

StacWidget _buildSummaryRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      _buildRtlLabelWithColon(title: label),
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.left,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.title}}',
          fontWeight: StacFontWeight.w600,
          fontSize: 14,
        ),
      ),
    ],
  );
}

StacWidget _buildTaskCard({
  required String title,
  required String badgeTitle,
  required bool isCompleted,
  required String createdAt,
  required String completedAt,
}) {
  return StacContainer(
    padding: StacEdgeInsets.all(14),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacExpanded(
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  color: '{{appColors.current.text.title}}',
                  fontWeight: StacFontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            StacSizedBox(width: 12),
            StacContainer(
              padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: StacBoxDecoration(
                borderRadius: StacBorderRadius.all(8),
                color: isCompleted ? '#DDF3E8' : '#D3F2F4',
              ),
              child: StacText(
                data: badgeTitle,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  color: isCompleted ? '#5DA181' : '#33A8B2',
                  fontWeight: StacFontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 16),
        _buildSummaryRow(
          label:
              '{{appStrings.generated.cartable.cartable_detail.created_at_label}}',
          value: createdAt,
        ),
        StacSizedBox(height: 12),
        _buildSummaryRow(
          label:
              '{{appStrings.generated.cartable.cartable_detail.completed_at_label}}',
          value: completedAt,
        ),
      ],
    ),
  );
}

StacWidget _buildRtlLabelWithColon({required String title}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisSize: StacMainAxisSize.min,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.subtitle}}',
          fontWeight: StacFontWeight.w500,
          fontSize: 14,
        ),
      ),
      StacSizedBox(width: 2),
      StacText(
        data: ':',
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.subtitle}}',
          fontWeight: StacFontWeight.w500,
          fontSize: 14,
        ),
      ),
    ],
  );
}

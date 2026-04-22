import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'cartable_real_app_bar.dart';

@StacScreen(screenName: 'cartable_real_detail')
StacWidget cartableRealDetail() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildCartableRealAppBar(title: 'جزئیات فرآیند'),
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
        title: 'وام قرض الحسنه ازدواج',
        startAt: '۱۴۰۴/۱۰/۰۶ - ۱۳:۴۶',
        status: 'باز',
        amount: '۳,۰۰۰,۰۰۰,۰۰۰ ریال',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title: 'اطلاعات عقد نامه متقاضی',
        badgeTitle: 'تکمیل‌شده',
        isCompleted: true,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۳:۴۶',
        completedAt: '۱۴۰۴/۱۲/۳۰ - ۱۰:۵۵',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title: 'مدارک متقاضی',
        badgeTitle: 'تکمیل‌شده',
        isCompleted: true,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۳:۴۶',
        completedAt: '۱۴۰۴/۱۲/۳۰ - ۱۰:۵۶',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title: 'اطلاعات محل سکونت متقاضی',
        badgeTitle: 'تکمیل‌شده',
        isCompleted: true,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۳:۴۶',
        completedAt: '۱۴۰۴/۱۲/۳۰ - ۱۰:۵۶',
      ),
    ],
  );
}

StacWidget _buildChildLoanDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title: 'وام قرض الحسنه فرزندآوری',
        startAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۱۱',
        status: 'بسته',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title: 'مدارک متقاضی',
        badgeTitle: 'در انتظار تکمیل',
        isCompleted: false,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۱۱',
        completedAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۴۸',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title: 'اطلاعات محل سکونت متقاضی',
        badgeTitle: 'در انتظار تکمیل',
        isCompleted: false,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۱۱',
        completedAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۴۸',
      ),
      StacSizedBox(height: 14),
      _buildTaskCard(
        title: 'اطلاعات فرزند متقاضی',
        badgeTitle: 'در انتظار تکمیل',
        isCompleted: false,
        createdAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۱۱',
        completedAt: '۱۴۰۴/۱۰/۰۶ - ۱۱:۴۸',
      ),
    ],
  );
}

StacWidget _buildCompletedDocsDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title: 'تکمیل مدارک',
        startAt: '۱۴۰۵/۰۱/۲۴ - ۱۵:۳۵',
        status: 'بسته',
      ),
      StacSizedBox(height: 18),
      _buildTaskCard(
        title: 'بررسی مدارک مشتری',
        badgeTitle: 'تکمیل‌شده',
        isCompleted: true,
        createdAt: '۱۴۰۵/۰۱/۲۴ - ۱۵:۳۵',
        completedAt: '۱۴۰۵/۰۱/۲۶ - ۰۷:۱۷',
      ),
    ],
  );
}

StacWidget _buildEmptyDocsDetail() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildSummarySection(
        title: 'تکمیل مدارک',
        startAt: '۱۴۰۵/۰۱/۲۳ - ۱۰:۵۵',
        status: 'بسته',
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
      _buildSummaryRow(label: 'شروع فرآیند', value: startAt),
      StacSizedBox(height: 14),
      _buildSummaryRow(label: 'وضعیت فرآیند', value: status),
      if (amount != null) ...[
        StacSizedBox(height: 14),
        _buildSummaryRow(label: 'مبلغ تسهیلات ازدواج', value: amount),
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
        _buildSummaryRow(label: 'زمان ایجاد', value: createdAt),
        StacSizedBox(height: 12),
        _buildSummaryRow(label: 'زمان اتمام', value: completedAt),
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

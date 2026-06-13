import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_detail_row.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_divider.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/format/format_number_action.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Promissory Real Flow - Success Page
///
/// This screen displays the successful promissory issuance result.
/// Data is populated into the registry by the previous 'Sign' screen.
@StacScreen(screenName: 'promissory_success')
StacWidget promissoryRealSuccess() {
  return StacStatefulWidget(
    // Set static/helper values on init
    onInit: StacSequenceAction(
      actions: [
        StacFormatNumberAction(
          sourceKey: 'transactionAmount',
          destinationKey: 'transactionAmount_formatted',
        ),
        StacCustomSetValueAction(
          values: [
            {
              'key': 'transactionType',
              'value':
                  // صدور سفته
                  '{{appStrings.promissory.issuanceTitle}}', // Use localized string
            },
          ],
        ).toJson(),
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: '{{appStrings.promissory.successTitle}}',
        showBack: false,
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.center,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacSizedBox(height: 24),
                  _buildSuccessHeader(),
                  StacSizedBox(height: 24),
                  _buildTransactionDetails(),
                  StacSizedBox(height: 16),
                  _buildPdfSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildSuccessHeader() {
  return StacColumn(
    children: [
      StacContainer(
        width: 80,
        height: 80,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.success.color}}20',
          borderRadius: StacBorderRadius.all(40),
        ),
        child: StacCenter(
          child: StacImage(
            src: 'assets/icons/ic_transaction_success.svg',
            imageType: StacImageType.asset,
            width: 60,
            height: 60,
          ),
        ),
      ),
      StacSizedBox(height: 16),
      StacText(
        // پرداخت موفق
        data: '{{appStrings.promissory.paymentSuccessful}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.success.color}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacText(
        //عملیات پرداخت با موفقیت انجام شد
        data: '{{appStrings.promissory.successfulMessage}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
    ],
  );
}

StacWidget _buildTransactionDetails() {
  return StacContainer(
    width: 999999,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        buildPromissoryDetailRow(
          // مبلغ پرداختی
          '{{appStrings.promissory.paidAmount}}',
          // ریال
          '{{transactionAmount_formatted}} {{appStrings.common.rial}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDivider(),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // نوع تراکنش
          '{{appStrings.promissory.transactionType}}',
          '{{transactionType}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDivider(),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // زمان تراکنش
          '{{appStrings.promissory.transactionTime}}',
          '{{transactionTime}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDivider(),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // پرداخت از طریق
          '{{appStrings.promissory.paidVia}}',
          '{{paymentMethod}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDivider(),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // شماره پیگیری
          '{{appStrings.promissory.trackingNumber}}',
          '{{requestId}}',
        ),
      ],
    ),
  );
}

StacWidget _buildPdfSection() {
  return StacContainer(
    width: 999999,
    margin: StacEdgeInsets.symmetric(horizontal: 0),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.start,
      textDirection: StacTextDirection.rtl,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: 'assets/icons/ic_pdf_file.svg',
                  imageType: StacImageType.asset,
                  width: 32,
                  height: 32,
                ),
                StacSizedBox(width: 8),
                StacText(
                  // سفته
                  data: '{{appStrings.promissory.promissory}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacGestureDetector(
                  onTap: StacNavigateAction(
                    routeName: 'promissory_preview',
                    navigationStyle: NavigationStyle.push,
                  ),
                  child: StacPadding(
                    padding: StacEdgeInsets.all(8),
                    child: StacImage(
                      src: 'assets/icons/ic_show.svg',
                      imageType: StacImageType.asset,
                      width: 24,
                      height: 24,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacSizedBox(width: 8),
              ],
            ),
          ],
        ),
        StacSizedBox(height: 8),
        buildPromissoryDivider(),
        StacSizedBox(height: 8),
        StacText(
          // کاربر گرامی سفته شما در بخش سفته‌های من نیز قابل دانلود است
          data: '{{appStrings.promissory.downloadMessage}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}


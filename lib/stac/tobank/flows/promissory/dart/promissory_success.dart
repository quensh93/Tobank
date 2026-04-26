import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Success Page
///
/// This screen displays the successful promissory issuance result:
/// 1. Success icon and message
/// 2. Promissory ID
/// 3. Transaction details (amount, type, time, payment method, tracking number)
/// 4. PDF section with preview and share options
/// 5. Return to home button
///
/// Reference: docs/promissory_docs/promissory_transaction_detail_page.dart
@StacScreen(screenName: 'promissory_success')
StacWidget promissorySuccess() {
  return StacStatefulWidget(
    // Load transaction details on init
    onInit: StacNetworkRequestAction(
      url: 'https://api.tobank.com/promissory_finalize',
      method: 'post',
      results: [
        {
          'statusCode': 200,
          'action': StacCustomSetValueAction(
            values: [
              {'key': 'promissoryId', 'value': '{{data.data.promissoryId}}'},
              {'key': 'transactionAmount', 'value': '{{data.data.amount}}'},
              {
                'key': 'transactionType',
                'value': '{{appStrings.promissory.issuanceTitle}}',
              },
              {
                'key': 'transactionTime',
                'value': '{{data.data.transactionTime}}',
              },
              {'key': 'paymentMethod', 'value': '{{form.payment_method}}'},
              {
                'key': 'trackingNumber',
                'value': '{{data.data.trackingNumber}}',
              },
            ],
          ).toJson(),
        },
      ],
    ),
    child: StacScaffold(

      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.successTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  // Success Icon
                  StacContainer(
                    width: 80,
                    height: 80,
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.success.color}}20',
                      borderRadius: StacBorderRadius.all(40),
                    ),
                    child: StacCenter(
                      child: StacImage(
                        src: 'assets/icons/ic_check_circle.svg',
                        imageType: StacImageType.asset,
                        width: 56,
                        height: 56,
                        color: '{{appColors.current.success.color}}',
                      ),
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Success Message
                  StacText(
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
                    data: '{{appStrings.promissory.successMessage}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(height: 8),
                  // Promissory ID
                  // StacText(
                  //   data:
                  //       '{{appStrings.promissory.promissoryIdLabel}}: {{promissoryId}}',
                  //   textDirection: StacTextDirection.rtl,
                  //   textAlign: StacTextAlign.center,
                  //   style: StacCustomTextStyle(
                  //     fontSize: 16,
                  //     color: '{{appColors.current.text.title}}',
                  //   ),
                  // ),
                  StacSizedBox(height: 24),

                  // Transaction Details Card
                  StacContainer(
                    width: 999999,
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
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
                        _buildDetailRow(
                          '{{appStrings.promissory.paidAmount}}',
                          '{{transactionAmount}} {{appStrings.common.rial}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.transactionType}}',
                          '{{transactionType}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.transactionTime}}',
                          '{{transactionTime}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.paidVia}}',
                          '{{paymentMethod}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.trackingNumber}}',
                          '{{trackingNumber}}',
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // PDF Section
                  StacContainer(
                    width: 999999,
                    margin: StacEdgeInsets.symmetric(horizontal: 0),
                    decoration: StacBoxDecoration(
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
                        // PDF Header Row
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
                                // Preview Button
                                StacGestureDetector(
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message':
                                        '{{appStrings.promissory.previewPdf}}',
                                  }),
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
                                // Share Button
                                StacGestureDetector(
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message':
                                        '{{appStrings.promissory.sharePdf}}',
                                  }),
                                  child: StacPadding(
                                    padding: StacEdgeInsets.all(8),
                                    child: StacImage(
                                      src: 'assets/icons/ic_share.svg',
                                      imageType: StacImageType.asset,
                                      width: 24,
                                      height: 24,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        StacSizedBox(height: 8),
                        _buildDivider(),
                        StacSizedBox(height: 8),
                        StacText(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Helper: Detail row
StacWidget _buildDetailRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 16),
      StacExpanded(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

/// Helper: Divider
StacWidget _buildDivider() {
  return StacContainer(
    height: 1,
    color: '{{appColors.current.input.borderEnabled}}',
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON action helper for simple actions
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Success Page
///
/// This screen displays the successful promissory issuance result.
/// Data is populated into the registry by the previous 'Sign' screen.
@StacScreen(screenName: 'promissory_real_success')
StacWidget promissoryRealSuccess() {
  return StacStatefulWidget(
    // Set static/helper values on init
    onInit: StacCustomSetValueAction(
      values: [
        {
          'key': 'transactionType',
          'value':
              '{{appStrings.promissory.issuanceTitle}}', // Use localized string
        },
        // We assume 'paymentMethod' is already set or we map 'selectedPaymentMethod'
        {'key': 'paymentMethod', 'value': '{{selectedPaymentMethod}}'},
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
                          'حساب بانکی',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.trackingNumber}}',
                          '{{requestId}}',
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
                                    'message': 'Preview PDF',
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
                                    'message': 'Share PDF',
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

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

/// Promissory Flow - Confirmation Page
///
/// This screen displays a summary of all entered data for review:
/// 1. Issuer Information
/// 2. Receiver Information
/// 3. Promissory Details (amount, date)
///
/// Reference: docs/promissory_docs/request_promissory_confirm_page.dart
@StacScreen(screenName: 'promissory_confirm')
StacWidget promissoryConfirm() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      showSupport: false,
      title: '{{appStrings.promissory.confirmTitle}}',
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                // Promissory Details Section
                _buildSummaryCard(
                  title: '{{appStrings.promissory.detailsTitle}}',
                  items: [
                    _buildSummaryItem(
                      '{{appStrings.promissory.amountLabel}}',
                      '{{form.promissory_amount}} {{appStrings.common.rial}}',
                    ),
                    StacSizedBox(height: 4),
                    _buildSummaryItem(
                      '{{appStrings.promissory.payDate}}',
                      '{{form.promissory_due_date}}',
                    ),
                    StacSizedBox(height: 4),

                    _buildTitleWithValue(
                      '{{appStrings.promissory.descriptionLabel}}',
                      '{{form.description}}',
                    ),
                    StacSizedBox(height: 4),

                    _buildTitleWithValue(
                      '{{appStrings.promissory.paymentPlaceLabel}}',
                      '{{form.promissory_payment_place}}',
                    ),
                  ],
                ),

                StacSizedBox(height: 16),

                // Issuer Section
                _buildSummaryCard(
                  title: '{{appStrings.promissory.issuerInfoTitle}}',
                  items: [
                    _buildSummaryItem(
                      '{{appStrings.promissory.nationalCode}}',
                      '{{userData.nationalCode}}',
                    ),
                    _buildSummaryItem(
                      '{{appStrings.promissory.fullName}}',
                      '{{userData.fullName}}',
                    ),
                    _buildSummaryItem(
                      '{{appStrings.promissory.issuerPhoneNumber}}',
                      '{{userData.issuerPhoneNumber}}',
                    ),
                    StacSizedBox(height: 4),

                    _buildTitleWithValue(
                      '{{appStrings.promissory.addressResidence}}',
                      '{{form.addressResidence}}',
                    ),
                  ],
                ),
                StacSizedBox(height: 16),

                // Receiver Section
                _buildSummaryCard(
                  title: '{{appStrings.promissory.receiverInfoTitle}}',
                  items: [
                    _buildSummaryItem(
                      '{{appStrings.promissory.nationalCode}}',
                      '{{form.receiver_national_code}}',
                    ),
                    _buildSummaryItem(
                      '{{appStrings.promissory.mobileNumber}}',
                      '{{form.receiver_mobile}}',
                    ),
                    _buildSummaryItem(
                      '{{appStrings.promissory.fullName}}',
                      '{{userData.fullName}}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Submit Button
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacFilledButton(
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              elevation: 0,
              fixedSize: StacSize(999999, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_payment',
              'navigationStyle': 'push',
            }),
            child: StacText(
              data: '{{appStrings.promissory.confirmAndPay}}',
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Helper: Summary card with title and items
StacWidget _buildSummaryCard({
  required String title,
  required List<StacWidget> items,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacContainer(
          height: 1,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.input.borderEnabled}}',
          ),
        ),
        StacSizedBox(height: 8),
        ...items,
      ],
    ),
  );
}

/// Helper: Summary item row
StacWidget _buildSummaryItem(String label, String value) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 8),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacText(
          data: value,
          textDirection: StacTextDirection.ltr,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

/// Helper: Title with value stacked vertically
StacWidget _buildTitleWithValue(String title, String value) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.end,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(height: 5),
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
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

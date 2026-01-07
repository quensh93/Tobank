import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Success Page
///
/// This screen displays the successful promissory issuance result:
/// 1. Success icon and message
/// 2. Promissory details
/// 3. Return to home button
///
/// Reference: docs/promissory_docs/promissory_transaction_detail_page.dart
@StacScreen(screenName: 'promissory_success')
StacWidget promissorySuccess() {
  return StacScaffold(
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
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.center,
              children: [
                StacSizedBox(height: 24),
                // Success Icon
                StacContainer(
                  width: 100,
                  height: 100,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.success.color}}20',
                    borderRadius: StacBorderRadius.all(50),
                  ),
                  child: StacCenter(
                    child: StacImage(
                      src: 'assets/icons/ic_check_circle.svg',
                      imageType: StacImageType.asset,
                      width: 60,
                      height: 60,
                      color: '{{appColors.current.success.color}}',
                    ),
                  ),
                ),
                StacSizedBox(height: 24),

                // Success Message
                StacText(
                  data: '{{appStrings.promissory.successMessage}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 20,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: '{{appStrings.promissory.successDescription}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacSizedBox(height: 32),

                // Details Card
                StacContainer(
                  width: 999999,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surfaceContainer}}',
                    borderRadius: StacBorderRadius.all(12),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  padding: StacEdgeInsets.all(16),
                  child: StacColumn(
                    children: [
                      _buildDetailRow(
                        '{{appStrings.promissory.amountLabel}}',
                        '{{form.promissory_amount}} {{appStrings.common.rial}}',
                      ),
                      StacSizedBox(height: 12),
                      _buildDetailRow(
                        '{{appStrings.promissory.dueDateLabel}}',
                        '{{form.promissory_due_date}}',
                      ),
                      StacSizedBox(height: 12),
                      _buildDetailRow(
                        '{{appStrings.promissory.status}}',
                        '{{appStrings.promissory.statusIssued}}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Return to Home Button
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
              'widgetType': 'tobank_menu_dart',
              'navigationStyle': 'pushAndRemoveUntil',
            }),
            child: StacText(
              data: '{{appStrings.promissory.returnToHome}}',
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

/// Helper: Detail row
StacWidget _buildDetailRow(String label, String value) {
  return StacRow(
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

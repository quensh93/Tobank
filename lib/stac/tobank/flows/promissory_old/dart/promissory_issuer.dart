import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

/// Promissory Flow - Issuer Information Page
///
/// This screen displays the issuer (صادرکننده) information.
/// Data is loaded from state and displayed in read-only format:
/// 1. Issuer Information Card (national code, mobile, name, IBAN)
/// 2. Residence Information Card (postal code, address)
///
/// Reference: docs/promissory_docs/request_promissory_issuer_page.dart
@StacScreen(screenName: 'promissory_issuer')
StacWidget promissoryIssuer() {
  return StacStatefulWidget(
    onInit: StacRawJsonAction({
      'actionType': 'sequence',
      'actions': [
        // Ensure we have address info. If userData.address is empty, we might need to fetch it.
        // For now, we assume standard flow has populated userData or we fetch it here.
        // Based on docs: POST /api/v1.0/dibalite/customer/info
        {
          'actionType': 'netRequest',
          'url': 'https://api.tobank.com/api/v1.0/dibalite/customer/info',
          'method': 'POST',
          'body': {
            'trackingNumber': '{{userData.trackingNumber}}',
            'nationalCode': '{{userData.nationalCode}}',
            'forceCacheUpdate': false,
            'forceInquireAddressInfo': true,
            'getCustomerStartableProcesses': false,
            'getCustomerDeposits': false,
            'getCustomerActiveCertificate': false,
          },
          'onSuccess': {
            'actionType': 'log',
            'message': 'Customer info fetched',
          },
        },
      ],
    }),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: false,
        title: '{{appStrings.promissory.issuerTitle}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          // Scrollable Content
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  // Issuer Information Card
                  StacContainer(
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
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
                          data: '{{appStrings.promissory.issuerInfoTitle}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(height: 16),
                        // National Code
                        _buildKeyValueRow(
                          key: '{{appStrings.promissory.nationalCode}}',
                          value: '{{userData.nationalCode}}',
                        ),
                        StacSizedBox(height: 16),
                        // Mobile Number
                        _buildKeyValueRow(
                          key: '{{appStrings.promissory.mobileNumber}}',
                          value: '{{userData.mobile}}',
                        ),
                        StacSizedBox(height: 16),
                        // Full Name
                        _buildKeyValueRow(
                          key: '{{appStrings.promissory.fullName}}',
                          value: '{{userData.fullName}}',
                        ),
                        StacSizedBox(height: 16),
                        // Deposit IBAN (Updated to use form.selected_shaba_number)
                        _buildKeyValueRow(
                          key: '{{appStrings.promissory.depositShaba}}',
                          value: '{{form.selected_shaba_number}}',
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),
                  // Residence Information Card
                  StacContainer(
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    padding: StacEdgeInsets.all(16),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.end,
                      children: [
                        StacText(
                          data:
                              '{{appStrings.promissory.issuerResidenceTitle}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(height: 16),
                        // Postal Code
                        StacText(
                          data: '{{appStrings.promissory.postalCode}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                        StacSizedBox(height: 8),
                        StacText(
                          data: '{{userData.postalCode}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(height: 16),
                        // Residence Address
                        StacText(
                          data: '{{appStrings.promissory.residenceAddress}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                        StacSizedBox(height: 8),
                        StacText(
                          data: '{{userData.address}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w600,
                            height: 1.4,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Continue Button
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
                'actionType': 'sequence',
                'actions': [
                  // Validation generic: ensure we have address/postal code
                  StacValidateFieldsAction(
                    resultKey: 'validationResult',
                    fields: [
                      {'id': 'userData.postalCode', 'rule': r'.+'},
                      {'id': 'userData.address', 'rule': r'.+'},
                    ],
                  ),
                  {
                    'actionType': 'navigate',
                    'widgetType': 'promissory_receiver',
                    'navigationStyle': 'push',
                  },
                ],
              }),
              child: StacText(
                data: '{{appStrings.common.continue}}',
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
    ),
  );
}

/// Helper: Key-Value row widget
StacWidget _buildKeyValueRow({required String key, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: key,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
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


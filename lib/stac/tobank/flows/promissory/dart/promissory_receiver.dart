import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

/// Promissory Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// For simplicity, this version uses individual receiver type only.
///
/// Reference: docs/promissory_docs/request_promissory_receiver_page.dart
@StacScreen(screenName: 'promissory_receiver')
StacWidget promissoryReceiver() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isReceiverFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.receiverTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.all(16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    // Title
                    StacText(
                      data: '{{appStrings.promissory.receiverInfoTitle}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // National Code Field
                    StacText(
                      data: '{{appStrings.promissory.nationalCode}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'receiver_national_code',
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'textDirection': 'ltr',
                      'textAlign': 'right',
                      'maxLength': 10,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.enterNationalCode}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message':
                              '{{appStrings.promissory.nationalCode}} نادرست است',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Mobile Number Field
                    StacText(
                      data: '{{appStrings.promissory.mobileNumber}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'receiver_mobile',
                      'keyboardType': 'phone',
                      'textInputAction': 'done',
                      'textDirection': 'ltr',
                      'textAlign': 'right',
                      'maxLength': 11,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.enterMobileNumber}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message':
                              '{{appStrings.promissory.mobileNumber}} نادرست است',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Continue Button
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isReceiverFormValid',
                'enabled': false,
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType': 'promissory_data',
                  'navigationStyle': 'push',
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
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

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

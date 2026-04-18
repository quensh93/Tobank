import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'verify_identity_real_app_bar.dart';

/// Postal code & address verification page.
/// User enters postal code, clicks "استعلام" to look up the address,
/// address section appears, then "تایید و ادامه" button becomes active.
@StacScreen(screenName: 'verify_identity_real_postal_code')
StacWidget verifyIdentityRealPostalCode() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'postalCode', 'value': ''},
        {'key': 'postalAddress', 'value': ''},
        {'key': 'hasPostalAddress', 'value': false},
        {'key': 'hasPostalCodeInput', 'value': false},
        {'key': 'isPostalCodeComplete', 'value': false},
        {'key': 'isPostalLoading', 'value': false},
      ],
    ),
    onDispose: const StacCustomSetValueAction(
      values: [
        {'key': 'postalCode', 'value': ''},
        {'key': 'postalAddress', 'value': ''},
        {'key': 'hasPostalAddress', 'value': false},
        {'key': 'hasPostalCodeInput', 'value': false},
        {'key': 'isPostalCodeComplete', 'value': false},
        {'key': 'isPostalLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildVerifyIdentityRealAppBar(
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    // Description text
                    StacText(
                      data:
                          '{{appStrings.authentication.postalCodeDescription}}',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.subtitle}}',
                        height: 1.8,
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildPostalCodeSection(),
                    StacSizedBox(height: 16),
                    _buildAddressSection(),
                  ],
                ),
              ),
            ),
            // Confirm button - only enabled when address is loaded
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'hasPostalAddress',
                'enabled': false,
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'disabledStyle': StacButtonStyle(
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.authentication.confirmAndContinue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
                'onPressed': StacNavigateAction(
                  routeName: 'verify_identity_real_signature',
                  navigationStyle: NavigationStyle.push,
                ),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Postal code label + text field + "استعلام" button
StacWidget _buildPostalCodeSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: '{{appStrings.authentication.postalCodeLabel}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 12),
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          // Text field
          StacExpanded(
            child: StacRawJsonWidget({
              'type': 'textFormField',
              'id': 'postalCodeInput',
              'textDirection': 'rtl',
              'textAlign': 'right',
              'keyboardType': 'number',
              'maxLength': 10,
              'inputFormatters': [
                {'type': 'allow', 'rule': '[0-9]'},
              ],
              'onChanged': StacSequenceAction(
                actions: [
                  const StacCustomSetValueAction(
                    values: [
                      {'key': 'postalAddress', 'value': ''},
                      {'key': 'hasPostalAddress', 'value': false},
                    ],
                  ),
                  const StacValidateFieldsAction(
                    resultKey: 'hasPostalCodeInput',
                    fields: [
                      {'id': 'postalCodeInput'},
                    ],
                  ),
                  const StacValidateFieldsAction(
                    resultKey: 'isPostalCodeComplete',
                    fields: [
                      {'id': 'postalCodeInput', 'rule': r'^\d{10}$'},
                    ],
                  ),
                ],
              ).toJson(),
              'style': StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ).toJson(),
              'decoration': {
                ...StacInputDecoration(
                  hintText: '{{appStrings.authentication.postalCodeHint}}',
                  hintStyle: StacTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.hint}}',
                  ),
                  filled: false,
                  contentPadding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  prefixIcon: StacRawJsonWidget({
                    'type': 'visibility',
                    'visible': '[[hasPostalCodeInput]]',
                    'child': StacGestureDetector(
                      onTap: const StacCustomSetValueAction(
                        values: [
                          {'key': 'postalCodeInput', 'value': ''},
                          {'key': 'postalAddress', 'value': ''},
                          {'key': 'hasPostalAddress', 'value': false},
                          {'key': 'postalCode', 'value': ''},
                          {'key': 'hasPostalCodeInput', 'value': false},
                          {'key': 'isPostalCodeComplete', 'value': false},
                        ],
                      ),
                      child: StacPadding(
                        padding: StacEdgeInsets.all(12),
                        child: StacIcon(
                          icon: StacIcons.close,
                          size: 20,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                    ).toJson(),
                  }),
                ).toJson(),
                'counterText': '',
              },
            }),
          ),
          StacSizedBox(width: 10),
          // "استعلام" button
          StacRawJsonWidget({
            'type': 'reactiveElevatedButton',
            'enabledKey': 'isPostalCodeComplete',
            'enabled': false,
            'style': StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              elevation: 0,
              padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 23),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
            ).toJson(),
            'disabledStyle': StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.background.surfaceContainerHigh}}',
              foregroundColor: '{{appColors.current.text.subtitle}}',
              elevation: 0,
              padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 23),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
            ).toJson(),
            'child': StacText(
              data: '{{appStrings.authentication.inquiryButton}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ).toJson(),
            'onPressed': StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  key: 'postalCode',
                  value: StacGetFormValueAction(id: 'postalCodeInput'),
                ),
                const StacCustomSetValueAction(
                  key: 'isPostalLoading',
                  value: true,
                ),
                const StacCustomSetValueAction(
                  values: [
                    {
                      'key': 'postalAddress',
                      'value':
                          'استان تهران، شهرستان تهران، بخش مرکزی، شهر تهران، محله اختیاریه، خیابان شهید محمدعلی سنجابی، کوچه حسینیه،',
                    },
                    {'key': 'hasPostalAddress', 'value': true},
                    {'key': 'isPostalLoading', 'value': false},
                  ],
                ),
              ],
            ).toJson(),
          }),
        ],
      ),
    ],
  );
}

/// Address section - shown after "استعلام" is clicked
StacWidget _buildAddressSection() {
  return StacRawJsonWidget({
    'type': 'visibility',
    'visible': '[[hasPostalAddress]]',
    'child': StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: '{{appStrings.authentication.addressLabel}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 12),
        StacContainer(
          padding: StacEdgeInsets.all(16),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(12),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacExpanded(
                child: StacRawJsonWidget({
                  'type': 'registryReactive',
                  'child': {
                    'type': 'text',
                    'data': '{{postalAddress}}',
                    'registryKey': 'postalAddress',
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'style': {
                      'type': 'custom',
                      'fontSize': 16,
                      'fontWeight': 'w600',
                      'color': '{{appColors.current.text.title}}',
                      'height': 1.8,
                    },
                  },
                }),
              ),
              StacSizedBox(width: 8),
              StacGestureDetector(
                onTap: const StacCustomSetValueAction(
                  values: [
                    {'key': 'postalAddress', 'value': ''},
                    {'key': 'hasPostalAddress', 'value': false},
                  ],
                ),
                child: StacPadding(
                  padding: StacEdgeInsets.all(4),
                  child: StacIcon(
                    icon: StacIcons.close,
                    size: 20,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).toJson(),
  });
}

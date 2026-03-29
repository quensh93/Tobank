import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

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
        {'key': 'isPostalLoading', 'value': false},
      ],
    ),
    onDispose: const StacCustomSetValueAction(
      values: [
        {'key': 'postalCode', 'value': ''},
        {'key': 'postalAddress', 'value': ''},
        {'key': 'hasPostalAddress', 'value': false},
        {'key': 'isPostalLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).title,
        centerTitle: true,
        leading: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).leading,
        actions: [
          StacPadding(
            padding: StacEdgeInsets.only(right: 15),
            child: StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(22),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_support.svg',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ),
        ],
      ),
      body: StacColumn(
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
              'onPressed': const StacShowResultAction(
                title: '{{appStrings.common.comingSoon}}',
                content: '{{appStrings.common.comingSoon}}',
              ).toJson(),
            }),
          ),
        ],
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
            child: StacTextFormField(
              id: 'postalCodeInput',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              keyboardType: StacTextInputType.number,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
              decoration: StacInputDecoration(
                hintText:
                    '{{appStrings.authentication.postalCodeHint}}',
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
                suffixIcon: StacRawJsonWidget({
                  'type': 'visibility',
                  'visible': '{{hasPostalAddress}}',
                  'child': StacGestureDetector(
                    onTap: const StacCustomSetValueAction(
                      values: [
                        {'key': 'postalAddress', 'value': ''},
                        {'key': 'hasPostalAddress', 'value': false},
                        {'key': 'postalCode', 'value': ''},
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
              ),
            ),
          ),
          StacSizedBox(width: 12),
          // "استعلام" button
          StacFilledButton(
            onPressed: StacSequenceAction(
              actions: [
                // Save the postal code value to registry
                StacCustomSetValueAction(
                  key: 'postalCode',
                  value: StacGetFormValueAction(id: 'postalCodeInput'),
                ),
                const StacCustomSetValueAction(
                  key: 'isPostalLoading',
                  value: true,
                ),
                // Mock: Set address after inquiry
                // In real app this would be a network request
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
            ),
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              elevation: 0,
              padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 18),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
            ),
            child: StacText(
              data: '{{appStrings.authentication.inquiryButton}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

/// Address section - shown after "استعلام" is clicked
StacWidget _buildAddressSection() {
  return StacRawJsonWidget({
    'type': 'visibility',
    'visible': '{{hasPostalAddress}}',
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
                      'fontSize': 14,
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

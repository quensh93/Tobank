import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Issuer Information Screen
///
/// This screen displays the issuer (صادرکننده) information.
/// It uses standard Stac widgets to handle:
/// - Loading state (shows spinner while fetching data)
/// - Error state (shows error message with retry button)
/// - Success state (shows issuer data)
@StacScreen(screenName: 'promissory_real_issuer')
StacWidget promissoryRealIssuer() {
  final fetchAction = StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: const [
          {'key': 'issuer.isLoading', 'value': true},
          {'key': 'issuer.hasError', 'value': false},
          {'key': 'issuer.showContent', 'value': false},
          {'key': 'issuer.error', 'value': null},
        ],
      ),
      StacNetworkRequestAction(
        url:
            'http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/info/{{userData.nationalCode}}',
        method: 'get',
        headers: {
          'accept': '*/*',
          'app-platform': 'android',
          'app-store': 'application/json',
          'app-version': '456',
          'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
          'serviceauthorization':
              'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
          'authorization': '{{auth.accessToken}}',
        },
        results: [
          {
            'statusCode': 200,
            'action': StacCustomSetValueAction(
              values: [
                {
                  'key': 'userData.nationalCode',
                  'value': '{{data.data.nationalCode}}',
                },
                {
                  'key': 'userData.contactNumber',
                  'value': '{{data.data.contactNumber}}',
                },
                {
                  'key': 'userData.mobile',
                  'value': '{{data.data.cellphoneNumber}}',
                },
                {'key': 'userData.lastName', 'value': '{{data.data.lastName}}'},
                {
                  'key': 'userData.fatherName',
                  'value': '{{data.data.fatherName}}',
                },
                {
                  'key': 'userData.fullName',
                  'value': '{{data.data.firstName}} {{data.data.lastName}}',
                },
                {
                  'key': 'userData.birthDate',
                  'value': '{{data.data.birthDate}}',
                },
                {
                  'key': 'userData.postalCode',
                  'value': '{{data.data.postCode}}',
                },
                {'key': 'userData.address', 'value': '{{data.data.address}}'},
                {
                  'key': 'selectedDeposit.depositIban',
                  'value': '{{form.selected_shaba_number}}',
                },
                {'key': 'issuer.isLoading', 'value': false},
                {'key': 'issuer.hasError', 'value': false},
                {'key': 'issuer.showContent', 'value': true},
              ],
            ).toJson(),
          },
          {
            'statusCode': 401,
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'issuer.isLoading', 'value': false},
                {'key': 'issuer.hasError', 'value': true},
                {'key': 'issuer.showContent', 'value': false},
                {
                  'key': 'issuer.error',
                  'value': 'Authentication failed. Please login again.',
                },
              ],
            ).toJson(),
          },
          {
            'statusCode': -1, // Fallback for network errors/timeouts
            'action': StacCustomSetValueAction(
              values: const [
                {'key': 'issuer.isLoading', 'value': false},
                {'key': 'issuer.hasError', 'value': true},
                {'key': 'issuer.showContent', 'value': false},
                {
                  'key': 'issuer.error',
                  'value':
                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  final continueAction = StacRawJsonAction({
    'actionType': 'navigate',
    'widgetType': 'promissory_real_receiver',
    'navigationStyle': 'push',
  });

  return StacStatefulWidget(
    onInit: fetchAction,
    child: StacRawJsonWidget({
      'type': 'visibility',
      'visible': '{{issuer.isLoading}}',
      'child': _buildLoadingScreen().toJson(),
      'replacement': StacRawJsonWidget({
        'type': 'visibility',
        'visible': '{{issuer.hasError}}',
        'child': _buildErrorScreen(fetchAction).toJson(),
        'replacement': _buildIssuerDataScreen(continueAction).toJson(),
      }).toJson(),
    }),
  );
}

StacWidget _buildLoadingScreen() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.selectDepositTitle}}',
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
    body: StacCenter(
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        children: [
          StacCircularProgressIndicator(),
          StacSizedBox(height: 16),
          StacText(
            data: 'در حال دریافت اطلاعات صادرکننده...',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildErrorScreen(StacAction onRetry) {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.issuanceTitle}}',
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
    body: StacCenter(
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacText(
              data: '{{issuer.error}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 14,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacElevatedButton(
            onPressed: onRetry,
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            child: StacText(
              data: 'تلاش مجدد',
              style: StacCustomTextStyle(
                color: '#FFFFFF',
                fontWeight: StacFontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildIssuerDataScreen(StacAction onContinue) {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.issuanceTitle}}',
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
                        data: '{{appStrings.promissory.issuerInfoTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 16),
                      _buildInfoRow(
                        label: '{{appStrings.promissory.nationalCode}}',
                        value: '{{userData.nationalCode}}',
                      ),
                      StacSizedBox(height: 16),
                      _buildInfoRow(
                        label: '{{appStrings.promissory.mobileNumber}}',
                        value: '{{userData.mobile}}',
                      ),
                      StacSizedBox(height: 16),
                      _buildInfoRow(
                        label: '{{appStrings.promissory.fullName}}',
                        value: '{{userData.fullName}}',
                      ),
                      StacSizedBox(height: 16),
                      _buildInfoRow(
                        label: '{{appStrings.promissory.depositShaba}}',
                        value: '{{selectedDeposit.depositIban}}',
                      ),
                    ],
                  ),
                ),
                StacSizedBox(height: 16),
                // Residence Information Card
                StacContainer(
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
                    crossAxisAlignment: StacCrossAxisAlignment.end,
                    children: [
                      StacText(
                        data: '{{appStrings.promissory.issuerResidenceTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 16),
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
                      StacText(
                        data: '{{appStrings.promissory.residencesAddress}}',
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
            onPressed: onContinue,
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
  );
}

StacWidget _buildInfoRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
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

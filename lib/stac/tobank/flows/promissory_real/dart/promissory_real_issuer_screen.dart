import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_detail_row.dart';

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
        dataBind: 'fetchCustomerInfo',
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
            'action': StacSequenceAction(
              actions: [
                StacLogAction(
                  message:
                      '❌❌❌ DEBUG:={{responses.fetchCustomerInfo.data.natinalCode}}',
                ).toJson(),
                StacCustomSetValueAction(
                  values: [
                    {
                      'key': 'userData.nationalCode',
                      'value':
                          '{{responses.fetchCustomerInfo.data.nationalCode}}',
                    },
                    {
                      'key': 'userData.contactNumber',
                      'value':
                          '{{responses.fetchCustomerInfo.data.contactNumber}}',
                    },
                    {
                      'key': 'userData.mobile',
                      'value':
                          '{{responses.fetchCustomerInfo.data.cellphoneNumber}}',
                    },
                    {
                      'key': 'userData.lastName',
                      'value': '{{responses.fetchCustomerInfo.data.lastName}}',
                    },
                    {
                      'key': 'userData.fatherName',
                      'value':
                          '{{responses.fetchCustomerInfo.data.fatherName}}',
                    },
                    {
                      'key': 'userData.fullName',
                      'value':
                          '{{responses.fetchCustomerInfo.data.firstName}} {{responses.fetchCustomerInfo.data.lastName}}',
                    },
                    {
                      'key': 'userData.birthDate',
                      'value': '{{responses.fetchCustomerInfo.data.birthDate}}',
                    },
                    {
                      'key': 'userData.postalCode',
                      'value': '{{responses.fetchCustomerInfo.data.postCode}}',
                    },
                    {
                      'key': 'userData.address',
                      'value': '{{responses.fetchCustomerInfo.data.address}}',
                    },
                    {'key': 'issuer.isLoading', 'value': false},
                    {'key': 'issuer.hasError', 'value': false},
                    {'key': 'issuer.showContent', 'value': true},
                  ],
                ).toJson(),
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
                      // خطا در برقراری ارتباط با سرور. لطفا مجددا تلاش کنید.
                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                },
              ],
            ).toJson(),
          },
        ],
      ),
    ],
  );

  final continueAction = const StacNavigateAction(
    routeName: 'promissory_real_receiver',
    navigationStyle: NavigationStyle.push,
  );

  return StacStatefulWidget(
    onInit: fetchAction,
    child: StacCustomVisibility(
      visible: '{{issuer.isLoading}}',
      child: _buildLoadingScreen().toJson(),
      replacement: StacCustomVisibility(
        visible: '{{issuer.hasError}}',
        child: _buildErrorScreen(fetchAction).toJson(),
        replacement: _buildIssuerDataScreen(continueAction).toJson(),
      ).toJson(),
    ),
  );
}

StacWidget _buildLoadingScreen() {
  return StacScaffold(
    appBar: buildPromissoryAppBar(
      // اطلاعات صادرکننده
      title: '{{appStrings.promissory.issuerTitle}}',
    ),
    body: StacCenter(
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        children: [
          StacCircularProgressIndicator(),
          StacSizedBox(height: 16),
          StacText(
            // در حال دریافت اطلاعات صادرکننده...
            data: '{{appStrings.promissory.issuerLoading}}',
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
    appBar: buildPromissoryAppBar(
      // اطلاعات صادرکننده
      title: '{{appStrings.promissory.issuerTitle}}',
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
              // تلاش مجدد
              data: '{{appStrings.common.tryAgain}}',
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
    appBar: buildPromissoryAppBar(
      // اطلاعات صادرکننده
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
                _buildIssuerCard(),
                StacSizedBox(height: 16),
                _buildResidenceCard(),
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
              // ادامه
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

StacWidget _buildIssuerCard() {
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
          // اطلاعات صادرکننده
          data: '{{appStrings.promissory.issuerInfoTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // کد ملی
          '{{appStrings.promissory.nationalCode}}',
          '{{userData.nationalCode}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // شماره موبایل
          '{{appStrings.promissory.mobileNumber}}',
          '{{userData.mobile}}',
        ),
        StacSizedBox(height: 16),
        buildPromissoryDetailRow(
          // نام و نام خانوادگی
          '{{appStrings.promissory.fullName}}',
          '{{userData.fullName}}',
        ),
        // StacSizedBox(height: 16),
        // buildPromissoryDetailRow(
        //   // شبا سپرده
        //   '{{appStrings.promissory.depositShaba}}',
        //   '{{selectedDeposit.depositIban}}',
        // ),
      ],
    ),
  );
}

StacWidget _buildResidenceCard() {
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
      crossAxisAlignment: StacCrossAxisAlignment.end,
      children: [
        StacText(
          // اطلاعات محل اقامت صادرکننده
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
          // کد پستی
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
          // آدرس محل اقامت
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
  );
}

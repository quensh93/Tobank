import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../utils/registry_notifier.dart';
import '../../builders/stac_stateful_widget.dart';
import '../../builders/stac_common_builders.dart';

/// Parser for the Promissory Real Issuer screen.
/// This parser handles loading, error, and success states internally.
class PromissoryRealIssuerParser extends StacParser<PromissoryRealIssuerModel> {
  const PromissoryRealIssuerParser();

  @override
  String get type => 'promissory_real_issuer_view';

  @override
  PromissoryRealIssuerModel getModel(Map<String, dynamic> json) {
    return PromissoryRealIssuerModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, PromissoryRealIssuerModel model) {
    return _PromissoryRealIssuerWidget(model: model);
  }
}

class PromissoryRealIssuerModel {
  final Map<String, dynamic>? onContinue;
  final Map<String, dynamic>? onRetry;

  const PromissoryRealIssuerModel({this.onContinue, this.onRetry});

  factory PromissoryRealIssuerModel.fromJson(Map<String, dynamic> json) {
    return PromissoryRealIssuerModel(
      onContinue: json['onContinue'] as Map<String, dynamic>?,
      onRetry: json['onRetry'] as Map<String, dynamic>?,
    );
  }
}

class _PromissoryRealIssuerWidget extends StatelessWidget {
  final PromissoryRealIssuerModel model;

  const _PromissoryRealIssuerWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, __) {
        final registry = StacRegistry.instance;
        final isLoaded = registry.getValue('issuer.isLoaded') == true;
        final errorMessage = registry.getValue('issuer.error')?.toString();

        final StacWidget stacWidget;
        if (!isLoaded) {
          stacWidget = _buildLoadingScreen();
        } else if (errorMessage != null && errorMessage.isNotEmpty) {
          stacWidget = _buildErrorScreen(
            message: errorMessage,
            onRetry: model.onRetry,
          );
        } else {
          stacWidget = _buildIssuerDataScreen(model.onContinue);
        }

        return Stac.fromJson(stacWidget.toJson(), context) ??
            const SizedBox.shrink();
      },
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

  StacWidget _buildErrorScreen({
    required String message,
    Map<String, dynamic>? onRetry,
  }) {
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
                data: message,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ),
            if (onRetry != null) ...[
              StacSizedBox(height: 16),
              StacElevatedButton(
                onPressed: StacRawJsonAction(onRetry),
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
          ],
        ),
      ),
    );
  }

  StacWidget _buildIssuerDataScreen(Map<String, dynamic>? onContinue) {
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
              onPressed: StacRawJsonAction(
                onContinue ??
                    {
                      'actionType': 'navigate',
                      'widgetType': 'promissory_real_receiver', 
                      'navigationStyle': 'push',
                    },
              ),
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
}

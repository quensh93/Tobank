import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_card_issue_result')
StacWidget depositCardIssueResult() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title:
          '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.title}}',
      showSupport: true,
      showBack: false,
    ),
    body: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.card}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.divider.color}}',
                width: 1,
              ),
            ),
            child: StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacContainer(
                    width: 64,
                    height: 64,
                    decoration: StacBoxDecoration(
                      color: '#E8F5E9',
                      borderRadius: StacBorderRadius.all(32),
                    ),
                    child: StacCenter(
                      child: StacImage(
                        src: '{{appAssets.current.icons.successCheck}}',
                        imageType: StacImageType.asset,
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                  StacSizedBox(height: 16),
                  StacText(
                    data:
                        '{{appStrings.generated.deposit_more_options.deposit_card_issue_result.title}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '#43A047',
                    ),
                  ),
                  StacSizedBox(height: 10),
                  StacText(
                    data:
                        '{{appStrings.generated.deposit_more_options.deposit_card_issue_result.request_card_result}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.hint}}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacExpanded(child: StacSizedBox(height: 0)),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              navigationStyle: NavigationStyle.pop,
            ),
            style: StacButtonStyle(
              fixedSize: StacSize(999999, 56),
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              elevation: 0,
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(16),
              ),
            ),
            child: StacText(
              data:
                  '{{appStrings.generated.authentication.authentication_signature_visual_guide.back}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
          StacSizedBox(height: 8),
        ],
      ),
    ),
  );
}

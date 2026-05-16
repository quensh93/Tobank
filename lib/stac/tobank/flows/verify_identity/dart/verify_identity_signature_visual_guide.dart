import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'verify_identity_signature_visual_guide')
StacWidget verifyIdentityRealSignatureVisualGuide() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: 'راهنمای تصویری امضا',
      showSupport: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacStack(
        children: [
          StacContainer(
            width: 999999,
            height: 999999,
            color: '{{appColors.current.background.surface}}',
          ),
          StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacExpanded(
                child: StacSingleChildScrollView(
                  padding: StacEdgeInsets.all(16),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacSizedBox(height: 20),
                      StacContainer(
                        height: 530,
                        decoration: StacBoxDecoration(
                          color:
                              '{{appColors.current.background.surfaceContainer}}',
                          borderRadius: StacBorderRadius.all(18),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 1,
                          ),
                        ),
                        child: StacClipRRect(
                          borderRadius: StacBorderRadius.all(18),
                          child: StacImage(
                            src: '{{appAssets.images.signatureSample}}',
                            imageType: StacImageType.asset,
                            fit: StacBoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StacPadding(
                padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: StacFilledButton(
                  onPressed: const StacNavigateAction(
                    navigationStyle: NavigationStyle.pop,
                  ),
                  style: StacButtonStyle(
                    backgroundColor: '{{appColors.current.primary.color}}',
                    foregroundColor: '{{appColors.current.primary.onPrimary}}',
                    minimumSize: const StacSize(999999, 54),
                    elevation: 0,
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ),
                  child: StacText(
                    data: 'بازگشت',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

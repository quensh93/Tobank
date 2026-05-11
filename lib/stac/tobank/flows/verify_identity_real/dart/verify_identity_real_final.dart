import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_final')
StacWidget verifyIdentityRealFinal() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      title: '{{appStrings.menu.items.verifyIdentity}}',
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacCenter(
                child: StacColumn(
                  mainAxisSize: StacMainAxisSize.min,
                  children: [
                    StacImage(
                      src: '{{appAssets.images.authenticationSuccess}}',
                      imageType: StacImageType.asset,
                      height: 210,
                      fit: StacBoxFit.contain,
                    ),
                    StacSizedBox(height: 28),
                    StacText(
                      data: 'احراز هویت شما با موفقیت انجام شد!',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.center,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StacFilledButton(
              onPressed: const StacNavigateAction(
                routeName: 'verify_identity_real_registration',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                elevation: 0,
                fixedSize: const StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              child: StacText(
                data: '{{appStrings.common.continue}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

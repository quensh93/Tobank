import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_final')
StacWidget verifyIdentityRealFinal() {
  return StacScaffold(
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
    body: StacPadding(
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
                    src: 'assets/images/authentication_success.png',
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
  );
}

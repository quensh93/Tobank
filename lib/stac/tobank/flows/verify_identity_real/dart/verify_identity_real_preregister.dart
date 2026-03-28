import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_preregister')
StacWidget verifyIdentityRealPreRegister() {
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
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: 'برای شروع احراز هویت شماره موبایل خود را تایید کنید',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.subtitle}}',
                    height: 1.8,
                  ),
                ),
                StacSizedBox(height: 32),
                StacText(
                  data: 'شماره موبایل',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16.5,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 12),
                StacContainer(
                  padding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    borderRadius: StacBorderRadius.all(12),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacText(
                    data: '09103611173',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.subtitle}}',
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
              routeName: 'verify_identity_real_verify_otp',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              elevation: 0,
              fixedSize: StacSize(999999, 64),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(14),
              ),
            ),
            child: StacText(
              data: 'دریافت کد فعالسازی',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

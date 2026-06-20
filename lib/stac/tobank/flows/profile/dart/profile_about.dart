import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_about')
StacWidget profileRealAbout() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: '{{appStrings.profile.real.menu.aboutUs}}',
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 32),
          StacCenter(
            child: StacImage(
              src: 'assets/icons/ic_tobank_red.svg',
              imageType: StacImageType.asset,
              width: 164,
              height: 40,
            ),
          ),
          StacSizedBox(height: 16),
          StacCenter(
            child: StacText(
              data: '{{appStrings.profile.real.about.slogan}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 32),
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacText(
              data: '{{appStrings.profile.real.about.description}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
                height: 1.9,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

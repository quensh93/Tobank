import 'package:stac_core/stac_core.dart';
import 'verify_identity_real_app_bar.dart';

@StacScreen(screenName: 'test_screen')
StacWidget testScreen() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildVerifyIdentityRealAppBar(
      title: 'احراز هویت',
    ),
    body: StacCenter(
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        children: [
          StacImage(
            src: '{{appAssets.icons.success}}',
            imageType: StacImageType.asset,
            width: 88,
            height: 88,
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'احراز هویت با موفقیت انجام شد',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 20,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
  );
}

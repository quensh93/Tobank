import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'test_screen')
StacWidget testScreen() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(showSupport: true, title: 'احراز هویت'),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacCenter(
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
    ),
  );
}

import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_primary_pin_result')
StacWidget dashboardPrimaryPinResult() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'نتیجه عملیات', showSupport: true, showBack: true),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 72,
              height: 72,
              decoration: StacBoxDecoration(
                color: '#E8F5E9',
                borderRadius: StacBorderRadius.all(36),
              ),
              child: StacCenter(
                child: StacImage(
                  src: '{{appAssets.current.icons.successCheck}}',
                  imageType: StacImageType.asset,
                  width: 40,
                  height: 40,
                  color: '#43A047',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'عملیات با موفقیت ثبت شد',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'درخواست شما با موفقیت ثبت گردید.',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w400,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacSizedBox(height: 48),
          StacFilledButton(
            onPressed: NavigationAction(fileName: 'dashboard_cards_management', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushAndRemoveAll),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'بازگشت به کارت‌ها',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

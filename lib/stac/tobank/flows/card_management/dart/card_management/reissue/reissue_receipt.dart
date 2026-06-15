import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'card_management_reissue_receipt')
StacWidget dashboardCardReissueReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'صدور کارت المثنی', showBack: false),
    body: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
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
                  color: '#43A047',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'درخواست شما با موفقیت ثبت شد!',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: 'کد رهگیری: ۱۵۰۳۳۱۹۱۵۱۹۸۳۲۸۴۲۲۴',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: 'مراتب از طریق پیامک به شما اطلاع داده خواهد شد.',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w400,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacExpanded(child: StacSizedBox(height: 0)),
          StacFilledButton(
            onPressed: NavigationAction(fileName: 'card_management_root', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushAndRemoveAll),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              elevation: 0,
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'بازگشت به لیست خدمات کارت',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
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

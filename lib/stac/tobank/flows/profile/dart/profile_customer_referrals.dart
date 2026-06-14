import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_customer_referrals')
StacWidget profileRealCustomerReferrals() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'لیست دعوت‌شدگان',
    ),
    body: StacCenter(
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacImage(
            src: 'assets/images/empty_list.png',
            imageType: StacImageType.asset,
            width: 200,
            height: 200,
            fit: StacBoxFit.contain,
          ),
          StacSizedBox(height: 24),
          StacText(
            data: 'موردی یافت نشد',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:stac_core/stac_core.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_customer_referrals')
StacWidget profileRealCustomerReferrals() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'Ù„ÛŒØ³Øª Ø¯Ø¹ÙˆØªâ€ŒØ´Ø¯Ú¯Ø§Ù†'),
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
            data: 'Ù…ÙˆØ±Ø¯ÛŒ ÛŒØ§ÙØª Ù†Ø´Ø¯',
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

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_about')
StacWidget profileRealAbout() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'درباره ما'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacText(
              data: 'TOBANK',
              style: StacCustomTextStyle(
                fontSize: 44,
                fontWeight: StacFontWeight.w800,
                color: '#D32F2F',
              ),
            ),
          ),
          StacSizedBox(height: 10),
          StacCenter(
            child: StacText(
              data: 'یک شعبه مجازی همراه شماست!',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data:
                'سوپر اپلیکیشن توبانک به عنوان محصول مشترک بانک گردشگری و شرکت نوین اندیشه'
                ' و آرامش آفرینان پاسارگاد، جامع در حوزه پرداخت و خدمات شعبه مجازی بانک گردشگری است.\n\n'
                'این سوپر اپلیکیشن علاوه بر خدمات پرداخت همچون کارت به کارت، در بستر خدمات مالی،'
                ' امکان افتتاح سپرده آنلاین، خرید شارژ و بسته اینترنتی تلفن همراه، دریافت تسهیلات'
                ' و انتقال وجه را بدون مراجعه حضوری برای شما میسر می‌کند.\n\n'
                'امنیت، سرعت، سادگی و تجربه کاربری متمرکز، باعث شده توبانک پاسخگوی نیازهای پرداختی'
                ' و مالی روزمره باشد.',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.justify,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
              height: 2,
            ),
          ),
        ],
      ),
    ),
  );
}

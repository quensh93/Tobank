import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_about')
StacWidget profileRealAbout() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'درباره ما',
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
              data: 'یک شعبه مجازی همراه شماست!',
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
              data:
                  'سوپر اپلیکیشن توبانک به عنوان محصول مشترک بانک گردشگری و شرکت نوین اندیشه '
                  'و آرامش آفرینان پاسارگاد، جامع در حوزه پرداخت و خدمات شعبه مجازی بانک گردشگری است. '
                  'این سوپر اپلیکیشن علاوه بر خدمات پرداخت همچون کارت به کارت، در بستر خدمات مالی، '
                  'استعلام خلافی خودرو و قبوض‌های متنوع و پرداخت آن‌ها و خرید شارژ و بسته‌ی اینترنتی تلفن همراه، '
                  'امکان احراز هویت و افتتاح سپرده آنلاین و رایگان در بانک گردشگری را نیز به مراجعه حضوری برای شما میسر می‌کند.\n\n'
                  'امنیت، سرعت، سادگی، تجربه کاربری منحصر‌به‌فرد، پوشش طیف گسترده‌ای از سرویس‌های متنوع، '
                  'یکی از بسترهای متفاوت دیگر و قابل اعتماد بودن، تمام آن چیزی است که مصرف‌کنندگان یک بستر خدماتی '
                  'در حوزه مالی به آن نیاز دارند. با توبانک نیاز به جابه‌جایی و بکارگیری روش‌های متفاوت برای '
                  'هرگونه پرداخت، اعم از نقد و انتقال پول و سرمایه‌گذاری برطرف می‌شود.',
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

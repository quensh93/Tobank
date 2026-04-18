import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_rules')
StacWidget profileRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'قوانین و مقررات'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacContainer(
        padding: StacEdgeInsets.all(14),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacText(
          data:
              'شرایط و مقررات ارائه خدمات توبانک\n'
              '۱- حدود مسئولیت و شرایط بانک\n'
              'امنیت سپرده‌ها و تضمین مبالغ مشتریان در چارچوب ضوابط قانونی و تعهدات بانک انجام می‌شود.\n\n'
              '۲- محرمانگی اطلاعات\n'
              'همه اطلاعات حساب‌ها و مدارک هویتی مشتریان محرمانه بوده و بانک جز در موارد مصرح قانونی از افشای آن خودداری می‌نماید.\n\n'
              '۳- ساعات پاسخگویی\n'
              'توبانک، یک بانک ۲۴ ساعته است و در هیچ روز و ساعتی از سال تعطیلی ندارد. تمام روزها و تمام ساعات شبانه‌روز، توبانک باز است.\n\n'
              '۴- پشتیبانی مشتریان\n'
              'توبانک از طریق مرکز امور مشتریان با شماره تماس ۲۳۹۵۰ داخلی ۷، موظف به پاسخگویی به مشتریان محترم می‌باشد.\n\n'
              '۵- پذیرش قوانین\n'
              'استفاده از خدمات توبانک به منزله مطالعه و پذیرش کامل قوانین و مقررات این سرویس است.\n\n'
              'کارمزدها\n'
              'درخواست‌های بانکی مشتریان با شفافیت کامل و مطابق تعرفه‌های مصوب انجام خواهد شد.',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
            height: 2,
          ),
        ),
      ),
    ),
  );
}

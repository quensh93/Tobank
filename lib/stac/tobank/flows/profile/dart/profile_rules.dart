import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_rules')
StacWidget profileRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'قوانین و مقررات',
    ),
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
              '''• مبالغ سيرده هاى مشتريان در جارجوب ضوابط قانونى و تا سقف قانونى تعيين شده، مورد تضمين صندوق ضمانت سيرده هاى بانك مركزى و بانك كَردشكَرى است.
• همهى اطلاعات حساب ها و مدارك هويتى مشتريان محرمانه بوده و بانك متعهد مى شود تحت هر شرايطى جز در موارد مصرحه قانونى و با دستور مراجع قانونى از
افشا آن خوددارى نمايد.
ساعات پاسخكويي
توبانك، يك بانك م٢ ساعته است و درهيج روز و ساعتى از سال، تعطيلى ندارد. تمام روزها و تمام ساعات شبانه روز، توبانك باز است.
• توبانك از طريق مركز امور مشتريان با شماره تماس
٢٣٩٥٠ داخلى ٧، موظف به پاسخكَويى به مشتريان
محترم مى باشد.
كارمزدها
• توبانك، كارت هاى بانكى درخواست شده مشتريان را براى بار اول، بهصورت رايكان و در كمترين زمان ممكن به دست مشتريان مى رساند.
. كليه هزينه ها وكارمزدهاى مرتبط با فرايند شناسايى مشترى، افتتاح حساب، صدور و ارسال كارت توسط توبانك پرداخت مى شود و خدمات مذكور براى مشتريان محترم رايكان است.'''
              '۱- حدود مسئولیت و شرایط بانک\n'
              'امنیت سپرده‌ها و تضمین مبالغ مشتریان در چارچوب ضوابط قانونی و تعهدات بانک انجام می‌شود.\n'
              '۲- محرمانگی اطلاعات\n'
              'همه اطلاعات حساب‌ها و مدارک هویتی مشتریان محرمانه بوده و بانک جز در موارد مصرح قانونی از افشای آن خودداری می‌نماید.\n'
              '۳- ساعات پاسخگویی\n'
              'توبانک، یک بانک ۲۴ ساعته است و در هیچ روز و ساعتی از سال تعطیلی ندارد. تمام روزها و تمام ساعات شبانه‌روز، توبانک باز است.\n'
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
          ),
        ),
      ),
    ),
  );
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const authenticationRealRulesSheetTitle = 'شرایط و مقررات ارائه خدمات توبانک';

class AuthenticationRealRuleSectionData {
  final String title;
  final List<String> paragraphs;

  const AuthenticationRealRuleSectionData({
    required this.title,
    required this.paragraphs,
  });
}

const authenticationRealRulesSections = <AuthenticationRealRuleSectionData>[
  AuthenticationRealRuleSectionData(
    title: 'حدود مسئولیت و شرایط بانک',
    paragraphs: [
      'امنیت سپرده‌ها و تضامین',
      'مبالغ سپرده‌های مشتریان در چارچوب ضوابط قانونی و تا سقف قانونی تعیین شده، مورد تضمین صندوق ضمانت سپرده های بانک مرکزی و بانک گردشگری است.',
      'همه‌ی اطلاعات حساب‌ها و مدارک هویتی مشتریان محرمانه بوده و بانک متعهد می‌شود تحت هر شرایطی جز در موارد مصرحه قانونی و با دستور مراجع قانونی از افشا آن خودداری نماید.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'ساعات پاسخگویی',
    paragraphs: [
      'توبانک ، یک بانک ۲۴ ساعته است و در هیچ روز و ساعتی از سال، تعطیلی ندارد. تمام روزها و تمام ساعات شبانه‌روز، توبانک باز است.',
      'توبانک از طریق مرکز امور مشتریان با شماره تماس23950 ، موظف به پاسخگویی به مشتریان محترم می‌باشد.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'کارمزدها',
    paragraphs: [
      'توبانک، کارت‌های بانکی درخواست شده مشتریان را برای بار اول، بصورت رایگان و در کمترین زمان ممکن به دست مشتریان می‌رساند.',
      'کلیه هزینه‌ها و کارمزدهای مرتبط با فرایند شناسایی مشتری، افتتاح حساب، صدور و ارسال کارت توسط توبانک پرداخت می‌شود و خدمات مذکور برای مشتریان محترم رایگان است.',
      'افتتاح حساب در توبانک، نیازمند هیچ مبلغ اولیه‌ای برای ذخیره‌سازی در حساب به استثنا موارد مصرحه قانونی نیست.',
      'هزینه هرگونه هدیه و تشویق مشتریان بابت دعوت مشتریان جدید، بر عهده توبانک است و مشتریان هیچ هزینه‌ای را به معرف بابت دریافت کد فعال‌سازی نباید پرداخت کنند.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'امنیت اطلاعات و حریم شخصی',
    paragraphs: [
      'تمامی موارد امنیتی که بر عهده بانک است توسط توبانک با کمال دقت رعایت خواهد شد و مسئولیت هرگونه تقصیر در این خصوص بر عهده توبانک است.',
      'حریم شخصی کاربران در هنگام استفاده از اپلیکیشن توبانک نظیر دسترسی به دوربین به جهت احراز هویت، حسگرهای بیومتریک به جهت ورود به اپلیکیشن، موقعیت مکانی به جهت دریافت کارت بانکی، مخاطبین به جهت خرید شارژ تلفن همراه، مدیریت فایل‌ها به جهت ذخیره رسید تراکنش‌ها و تشخیص اپلیکیشن‌های مخرب توسط توبانک رعایت می‌شود.',
      'توبانک موظف است اطلاعات هویتی و مدارک کاربران را در کمال دقت و جدیت نگهداری نماید؛ توبانک نیز با انجام نظارت، مسئولیت هرگونه سو استفاده از آن ها را تعهد می نماید.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'امکانات',
    paragraphs: [
      'کارت‌های بانکی ، به شبکه‌های سراسری شتاب و شاپرک متصل است و کاربران، امکان کار با همه دستگاه‌های خودپرداز شتابی سراسر کشور، دستگاه‌های کارتخوان فروشگاه‌ها، و درگاه‌های پرداخت اینترنتی را دارند.',
      'توبانک، نوآوری در محصولات و خدمات بانکی را وظیفه قطعی و حتمی خود می‌داند و مأموریت خود را خلق و طراحی چیزی بیشتر از گذشته می‌داند. این موضوع نه یک چشم‌انداز بلکه یکی از تعهدات ماست به مشتریان.',
      'توبانک ضروری می‌داند شفافیت کاملی در مبالغ کارمزدها، سودهای دریافتی و پرداختی و نیز عملیات مالی داشته باشد.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'حدود مسئولیت مشتری و شرایط لازم برای افتتاح حساب:',
    paragraphs: [
      'افتتاح حساب در توبانک بر اساس ضوابط، مقررات و دستورالعمل های بانکی ابلاغی از سوی بانک مرکزی و سایر مراجع قانونی است.',
      'کاربران با سن ۱۸ سال تمام و به بالا، می‌توانند نسبت به افتتاح سپرده سرمایه گذاری کوتاه مدت اقدام کنند. بانک گردشگری استرداد مبلغ اصل حساب را تعهد می نماید و وجوه حساب سرمایه گذاری را با حق توکیل به غیر ولو کرارا و در صورت فوت صاحب / صاحبان حساب به وصایت(از طرف صاحب/صاحبان حساب) طبق قانون عملیات بانکی بودن ربا به طور مشاع به کار گرفته و منافع حاصله را پس از کسر حق الوکاله و حق الوصایه با داشتن حق مصالحه طبق آیین نامه و مقررات مربوطه به تناسب مبلغ و مدت به ذینفع حساب ها یا قائم مقام قانونی ایشان پرداخت می نماید.',
      'صرفا صاحب حساب حق استفاده از موجودی حساب آن هم از درگاه‌های مورد تایید توبانک را دارد و در مواقع ضروری پیش بینی شده در قانون مثل فوت، حجر و ... ، استفاده از حساب صرفا از طریق مرکز عملیات توبانک برای صاحب حساب و یا نماینده قانونی او (ولی، وصی، قیم و وکیل) پس از ارایه مدارک و گواهی‌های مثبته قانونی و رعایت تشریفات مالیاتی ممکن خواهد بود.',
      'مشتری می‌تواند از طریق توبانک بر اساس ضوابط و مقررات اعلامی از سوی بانک مرکزی یا آیین‌نامه‌های داخلی بانک، مبالغ را از حساب خود به هر حسابی در بانک گردشگری و سایر بانک‌ها منتقل نماید.',
      'در صورتی که بانک به هر طریقی از فوت، حجر و ورشکستگی دارنده حساب یا استفاده‌کننده از خدمات الکترونیکی مطلع گردد و همچنین در مواردی که نامه‌ای از مراجع ذیصلاح قانونی که حق بازداشت اموال اشخاص را دارند دریافت نماید، خدمات مذکور را غیرفعال نموده و با مانده حساب‌های مرتبط به آن طبق شرایط و مقررات حساب‌های مذکور عمل خواهد نمود.',
      'کارت بانکی ، به آدرس اعلامی مشتریان ارسال می‌شود و دریافت رمزها، در اپلیکیشن انجام می‌شود.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'احراز هویت مشتری',
    paragraphs: [
      'مشتری با رضایت کامل اقرار نمود کلیه اطلاعات احراز هویت را مطابق با واقعیت و منطبق بر آخرین مدارک شناسایی خود در اختیار توبانک قرار داده است.',
      'توبانک در صورت عدم احراز شرایط مقرر برای احراز هویت یا صلاحیت متقاضیان، می‌تواند از افتتاح حساب خودداری نماید.',
      'به منظور رعایت اصول امنیتی و مراقبت از اطلاعات و حقوق مشتریان، این حق برای توبانک محفوظ است که فرایند شناسایی مشتری را در هر زمانی که لازم است تکرار و اطلاعات مشتری را صحه‌گذاری نماید.',
      'متقاضی افتتاح حساب، به توبانک اجازه می‌دهد تا برای شناسایی هویت و اعتبارسنجی وی، از مراجع قانونی و با صلاحیت نظیر بانک مرکزی و سازمان ثبت احوال، در مورد اطلاعات وی استعلام نماید.',
      'تعریف مشتری و افتتاح حساب برای وی، مستلزم استعلام‌هایی از بانک مرکزی و ثبت احوال و نیز تطابق آنها با اطلاعات اظهار شده‌ی کاربر است؛ در صورت عدم تطابق اطلاعات مشتری و یا وجود اشکال سیستمی در استعلام، مسئولیتی متوجه توبانک نخواهد بود.',
      'توبانک برای ارائه خدمات به مشتریان شناسایی شده، با رعایت کامل اصول و استانداردهای امنیتی، از روش‌هایی نظیر شناسایی با رمز اختصاصی یا ویژگی‌های بایومتریک استفاده می‌کند که به منزله تشخیص با امضای مشتری بوده و این موضوع مورد تایید و موافقت مشتری می‌باشد.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'شرایط عملیاتی توبانک',
    paragraphs: [
      'توبانک فاقد شعبه فیزیکی برای مراجعه و انجام عملیات بانکی است و همه امور مشتریان از درگاه اپلیکیشن انجام می‌شود.',
      'در مواردی که بنا به عللی از قبیل خرابی زیرساختهای اینترنتی، اختلال یا قطع خطوط ارتباطی و سایر رویدادهای اجتناب‌ناپذیر که خارج از کنترل توبانک باشد، این بانک قادر به ارائه خدمات بانکی نخواهد بود که جزئی از ماهیت یک سرویس‌های تمام دیجیتال است.',
    ],
  ),
  AuthenticationRealRuleSectionData(
    title: 'اختیارات توبانک',
    paragraphs: [
      'صاحب حساب ضمن عقد خارج لازم و به طور غیرقابل برگشت به بانک اختیار داد که اگر توبانک تحت هر عنوان اشتباها و یا من غیر حق وجوه یا ارقامی اضافه بر حساب مشتری منظور و یا در محاسبه هر نوع اشتباهی نماید، مجاز است راسا و بدون نیاز به هرگونه تشریفات اداری و قضایی نسبت به رفع اشتباه و برگشت از حساب وی اقدام نماید، چنانچه مشتری وجوه را قبلا برداشت نماید، بدینوسیله تعهد نمود که ظرف مدت 3 روز کاری پس از اخطار کتبی بانک نسبت به استرداد وجه اقدام نماید در غیر این صورت علاوه بر استرداد اصل وجوه استفاده شده، وجه التزامی( معادل بالاترین نرخ سود تسهیلات اعطایی در بخش خدمات به علاوه 6 درصد) از تاریخ برداشت به بانک پرداخت نماید. تشخیص بانک در مورد وقوع اشتباه یا پرداخت بدون حق و لزوم برگشت از حساب معتبر بوده و صاحب حساب حق هرگونه اعتراضی را در این خصوص از خود سلب نمود.',
    ],
  ),
];

@StacScreen(screenName: 'authentication_rules')
StacWidget authenticationRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.authentication.rulesTitle}}',
      showSupport: false,
      showBack: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacContainer(
              height: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacSizedBox(height: 24),
            StacExpanded(
              child: StacSingleChildScrollView(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacText(
                      data: authenticationRealRulesSheetTitle,
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 17,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 12),
                    ...authenticationRealRulesSections.map(
                      (section) =>
                          _buildRuleSection(section.title, section.paragraphs),
                    ),
                    StacSizedBox(height: 20),
                    StacPadding(
                      padding: StacEdgeInsets.only(bottom: 12),
                      child: StacElevatedButton(
                        onPressed: const StacNavigateAction(
                          navigationStyle: NavigationStyle.pop,
                        ),
                        style: StacButtonStyle(
                          backgroundColor: '#FFFFFF',
                          foregroundColor: '#D61F2C',
                          elevation: 0,
                          fixedSize: StacSize(999999, 67),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(13),
                            side: const StacBorderSide(
                              color: '#D61F2C',
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: StacText(
                          data: 'متوجه شدم',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 17,
                            fontWeight: StacFontWeight.w700,
                            color: '#D61F2C',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildRuleSection(String title, List<String> paragraphs) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 4),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
            height: 1.8,
          ),
        ),
        ...paragraphs.map(_buildRuleParagraph),
      ],
    ),
  );
}

StacWidget _buildRuleParagraph(String description) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 12),
    child: StacText(
      data: description,
      textDirection: StacTextDirection.rtl,
      textAlign: StacTextAlign.right,
      style: StacCustomTextStyle(
        fontSize: 15,
        fontWeight: StacFontWeight.w500,
        color: '{{appColors.current.text.subtitle}}',
        height: 1.9,
      ),
    ),
  );
}

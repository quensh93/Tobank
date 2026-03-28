import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_rules')
StacWidget verifyIdentityRealRules() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildPromissoryAppBar(
      title: '{{appStrings.login.rulesAndRegulations}}',
    ),
    body: StacPadding(
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
                    data: 'شرایط و مقررات ارائه خدمات توبانک',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 20),
                  _buildRuleItem(
                    '۱- حدود مسئولیت و شرایط بانک',
                    'امنیت سپرده‌ها و تضمین مبالغ مشتریان در چارچوب ضوابط قانونی و تعهدات بانک انجام می‌شود.',
                  ),
                  _buildRuleItem(
                    '۲- محرمانگی اطلاعات',
                    'همه اطلاعات حساب‌ها و مدارک هویتی مشتریان محرمانه بوده و بانک جز در موارد مصرح قانونی از افشای آن خودداری می‌نماید.',
                  ),
                  _buildRuleItem(
                    '۳- ساعات پاسخگویی',
                    'توبانک یک بانک ۲۴ ساعته است و در هیچ روز و ساعتی از سال تعطیلی ندارد. تمام روزها و تمام ساعات شبانه‌روز، توبانک باز است.',
                  ),
                  _buildRuleItem(
                    '۴- پشتیبانی مشتریان',
                    'توبانک از طریق مرکز امور مشتریان با شماره تماس ۲۳۹۵۰ داخلی ۷، موظف به پاسخگویی به مشتریان محترم است.',
                  ),
                  _buildRuleItem(
                    '۵- پذیرش قوانین',
                    'استفاده از خدمات احراز هویت به منزله مطالعه و پذیرش کامل قوانین و مقررات توبانک توسط کاربر است.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildRuleItem(String title, String description) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 18),
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
            color: '{{appColors.current.text.subtitle}}',
            height: 1.8,
          ),
        ),
        StacText(
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
      ],
    ),
  );
}

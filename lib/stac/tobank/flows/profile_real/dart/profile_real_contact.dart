import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_contact')
StacWidget profileRealContact() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'تماس با ما'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          _contactCard(
            label: 'آدرس',
            value: 'تهران، سعادت‌آباد، بلوار فرهنگ، نبش کوچه نور، پلاک ۶',
          ),
          StacSizedBox(height: 12),
          _contactCard(label: 'کد پستی', value: '۱۹۹۷۷۴۴۵۳۷'),
          StacSizedBox(height: 12),
          _contactCard(label: 'پشتیبانی شعبه', value: 'داخلی ۳ - ۰۲۱۲۳۹۵۰'),
          StacSizedBox(height: 12),
          _contactCard(
            label: 'اینستاگرام بانک گردشگری',
            value: '@tourism.bank',
          ),
          StacSizedBox(height: 28),
          StacCenter(
            child: StacText(
              data: 'ارتباط با توبانک',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 25,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(height: 18),
          _socialRow(icons: ['language', 'mail', 'call']),
          StacSizedBox(height: 16),
          _socialRow(icons: ['sports_soccer', 'business_center', 'camera_alt']),
        ],
      ),
    ),
  );
}

StacWidget _contactCard({required String label, required String value}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _socialRow({required List<String> icons}) {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.center,
    children: icons
        .map(
          (icon) => StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 8),
            child: StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '#F9EBEE',
                shape: StacBoxShape.circle,
              ),
              child: StacIconButton(
                onPressed: const StacShowResultAction(
                  title: 'لینک شبکه اجتماعی',
                  content: 'این بخش به زودی فعال می‌شود.',
                ),
                icon: StacIcon(icon: icon, color: '#D32F2F', size: 20),
              ),
            ),
          ),
        )
        .toList(),
  );
}

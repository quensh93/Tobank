import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/verify_identity_real/dart/widgets/verify_identity_real_app_bar.dart';

const List<String> verifyIdentityRealJobTitles = [
  'پزشک',
  'بازرگانی',
  'بازنشسته',
  'تولیدی',
  'خدماتی',
  'ساختمانی',
  'فرهنگی',
  'کارمند دولت',
  'مراکز تفریحی، ورزشی، موزه، دینی و...',
  'وکالت',
  'خانه دار',
  'مستمری بگیر',
  'دانشجو',
  'بیکار',
  'دارای بیمه بیکاری',
  'اشخاص خارجی فاقد مجوز فعالیت معتبر',
  'سایر فعالان گردشگری(صنایع دستی، راهنمایان تور،و...',
];

@StacScreen(screenName: 'verify_identity_real_job_selector')
StacWidget verifyIdentityRealJobSelector() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildVerifyIdentityRealAppBar(
      title: '{{appStrings.menu.items.verifyIdentity}}',
      showSupport: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: buildVerifyIdentityRealJobSelectorContent(showHandle: false),
    ),
  );
}

StacWidget buildVerifyIdentityRealJobSelectorContent({
  required bool showHandle,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      if (showHandle) StacSizedBox(height: 8),
      if (showHandle)
        StacCenter(
          child: StacContainer(
            width: 44,
            height: 4,
            decoration: StacBoxDecoration(
              color: '#D9DDE5',
              borderRadius: StacBorderRadius.all(999),
            ),
          ),
        ),
      StacSizedBox(height: showHandle ? 18 : 24),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16),
        child: StacText(
          data: 'حوزه فعالیت خود را انتخاب کنید',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      StacSizedBox(height: 16),
      StacExpanded(
        child: StacSingleChildScrollView(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: verifyIdentityRealJobTitles
                .map((title) => _buildJobListItem(title))
                .toList(),
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildJobListItem(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'verifyIdentitySelectedJobTitle', 'value': title},
            {'key': 'verifyIdentityHasSelectedJob', 'value': true},
          ],
        ),
        const StacNavigateAction(navigationStyle: NavigationStyle.pop),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: StacBoxDecoration(
        border: StacBorder(
          bottom: StacBorderSide(
            color: '{{appColors.current.background.surfaceContainerHigh}}',
            width: 1,
          ),
        ),
      ),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
  );
}

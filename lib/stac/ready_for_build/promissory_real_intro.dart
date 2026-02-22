import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

/// Promissory Real Flow - Intro Screen
///
/// This is the main visual intro screen for the Real Promissory flow.
/// It contains the Tabs (Services/My Notes) and the Service Cards.
@StacScreen(screenName: 'promissory_real_intro')
StacWidget promissoryRealIntro() {
  return StacScaffold(
    // سفته الکترونیک
    appBar: buildPromissoryAppBar(title: '{{appStrings.promissory.title}}'),
    body: StacColumn(
      children: [
        StacSizedBox(height: 16),
        _buildTabs(),
        StacSizedBox(height: 16),
        _buildTitleCard(),
        StacSizedBox(height: 12),
        StacExpanded(
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(horizontal: 16),
            child: _buildServiceCards(),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildTabs() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacColumn(
            children: [
              StacText(
                // خدمات سفته
                data: '{{appStrings.promissory.servicesTab}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacContainer(
                width: 40,
                height: 3,
                decoration: StacBoxDecoration(
                  color: '#D32F2F',
                  borderRadius: StacBorderRadius.all(2),
                ),
              ),
            ],
          ),
        ),
        StacContainer(
          width: 1,
          height: 24,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacExpanded(
          child: StacGestureDetector(
            onTap: const StacShowResultAction(
              // به زودی
              title: '{{appStrings.common.comingSoon}}',
              // این بخش در حال توسعه است.
              content: '{{appStrings.promissory.myNotesComingSoon}}',
            ),
            child: StacCenter(
              child: StacText(
                // سفته‌های من
                data: '{{appStrings.promissory.myNotesTab}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildTitleCard() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            // سفته الکترونیک
            data: '{{appStrings.promissory.title}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildServiceCards() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildServiceCard(
        icon: 'assets/icons/ic_promissory_request.svg',
        // صدور سفته
        title: '{{appStrings.promissory.requestPromissory}}',
        // صدور سفته آنلاین
        description: '{{appStrings.promissory.requestPromissoryDesc}}',
        onTap: StacNavigateAction(
          routeName: 'promissory_real_rules',
          navigationStyle: NavigationStyle.push,
        ),
      ),
      StacSizedBox(height: 12),
      _buildServiceCard(
        icon: 'assets/icons/ic_promissory_guarantee.svg',
        // ضمانت سفته
        title: '{{appStrings.promissory.guaranteePromissory}}',
        // بدون پرداخت وجه برای ضمانت کننده
        description: '{{appStrings.promissory.guaranteePromissoryDesc}}',
        onTap: const StacShowResultAction(
          // به زودی
          title: '{{appStrings.common.comingSoon}}',
          // این بخش در حال توسعه است.
          content: '{{appStrings.promissory.comingSoonMessage}}',
        ),
      ),
      StacSizedBox(height: 12),
      _buildServiceCard(
        icon: 'assets/icons/ic_promissory_inquiry.svg',
        // استعلام سفته
        title: '{{appStrings.promissory.viewPromissory}}',
        // مشاهده جزئیات سفته
        description: '{{appStrings.promissory.viewPromissoryDesc}}',
        onTap: const StacShowResultAction(
          // به زودی
          title: '{{appStrings.common.comingSoon}}',
          // این بخش در حال توسعه است.
          content: '{{appStrings.promissory.comingSoonMessage}}',
        ),
      ),
    ],
  );
}

StacWidget _buildServiceCard({
  required String icon,
  required String title,
  required String description,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacContainer(
            width: 48,
            height: 48,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacCenter(
              child: StacImage(
                src: icon,
                imageType: StacImageType.asset,
                width: 30,
                height: 30,
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 4),
                StacText(
                  data: description,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 12,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

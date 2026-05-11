import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

/// Promissory Real Flow - Intro Screen
///
/// Tabs are stateful and user can switch between:
/// 1) خدمات سفته
/// 2) سفته‌های من
@StacScreen(screenName: 'promissory_real_intro')
StacWidget promissoryRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isElectronicPromissoryExpanded', 'value': false},
      ],
    ),
    child: StacScaffold(
      // سفته انلاین
      appBar: buildTobankFlowAppBar(
        showSupport: false,
        backIconSrc: 'assets/icons/ic_right_arrow.svg',
        title: '{{appStrings.promissory.PromissoryTitle}}',
      ),
      body: StacDefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StacColumn(
          children: [
            StacSizedBox(height: 16),
            _buildTabs(),
            StacSizedBox(height: 8),
            StacContainer(
              height: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacSizedBox(height: 16),
            StacExpanded(
              child: StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 16),
                child: StacTabBarView(
                  children: [
                    _buildMyPromissoryCards(),
                    _buildServicesTabContent(),
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

StacWidget _buildTabs() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    child: StacStack(
      children: [
        StacTabBar(
          enableFeedback: false,
          dividerColor: '#00000000',
          indicatorColor: '#D32F2F',
          indicatorWeight: 3,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 42, top: 32, right: 42),
          labelStyle: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w700,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.subtitle}}',
          tabs: const [
            StacTab(text: '{{appStrings.promissory.myNotesTab}}', height: 34),
            StacTab(text: '{{appStrings.promissory.servicesTab}}', height: 34),
          ],
        ),
        StacPositioned(
          top: 4,
          bottom: 4,
          left: 0,
          right: 0,
          child: StacCenter(
            child: StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildServicesTabContent() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildTitleCard(),
      StacSizedBox(height: 12),
      StacExpanded(
        child: StacSingleChildScrollView(child: _buildServiceCards()),
      ),
    ],
  );
}

StacWidget _buildMyPromissoryCards() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _buildMyPromissoryCard(
          icon: 'assets/icons/ic_promissory_request_history.svg',
          title: 'تکمیل شده',
        ),
        StacSizedBox(height: 12),
        _buildMyPromissoryCard(
          icon: 'assets/icons/ic_promissory_finalize_history.svg',
          title: 'در انتظار تکمیل',
        ),
      ],
    ),
  );
}

StacWidget _buildMyPromissoryCard({
  required String icon,
  required String title,
}) {
  return StacGestureDetector(
    onTap: const StacShowResultAction(
      title: '{{appStrings.common.comingSoon}}',
      content: '{{appStrings.promissory.comingSoonMessage}}',
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
          StacImage(
            src: icon,
            imageType: StacImageType.asset,
            width: 21,
            height: 21,
          ),
          StacSizedBox(width: 9),
          StacExpanded(
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
        ],
      ),
    ),
  );
}

StacWidget _buildTitleCard() {
  return StacGestureDetector(
    onTap: const StacCustomSetValueAction(
      key: 'isElectronicPromissoryExpanded',
      value: '{{isElectronicPromissoryExpanded ? false : true}}',
    ),
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
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: StacText(
                  data: '{{appStrings.promissory.title}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
              StacSizedBox(width: 8),
              StacCustomVisibility(
                visible: '[[isElectronicPromissoryExpanded]]',
                child: StacImage(
                  src: 'assets/icons/ic_arrow_circle_up.svg',
                  imageType: StacImageType.asset,
                  width: 23,
                  height: 23,
                ).toJson(),
                replacement: StacImage(
                  src: 'assets/icons/ic_arrow_circle_down.svg',
                  imageType: StacImageType.asset,
                  width: 23,
                  height: 23,
                ).toJson(),
              ),
            ],
          ),
          StacCustomVisibility(
            visible: '[[isElectronicPromissoryExpanded]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacSizedBox(height: 12),
                StacContainer(
                  height: 1,
                  color: '{{appColors.current.input.borderEnabled}}',
                ),
                StacSizedBox(height: 12),
                StacText(
                  data:
                      'سفته الکترونیکی، یک سند تجاری است که به صورت الکترونیکی، صادر شده و به موجب آن، صادر‌کننده، پرداخت مبلغی را در قبال شخص دیگر، متعهد میشود',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ).toJson(),
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
        title: '{{appStrings.promissory.requestPromissory}}',
        description: '{{appStrings.promissory.requestPromissoryDesc}}',
        onTap: StacNavigateAction(
          routeName: 'promissory_real_rules',
          navigationStyle: NavigationStyle.push,
        ),
      ),
      StacSizedBox(height: 12),
      _buildServiceCard(
        icon: 'assets/icons/ic_promissory_guarantee.svg',
        title: '{{appStrings.promissory.guaranteePromissory}}',
        description: '{{appStrings.promissory.guaranteePromissoryDesc}}',
        onTap: const StacShowResultAction(
          title: '{{appStrings.common.comingSoon}}',
          content: '{{appStrings.promissory.comingSoonMessage}}',
        ),
      ),
      StacSizedBox(height: 12),
      _buildServiceCard(
        icon: 'assets/icons/ic_promissory_inquiry.svg',
        title: '{{appStrings.promissory.viewPromissory}}',
        description: '{{appStrings.promissory.viewPromissoryDesc}}',
        onTap: const StacShowResultAction(
          title: '{{appStrings.common.comingSoon}}',
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

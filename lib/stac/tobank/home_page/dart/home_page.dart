import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'tobank_home_page_dart')
StacWidget tobankHomePageDart() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'homePage.tab.deposits', 'value': true},
        {'key': 'homePage.tab.cards', 'value': false},
        {'key': 'homePage.tab.investment', 'value': false},
        {'key': 'homePage.tab.services', 'value': false},
        {'key': 'homePage.authenticated', 'value': false},
        {'key': 'homePage.balanceVisible', 'value': false},
        {'key': 'homePage.depositPageIndex', 'value': 3},
        {'key': 'homePage.page.create', 'value': false},
        {'key': 'homePage.page.first', 'value': false},
        {'key': 'homePage.page.second', 'value': false},
        {'key': 'homePage.page.third', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacPadding(
            padding: StacEdgeInsets.only(left: 24, top: 20, right: 24),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                StacSizedBox(height: 24),
                _buildTopTabs(),
                StacSizedBox(height: 8),
              ],
            ),
          ),
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildHeader() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    textDirection: StacTextDirection.rtl,
    children: [
      StacImage(
        src: 'assets/icons/ic_tobank_logo.svg',
        imageType: StacImageType.asset,
        width: 118,
        height: 32,
      ),
      StacRow(
        children: [
          _buildHeaderIcon('assets/icons/ic_support.svg'),
          StacSizedBox(width: 18),
          _buildHeaderIcon('assets/icons/ic_notification_unread.svg'),
          StacSizedBox(width: 18),
          _buildHeaderIcon('assets/icons/ic_instagram.svg'),
        ],
      ),
    ],
  );
}

StacWidget _buildHeaderIcon(String assetPath) {
  return StacContainer(
    width: 26,
    height: 26,
    alignment: StacAlignment.center,
    child: StacImage(
      src: assetPath,
      imageType: StacImageType.asset,
      width: 24,
      height: 24,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacRow(
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      _buildTopTab(
        isSelectedKey: 'homePage.tab.services',
        label: 'خدمات',
        iconPath: 'assets/icons/ic_more_services.svg',
        action: _buildTabAction(
          deposits: false,
          cards: false,
          investment: false,
          services: true,
        ),
      ),
      _buildTabDivider(),
      _buildTopTab(
        isSelectedKey: 'homePage.tab.investment',
        label: 'سرمایه‌گذاری',
        iconPath: 'assets/icons/ic_finance.svg',
        action: _buildTabAction(
          deposits: false,
          cards: false,
          investment: true,
          services: false,
        ),
      ),
      _buildTabDivider(),
      _buildTopTab(
        isSelectedKey: 'homePage.tab.cards',
        label: 'کارت‌ها',
        iconPath: 'assets/icons/ic_card.svg',
        action: _buildTabAction(
          deposits: false,
          cards: true,
          investment: false,
          services: false,
        ),
      ),
      _buildTabDivider(),
      _buildTopTab(
        isSelectedKey: 'homePage.tab.deposits',
        label: 'سپرده‌ها',
        iconPath: 'assets/icons/ic_stored_deposit.svg',
        action: _buildTabAction(
          deposits: true,
          cards: false,
          investment: false,
          services: false,
        ),
      ),
    ],
  );
}

StacWidget _buildTopTab({
  required String isSelectedKey,
  required String label,
  required String iconPath,
  required StacAction action,
}) {
  return StacExpanded(
    child: StacTextButton(
      onPressed: action,
      style: StacButtonStyle(
        padding: StacEdgeInsets.all(0),
        minimumSize: const StacSize(0, 0),
        overlayColor: '#00000000',
        tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
      ),
      child: StacCustomVisibility(
        visible: '[[$isSelectedKey]]',
        child: _buildSelectedTopTab(iconPath: iconPath, label: label).toJson(),
        replacement: _buildUnselectedTopTab(
          iconPath: iconPath,
          label: label,
        ).toJson(),
      ),
    ),
  );
}

StacWidget _buildSelectedTopTab({
  required String iconPath,
  required String label,
}) {
  return StacColumn(
    children: [
      StacSizedBox(
        height: 32,
        child: StacCenter(
          child: StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.primary.color}}',
          ),
        ),
      ),
      StacSizedBox(height: 4),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 12,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 13),
    ],
  );
}

StacWidget _buildUnselectedTopTab({
  required String iconPath,
  required String label,
}) {
  return StacColumn(
    children: [
      StacSizedBox(
        height: 32,
        child: StacCenter(
          child: StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(height: 4),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 12,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 13),
    ],
  );
}

StacWidget _buildTabDivider() {
  return StacContainer(
    width: 1,
    height: 24,
    margin: StacEdgeInsets.only(top: 8, left: 8, right: 8),
    color: '{{appColors.current.input.borderEnabled}}',
  );
}

StacAction _buildTabAction({
  required bool deposits,
  required bool cards,
  required bool investment,
  required bool services,
}) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'homePage.tab.deposits', 'value': deposits},
      {'key': 'homePage.tab.cards', 'value': cards},
      {'key': 'homePage.tab.investment', 'value': investment},
      {'key': 'homePage.tab.services', 'value': services},
    ],
  );
}

StacWidget _buildTabContent() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacCustomVisibility(
        visible: '[[homePage.tab.deposits]]',
        child: _buildDepositsTab().toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.tab.cards]]',
        child: _buildPlaceholderTab('کارت‌ها').toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.tab.investment]]',
        child: _buildPlaceholderTab('سرمایه‌گذاری').toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.tab.services]]',
        child: _buildPlaceholderTab('خدمات').toJson(),
      ),
    ],
  );
}

StacWidget _buildPlaceholderTab(String label) {
  return StacContainer(
    height: 360,
    alignment: StacAlignment.center,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(24),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacText(
      data: label,
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 24,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.text.subtitle}}',
      ),
    ),
  );
}

StacWidget _buildDepositsTab() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacCustomVisibility(
        visible: '[[homePage.authenticated]]',
        child: _buildAuthenticatedDepositsState().toJson(),
        replacement: _buildUnauthenticatedDepositsState().toJson(),
      ),
      StacSizedBox(height: 28),
      StacText(
        data: 'خدمات ویژه توبانک',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 18),
      StacRow(
        children: [
          StacExpanded(
            child: _buildServiceCard(
              title: 'سایر خدمات',
              subtitle: 'سفته الکترونیک ...',
              iconPath: 'assets/icons/ic_more_services.svg',
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _buildServiceCard(
              title: 'انواع تسهیلات',
              subtitle: 'ازدواج، کارت اعتباری ...',
              iconPath: 'assets/icons/ic_card_service.svg',
            ),
          ),
        ],
      ),
      StacSizedBox(height: 18),
      _buildHomeBannerCarousel(),
      StacSizedBox(height: 10),
      _buildStaticCustomerClubBanner(),
    ],
  );
}

StacWidget _buildUnauthenticatedDepositsState() {
  return StacCard(
    color: '{{appColors.current.background.surfaceContainerLowest}}',
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    shape: StacRoundedRectangleBorder(
      borderRadius: StacBorderRadius.all(12),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacText(
            data:
                'کاربر گرامی، برای فعال سازی خدمات مرتبط با سپرده‌های بانک گردشگری، لطفا فرآیند احراز هویت را تکمیل نمایید.',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
              height: 1.6,
            ),
          ),
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: const StacCustomSetValueAction(
              values: [
                {'key': 'homePage.authenticated', 'value': true},
                {'key': 'homePage.balanceVisible', 'value': false},
                {'key': 'homePage.depositPageIndex', 'value': 3},
                {'key': 'homePage.page.create', 'value': false},
                {'key': 'homePage.page.first', 'value': false},
                {'key': 'homePage.page.second', 'value': false},
                {'key': 'homePage.page.third', 'value': true},
              ],
            ),
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              minimumSize: const StacSize(0, 48),
              padding: StacEdgeInsets.symmetric(vertical: 10),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'احراز هویت',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
          StacSizedBox(height: 32),
          _buildQuickActionsRow(),
        ],
      ),
    ),
  );
}

StacWidget _buildAuthenticatedDepositsState() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacCustomVisibility(
        visible: '[[homePage.page.create]]',
        child: _buildCreateDepositCard().toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.page.first]]',
        child: _buildExistingDepositCard(
          accountNumber: '110.55.4203401',
          accountTitle: 'حساب قرض الحسنه جاری توبانک',
        ).toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.page.second]]',
        child: _buildExistingDepositCard(
          accountNumber: '110.79.1754212',
          accountTitle: 'حساب قرض الحسنه جاری سپرده دوم',
        ).toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.page.third]]',
        child: _buildExistingDepositCard(
          accountNumber: '110.79.1755809.1',
          accountTitle: 'حساب قرض الحسنه جاری حقیقی توبانک',
        ).toJson(),
      ),
      StacSizedBox(height: 16),
      _buildDepositIndicators(),
    ],
  );
}

StacWidget _buildCreateDepositCard() {
  return StacCard(
    color: '{{appColors.current.background.surfaceContainerLowest}}',
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    shape: StacRoundedRectangleBorder(
      borderRadius: StacBorderRadius.all(24),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(18),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            textDirection: StacTextDirection.rtl,
            crossAxisAlignment: StacCrossAxisAlignment.center,
            children: [
              StacImage(
                src: 'assets/icons/ic_deposit.svg',
                imageType: StacImageType.asset,
                width: 54,
                height: 54,
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacText(
                  data: 'افتتاح سپرده بانک گردشگری',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 18),
          StacRow(
            textDirection: StacTextDirection.rtl,
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacImage(
                src: '{{appAssets.icons.success}}',
                imageType: StacImageType.asset,
                width: 22,
                height: 22,
              ),
              StacSizedBox(width: 10),
              StacExpanded(
                child: StacText(
                  data: 'کوتاه مدت، قرض الحسنه پس انداز، بلندمدت و ...',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                    height: 1.8,
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 22),
          StacFilledButton(
            style: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              padding: StacEdgeInsets.symmetric(vertical: 18),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(18),
              ),
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: 'افتتاح سپرده',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                  ),
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: '+',
                  style: StacCustomTextStyle(
                    fontSize: 24,
                    fontWeight: StacFontWeight.w700,
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

StacWidget _buildExistingDepositCard({
  required String accountNumber,
  required String accountTitle,
}) {
  return StacCard(
    color: '{{appColors.current.background.surfaceContainerLowest}}',
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    shape: StacRoundedRectangleBorder(
      borderRadius: StacBorderRadius.all(24),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(18),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacCustomOpacity(
                opacity: 0.14,
                child: StacImage(
                  src: 'assets/icons/ic_deposit_bg_dark.svg',
                  imageType: StacImageType.asset,
                  width: 118,
                  height: 122,
                  fit: StacBoxFit.contain,
                ).toJson(),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _buildDepositBalanceRow(),
                    StacSizedBox(height: 8),
                    StacText(
                      data: accountNumber,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 14),
                    StacText(
                      data: accountTitle,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 17,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.text.title}}',
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          StacSizedBox(height: 18),
          _buildQuickActionsRow(),
        ],
      ),
    ),
  );
}

StacWidget _buildDepositBalanceRow() {
  return StacTextButton(
    onPressed: const StacCustomSetValueAction(
      key: 'homePage.balanceVisible',
      value: '{{!homePage.balanceVisible}}',
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.all(0),
      minimumSize: const StacSize(0, 0),
      tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
      alignment: StacAlignment.centerRight,
    ),
    child: StacCustomVisibility(
      visible: '[[homePage.balanceVisible]]',
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.end,
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: '{{appAssets.icons.refresh}}',
            imageType: StacImageType.asset,
            width: 22,
            height: 22,
            color: '{{appColors.current.text.title}}',
          ),
          StacSizedBox(width: 8),
          StacText(
            data: 'ریال 77,641',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ).toJson(),
      replacement: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.end,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: 'ریال',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 8),
          StacRow(
            children: List.generate(
              7,
              (_) => StacContainer(
                width: 12,
                height: 12,
                margin: StacEdgeInsets.only(left: 4),
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.text.title}}',
                  borderRadius: StacBorderRadius.all(99),
                ),
              ),
            ),
          ),
        ],
      ).toJson(),
    ),
  );
}

StacWidget _buildQuickActionsRow() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceEvenly,
    textDirection: StacTextDirection.rtl,
    children: [
      _buildQuickAction(
        label: 'گردش سپرده',
        iconPath: 'assets/icons/ic_share_deposit.svg',
      ),
      _buildQuickAction(
        label: 'انتقال وجه',
        iconPath: 'assets/icons/ic_transfer_amount.svg',
      ),
      _buildQuickAction(label: 'بیشتر', iconPath: 'assets/icons/ic_more.svg'),
    ],
  );
}

StacWidget _buildQuickAction({
  required String label,
  required String iconPath,
}) {
  return StacTextButton(
    style: StacButtonStyle(
      padding: StacEdgeInsets.all(0),
      minimumSize: const StacSize(0, 0),
      tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
    ),
    child: StacColumn(
      children: [
        StacContainer(
          width: 40,
          height: 40,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainerLowest}}',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          alignment: StacAlignment.center,
          child: StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 22,
            height: 22,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 6),
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 10,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildDepositIndicators() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.center,
    children: [
      _buildIndicatorDot(
        isSelectedKey: 'homePage.page.create',
        action: _buildSelectDepositPageAction(index: 0),
      ),
      StacSizedBox(width: 10),
      _buildIndicatorDot(
        isSelectedKey: 'homePage.page.first',
        action: _buildSelectDepositPageAction(index: 1),
      ),
      StacSizedBox(width: 10),
      _buildIndicatorDot(
        isSelectedKey: 'homePage.page.second',
        action: _buildSelectDepositPageAction(index: 2),
      ),
      StacSizedBox(width: 10),
      _buildIndicatorDot(
        isSelectedKey: 'homePage.page.third',
        action: _buildSelectDepositPageAction(index: 3),
      ),
    ],
  );
}

StacWidget _buildIndicatorDot({
  required String isSelectedKey,
  required StacAction action,
}) {
  return StacTextButton(
    onPressed: action,
    style: StacButtonStyle(
      padding: StacEdgeInsets.all(0),
      minimumSize: const StacSize(0, 0),
      tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
    ),
    child: StacCustomVisibility(
      visible: '[[$isSelectedKey]]',
      child: StacContainer(
        width: 18,
        height: 18,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.primary.color}}',
          borderRadius: StacBorderRadius.all(99),
        ),
      ).toJson(),
      replacement: StacContainer(
        width: 14,
        height: 14,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainerHigh}}',
          borderRadius: StacBorderRadius.all(99),
        ),
      ).toJson(),
    ),
  );
}

StacAction _buildSelectDepositPageAction({required int index}) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'homePage.depositPageIndex', 'value': index},
      {'key': 'homePage.page.create', 'value': index == 0},
      {'key': 'homePage.page.first', 'value': index == 1},
      {'key': 'homePage.page.second', 'value': index == 2},
      {'key': 'homePage.page.third', 'value': index == 3},
      {
        'key': 'homePage.balanceVisible',
        'value': index == 0 ? false : '{{homePage.balanceVisible}}',
      },
    ],
  );
}

StacWidget _buildServiceCard({
  required String title,
  required String subtitle,
  required String iconPath,
}) {
  return StacCard(
    color: '{{appColors.current.background.surfaceContainerLowest}}',
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    shape: StacRoundedRectangleBorder(
      borderRadius: StacBorderRadius.all(8),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(10),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            mainAxisAlignment: StacMainAxisAlignment.start,
            textDirection: StacTextDirection.rtl,
            children: [
              StacImage(
                src: iconPath,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.subtitle}}',
              ),
              StacSizedBox(width: 8),
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
          StacSizedBox(height: 12),
          StacText(
            data: subtitle,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
              height: 1.7,
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildHomeBannerCarousel() {
  return StacTobankBannerCarousel(
    imageUrls: const [
      'https://picsum.photos/seed/tobank-home-banner-1/1200/420',
      'https://picsum.photos/seed/tobank-home-banner-2/1200/420',
    ],
    height: 146,
    borderRadius: 8,
    autoScrollSeconds: 15,
    showIndicators: true,
    indicatorActiveColor: '#E31A2F',
    indicatorInactiveColor: '#4C5E7A',
    indicatorSpacing: 8,
  );
}

StacWidget _buildStaticCustomerClubBanner() {
  return StacCard(
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    clipBehavior: StacClip.antiAlias,
    shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
    child: StacImage(
      src: 'assets/images/customer_club_banner.png',
      imageType: StacImageType.asset,
      height: 72,
      fit: StacBoxFit.cover,
    ),
  );
}

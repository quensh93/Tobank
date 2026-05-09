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
        {'key': 'homePage.authenticated', 'value': true},
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
      body: StacStack(
        children: [
          StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacPadding(
                padding: StacEdgeInsets.only(left: 16, top: 25, right: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    StacSizedBox(height: 45),
                    _buildTopTabs(),
                    StacSizedBox(height: 10),
                  ],
                ),
              ),
              StacExpanded(child: _buildContentArea()),
            ],
          ),
          _buildCardsFixedAddButtonOverlay(),
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
        src: '{{appAssets.current.icons.tobankRed}}',
        imageType: StacImageType.asset,
        width: 18,
        height: 18,
      ),
      StacRow(
        children: [
          _buildHeaderIcon('{{appAssets.current.icons.support}}'),
          StacSizedBox(width: 18),
          _buildHeaderIcon(
            '{{appAssets.current.icons.notificationUnread}}',
            colorize: false,
          ),
          StacSizedBox(width: 18),
          _buildHeaderIcon('{{appAssets.current.icons.map}}'),
        ],
      ),
    ],
  );
}

StacWidget _buildHeaderIcon(String assetPath, {bool colorize = true}) {
  return StacContainer(
    width: 24,
    height: 24,
    alignment: StacAlignment.center,
    child: StacImage(
      src: assetPath,
      imageType: StacImageType.asset,
      width: 22,
      height: 22,
      color: colorize ? '{{appColors.current.text.title}}' : null,
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
        iconPath: '{{appAssets.current.icons.other}}',
        selectedIconPath: '{{appAssets.current.icons.otherSelected}}',
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
        iconPath: '{{appAssets.current.icons.finance}}',
        selectedIconPath: '{{appAssets.current.icons.financeSelected}}',
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
        iconPath: '{{appAssets.current.icons.card}}',
        selectedIconPath: '{{appAssets.current.icons.cardSelected}}',
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
        iconPath: '{{appAssets.current.icons.storedDeposit}}',
        selectedIconPath: '{{appAssets.current.icons.depositSelected}}',
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
  required String selectedIconPath,
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
        child: _buildSelectedTopTab(
          iconPath: selectedIconPath,
          label: label,
        ).toJson(),
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
        height: 30,
        child: StacCenter(
          child: StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
        ),
      ),
      StacSizedBox(height: 8),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 10),
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
        height: 30,
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
      StacSizedBox(height: 8),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(height: 10),
    ],
  );
}

StacWidget _buildTabDivider() {
  return StacContainer(
    width: 1,
    height: 24,
    margin: StacEdgeInsets.only(top: 6, left: 6, right: 6),
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

StacWidget _buildContentArea() {
  return StacCustomVisibility(
    visible: '[[homePage.tab.cards]]',
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, right: 16),
      child: _buildCardsTab(),
    ).toJson(),
    replacement: StacCustomVisibility(
      visible: '[[homePage.tab.services]]',
      child: StacSingleChildScrollView(
        padding: StacEdgeInsets.only(bottom: 32),
        child: _buildServicesTab(),
      ).toJson(),
      replacement: StacSingleChildScrollView(
        padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: _buildScrollableTabsContent(),
      ).toJson(),
    ).toJson(),
  );
}

StacWidget _buildScrollableTabsContent() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacCustomVisibility(
        visible: '[[homePage.tab.deposits]]',
        child: _buildDepositsTab().toJson(),
      ),
      StacCustomVisibility(
        visible: '[[homePage.tab.investment]]',
        child: _buildInvestmentTab().toJson(),
      ),
    ],
  );
}

StacWidget _buildServicesTab() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacSizedBox(height: 24),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 8),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _buildServicesRow(
              first: _buildServiceGridItem(
                label: 'کارت به کارت',
                iconPath: '{{appAssets.current.icons.cardToCard}}',
              ),
              second: _buildServiceGridItem(
                label: 'چک صیادی',
                iconPath: '{{appAssets.current.icons.checkReceive}}',
              ),
              third: _buildServiceGridItem(
                label: 'موجودی',
                iconPath: '{{appAssets.current.icons.cardBalance}}',
              ),
              fourth: _buildServiceGridItem(
                label: 'شارژ',
                iconPath: '{{appAssets.current.icons.simCharge}}',
              ),
            ),
            StacSizedBox(height: 16),
            _buildServicesRow(
              first: _buildServiceGridItem(
                label: 'بسته اینترنت',
                iconPath: '{{appAssets.current.icons.internet}}',
              ),
              second: _buildServiceGridItem(
                label: 'خدمات سفر',
                iconPath: '{{appAssets.current.icons.megagasht}}',
                onTap: const StacNavigateAction(
                  routeName: 'tobank_travel_services_page',
                  navigationStyle: NavigationStyle.push,
                ),
              ),
              third: _buildServiceGridItem(
                label: 'کارت هدیه',
                iconPath: '{{appAssets.current.icons.giftCard}}',
              ),
              fourth: _buildServiceGridItem(
                label: 'قبض',
                iconPath: '{{appAssets.current.icons.invoice}}',
              ),
            ),
            StacSizedBox(height: 16),
            _buildServicesRow(
              first: _buildServiceGridItem(
                label: 'پذیرندگی',
                iconPath: '{{appAssets.current.icons.acceptor}}',
                onTap: const StacNavigateAction(
                  routeName: 'tobank_acceptor_services_page',
                ),
              ),
              second: StacSizedBox(),
              third: StacSizedBox(),
              fourth: StacSizedBox(),
            ),
          ],
        ),
      ),
      StacSizedBox(height: 16),
    ],
  );
}

StacWidget _buildServicesRow({
  required StacWidget first,
  required StacWidget second,
  required StacWidget third,
  required StacWidget fourth,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(child: first),
      StacSizedBox(width: 8),
      StacExpanded(child: second),
      StacSizedBox(width: 8),
      StacExpanded(child: third),
      StacSizedBox(width: 8),
      StacExpanded(child: fourth),
    ],
  );
}

StacWidget _buildServiceGridItem({
  required String label,
  required String iconPath,
  StacAction? onTap,
}) {
  final item = StacColumn(
    mainAxisSize: StacMainAxisSize.min,
    children: [
      StacContainer(
        width: 40,
        height: 40,
        alignment: StacAlignment.center,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainerLowest}}',
          borderRadius: StacBorderRadius.all(8),
        ),
        child: StacImage(
          src: iconPath,
          imageType: StacImageType.asset,
          width: 28,
          height: 28,
        ),
      ),
      StacSizedBox(height: 8),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );

  final content = onTap == null ? item : StacGestureDetector(onTap: onTap, child: item);
  return StacAlign(alignment: StacAlignmentDirectional.topCenter, child: content);
}

StacWidget _buildInvestmentTab() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacSizedBox(height: 8),
      StacCard(
        color: '{{appColors.current.background.surfaceContainerLowest}}',
        elevation: 0,
        margin: StacEdgeInsets.all(0),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(8),
          side: StacBorderSide(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 0.5,
          ),
        ),
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacStack(
                alignment: StacAlignment.center,
                children: [
                  StacCustomOpacity(
                    opacity: 0.28,
                    child: StacImage(
                      src: '{{appAssets.current.icons.depositBg}}',
                      imageType: StacImageType.asset,
                      width: 320,
                      height: 170,
                      fit: StacBoxFit.cover,
                    ).toJson(),
                  ),
                  StacStack(
                    alignment: StacAlignment.center,
                    children: [
                      StacImage(
                        src: 'assets/images/sarmayeh.png',
                        imageType: StacImageType.asset,
                        width: 184,
                        height: 184,
                        fit: StacBoxFit.contain,
                      ),
                      StacImage(
                        src: '{{appAssets.current.icons.gardeshgariSarmayeh}}',
                        imageType: StacImageType.asset,
                        width: 120,
                        height: 120,
                        fit: StacBoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
              StacSizedBox(height: 12),
              StacText(
                data: 'صندوق سرمایه‌گذاری',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 20),
              _buildInvestmentFeature('معاف از مالیات'),
              StacSizedBox(height: 14),
              _buildInvestmentFeature('تحت مجوز و نظارت سازمان بورس'),
              StacSizedBox(height: 34),
              StacFilledButton(
                onPressed: const StacCustomSetValueAction(
                  values: [
                    {'key': 'homePage.tab.deposits', 'value': false},
                    {'key': 'homePage.tab.cards', 'value': false},
                    {'key': 'homePage.tab.investment', 'value': true},
                    {'key': 'homePage.tab.services', 'value': false},
                  ],
                ),
                style: StacButtonStyle(
                  backgroundColor: '#E31A2F',
                  foregroundColor: '#FFFFFF',
                  minimumSize: const StacSize(0, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                  elevation: 0,
                ),
                child: StacText(
                  data: 'شروع سرمایه گذاری',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '#FFFFFF',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(height: 24),
    ],
  );
}

StacWidget _buildInvestmentFeature(String title) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 8),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: '{{appAssets.current.icons.success}}',
          imageType: StacImageType.asset,
          width: 18,
          height: 18,
          color: '{{appColors.current.text.subtitle}}',
        ),
        StacSizedBox(width: 8),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildCardsTab() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacSizedBox(height: 140),
      StacExpanded(
        child: StacTobankCardsStackScroller(
          topSpacerHeight: 26,
          bottomSpacerHeight: 130,
          itemHeight: 125,
          itemHeightFactor: 0.72,
          scaleDistance: 300,
          minScale: 0.86,
          fadeStart: 0.18,
          maxWidthInset: 14,
          walletCard: _buildWalletCardWithHandle().toJson(),
          cards: [
            _buildBankCardItem(
              cardNumber: '۵۵۰۴ ۱۶۱۷ ۰۲۸۲ ۲۳۳۳',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
            _buildBankCardItem(
              cardNumber: '۵۵۰۴ ۱۶۱۷ ۰۵۰۳ ۰۶۰۳',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
            _buildBankCardItem(
              cardNumber: '۵۵۰۴ ۱۶۶۰ ۱۱۶۵ ۰۶۳۴',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
            _buildBankCardItem(
              cardNumber: '۵۵۰۴ ۱۶۷۸ ۳۴۹۱ ۶۲۴۰',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
            _buildBankCardItem(
              cardNumber: '۵۰۲۲ ۲۲۹۸ ۷۷۴۵ ۱۲۰۱',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
            _buildBankCardItem(
              cardNumber: '۵۸۹۲ ۱۰۱۰ ۶۵۴۳ ۷۹۹۸',
              subtitle: 'حساب قرض الحسنه گردشگری',
            ).toJson(),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildWalletCardWithHandle() {
  return StacStack(
    clipBehavior: StacClip.none,
    children: [
      _buildWalletCard(),
      StacPositioned(
        top: -26,
        left: 0,
        right: 0,
        child: StacAlign(
          alignment: StacAlignmentDirectional.topCenter,
          child: StacImage(
            src: '{{appAssets.current.icons.scroll}}',
            imageType: StacImageType.asset,
            width: 46,
            height: 27,
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildWalletCard() {
  return StacGestureDetector(
    onTap: StacRawJsonAction({
      'actionType': 'navigate',
      'widgetType': 'dashboard_real_cards_management',
      'navigationStyle': 'push',
    }),
    child: StacContainer(
    height: 125,
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.bottomLeft,
        end: StacAlignment.topRight,
        colors: ['#15A0A0', '#50E8E8'],
      ),
      borderRadius: StacBorderRadius.only(
        topLeft: 20,
        topRight: 20,
        bottomLeft: 11,
        bottomRight: 11,
      ),
      boxShadow: [
        StacBoxShadow(
          color: '#141B1F44',
          blurRadius: 30,
          offset: StacOffset(dx: 0, dy: 16),
        ),
      ],
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.end,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacRow(
                mainAxisAlignment: StacMainAxisAlignment.end,
                children: [
                  StacText(
                    data: 'کیف پول توبانک',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 34 / 2,
                      fontWeight: StacFontWeight.w700,
                      color: '#FFFFFF',
                    ),
                  ),
                  StacSizedBox(width: 12),
                  _buildWalletTargetIcon(),
                ],
              ),

              StacPadding(
                padding: StacEdgeInsets.only(bottom: 18),
                child: StacRow(
                  mainAxisAlignment: StacMainAxisAlignment.end,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data: '۳۳,۲۲۲',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w600,
                        color: '#FFFFFF',
                      ),
                    ),
                    StacSizedBox(width: 6),
                    StacText(
                      data: 'ریال',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 18 / 1.5,
                        fontWeight: StacFontWeight.w600,
                        color: '#FFFFFF',
                      ),
                    ),
                  ],
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

StacWidget _buildWalletTargetIcon() {
  return StacImage(
    src: '{{appAssets.current.icons.tobankLogo}}',
    imageType: StacImageType.asset,
    width: 34,
    height: 34,
  );
}

StacWidget _buildBankCardItem({
  required String cardNumber,
  required String subtitle,
}) {
  return StacGestureDetector(
    onTap: StacRawJsonAction({
      'actionType': 'navigate',
      'widgetType': 'dashboard_real_cards_management',
      'navigationStyle': 'push',
    }),
    child: StacContainer(
    height: 112,
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.bottomLeft,
        end: StacAlignment.topRight,
        colors: ['#EE3E62', '#FD6F8E'],
      ),
      borderRadius: StacBorderRadius.all(15),
      boxShadow: [
        StacBoxShadow(
          color: '#0A101828',
          blurRadius: 15,
          offset: StacOffset(dx: 0, dy: 2),
        ),
      ],
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.gardeshgari}}',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '#FFFFFF',
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: 'بانک‌گردشگری',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w700,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
            StacColumn(
              children: [
                StacText(
                  data: cardNumber,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.left,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w600,
                    color: '#FFFFFF',
                  ),
                ),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w600,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
   ),
  );
}

StacWidget _buildCardsFixedAddButtonOverlay() {
  return StacCustomVisibility(
    visible: '[[homePage.tab.cards]]',
    child: StacAlign(
      alignment: StacAlignmentDirectional.bottomCenter,
      child: StacPadding(
        padding: StacEdgeInsets.only(bottom: 16),
        child: _buildCardsAddButton(),
      ),
    ).toJson(),
  );
}

StacWidget _buildCardsAddButton() {
  return StacContainer(
    width: 56,
    height: 56,
    decoration: StacBoxDecoration(
      color: '#FFFFFF',
      borderRadius: StacBorderRadius.all(40),
      boxShadow: [
        StacBoxShadow(
          color: '#1F101828',
          blurRadius: 18,
          offset: StacOffset(dx: 0, dy: 8),
        ),
      ],
    ),
    alignment: StacAlignment.center,
    child: StacImage(
      src: '{{appAssets.current.icons.addPlus}}',
      imageType: StacImageType.asset,
      width: 24,
      height: 24,
      color: '{{appColors.current.primary.color}}',
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
      StacSizedBox(height: 24),
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
      StacSizedBox(height: 16),
      StacRow(
        children: [
          StacExpanded(
            child: _buildServiceCard(
              title: 'سایر خدمات',
              subtitle: 'سفته الکترونیک ...',
              iconPath: '{{appAssets.current.icons.promissory}}',
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _buildServiceCard(
              title: 'انواع تسهیلات',
              subtitle: 'ازدواج، کارت اعتباری ...',
              iconPath: '{{appAssets.current.icons.creditCard}}',
            ),
          ),
        ],
      ),
      StacSizedBox(height: 24),
      _buildHomeBannerCarousel(),
      StacSizedBox(height: 12),
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
      borderRadius: StacBorderRadius.all(8),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
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
          StacSizedBox(height: 16),
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
              minimumSize: const StacSize(0, 56),
              padding: StacEdgeInsets.symmetric(vertical: 8),
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
          StacSizedBox(height: 16),
          _buildQuickActionsRow(),
        ],
      ),
    ),
  );
}

StacWidget _buildAuthenticatedDepositsState() {
  return StacTobankCardsCarousel(
    height: 268,
    initialPage: 3,
    indicatorTopSpacing: 16,
    indicatorActiveColor: '#E31A2F',
    indicatorInactiveColor: '#D0D5DD',
    indicatorSpacing: 8,
    indicatorSize: 12,
    pages: [
      _buildCreateDepositCard().toJson(),
      _buildExistingDepositCard(
        accountNumber: '110.55.4203401',
        accountTitle: 'حساب قرض الحسنه جاری توبانک',
      ).toJson(),
      _buildExistingDepositCard(
        accountNumber: '110.79.1754212',
        accountTitle: 'حساب قرض الحسنه جاری سپرده دوم',
      ).toJson(),
      _buildExistingDepositCard(
        accountNumber: '110.79.1755809.1',
        accountTitle: 'حساب قرض الحسنه جاری حقیقی توبانک',
      ).toJson(),
    ],
  );
}

StacWidget _buildCreateDepositCard() {
  return StacContainer(
    height: 258,
    child: StacCard(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      elevation: 0,
      margin: StacEdgeInsets.all(0),
      shape: StacRoundedRectangleBorder(
        borderRadius: StacBorderRadius.all(8),
        side: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 0.5,
        ),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.all(12),
        child: StacColumn(
          mainAxisAlignment: StacMainAxisAlignment.spaceAround,
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.gardeshgari}}',
                  imageType: StacImageType.asset,
                  width: 32,
                  height: 32,
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: 'افتتاح سپرده بانک گردشگری',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
            StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.current.icons.success}}',
                  imageType: StacImageType.asset,
                  width: 16,
                  height: 16,
                  color: '{{appColors.current.text.subtitle}}',
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: 'کوتاه مدت، قرض الحسنه پس انداز، بلندمدت و ...',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
              ],
            ),
            StacFilledButton(
              style: StacButtonStyle(
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                minimumSize: const StacSize(0, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
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
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                    ),
                  ),
                  StacSizedBox(width: 8),
                  StacText(
                    data: '+',
                    style: StacCustomTextStyle(
                      fontSize: 20,
                      fontWeight: StacFontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      borderRadius: StacBorderRadius.all(8),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCard(
            elevation: 0,
            margin: StacEdgeInsets.all(0),
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(8),
            ),
            child: StacStack(
              children: [
                StacAlign(
                  alignment: StacAlignmentDirectional.centerStart,
                  child: StacCustomOpacity(
                    opacity: 0.62,
                    child: StacImage(
                      src: '{{appAssets.current.icons.depositBg}}',
                      imageType: StacImageType.asset,
                      width: 170,
                      height: 132,
                      fit: StacBoxFit.contain,
                    ).toJson(),
                  ),
                ),
                StacPadding(
                  padding: StacEdgeInsets.all(16),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacRow(
                        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                        textDirection: StacTextDirection.rtl,
                        crossAxisAlignment: StacCrossAxisAlignment.start,
                        children: [
                          StacExpanded(
                            child: StacColumn(
                              crossAxisAlignment:
                                  StacCrossAxisAlignment.stretch,
                              children: [
                                _buildDepositBalanceRow(),
                                StacSizedBox(height: 8),
                                StacText(
                                  data: accountNumber,
                                  textDirection: StacTextDirection.rtl,
                                  textAlign: StacTextAlign.right,
                                  style: StacCustomTextStyle(
                                    fontSize: 16,
                                    fontWeight: StacFontWeight.w600,
                                    color:
                                        '{{appColors.current.text.subtitle}}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StacSizedBox(width: 8),
                          StacImage(
                            src: '{{appAssets.current.icons.gardeshgari}}',
                            imageType: StacImageType.asset,
                            width: 32,
                            height: 32,
                          ),
                        ],
                      ),
                      StacSizedBox(height: 16),
                      StacText(
                        data: accountTitle,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 16),
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
            src: '{{appAssets.current.icons.refresh}}',
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
            data: '⬤⬤⬤⬤⬤⬤⬤',
            textDirection: StacTextDirection.ltr,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
              letterSpacing: 2,
              height: 1.4,
            ),
          ),
          StacSizedBox(width: 6),
          StacText(
            data: 'ریال',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ).toJson(),
    ),
  );
}

StacWidget _buildQuickActionsRow() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, right: 4),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceAround,
      textDirection: StacTextDirection.rtl,
      children: [
        _buildQuickAction(
          label: 'گردش سپرده',
          iconPath: '{{appAssets.current.icons.shareDeposit}}',
        ),
        _buildQuickAction(
          label: 'انتقال وجه',
          iconPath: '{{appAssets.current.icons.transferAmount}}',
        ),
        _buildQuickAction(
          label: 'بیشتر',
          iconPath: '{{appAssets.current.icons.more}}',
        ),
      ],
    ),
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
          width: 44,
          height: 44,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainerLowest}}',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 0.5,
            ),
          ),
          alignment: StacAlignment.center,
          child: StacImage(
            src: iconPath,
            imageType: StacImageType.asset,
            width: 28,
            height: 28,
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
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
        width: 0.5,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(12),
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
              ),
              StacSizedBox(width: 8),
              StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
          StacSizedBox(height: 16),
          StacText(
            data: subtitle,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
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
    height: 106,
    borderRadius: 8,
    autoScrollSeconds: 15,
    showIndicators: true,
    indicatorActiveColor: '#6B94E8',
    indicatorInactiveColor: '#AFC8F6',
    indicatorSpacing: 8,
  );
}

StacWidget _buildStaticCustomerClubBanner() {
  return StacCard(
    elevation: 0,
    margin: StacEdgeInsets.all(0),
    clipBehavior: StacClip.antiAlias,
    shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    child: StacImage(
      src: 'assets/images/customer_club_banner.png',
      imageType: StacImageType.asset,
      height: 82,
      fit: StacBoxFit.cover,
    ),
  );
}

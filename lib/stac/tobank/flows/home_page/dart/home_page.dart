// ignore_for_file: unused_element
import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'tobank_home_page_dart')
StacWidget tobankHomePageDart() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        {'actionType': 'kyc_check', 'targetKey': 'homePage.authenticated'},
        const StacCustomSetValueAction(
          values: [
            {'key': 'homePage.tab.deposits', 'value': true},
            {'key': 'homePage.tab.cards', 'value': false},
            {'key': 'homePage.tab.investment', 'value': false},
            {'key': 'homePage.tab.services', 'value': false},
            {'key': 'homePage.balanceVisible', 'value': false},
            {'key': 'homePage.depositPageIndex', 'value': 3},
            {'key': 'homePage.page.create', 'value': false},
            {'key': 'homePage.page.first', 'value': false},
            {'key': 'homePage.page.second', 'value': false},
            {'key': 'homePage.page.third', 'value': true},
          ],
        ),
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

String _homeString(String key) => '{{appStrings.homePage.$key}}';

String _commonString(String key) => '{{appStrings.common.$key}}';

String _menuString(String key) => '{{appStrings.menu.$key}}';

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
        label: _homeString('tabs.services'),
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
        label: _homeString('tabs.investment'),
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
        label: _homeString('tabs.cards'),
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
        label: _homeString('tabs.deposits'),
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
                label: _homeString('services.sayadiCheck'),
                iconPath: '{{appAssets.current.icons.checkReceive}}',
              ),
              second: _buildServiceGridItem(
                label: _homeString('services.topUp'),
                iconPath: '{{appAssets.current.icons.simCharge}}',
                onTap: const StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      key: 'crChargeFlowInitialized',
                      value: false,
                    ),
                    NavigationAction(
                      fileName: 'charge_intro',
                      navMode: NavModes.dart,
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ),
              ),
              third: _buildServiceGridItem(
                label: _homeString('services.internetPackage'),
                iconPath: '{{appAssets.current.icons.internet}}',
                onTap: const StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      key: 'crChargeFlowInitialized',
                      value: false,
                    ),
                    NavigationAction(
                      fileName: 'internet_pakage_intro',
                      navMode: NavModes.dart,
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ),
              ),
              fourth: _buildServiceGridItem(
                label: _homeString('services.travelServices'),
                iconPath: '{{appAssets.current.icons.megagasht}}',
                onTap: NavigationAction(
                  fileName: 'tobank_travel_services_page',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                ),
              ),
            ),
            StacSizedBox(height: 16),
            _buildServicesRow(
              first: _buildServiceGridItem(
                label: _homeString('services.giftCard'),
                iconPath: '{{appAssets.current.icons.giftCard}}',
                onTap: NavigationAction(
                  fileName: 'gift_card_intro',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                ),
              ),
              second: _buildServiceGridItem(
                label: _homeString('services.bill'),
                iconPath: '{{appAssets.current.icons.invoice}}',
              ),
              third: _buildServiceGridItem(
                label: _homeString('services.acceptor'),
                iconPath: '{{appAssets.current.icons.acceptor}}',
                onTap: NavigationAction(
                  fileName: 'tobank_acceptor_services_page',
                  navMode: NavModes.dart,
                ),
              ),
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

  final content = onTap == null
      ? item
      : StacGestureDetector(onTap: onTap, child: item);
  return StacAlign(
    alignment: StacAlignmentDirectional.topCenter,
    child: content,
  );
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
                data: _homeString('investment.title'),
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 20),
              _buildInvestmentFeature(_homeString('investment.featureTaxFree')),
              StacSizedBox(height: 14),
              _buildInvestmentFeature(
                _homeString('investment.featureUnderSupervision'),
              ),
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
                  data: _homeString('investment.startButton'),
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
              cardNumber: '{{appStrings.generated.home_page.home_page.title}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 1,
            ).toJson(),
            _buildBankCardItem(
              cardNumber:
                  '{{appStrings.generated.home_page.home_page.card_number}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 3,
            ).toJson(),
            _buildBankCardItem(
              cardNumber:
                  '{{appStrings.generated.home_page.home_page.card_number_text}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 2,
            ).toJson(),
            _buildBankCardItem(
              cardNumber:
                  '{{appStrings.generated.home_page.home_page.card_number_label}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 4,
            ).toJson(),
            _buildBankCardItem(
              cardNumber:
                  '{{appStrings.generated.home_page.home_page.card_number_message}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 5,
            ).toJson(),
            _buildBankCardItem(
              cardNumber:
                  '{{appStrings.generated.home_page.home_page.card_number_item}}',
              subtitle: _homeString('cards.cardSubtitle'),
              selectedIndex: 5,
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
    onTap: _openCardsManagementAction(0),
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
                      data: _homeString('cards.walletTitle'),
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
                        data:
                            '{{appStrings.generated.home_page.home_page.amount_value}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w600,
                          color: '#FFFFFF',
                        ),
                      ),
                      StacSizedBox(width: 6),
                      StacText(
                        data: _commonString('rial'),
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

StacAction _openCardsManagementAction(int selectedIndex) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        key: 'cardsManagement.initialPage',
        value: selectedIndex,
      ),
      NavigationAction(
        fileName: 'card_management_root',
        navMode: NavModes.dart,
        navigationStyle: NavigationStyle.push,
      ),
    ],
  );
}

StacWidget _buildBankCardItem({
  required String cardNumber,
  required String subtitle,
  required int selectedIndex,
}) {
  return StacGestureDetector(
    onTap: _openCardsManagementAction(selectedIndex),
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
                    data: _homeString('cards.bankTitle'),
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
  return StacGestureDetector(
    onTap: NavigationAction(
      fileName: 'card_management_add_card',
      navMode: NavModes.dart,
      navigationStyle: NavigationStyle.push,
    ),
    child: StacContainer(
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
        data: _homeString('deposits.specialServicesTitle'),
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
              title: _homeString('deposits.otherServicesTitle'),
              subtitle: _homeString('deposits.otherServicesSubtitle'),
              iconPath: '{{appAssets.current.icons.promissory}}',
              onTap: NavigationAction(
                fileName: 'tobank_special_services_page',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _buildServiceCard(
              title: _homeString('deposits.facilitiesTitle'),
              subtitle: _homeString('deposits.facilitiesSubtitle'),
              iconPath: '{{appAssets.current.icons.creditCard}}',
              onTap: NavigationAction(
                fileName: 'tobank_facilities_page',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
              ),
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
            data: _homeString('deposits.unauthenticatedMessage'),
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
            onPressed: NavigationAction(
              fileName: 'authentication_intro',
              navMode: NavModes.dart,
              navigationStyle: NavigationStyle.push,
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
              data: _menuString('items.authentication'),
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

StacWidget _buildAuthCardPage() {
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
            StacText(
              data: _homeString('deposits.unauthenticatedMessage'),
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
                height: 1.6,
              ),
            ),
            StacFilledButton(
              onPressed: NavigationAction(
                fileName: 'authentication_intro',
                navMode: NavModes.dart,
                navigationStyle: NavigationStyle.push,
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
                data: _menuString('items.authentication'),
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                ),
              ),
            ),
            _buildDisabledQuickActionsRow(),
          ],
        ),
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
        accountTitle: _homeString('deposits.accounts.firstTitle'),
      ).toJson(),
      _buildExistingDepositCard(
        accountNumber: '110.79.1754212',
        accountTitle: _homeString('deposits.accounts.secondTitle'),
      ).toJson(),
      _buildExistingDepositCard(
        accountNumber: '110.79.1755809.1',
        accountTitle: _homeString('deposits.accounts.thirdTitle'),
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
                  data: _homeString('deposits.createTitle'),
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
                  data: _homeString('deposits.createSubtitle'),
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
                    data: _homeString('deposits.createButton'),
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
                                StacSizedBox(height: 10),
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
          _buildQuickActionsRow(enabled: true),
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
        mainAxisAlignment: StacMainAxisAlignment.start,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: '77,641',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 1),
          StacText(
            data: _commonString('rial'),
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(width: 8),
          StacImage(
            src: '{{appAssets.current.icons.refresh}}',
            imageType: StacImageType.asset,
            width: 22,
            height: 22,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ).toJson(),
      replacement: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.start,
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
        ],
      ).toJson(),
    ),
  );
}

StacWidget _buildQuickActionsRow({bool enabled = false}) {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, right: 4),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceAround,
      textDirection: StacTextDirection.rtl,
      children: [
        _buildQuickAction(
          label: _homeString('deposits.quickActions.turnover'),
          iconPath: '{{appAssets.current.icons.shareDeposit}}',
          enabled: enabled,
          onPressed: enabled ? showDepositTurnoverBottomSheetAction() : null,
        ),
        _buildQuickAction(
          label: _homeString('deposits.quickActions.transfer'),
          iconPath: '{{appAssets.current.icons.transferAmount}}',
          enabled: enabled,
          onPressed: enabled
              ? NavigationAction(
                  fileName: 'transfer_amount',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                )
              : null,
        ),
        _buildQuickAction(
          label: _homeString('deposits.quickActions.more'),
          iconPath: '{{appAssets.current.icons.more}}',
          enabled: enabled,
          onPressed: enabled ? showDepositMoreOptionsBottomSheetAction() : null,
        ),
      ],
    ),
  );
}

StacWidget _buildQuickAction({
  required String label,
  required String iconPath,
  bool enabled = true,
  StacAction? onPressed,
}) {
  return StacTextButton(
    onPressed: onPressed,
    style: StacButtonStyle(
      padding: StacEdgeInsets.all(0),
      minimumSize: const StacSize(0, 0),
      tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
    ),
    child: StacCustomOpacity(
      opacity: enabled ? 1 : 0.4,
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
              color: enabled
                  ? '{{appColors.current.text.title}}'
                  : '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ).toJson(),
    ),
  );
}

StacWidget _buildDisabledQuickActionsRow() {
  return StacCustomOpacity(
    opacity: 0.4,
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, right: 4),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceAround,
        textDirection: StacTextDirection.rtl,
        children: [
          _buildDisabledQuickAction(
            label: _homeString('deposits.quickActions.turnover'),
            iconPath: '{{appAssets.current.icons.shareDeposit}}',
          ),
          _buildDisabledQuickAction(
            label: _homeString('deposits.quickActions.transfer'),
            iconPath: '{{appAssets.current.icons.transferAmount}}',
          ),
          _buildDisabledQuickAction(
            label: _homeString('deposits.quickActions.more'),
            iconPath: '{{appAssets.current.icons.more}}',
          ),
        ],
      ),
    ).toJson(),
  );
}

StacWidget _buildDisabledQuickAction({
  required String label,
  required String iconPath,
}) {
  return StacColumn(
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
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
    ],
  );
}

StacWidget _buildServiceCard({
  required String title,
  required String subtitle,
  required String iconPath,
  StacAction? onTap,
}) {
  final card = StacCard(
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

  if (onTap == null) {
    return card;
  }

  return StacGestureDetector(onTap: onTap, child: card);
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

StacAction showDepositTurnoverBottomSheetAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'dtFilterLatestSelected', 'value': true},
          {'key': 'dtFilterTimeSelected', 'value': false},
          {
            'key': 'dtFromDate',
            'value':
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_value}}',
          },
          {
            'key': 'dtToDate',
            'value':
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_value_text}}',
          },
        ],
      ),
      StacShowBottomSheetAction(
        title: 'deposit_filter',
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: '#00000000',
        barrierColor: '#8B000000',
        sheet: _buildDepositTurnoverBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _buildDepositTurnoverBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 38,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(99),
              ),
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data: '{{appStrings.homePage.deposits.quickActions.turnover}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 19,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 20),
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(8),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data:
                      '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.amount_value}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 22),
          StacText(
            data:
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.based_on_label}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacRow(
            children: [
              StacExpanded(
                child: _filterOptionCard(
                  label:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.turnover}}',
                  selectedKey: 'dtFilterLatestSelected',
                  onTap: _selectLatestFilterAction(),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: _filterOptionCard(
                  label:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_range_label}}',
                  selectedKey: 'dtFilterTimeSelected',
                  onTap: _selectTimeRangeFilterAction(),
                ),
              ),
            ],
          ),
          StacCustomVisibility(
            visible: '[[dtFilterTimeSelected]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacSizedBox(height: 14),
                StacRow(
                  children: [
                    StacExpanded(
                      child: StacText(
                        data:
                            '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_until}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                    StacSizedBox(width: 12),
                    StacExpanded(
                      child: StacText(
                        data:
                            '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date}}',
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
                StacSizedBox(height: 8),
                StacRow(
                  children: [
                    StacExpanded(
                      child: _dateFieldCard(
                        value: '{{dtToDate}}',
                        registryKey: 'dtToDate',
                      ),
                    ),
                    StacSizedBox(width: 12),
                    StacExpanded(
                      child: _dateFieldCard(
                        value: '{{dtFromDate}}',
                        registryKey: 'dtFromDate',
                      ),
                    ),
                  ],
                ),
              ],
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          StacSizedBox(height: 22),
          StacFilledButton(
            onPressed: StacCloseDialogAction(
              result: _buildDepositTurnoverFingerPrintAction().toJson(),
            ),
            style: StacButtonStyle(
              fixedSize: const StacSize(999999, 52),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            child: StacText(
              data: '{{appStrings.authentication.confirmAndContinue}}',
              style: StacTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _buildDepositTurnoverFingerPrintAction() {
  return const StacFingerPrintAction(
    title:
        '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.mobile_pin_bank}}',
    description:
        '{{appStrings.generated.child_loan.child_loan_child_check.continue}}',
    onSuccess: {
      'actionType': 'navigate',
      'fileName': 'deposit_turnover_transactions',
      'navMode': 'dart',
      'navigationStyle': 'push',
    },
    onFailure: {
      'actionType': 'showSnackBar',
      'title':
          '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.authentication_failed}}',
      'detail':
          '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.try_again}}',
      'type': 'error',
    },
  );
}

StacAction _selectLatestFilterAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'dtFilterLatestSelected', 'value': true},
      {'key': 'dtFilterTimeSelected', 'value': false},
    ],
  );
}

StacAction _selectTimeRangeFilterAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'dtFilterLatestSelected', 'value': false},
          {'key': 'dtFilterTimeSelected', 'value': true},
        ],
      ),
      _openDepositDateRangePickerAction(),
    ],
  );
}

StacAction _openDepositDateRangePickerAction() {
  return StacRawJsonAction({
    'actionType': 'persianDateRangePicker',
    'startDateKey': 'dtFromDate',
    'endDateKey': 'dtToDate',
    'helpText':
        '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.select}}',
    'confirmText': '{{appStrings.common.confirm}}',
    'cancelText': '{{appStrings.common.cancel}}',
    'firstDate': '1400/01/01',
    'lastDate': '1450/12/29',
  });
}

StacWidget _filterOptionCard({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  return StacCustomVisibility(
    visible: '[[$selectedKey]]',
    child: _selectedFilterOptionCard(label: label, onTap: onTap).toJson(),
    replacement: _unselectedFilterOptionCard(
      label: label,
      onTap: onTap,
    ).toJson(),
  );
}

StacWidget _selectedFilterOptionCard({
  required String label,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.secondary.color}}',
          width: 1.4,
        ),
        color: '{{appColors.current.secondary.secondaryContainer}}',
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: label,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.secondary.color}}',
            ),
          ),
          StacContainer(
            width: 24,
            height: 24,
            decoration: StacBoxDecoration(
              shape: StacBoxShape.circle,
              border: StacBorder.all(
                color: '{{appColors.current.secondary.color}}',
                width: 2,
              ),
            ),
            child: StacCenter(
              child: StacContainer(
                width: 10,
                height: 10,
                decoration: StacBoxDecoration(
                  shape: StacBoxShape.circle,
                  color: '{{appColors.current.secondary.color}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _unselectedFilterOptionCard({
  required String label,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1.4,
        ),
        color: '{{appColors.current.background.surfaceContainer}}',
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: label,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacContainer(
            width: 24,
            height: 24,
            decoration: StacBoxDecoration(
              shape: StacBoxShape.circle,
              border: StacBorder.all(
                color: '{{appColors.current.text.title}}',
                width: 2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _dateFieldCard({
  required String value,
  required String registryKey,
}) {
  return StacGestureDetector(
    onTap: _openDepositDateRangePickerAction(),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacCustomWidget.fromJson({
            'type': 'registryReactive',
            'registryKey': registryKey,
            'child': StacText(
              data: value,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ).toJson(),
          }),
          StacImage(
            src: '{{appAssets.current.icons.calendar}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
  );
}

const bool _showCardIssueByFlag = true;

StacAction showDepositMoreOptionsBottomSheetAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {
            'key': 'deposit_more_show_card_issue',
            'value': _showCardIssueByFlag,
          },
        ],
      ),
      StacShowBottomSheetAction(
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: '{{appColors.current.background.surface}}',
        barrierColor: '#8B000000',
        sheet: _buildDepositServicesBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _buildDepositServicesBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 20, topRight: 20),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 36,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(4),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data:
                '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.deposit_services}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w800,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacCustomVisibility(
            visible: '[[deposit_more_show_card_issue]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildDepositServiceTile(
                  title:
                      '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.card}}',
                  iconPath: '{{appAssets.icons.requestCardCurrent}}',
                  onTap: const StacCloseDialogAction(
                    result: {
                      'actionType': 'navigate',
                      'fileName': 'deposit_card_issue_address',
                      'navMode': 'dart',
                      'navigationStyle': 'push',
                    },
                  ),
                ),
                StacSizedBox(height: 10),
              ],
            ).toJson(),
          ),
          _buildDepositServiceTile(
            title:
                '{{appStrings.generated.deposit_more_options.deposit_close_confirm.title}}',
            iconPath: '{{appAssets.icons.closeDepositCurrent}}',
            onTap: const StacCloseDialogAction(
              result: {
                'actionType': 'navigate',
                'fileName': 'deposit_close_confirm',
                'navMode': 'dart',
                'navigationStyle': 'push',
              },
            ),
          ),
          StacSizedBox(height: 10),
          _buildDepositServiceTile(
            title:
                '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.details_deposit}}',
            iconPath: '{{appAssets.icons.depositDetailCurrent}}',
            onTap: _openDepositDetailsBottomSheetAction(),
          ),
          StacSizedBox(height: 4),
        ],
      ),
    ),
  );
}

StacWidget _buildDepositServiceTile({
  required String title,
  required String iconPath,
  StacAction? onTap,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacInkWell(
      onTap: onTap ?? const StacCloseDialogAction(),
      borderRadius: StacBorderRadius.all(8),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.start,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacContainer(
              width: 40,
              height: 40,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(40),
              ),
              child: StacCenter(
                child: StacImage(
                  src: iconPath,
                  imageType: StacImageType.asset,
                  width: 31,
                  height: 31,
                ),
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacAction _openDepositDetailsBottomSheetAction() {
  return StacCloseDialogAction(
    result: StacSequenceAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {
              'key': 'depositMoreOptions.details.depositNumber',
              'value':
                  '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.amount_value}}',
            },
            {
              'key': 'depositMoreOptions.details.iban',
              'value':
                  '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.ir620640011992901612988001}}',
            },
          ],
        ),
        StacShowBottomSheetAction(
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: '{{appColors.current.background.surface}}',
          barrierColor: '#8B000000',
          sheet: _buildDepositDetailsBottomSheet().toJson(),
        ),
      ],
    ).toJson(),
  );
}

StacWidget _buildDepositDetailsBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 20, topRight: 20),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 36,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(4),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data:
                '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.details_deposit}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _depositDetailsItem(
            title:
                '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
            valueKey: 'depositMoreOptions.details.depositNumber',
            rightIconAsset: '{{appAssets.icons.shareDepositCurrent}}',
            ltrValue: false,
          ),
          StacSizedBox(height: 16),
          _depositDetailsItem(
            title:
                '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.iban_number}}',
            valueKey: 'depositMoreOptions.details.iban',
            rightIconAsset: '{{appAssets.icons.shareIbanCurrent}}',
            ltrValue: true,
          ),
        ],
      ),
    ),
  );
}

StacWidget _depositDetailsItem({
  required String title,
  required String valueKey,
  required String rightIconAsset,
  required bool ltrValue,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 8, top: 16, right: 16, bottom: 16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacContainer(
            width: 40,
            height: 40,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(40),
            ),
            child: StacCenter(
              child: StacImage(
                src: rightIconAsset,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    color: '{{appColors.current.text.subtitle}}',
                    fontSize: 16,
                    fontWeight: StacFontWeight.w400,
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: '{{$valueKey}}',
                  textDirection: ltrValue
                      ? StacTextDirection.ltr
                      : StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    color: '{{appColors.current.text.title}}',
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          StacGestureDetector(
            onTap: StacCopyToClipboardAction(valueKey: valueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: '{{appAssets.icons.copyCurrent}}',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
          StacGestureDetector(
            onTap: StacShareTextAction(valueKey: valueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: '{{appAssets.icons.shareCurrent}}',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

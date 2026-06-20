import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const _destinationMenuKeys = [
  'profileRealMenuCard1',
  'profileRealMenuCard2',
  'profileRealMenuCard3',
  'profileRealMenuCard4',
  'profileRealMenuDeposit1',
  'profileRealMenuDeposit2',
  'profileRealMenuDeposit3',
  'profileRealMenuIban1',
  'profileRealMenuIban2',
  'profileRealMenuIban3',
  'profileRealMenuIban4',
  'profileRealMenuIban5',
  'profileRealMenuIban6',
];

@StacScreen(screenName: 'profile_destinations')
StacWidget profileRealDestinations() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'profileRealShowAddCardSheet', 'value': false},
        {'key': 'profileRealMenuCard1', 'value': false},
        {'key': 'profileRealMenuCard2', 'value': false},
        {'key': 'profileRealMenuCard3', 'value': false},
        {'key': 'profileRealMenuCard4', 'value': false},
        {'key': 'profileRealMenuDeposit1', 'value': false},
        {'key': 'profileRealMenuDeposit2', 'value': false},
        {'key': 'profileRealMenuDeposit3', 'value': false},
        {'key': 'profileRealMenuIban1', 'value': false},
        {'key': 'profileRealMenuIban2', 'value': false},
        {'key': 'profileRealMenuIban3', 'value': false},
        {'key': 'profileRealMenuIban4', 'value': false},
        {'key': 'profileRealMenuIban5', 'value': false},
        {'key': 'profileRealMenuIban6', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.profile.real.destinations.title}}',
      ),
      body: StacStack(
        children: [
          StacDefaultTabController(
            length: 3,
            initialIndex: 2,
            child: StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _tabSwitcher(),
                  StacSizedBox(height: 16),
                  StacExpanded(
                    child: StacTabBarView(
                      children: [
                        StacSingleChildScrollView(child: _ibanTabList()),
                        StacSingleChildScrollView(child: _depositTabList()),
                        _cardTabContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacCustomVisibility(
            visible: '[[profileRealShowAddCardSheet]]',
            child: _addCardBottomSheetOverlay().toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _cardTabContent() {
  return StacStack(
    children: [
      StacSingleChildScrollView(
        child: StacColumn(
          children: [_cardTabList(), StacSizedBox(height: 104)],
        ),
      ),
      StacAlign(
        alignment: StacAlignmentDirectional.bottomCenter,
        child: StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: _addDestinationButton(),
        ),
      ),
    ],
  );
}

StacWidget _tabSwitcher() {
  return StacStack(
    children: [
      StacTabBar(
        enableFeedback: false,
        dividerColor: '#00000000',
        indicatorColor: '{{appColors.current.primary.color}}',
        indicatorWeight: 2,
        indicatorSize: StacTabBarIndicatorSize.tab,
        indicatorPadding: StacEdgeInsets.only(left: 48, top: 42, right: 48),
        labelStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
        ),
        unselectedLabelStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
        ),
        labelColor: '{{appColors.current.text.title}}',
        unselectedLabelColor: '{{appColors.current.text.subtitle}}',
        tabs: const [
          StacTab(
            text: '{{appStrings.profile.real.destinations.tabIban}}',
            height: 44,
          ),
          StacTab(
            text: '{{appStrings.profile.real.destinations.tabDeposit}}',
            height: 44,
          ),
          StacTab(
            text: '{{appStrings.profile.real.destinations.tabCard}}',
            height: 44,
          ),
        ],
      ),
      StacPositioned(
        top: 10,
        bottom: 10,
        left: 0,
        right: 0,
        child: StacRow(
          children: [
            StacExpanded(child: StacSizedBox()),
            StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacExpanded(child: StacSizedBox()),
            StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacExpanded(child: StacSizedBox()),
          ],
        ),
      ),
    ],
  );
}

StacWidget _cardTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.cardItem2Title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.card_number}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuCard1',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.cardItem2Title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.card_number_text}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuCard2',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.cardItem2Title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.card_number_label}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuCard3',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.generated.profile.profile_destinations.title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.card_number_message}}',
        logoAsset: 'assets/icons/ic_success_new.svg',
        menuKey: 'profileRealMenuCard4',
      ),
    ],
  );
}

StacWidget _depositTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.depositItem2Title}}',
        subtitle:
            '{{appStrings.profile.real.destinations.depositItem2Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuDeposit1',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.generated.profile.profile_destinations.title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.amount_value}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuDeposit2',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.generated.profile.profile_destinations.title}}',
        subtitle:
            '{{appStrings.generated.profile.profile_destinations.amount_value_text}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuDeposit3',
      ),
    ],
  );
}

StacWidget _ibanTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: '{{appStrings.profile.real.userName}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem1Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuIban1',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.depositItem2Title}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem2Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuIban2',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.generated.profile.profile_destinations.title}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem3Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuIban3',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title:
            '{{appStrings.generated.profile.profile_destinations.sample_contact_name}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem4Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuIban4',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title:
            '{{appStrings.generated.profile.profile_destinations.ali_sinaei_asl_name}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem5Subtitle}}',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
        menuKey: 'profileRealMenuIban5',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '{{appStrings.profile.real.destinations.depositItem2Title}}',
        subtitle: '{{appStrings.profile.real.destinations.ibanItem6Subtitle}}',
        logoAsset: 'assets/icons/ic_success_new.svg',
        menuKey: 'profileRealMenuIban6',
      ),
    ],
  );
}

StacWidget _destinationCard({
  required String title,
  required String subtitle,
  required String logoAsset,
  required String menuKey,
}) {
  return StacStack(
    clipBehavior: StacClip.none,
    children: [
      StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacImage(
              src: logoAsset,
              imageType: StacImageType.asset,
              width: 24,
              height: 24,
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacText(
                    data: title,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(height: 8),
                  StacText(
                    data: subtitle,
                    textDirection: StacTextDirection.ltr,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 17,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
            ),
            StacSizedBox(width: 8),
            StacContainer(
              width: 1,
              height: 16,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacSizedBox(width: 8),
            StacGestureDetector(
              onTap: _openDestinationMenu(menuKey),
              child: StacContainer(
                color: '#00000000',
                padding: StacEdgeInsets.all(4),
                child: StacIcon(
                  icon: 'more_vert',
                  size: 20,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
      ),
      StacCustomVisibility(
        visible: '[[$menuKey]]',
        child: StacPositioned(
          left: 20,
          top: -8,
          child: _destinationCardMenu(menuKey),
        ).toJson(),
      ),
    ],
  );
}

StacWidget _destinationCardMenu(String menuKey) {
  return StacContainer(
    width: 168,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      boxShadow: [
        StacBoxShadow(
          color: '#1F000000',
          blurRadius: 16,
          offset: const StacOffset(dx: 0, dy: 4),
        ),
      ],
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      children: [
        _destinationCardMenuItem(
          title: '{{appStrings.verifyOtp.edit}}',
          iconAsset: 'assets/icons/ic_edit_dark.svg',
          onTap: StacSequenceAction(
            actions: [
              _closeAllDestinationMenus(),
              const StacShowResultAction(
                title: '{{appStrings.verifyOtp.edit}}',
                content:
                    '{{appStrings.generated.profile.profile_destinations.edit_active}}',
              ),
            ],
          ),
        ),
        StacContainer(
          margin: StacEdgeInsets.symmetric(horizontal: 12),
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        _destinationCardMenuItem(
          title:
              '{{appStrings.generated.authentication.authentication_selfie.delete}}',
          iconAsset: 'assets/icons/ic_delete_dark.svg',
          onTap: StacSequenceAction(
            actions: [
              _closeAllDestinationMenus(),
              StacShowDialogAction(
                title:
                    '{{appStrings.generated.card_management.card_management_root.delete_card}}',
                description:
                    '{{appStrings.generated.profile.profile_destinations.delete_message}}',
                positiveText: '{{appStrings.common.confirm}}',
                negativeText: '{{appStrings.common.cancel}}',
                positiveAction: StacSequenceAction(
                  actions: [
                    const StacCloseDialogAction(),
                    const StacCustomSnackBarAction(
                      title:
                          '{{appStrings.generated.profile.profile_destinations.delete}}',
                      detail:
                          '{{appStrings.generated.profile.profile_destinations.successfully_delete}}',
                      duration: 3000,
                    ),
                  ],
                ),
                negativeAction: const StacCloseDialogAction(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _destinationCardMenuItem({
  required String title,
  required String iconAsset,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 22,
            height: 22,
          ),
          StacSizedBox(width: 10),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _openDestinationMenu(String menuKey) {
  return StacCustomSetValueAction(
    values: [
      for (final key in _destinationMenuKeys)
        {'key': key, 'value': key == menuKey},
    ],
  );
}

StacAction _closeAllDestinationMenus() {
  return StacCustomSetValueAction(
    values: [
      for (final key in _destinationMenuKeys) {'key': key, 'value': false},
    ],
  );
}

StacWidget _addDestinationButton() {
  return StacFilledButton(
    onPressed: const StacCustomSetValueAction(
      key: 'profileRealShowAddCardSheet',
      value: true,
    ),
    style: StacButtonStyle(
      elevation: 6,
      fixedSize: const StacSize(175, 56),
      padding: StacEdgeInsets.symmetric(horizontal: 12),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(16)),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      mainAxisSize: StacMainAxisSize.min,
      textDirection: StacTextDirection.rtl,
      children: [
        StacContainer(
          width: 24,
          height: 24,
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(6),
            border: StacBorder.all(
              color: '{{appColors.current.button.primary.foregroundColor}}',
              width: 1,
            ),
          ),
          child: StacCenter(
            child: StacIcon(
              icon: 'add',
              size: 15,
              color: '{{appColors.current.button.primary.foregroundColor}}',
            ),
          ),
        ),
        StacSizedBox(width: 7),
        StacText(
          data: '{{appStrings.profile.real.destinations.addDestinationButton}}',
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.button.primary.foregroundColor}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _addCardBottomSheetOverlay() {
  return StacStack(
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          key: 'profileRealShowAddCardSheet',
          value: false,
        ),
        child: StacContainer(width: 999999, height: 999999, color: '#9F000000'),
      ),
      StacAlign(
        alignment: StacAlignmentDirectional.bottomCenter,
        child: StacContainer(
          width: 999999,
          padding: StacEdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 16,
          ),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surface}}',
            borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
          ),
          child: StacForm(
            child: StacColumn(
              mainAxisSize: StacMainAxisSize.min,
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacCenter(
                  child: StacContainer(
                    width: 44,
                    height: 5,
                    decoration: StacBoxDecoration(
                      color: '#668790A3',
                      borderRadius: StacBorderRadius.all(999),
                    ),
                  ),
                ),
                StacSizedBox(height: 24),
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacExpanded(
                      child: StacText(
                        data:
                            '{{appStrings.profile.real.destinations.addCardTitle}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                    StacSizedBox(width: 12),
                    StacOutlinedButton(
                      onPressed: StacRawJsonAction({
                        'actionType': 'showTransferCardScanner',
                        'fieldId': 'profileRealDestinationCardNumber',
                        'failedAction': const StacCustomSnackBarAction(
                          title: '{{appStrings.common.error}}',
                          detail:
                              '{{appStrings.generated.profile.profile_destinations.failed_card}}',
                          duration: 2600,
                        ).toJson(),
                      }),
                      style: StacButtonStyle(
                        minimumSize: const StacSize(125, 50),
                        side: StacBorderSide(
                          color: '{{appColors.current.text.title}}',
                          width: 1,
                        ),
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(10),
                        ),
                      ),
                      child: StacRow(
                        mainAxisSize: StacMainAxisSize.min,
                        textDirection: StacTextDirection.rtl,
                        children: [
                          StacImage(
                            src: 'assets/icons/ic_card_default.svg',
                            imageType: StacImageType.asset,
                            width: 24,
                            height: 24,
                            color: '{{appColors.current.text.title}}',
                          ),
                          StacSizedBox(width: 6),
                          StacText(
                            data:
                                '{{appStrings.profile.real.destinations.scanCard}}',
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                StacSizedBox(height: 16),
                StacText(
                  data:
                      '{{appStrings.profile.real.destinations.cardNumberLabel}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacTextFormField(
                  id: 'profileRealDestinationCardNumber',
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  keyboardType: StacTextInputType.number,
                  decoration: StacInputDecoration(
                    hintText:
                        '{{appStrings.profile.real.destinations.cardNumberHint}}',
                    hintStyle: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.hint}}',
                    ),
                    filled: false,
                    contentPadding: StacEdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 19,
                    ),
                  ),
                ),
                StacSizedBox(height: 16),
                StacText(
                  data:
                      '{{appStrings.profile.real.destinations.cardTitleLabel}}',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacTextFormField(
                  id: 'profileRealDestinationCardTitle',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  keyboardType: StacTextInputType.text,
                  decoration: StacInputDecoration(
                    hintText:
                        '{{appStrings.profile.real.destinations.cardTitleHint}}',
                    hintStyle: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.hint}}',
                    ),
                    filled: false,
                    contentPadding: StacEdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 19,
                    ),
                  ),
                ),
                StacSizedBox(height: 24),
                StacFilledButton(
                  onPressed: const StacSequenceAction(
                    actions: [
                      StacCustomSetValueAction(
                        key: 'profileRealShowAddCardSheet',
                        value: false,
                      ),
                      StacShowResultAction(
                        title:
                            '{{appStrings.profile.real.destinations.submitTitle}}',
                        content:
                            '{{appStrings.profile.real.destinations.submitContent}}',
                      ),
                    ],
                  ),
                  style: StacButtonStyle(
                    fixedSize: const StacSize(999999, 52),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(10),
                    ),
                    backgroundColor:
                        '{{appColors.current.button.primary.backgroundColor}}',
                  ),
                  child: StacText(
                    data:
                        '{{appStrings.profile.real.destinations.submitTitle}}',
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color:
                          '{{appColors.current.button.primary.foregroundColor}}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

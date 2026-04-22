import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_destinations')
StacWidget profileRealDestinations() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'profileRealDestTabCard', 'value': true},
        {'key': 'profileRealDestTabDeposit', 'value': false},
        {'key': 'profileRealDestTabIban', 'value': false},
        {'key': 'profileRealShowAddCardSheet', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildProfileRealAppBar(title: 'Ù…Ø®Ø§Ø·Ø¨ÛŒÙ†'),
      body: StacStack(
        children: [
          StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _tabSwitcher(),
                StacSizedBox(height: 16),
                StacCustomVisibility(
                  visible: '[[profileRealDestTabCard]]',
                  child: _cardTabList().toJson(),
                ),
                StacCustomVisibility(
                  visible: '[[profileRealDestTabDeposit]]',
                  child: _depositTabList().toJson(),
                ),
                StacCustomVisibility(
                  visible: '[[profileRealDestTabIban]]',
                  child: _ibanTabList().toJson(),
                ),
                StacSizedBox(height: 96),
              ],
            ),
          ),
          StacAlign(
            alignment: StacAlignmentDirectional.bottomCenter,
            child: StacCustomVisibility(
              visible: '[[profileRealDestTabCard]]',
              child: StacPadding(
                padding: StacEdgeInsets.only(bottom: 16),
                child: _addDestinationButton(),
              ).toJson(),
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

StacWidget _tabSwitcher() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
    
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        _tabItem(
          label: 'Ú©Ø§Ø±Øª',
          activeKey: 'profileRealDestTabCard',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'profileRealDestTabCard', 'value': true},
              {'key': 'profileRealDestTabDeposit', 'value': false},
              {'key': 'profileRealDestTabIban', 'value': false},
            ],
          ),
        ),
        _tabDivider(),
        _tabItem(
          label: 'Ø³Ù¾Ø±Ø¯Ù‡',
          activeKey: 'profileRealDestTabDeposit',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'profileRealDestTabCard', 'value': false},
              {'key': 'profileRealDestTabDeposit', 'value': true},
              {'key': 'profileRealDestTabIban', 'value': false},
            ],
          ),
        ),
        _tabDivider(),
        _tabItem(
          label: 'Ø´Ø¨Ø§',
          activeKey: 'profileRealDestTabIban',
          onTap: const StacCustomSetValueAction(
            values: [
              {'key': 'profileRealDestTabCard', 'value': false},
              {'key': 'profileRealDestTabDeposit', 'value': false},
              {'key': 'profileRealDestTabIban', 'value': true},
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _tabDivider() {
  return StacContainer(
    width: 1,
    height: 24,
    color: '{{appColors.current.input.borderEnabled}}',
  );
}

StacWidget _tabItem({
  required String label,
  required String activeKey,
  required StacAction onTap,
}) {
  return StacExpanded(
    child: StacGestureDetector(
      onTap: onTap,
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(vertical: 10),
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          children: [
            StacCustomVisibility(
              visible: '[[$activeKey]]',
              child: StacText(
                data: label,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ).toJson(),
              replacement: StacText(
                data: label,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ).toJson(),
            ),
            StacSizedBox(height: 8),
            StacCustomVisibility(
              visible: '[[$activeKey]]',
              child: StacContainer(
                width: 52,
                height: 2,
                color: '{{appColors.current.primary.color}}',
              ).toJson(),
              replacement: StacContainer(
                width: 52,
                height: 2,
                color: '#00000000',
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _cardTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: 'yuy',
        subtitle: 'ÛµÛµÛ°Û´ - Û±Û¶Û±Û° - Û±Û²Û¹Û° - Û¶ÛµÛ¶Ûµ',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ - Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ',
        subtitle: 'ÛµÛµÛ°Û´ - Û±Û¶Û±Û· - Û°Û´Û¸Û² - Û²Û³Û³Û³',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ù…Ù‡ÛŒØ§Ø± Ø®Ù„ÛŒØ¬ÛŒ',
        subtitle: 'ÛµÛ¸ÛµÛ¹ - Û¸Û³Û±Û¸ - Û²Û´Û¶Û± - Û·Û°Û³Û¸',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'blu',
        subtitle: 'Û¶Û²Û±Û¹ - Û¸Û¶Û±Û¹ - Û°Û·Û·Û· - Û¹ÛµÛµÛ·',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'blu',
        subtitle: 'Û¶Û²Û±Û¹ - Û¸Û¶Û±Û¹ - Û°Û·Û·Û· - Û¹ÛµÛµÛ·',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
    ],
  );
}

StacWidget _depositTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: 'Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
        subtitle: 'Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·ÛµÛµÛ¸Û°Û¹.Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ø¹Ù„ÛŒØ±Ø¶Ø§ Ø­ÛŒØ¯Ø±ÛŒØ§Ù†',
        subtitle: 'Û±Û±Û°.Û¹Û¹Û¹Û³.Û·Û¶Û³Û´Û°ÛµÛ°.Û±',
        logoAsset: 'assets/icons/ic_success_new.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
        subtitle: 'Û±Û±Û°.Û·Û¹Û±.Û±Û·ÛµÛµÛ¸Û°Û¹.Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±',
        subtitle: 'Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û´Û¸Û¸Ûµ.Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
    ],
  );
}

StacWidget _ibanTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: 'Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
        subtitle: 'IRÛ°Û¶Û°Û¶Û¶Û·Û¶Û±Û±Û¸Û²Û¸Û°Û°Û±Û°Û°Û°Û¸Û¸Û·Û°Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ø§ÙˆÙ„ Ú©ÛŒØ´',
        subtitle: 'IRÛ°ÛµÛ°Û±Û´Û°Û°Û²Û°Û°Û°Û°Û°Û°Û°Û°Û¹Û¸Û¸Û¸Û¸Û¸ÛµÛ°Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ø²ÛŒÙ†Ø¨ Ù†Ø¹Ù…Øª Ø§Ù„Ù‡ÛŒ',
        subtitle: 'IRÛ·Û±ÛµÛ·Û°Û³Û°Û´Û³Û·Û·Û°Û°Û±Û·Û¹Û¸Û´Û°Û°Û°Û±Û°Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ø¢Ø°Ø± Ø¹Ø³Ú©Ø±ÛŒ',
        subtitle: 'IRÛ¹Û¸Û°Û¶Û´Û°Û°Û±Û±Û¹Û¹Û¹Û¶Û¹Û¹Û¹Û·Û·Û¸Û¸Û°Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ø§ÙØ¯Ø³ Ø¹Ø³Ú©Ø±ÛŒ',
        subtitle: 'IRÛ°Û³Û°ÛµÛ¶Û¶Û·Û±Û±Û¸Û²Û¸Û°Û°Û¶Û²Û²Û³Û¹Û²Û±Û¹Û°Û±',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
        subtitle: 'IRÛ°ÛµÛ±Û´Û´Û°Û°Û°Û°Û°Û°Û°Û°Û±Û±Û°Û·ÛµÛµÛ¸Û°Û¹Û±',
        logoAsset: 'assets/icons/ic_success_new.svg',
      ),
    ],
  );
}

StacWidget _destinationCard({
  required String title,
  required String subtitle,
  required String logoAsset,
}) {
  return StacGestureDetector(
    onTap: const StacShowResultAction(
      title: 'Ú¯Ø²ÛŒÙ†Ù‡â€ŒÙ‡Ø§',
      content: 'Ù…Ø¯ÛŒØ±ÛŒØª Ù…Ù‚ØµØ¯ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
    ),
    child: StacContainer(
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
          StacIcon(
            icon: 'more_vert',
            size: 20,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
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
      shape: StacRoundedRectangleBorder(
        borderRadius: StacBorderRadius.all(16),
      ),
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
          data: 'Ø§ÙØ²ÙˆØ¯Ù† Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯',
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
        child: StacContainer(
          width: 999999,
          height: 999999,
          color: '#9F000000',
        ),
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
            borderRadius: StacBorderRadius.only(
              topLeft: 16,
              topRight: 16,
            ),
          ),
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
                      data: 'Ø§ÙØ²ÙˆØ¯Ù† Ú©Ø§Ø±Øª Ø¬Ø¯ÛŒØ¯',
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
                    onPressed: const StacShowResultAction(
                      title: 'Ø§Ø³Ú©Ù† Ú©Ø§Ø±Øª',
                      content: 'Ø§ÛŒÙ† Ø¨Ø®Ø´ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯.',
                    ),
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
                          src: 'assets/icons/ic_scanner.svg',
                          imageType: StacImageType.asset,
                          width: 23,
                          height: 23,
                          color: '{{appColors.current.text.title}}',
                        ),
                        StacSizedBox(width: 6),
                        StacText(
                          data: 'Ø§Ø³Ú©Ù† Ú©Ø§Ø±Øª',
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
                data: 'Ø´Ù…Ø§Ø±Ù‡ Ú©Ø§Ø±Øª',
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
                  hintText: 'ÛŒÚ© Ø´Ù…Ø§Ø±Ù‡ Ú©Ø§Ø±Øª Ù…Ø¹ØªØ¨Ø± ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯',
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
                data: 'Ø¹Ù†ÙˆØ§Ù† Ú©Ø§Ø±Øª',
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
                  hintText: 'Ø¹Ù†ÙˆØ§Ù† Ú©Ø§Ø±Øª Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯',
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
                      title: 'Ø«Ø¨Øª',
                      content: 'Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø«Ø¨Øª Ø´Ø¯.',
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
                  data: 'Ø«Ø¨Øª',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.button.primary.foregroundColor}}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

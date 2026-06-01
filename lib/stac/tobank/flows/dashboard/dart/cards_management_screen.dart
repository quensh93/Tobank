import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const _serviceTopUpTitle = '{{appStrings.cardsManagement.services.topUp}}';
const _serviceTransferTitle =
    '{{appStrings.cardsManagement.services.transfer}}';
const _serviceFirstPinTitle =
    '{{appStrings.cardsManagement.services.firstPin}}';
const _serviceSecondPinTitle =
    '{{appStrings.cardsManagement.services.secondPin}}';
const _serviceReissueTitle = '{{appStrings.cardsManagement.services.reissue}}';
const _serviceBlockTitle = '{{appStrings.cardsManagement.services.block}}';
const _serviceBalanceTitle = '{{appStrings.cardsManagement.services.balance}}';
const _servicePlaceholderContent =
    '{{appStrings.cardsManagement.services.placeholder}}';
const _walletTransferMockDestinationWallet = 'سینایی';

@StacScreen(screenName: 'dashboard_cards_management')
StacWidget dashboardCardsManagement() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: '{{appStrings.cardsManagement.title}}',
    ),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacTobankCardManagementSlider(
            height: 184,
            initialPage: 0,
            indicatorTopSpacing: 16,
            indicatorActiveColor: '{{appColors.current.brand.primary}}',
            indicatorInactiveColor: '{{appColors.current.input.borderEnabled}}',
            indicatorSpacing: 8,
            indicatorSize: 12,
            initialPageKey: 'cardsManagement.initialPage',
            selectedEnabledKey: 'cardsManagement.selectedEnabled',
            selectedIndexKey: 'cardsManagement.selectedIndex',
            selectedTypeKey: 'cardsManagement.selectedType',
            selectedIsWalletKey: 'cardsManagement.selectedIsWallet',
            selectedIsGardeshgaryKey: 'cardsManagement.selectedIsGardeshgary',
            selectedIsNonTobankKey: 'cardsManagement.selectedIsNonTobank',
            selectedIsBlockedKey: 'cardsManagement.selectedIsBlocked',
            enabledStates: const [true, true, true, true, true, false],
            cardTypes: const [
              'wallet',
              'gardeshgary',
              'nonTobank',
              'gardeshgary',
              'nonTobank',
              'blocked',
            ],
            pages: [
              _buildWalletCard(balance: '۱۸۴,۶۰۰').toJson(),
              _buildTobankCard(
                cardNumber: '۵۰۵۴ ۱۶۱۷ ۰۲۸۴ ۴۶۹۱',
                title:
                    '{{appStrings.cardsManagement.cards.gardeshgariVirtual}}',
                expDate: '۰۶/۰۹',
                amount: '۱۲,۴۵۰,۰۰۰',
                depositNumber: '0107500462808',
                amountVisibleKey: 'cardsManagement.tobankCard.0.amountVisible',
                showRefresh: true,
              ).toJson(),
              _buildThirdPartyCard(
                bankName: '{{appStrings.cardsManagement.cards.samanBank}}',
                cardNumber: '۶۲۱۹ ۸۶۱۰ ۵۵۵۴ ۱۴۲۸',
                owner: 'test',
                expDate: '۰۵/۰۷',
              ).toJson(),
              _buildTobankCard(
                cardNumber: '۵۰۵۴ ۱۶۱۷ ۰۵۰۳ ۰۶۰۳',
                title: '{{appStrings.cardsManagement.cards.secondDeposit}}',
                expDate: '۰۷/۱۰',
                amount: '۸,۳۲۰,۰۰۰',
                depositNumber: '0107500462816',
                amountVisibleKey: 'cardsManagement.tobankCard.1.amountVisible',
              ).toJson(),
              _buildThirdPartyCard(
                bankName: '{{appStrings.cardsManagement.cards.mellatBank}}',
                cardNumber: '۶۱۰۴ ۳۳۷۸ ۱۲۹۰ ۲۲۰۱',
                owner: 'ali',
                expDate: '۰۹/۱۱',
              ).toJson(),
              _buildBlockedCard(
                cardNumber: '۵۰۵۴ ۱۶۱۶ ۵۰۱۷ ۴۷۸۶',
                bankName: 'بانک‌گردشگری',
              ).toJson(),
            ],
          ),
          StacSizedBox(height: 24),
          _buildServicesBySelectedType(),
        ],
      ),
    ),
  );
}

StacWidget _buildWalletCard({required String balance}) {
  return StacContainer(
    height: 130,
    padding: StacEdgeInsets.all(0),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#15A0A0', '#50E8E8'],
      ),
      borderRadius: StacBorderRadius.all(24),
    ),
    child: StacStack(
      children: [
        StacPositioned(
          top: 16,
          right: 16,
          child: StacImage(
            src: '{{appAssets.icons.tobankLogo}}',
            imageType: StacImageType.asset,
            width: 38,
            height: 38,
          ),
        ),
        StacPositioned(
          top: 18,
          left: 16,
          child: StacText(
            data: '{{appStrings.cardsManagement.wallet.title}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 20,
              fontWeight: StacFontWeight.w700,
              color: '#FFFFFF',
            ),
          ),
        ),
        StacPositioned(
          left: 16,
          bottom: 16,
          child: StacRow(
            children: [
              StacText(
                data: 'ریال',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '#FFFFFF',
                ),
              ),
              StacSizedBox(width: 8),
              StacText(
                data: balance,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 24,
                  fontWeight: StacFontWeight.w600,
                  color: '#FFFFFF',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildTobankCard({
  required String cardNumber,
  required String title,
  required String expDate,
  required String depositNumber,
  required String amount,
  required String amountVisibleKey,
  bool showRefresh = true,
}) {
  return StacContainer(
    height: 172,
    margin: StacEdgeInsets.symmetric(horizontal: 2),
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.bottomLeft,
        end: StacAlignment.topRight,
        colors: ['#EF3A55', '#FF5F87'],
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: '{{appAssets.icons.gardeshgari}}',
                  imageType: StacImageType.asset,
                  width: 28,
                  height: 28,
                  color: '#FFFFFF',
                ),
                StacSizedBox(width: 8),
                StacText(
                  data:
                      '\u0628\u0627\u0646\u06a9\u200c\u06af\u0631\u062f\u0634\u06af\u0631\u06cc',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 15,
                    fontWeight: StacFontWeight.w700,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
            StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.rtl,
              children: [
                if (showRefresh)
                  StacGestureDetector(
                    onTap: StacCustomSetValueAction(
                      key: amountVisibleKey,
                      value: true,
                    ),
                    child: StacImage(
                      src: '{{appAssets.icons.refresh}}',
                      imageType: StacImageType.asset,
                      width: 28,
                      height: 28,
                      color: '#FFFFFF',
                    ),
                  ),
                if (showRefresh) StacSizedBox(width: 8),
                StacCustomRegistryReactive(
                  registryKey: amountVisibleKey,
                  child: StacCustomVisibility(
                    visible: '[[$amountVisibleKey]]',
                    child: StacText(
                      data: amount,
                      textDirection: StacTextDirection.ltr,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w500,
                        color: '#FFFFFF',
                      ),
                    ).toJson(),
                    replacement: StacText(
                      data: '-',
                      textDirection: StacTextDirection.ltr,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w500,
                        color: '#FFFFFF',
                      ),
                    ).toJson(),
                  ).toJson(),
                ),
                StacSizedBox(width: 2),
                StacText(
                  data: '\u0631\u06cc\u0627\u0644',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
          ],
        ),
        StacSizedBox(height: 26),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.ltr,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacExpanded(child: StacSizedBox(height: 0)),
        StacContainer(height: 1, color: '#FFFFFF'),
        StacSizedBox(height: 12),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacGestureDetector(
                  onTap: _openCardDetailSheetAction(
                    showDelete: false,
                    isDefault: false,
                    title: title,
                    cardNumber: cardNumber,
                    expDate: expDate,
                  ),
                  child: StacImage(
                    src: '{{appAssets.icons.menu}}',
                    imageType: StacImageType.asset,
                    width: 26,
                    height: 26,
                    color: '#FFFFFF',
                  ),
                ),
                StacSizedBox(width: 20),
                StacGestureDetector(
                  onTap: _openShareSheetAction(
                    title: title,
                    cardNumber: cardNumber,
                    showDeposit: true,
                    depositNumber: depositNumber,
                  ),
                  child: StacImage(
                    src: '{{appAssets.icons.share}}',
                    imageType: StacImageType.asset,
                    width: 28,
                    height: 28,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
            StacText(
              data:
                  '\u062a\u0627\u0631\u06cc\u062e \u0627\u0646\u0642\u0636\u0627: $expDate',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w400,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildThirdPartyCard({
  required String bankName,
  required String cardNumber,
  required String owner,
  required String expDate,
}) {
  return StacContainer(
    height: 172,
    margin: StacEdgeInsets.symmetric(horizontal: 2),
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.bottomLeft,
        end: StacAlignment.topRight,
        colors: ['#1FA3E3', '#83DBF8'],
      ),
      borderRadius: StacBorderRadius.all(12),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: bankName,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 54),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: owner,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '#FFFFFF',
              ),
            ),
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.ltr,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacExpanded(child: StacSizedBox(height: 0)),
        StacContainer(height: 1, color: '#FFFFFF'),
        StacSizedBox(height: 12),
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacGestureDetector(
                  onTap: _openCardDetailSheetAction(
                    showDelete: true,
                    isDefault: false,
                    title: bankName,
                    cardNumber: cardNumber,
                    expDate: expDate,
                  ),
                  child: StacImage(
                    src: '{{appAssets.icons.menu}}',
                    imageType: StacImageType.asset,
                    width: 26,
                    height: 26,
                    color: '#FFFFFF',
                  ),
                ),
                StacSizedBox(width: 20),
                StacGestureDetector(
                  onTap: _openShareSheetAction(
                    title: bankName,
                    cardNumber: cardNumber,
                    showDeposit: false,
                    depositNumber: '',
                  ),
                  child: StacImage(
                    src: '{{appAssets.icons.share}}',
                    imageType: StacImageType.asset,
                    width: 28,
                    height: 28,
                    color: '#FFFFFF',
                  ),
                ),
              ],
            ),
            StacText(
              data:
                  '\u062a\u0627\u0631\u06cc\u062e \u0627\u0646\u0642\u0636\u0627: $expDate',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w400,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildBlockedCard({
  required String cardNumber,
  required String bankName,
}) {
  return StacContainer(
    height: 130,
    padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: StacBoxDecoration(
      gradient: StacLinearGradient(
        begin: StacAlignment.centerLeft,
        end: StacAlignment.centerRight,
        colors: ['#B9B9B9', '#8F8F8F'],
      ),
      borderRadius: StacBorderRadius.all(24),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: cardNumber,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '#FFFFFF',
              ),
            ),
            StacText(
              data: bankName,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 13,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 6),
        StacText(
          data: '{{appStrings.cardsManagement.cards.blocked}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '#FFFFFF',
          ),
        ),
        StacExpanded(
          child: StacCenter(
            child: StacImage(
              src: '{{appAssets.icons.block}}',
              imageType: StacImageType.asset,
              width: 58,
              height: 48,
              color: '#1E2538',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildServicesBySelectedType() {
  return StacCustomRegistryReactive(
    registryKey: 'cardsManagement.selectedType',
    child: StacColumn(
      children: [
        StacCustomVisibility(
          visible: '[[cardsManagement.selectedIsWallet]]',
          child: _buildWalletServices().toJson(),
          replacement: StacSizedBox(height: 0).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[cardsManagement.selectedIsGardeshgary]]',
          child: _buildGardeshgaryServices().toJson(),
          replacement: StacSizedBox(height: 0).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[cardsManagement.selectedIsNonTobank]]',
          child: _buildNonTobankServices().toJson(),
          replacement: StacSizedBox(height: 0).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[cardsManagement.selectedIsBlocked]]',
          child: _buildDisabledServices().toJson(),
          replacement: StacSizedBox(height: 0).toJson(),
        ),
      ],
    ).toJson(),
  );
}

StacWidget _buildWalletServices() {
  return StacRow(
    children: [
      StacExpanded(
        child: _serviceTile(
          title: _serviceTransferTitle,
          iconRegistryKey: 'appAssets.current.icons.cardService',
          onTap: StacSequenceAction(
            actions: [
              const StacCustomSetValueAction(
                values: [
                  {
                    'key': 'cardsManagement.wallet.isTransferFormValid',
                    'value': false,
                  },
                  {'key': 'cardsManagement.wallet.transferPhone', 'value': ''},
                  {'key': 'cardsManagement.wallet.transferAmount', 'value': ''},
                  {
                    'key': 'cardsManagement.wallet.transferDescription',
                    'value': '',
                  },
                  {
                    'key': 'cardsManagement.wallet.destinationWalletLabel',
                    'value': _walletTransferMockDestinationWallet,
                  },
                ],
              ),
              StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _walletTransferBottomSheet().toJson(),
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(width: 12),
      StacExpanded(
        child: _serviceTile(
          title: _serviceTopUpTitle,
          iconRegistryKey: 'appAssets.current.icons.cardService',
          onTap: StacSequenceAction(
            actions: [
              const StacCustomSetValueAction(
                values: [
                  {'key': 'cardsManagement.wallet.chargeAmount', 'value': ''},
                  {
                    'key': 'cardsManagement.wallet.isChargeAmountSelected',
                    'value': false,
                  },
                  {'key': 'wallet_charge_amount', 'value': ''},
                  {
                    'key': 'cardsManagement.wallet.amountPreset50kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset200kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset500kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset1000kSelected',
                    'value': false,
                  },
                ],
              ),
              StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _walletChargeBottomSheet().toJson(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildGardeshgaryServices() => _buildCardServiceGrid();

StacWidget _buildNonTobankServices() {
  return StacRow(
    children: [
      StacExpanded(
        child: _serviceTile(
          title: _serviceBalanceTitle,
          iconRegistryKey: 'appAssets.current.icons.cardBalance',
          onTap: StacRawJsonAction({
            'actionType': 'navigate',
            'widgetType': 'dashboard_card_balance',
            'navigationStyle': 'push',
          }),
        ),
      ),
      StacSizedBox(width: 12),
      StacExpanded(child: StacSizedBox(height: 0)),
    ],
  );
}

StacWidget _buildCardServiceGrid() {
  return StacColumn(
    children: [
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: _serviceSecondPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              onTap: StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _secondaryPinSelectBottomSheet().toJson(),
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceFirstPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              onTap: StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _primaryPinSelectBottomSheet().toJson(),
              ),
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: _serviceBlockTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceBlock',
              onTap: StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _cardBlockBottomSheet().toJson(),
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceReissueTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceReissue',
              onTap: StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _reissuePostalCodeBottomSheet().toJson(),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

StacAction _openCardDetailSheetAction({
  required bool showDelete,
  required bool isDefault,
  required String title,
  required String cardNumber,
  required String expDate,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'cardsManagement.sheet.showDelete', 'value': showDelete},
          {'key': 'cardsManagement.sheet.isDefault', 'value': isDefault},
          {'key': 'cardsManagement.sheet.title', 'value': title},
          {'key': 'cardsManagement.sheet.cardNumber', 'value': cardNumber},
          {'key': 'cardsManagement.sheet.expDate', 'value': expDate},
        ],
      ),
      StacShowBottomSheetAction(
        backgroundColor: '#00000000',
        sheet: _cardDetailsBottomSheet().toJson(),
      ),
    ],
  );
}

StacAction _openShareSheetAction({
  required String title,
  required String cardNumber,
  required bool showDeposit,
  required String depositNumber,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'cardsManagement.share.title', 'value': title},
          {'key': 'cardsManagement.share.cardNumber', 'value': cardNumber},
          {'key': 'cardsManagement.share.showDeposit', 'value': showDeposit},
          {
            'key': 'cardsManagement.share.depositNumber',
            'value': depositNumber,
          },
        ],
      ),
      StacShowBottomSheetAction(
        backgroundColor: '#00000000',
        sheet: _shareCardBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _cardDetailsBottomSheet() {
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
            data: 'جزئیات',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _cardDetailDefaultItem(),
          StacSizedBox(height: 16),
          _cardDetailActionItem(
            title: 'ویرایش کارت',
            iconAsset: 'assets/icons/ic_card_edit.svg',
            onTap: StacSequenceAction(
              actions: [
                const StacCloseDialogAction(),
                StacRawJsonAction({
                  'actionType': 'navigate',
                  'widgetType': 'dashboard_card_edit',
                  'navigationStyle': 'push',
                }),
              ],
            ),
          ),
          StacCustomVisibility(
            visible: '[[cardsManagement.sheet.showDelete]]',
            child: StacColumn(
              children: [
                StacSizedBox(height: 16),
                _cardDetailActionItem(
                  title: 'حذف کارت',
                  iconAsset: 'assets/icons/ic_card_delete.svg',
                  onTap: StacShowDialogAction(
                    title: 'حذف کارت',
                    description: 'آیا از حذف این کارت اطمینان دارید؟',
                    positiveText: '{{appStrings.common.confirm}}',
                    negativeText: '{{appStrings.common.cancel}}',
                    positiveAction: StacSequenceAction(
                      actions: [
                        const StacCloseDialogAction(),
                        const StacCloseDialogAction(),
                        StacCustomSnackBarAction(
                          title: 'کارت حذف شد',
                          detail: 'کارت با موفقیت از لیست حذف شد.',
                          duration: 3000,
                        ),
                      ],
                    ),
                    negativeAction: const StacCloseDialogAction(),
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

StacWidget _shareCardBottomSheet() {
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
            data: 'اشتراک‌گذاری',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _shareInfoItem(
            title: 'شماره کارت',
            valueKey: 'cardsManagement.share.cardNumber',
            iconAsset: 'assets/icons/ic_share_card.svg',
          ),
          StacCustomVisibility(
            visible: '[[cardsManagement.share.showDeposit]]',
            child: StacColumn(
              children: [
                StacSizedBox(height: 16),
                _shareInfoItem(
                  title: 'شماره سپرده',
                  valueKey: 'cardsManagement.share.depositNumber',
                  iconAsset: 'assets/icons/ic_share_deposit.svg',
                ),
              ],
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _shareInfoItem({
  required String title,
  required String valueKey,
  required String iconAsset,
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
      padding: StacEdgeInsets.all(16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          _cardDetailIconCircle(asset: iconAsset),
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
                    fontSize: 16,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: '{{$valueKey}}',
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.title}}',
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
                src: 'assets/icons/ic_copy.svg',
                imageType: StacImageType.asset,
                width: 20,
                height: 20,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
          StacGestureDetector(
            onTap: StacShareTextAction(valueKey: valueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: '{{appAssets.icons.share}}',
                imageType: StacImageType.asset,
                width: 20,
                height: 20,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _cardDetailDefaultItem() {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          _cardDetailIconCircle(asset: 'assets/icons/ic_card_default.svg'),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacText(
              data: 'انتخاب کارت پیش‌فرض',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacCustomReactiveSwitch(
            valueKey: 'cardsManagement.sheet.isDefault',
            activeColor: '{{appColors.current.button.primary.backgroundColor}}',
            inactiveTrackColor: '{{appColors.current.input.borderEnabled}}',
            inactiveThumbColor:
                '{{appColors.current.background.surfaceContainerLowest}}',
            scale: 0.7,
          ),
        ],
      ),
    ),
  );
}

StacWidget _cardDetailActionItem({
  required String title,
  required String iconAsset,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacPadding(
        padding: StacEdgeInsets.all(16),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            _cardDetailIconCircle(asset: iconAsset),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w400,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _cardDetailIconCircle({required String asset}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(40),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(8),
      child: StacImage(
        src: asset,
        imageType: StacImageType.asset,
        width: 24,
        height: 24,
      ),
    ),
  );
}

StacWidget _buildDisabledServices() {
  return StacColumn(
    children: [
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: _serviceSecondPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              enabled: false,
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceFirstPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              enabled: false,
            ),
          ),
        ],
      ),
      StacSizedBox(height: 12),
      StacRow(
        children: [
          StacExpanded(
            child: _serviceTile(
              title: _serviceBlockTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceBlock',
              enabled: false,
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceReissueTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceReissue',
              onTap: StacShowBottomSheetAction(
                backgroundColor: '#00000000',
                sheet: _reissuePostalCodeBottomSheet().toJson(),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _serviceTile({
  required String title,
  required String iconRegistryKey,
  bool enabled = true,
  StacAction? onTap,
}) {
  final borderColor = '{{appColors.current.input.borderEnabled}}';
  final enabledColor = '{{appColors.current.text.title}}';
  final disabledColor = '{{appColors.current.text.hint}}';
  final foreground = enabled ? enabledColor : disabledColor;

  final tile = StacContainer(
    height: 92,
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(color: borderColor, width: 1),
    ),
    child: StacColumn(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        _serviceIcon(
          registryKey: iconRegistryKey,
          color: enabled ? null : foreground,
        ),
        StacSizedBox(height: 8),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: foreground,
          ),
        ),
      ],
    ),
  );

  if (!enabled || onTap == null) {
    return tile;
  }
  return StacGestureDetector(onTap: onTap, child: tile);
}

StacWidget _serviceIcon({required String registryKey, String? color}) {
  return StacRawJsonWidget({
    'type': 'image',
    'src': '',
    'registryKey': registryKey,
    'imageType': 'asset',
    'width': 32,
    'height': 28,
    ...?(color == null ? null : {'color': color}),
  });
}

// ─── Wallet: Charge ───────────────────────────────────────────────────────

StacWidget _walletChargeBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacForm(
      autovalidateMode: StacAutovalidateMode.onUserInteraction,
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
              data: 'شارژ کیف پول',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 12),
            StacContainer(
              padding: StacEdgeInsets.all(16),
              decoration: StacBoxDecoration(
                borderRadius: StacBorderRadius.all(8),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacText(
                data:
                    'مبلغ کیف پول شما قابل برداشت نیست و فقط در بخش خدمات توبانک قابل استفاده میباشد',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 13,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.hint}}',
                ),
              ),
            ),
            StacSizedBox(height: 20),
            StacText(
              data: 'مبلغ شارژ',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: 'wallet_charge_amount',
              textDirection: 'rtl',
              textAlign: 'right',
              keyboardType: 'number',
              formatThousands: true,
              thousandsSeparator: '،',
              onChanged: StacCustomSetValueAction(
                values: [
                  {
                    'key': 'cardsManagement.wallet.chargeAmount',
                    'value': '[[wallet_charge_amount]]',
                  },
                  {
                    'key': 'cardsManagement.wallet.isChargeAmountSelected',
                    'value': true,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset50kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset200kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset500kSelected',
                    'value': false,
                  },
                  {
                    'key': 'cardsManagement.wallet.amountPreset1000kSelected',
                    'value': false,
                  },
                ],
              ),
              decoration: {
                'hintText': 'مبلغ شارژ را به ریال وارد کنید',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
                },
                'helperText':
                    'حداقل مبلغ شارژ ۱۰،۰۰۰ ریال و سقف موجودی ۵۰،۰۰۰،۰۰۰ ریال',
                'helperStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 12,
                  },
                },
                'border': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'enabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'disabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderFocused}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 16,
                  'right': 16,
                  'bottom': 16,
                },
              },
            ),
            StacSizedBox(height: 12),
            StacColumn(
              children: [
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    _amountChip(
                      '۵۰،۰۰۰ ریال',
                      rawValue: '50000',
                      fieldValue: '۵۰،۰۰۰',
                      selectedKey:
                          'cardsManagement.wallet.amountPreset50kSelected',
                      resetKeys: const [
                        'cardsManagement.wallet.amountPreset200kSelected',
                        'cardsManagement.wallet.amountPreset500kSelected',
                        'cardsManagement.wallet.amountPreset1000kSelected',
                      ],
                    ),
                    StacSizedBox(width: 8),
                    _amountChip(
                      '۲۰۰،۰۰۰ ریال',
                      rawValue: '200000',
                      fieldValue: '۲۰۰،۰۰۰',
                      selectedKey:
                          'cardsManagement.wallet.amountPreset200kSelected',
                      resetKeys: const [
                        'cardsManagement.wallet.amountPreset50kSelected',
                        'cardsManagement.wallet.amountPreset500kSelected',
                        'cardsManagement.wallet.amountPreset1000kSelected',
                      ],
                    ),
                  ],
                ),
                StacSizedBox(height: 8),
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    _amountChip(
                      '۵۰۰،۰۰۰ ریال',
                      rawValue: '500000',
                      fieldValue: '۵۰۰،۰۰۰',
                      selectedKey:
                          'cardsManagement.wallet.amountPreset500kSelected',
                      resetKeys: const [
                        'cardsManagement.wallet.amountPreset50kSelected',
                        'cardsManagement.wallet.amountPreset200kSelected',
                        'cardsManagement.wallet.amountPreset1000kSelected',
                      ],
                    ),
                    StacSizedBox(width: 8),
                    _amountChip(
                      '۱،۰۰۰،۰۰۰ ریال',
                      rawValue: '1000000',
                      fieldValue: '۱،۰۰۰،۰۰۰',
                      selectedKey:
                          'cardsManagement.wallet.amountPreset1000kSelected',
                      resetKeys: const [
                        'cardsManagement.wallet.amountPreset50kSelected',
                        'cardsManagement.wallet.amountPreset200kSelected',
                        'cardsManagement.wallet.amountPreset500kSelected',
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StacSizedBox(height: 24),
            StacCustomRegistryReactive(
              registryKey: 'cardsManagement.wallet.isChargeAmountSelected',
              child: StacCustomVisibility(
                visible: '[[cardsManagement.wallet.isChargeAmountSelected]]',
                child: _walletChargeContinueButton().toJson(),
                replacement: _walletChargeDisabledButton().toJson(),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _walletChargeContinueButton() {
  return StacFilledButton(
    onPressed: StacSequenceAction(
      actions: [
        const StacCustomSetValueAction(
          key: 'cardsManagement.wallet.paymentMethod',
          value: 'gateway',
        ),
        StacShowBottomSheetAction(
          backgroundColor: '#00000000',
          sheet: _walletPaymentMethodBottomSheet().toJson(),
        ),
      ],
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
      foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _walletChargeDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title: 'مبلغ شارژ انتخاب نشده',
      detail: 'لطفاً مبلغ شارژ را وارد کنید یا از مبالغ پیشنهادی انتخاب کنید.',
      duration: 2000,
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.input.borderEnabled}}',
      foregroundColor: '{{appColors.current.text.hint}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _amountChip(
  String label, {
  required String rawValue,
  required String fieldValue,
  required String selectedKey,
  required List<String> resetKeys,
}) {
  StacWidget chipContent({
    required String borderColor,
    required double borderWidth,
  }) {
    return StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 10),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.card}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(color: borderColor, width: borderWidth),
      ),
      child: StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    );
  }

  return StacExpanded(
    child: StacGestureDetector(
      onTap: StacCustomSetValueAction(
        values: [
          {'key': 'cardsManagement.wallet.chargeAmount', 'value': fieldValue},
          {
            'key': 'cardsManagement.wallet.isChargeAmountSelected',
            'value': true,
          },
          {'key': 'wallet_charge_amount', 'value': fieldValue},
          {'key': selectedKey, 'value': true},
          ...resetKeys.map((key) => {'key': key, 'value': false}),
        ],
      ),
      child: StacCustomRegistryReactive(
        registryKey: selectedKey,
        child: StacCustomVisibility(
          visible: '[[${selectedKey}]]',
          child: chipContent(
            borderColor: '{{appColors.current.button.primary.backgroundColor}}',
            borderWidth: 1.5,
          ).toJson(),
          replacement: chipContent(
            borderColor: '{{appColors.current.input.borderEnabled}}',
            borderWidth: 1,
          ).toJson(),
        ).toJson(),
      ),
    ),
  );
}

// ─── Wallet: Payment Method ───────────────────────────────────────────────

StacWidget _walletPaymentMethodBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
          StacCenter(
            child: StacContainer(
              width: 56,
              height: 56,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.card}}',
                borderRadius: StacBorderRadius.all(28),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_wallet.svg',
                  imageType: StacImageType.asset,
                  width: 28,
                  height: 28,
                  color: '{{appColors.current.text.body}}',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 20),
          StacText(
            data: 'افزایش موجودی کیف پول',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 28),
          _walletPaymentSummaryRow(
            title: 'مبلغ قابل پرداخت',
            valueKey: 'cardsManagement.wallet.chargeAmount',
            suffix: 'ریال',
          ),
          StacSizedBox(height: 28),
          StacText(
            data: 'روش پرداخت',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacContainer(
            height: 72,
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surface}}',
              borderRadius: StacBorderRadius.all(16),
              border: StacBorder.all(
                color: '{{appColors.current.brand.primary}}',
                width: 1.5,
              ),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacContainer(
                  width: 44,
                  height: 44,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.card}}',
                    borderRadius: StacBorderRadius.all(16),
                  ),
                  child: StacCenter(
                    child: StacImage(
                      src: 'assets/icons/ic_gateway.svg',
                      imageType: StacImageType.asset,
                      width: 22,
                      height: 22,
                      color: '{{appColors.current.icon.main}}',
                    ),
                  ),
                ),
                StacExpanded(
                  child: StacPadding(
                    padding: StacEdgeInsets.only(right: 16),
                    child: StacText(
                      data: 'درگاه بانکی',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 48),
          StacFilledButton(
            onPressed: StacShowDialogAction(
              dialogActionType: 'showLogoutConfirmDialog',
              warningIconAsset: 'assets/icons/ic_warning_red.svg',
              title: 'تایید افزایش موجودی',
              description: 'آیا از افزایش موجودی کیف پول مطمئن هستید؟',
              positiveText: '{{appStrings.common.confirm}}',
              negativeText: '{{appStrings.common.cancel}}',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  StacCustomSnackBarAction(
                    title: 'افزایش موجودی با موفقیت ثبت شد',
                    detail: 'موجودی کیف پول به‌روزرسانی شد. (mock)',
                    duration: 3000,
                  ),
                ],
              ),
              negativeAction: const StacCloseDialogAction(),
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'پرداخت',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _walletPaymentSummaryRow({
  required String title,
  required String valueKey,
  String? suffix,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w400,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacFlexible(
        child: StacCustomRegistryReactive(
          registryKey: valueKey,
          child: StacText(
            data: suffix == null ? '{{$valueKey}}' : '{{$valueKey}} $suffix',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ).toJson(),
        ),
      ),
    ],
  );
}

// ─── Wallet: Transfer ─────────────────────────────────────────────────────

StacWidget _walletTransferBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacForm(
      autovalidateMode: StacAutovalidateMode.onUserInteraction,
      child: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
              data: 'انتقال وجه کیف پول',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 24),
            StacText(
              data: 'شماره موبایل',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(
                  child: StacCustomTextFormField(
                    id: 'wallet_transfer_phone',
                    textDirection: 'rtl',
                    textAlign: 'right',
                    keyboardType: 'phone',
                    maxLength: 11,
                    inputFormatters: const [
                      {'type': 'allow', 'rule': '[0-9]'},
                    ],
                    validatorRules: const [
                      {
                        'rule': r'^09\d{9}$',
                        'message': 'شماره موبایل معتبر نیست',
                      },
                    ],
                    onChanged: StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'cardsManagement.wallet.transferPhone',
                          value: const StacGetFormValueAction(
                            id: 'wallet_transfer_phone',
                          ),
                        ),
                        const StacValidateFieldsAction(
                          resultKey:
                              'cardsManagement.wallet.isTransferFormValid',
                          fields: [
                            {
                              'id': 'wallet_transfer_phone',
                              'rule': r'^09\d{9}$',
                            },
                            {
                              'id': 'wallet_transfer_amount',
                              'rule': r'^[0-9،]{6,}$',
                            },
                          ],
                        ),
                      ],
                    ),
                    decoration: {
                      'hintText': 'شماره همراه مقصد را وارد کنید',
                      'hintStyle': {
                        'textDirection': 'rtl',
                        'style': {
                          'color': '{{appColors.current.text.hint}}',
                          'fontSize': 14,
                        },
                      },
                      'enabledBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color': '{{appColors.current.input.borderEnabled}}',
                          'width': 1,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'focusedBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color':
                              '{{appColors.current.button.primary.backgroundColor}}',
                          'width': 1.5,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'contentPadding': {
                        'left': 16,
                        'top': 16,
                        'right': 16,
                        'bottom': 16,
                      },
                    },
                  ),
                ),
                StacSizedBox(width: 8),
                StacGestureDetector(
                  onTap: StacPickContactPhoneAction(
                    formFieldId: 'wallet_transfer_phone',
                    targetKey: 'cardsManagement.wallet.transferPhone',
                    permissionDeniedMessage: 'دسترسی مخاطبین مجاز نیست',
                    invalidMobileMessage: 'شماره همراه معتبر در مخاطب یافت نشد',
                  ),
                  child: StacContainer(
                    width: 52,
                    height: 52,
                    decoration: StacBoxDecoration(
                      borderRadius: StacBorderRadius.all(12),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacCenter(
                      child: StacImage(
                        src: 'assets/icons/ic_contact_list.svg',
                        imageType: StacImageType.asset,
                        width: 24,
                        height: 24,
                        color: '{{appColors.current.button.primary}}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 16),
            StacText(
              data: 'مبلغ انتقال',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: 'wallet_transfer_amount',
              textDirection: 'rtl',
              textAlign: 'right',
              keyboardType: 'number',
              formatThousands: true,
              thousandsSeparator: '،',
              validatorRules: const [
                {
                  'rule': r'^\d{5,}$',
                  'message': 'حداقل مبلغ انتقال ۱۰،۰۰۰ ریال است',
                },
              ],
              onChanged: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'cardsManagement.wallet.transferAmount',
                    value: const StacGetFormValueAction(
                      id: 'wallet_transfer_amount',
                    ),
                  ),
                  const StacValidateFieldsAction(
                    resultKey: 'cardsManagement.wallet.isTransferFormValid',
                    fields: [
                      {'id': 'wallet_transfer_phone', 'rule': r'^09\d{9}$'},
                      {'id': 'wallet_transfer_amount', 'rule': r'^[0-9،]{6,}$'},
                    ],
                  ),
                ],
              ),
              decoration: {
                'hintText': 'مبلغ را به ریال وارد کنید',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
                },
                'enabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color':
                        '{{appColors.current.button.primary.backgroundColor}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 16,
                  'right': 16,
                  'bottom': 16,
                },
              },
            ),
            StacSizedBox(height: 16),
            StacText(
              data: 'توضیحات(اختیاری)',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacCustomTextFormField(
              id: 'wallet_transfer_desc',
              textDirection: 'rtl',
              textAlign: 'right',
              maxLines: 2,
              onChanged: StacCustomSetValueAction(
                key: 'cardsManagement.wallet.transferDescription',
                value: const StacGetFormValueAction(id: 'wallet_transfer_desc'),
              ),
              decoration: {
                'hintText': 'توضیحات انتقال وجه را وارد کنید',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
                },
                'enabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color':
                        '{{appColors.current.button.primary.backgroundColor}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 16,
                  'right': 16,
                  'bottom': 16,
                },
              },
            ),
            StacSizedBox(height: 24),
            StacCustomReactiveElevatedButton(
              enabledKey: 'cardsManagement.wallet.isTransferFormValid',
              onPressed: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'cardsManagement.wallet.transferPhone',
                    value: const StacGetFormValueAction(
                      id: 'wallet_transfer_phone',
                    ),
                  ),
                  StacCustomSetValueAction(
                    key: 'cardsManagement.wallet.transferAmount',
                    value: const StacGetFormValueAction(
                      id: 'wallet_transfer_amount',
                    ),
                  ),
                  StacCustomSetValueAction(
                    key: 'cardsManagement.wallet.transferDescription',
                    value: const StacGetFormValueAction(
                      id: 'wallet_transfer_desc',
                    ),
                  ),
                  const StacCustomSetValueAction(
                    key: 'cardsManagement.wallet.destinationWalletLabel',
                    value: _walletTransferMockDestinationWallet,
                  ),
                  StacShowBottomSheetAction(
                    backgroundColor: '#00000000',
                    sheet: _walletTransferConfirmBottomSheet().toJson(),
                  ),
                ],
              ).toJson(),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              disabledStyle: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor: '{{appColors.current.input.borderEnabled}}',
                foregroundColor: '{{appColors.current.text.subtitle}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              child: StacText(
                data: 'ادامه',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w700,
                ),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _walletTransferContactPicker() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
            data: 'انتخاب از مخاطبین',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _contactRow(name: 'علی سینایی', phone: '09121234567'),
          _sheetDivider(),
          _contactRow(name: 'رضا محمدی', phone: '09351112222'),
          _sheetDivider(),
          _contactRow(name: 'مریم احمدی', phone: '09123334444'),
        ],
      ),
    ),
  );
}

StacWidget _contactRow({required String name, required String phone}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: 'cardsManagement.wallet.transferPhone',
          value: phone,
        ),
        const StacCloseDialogAction(),
      ],
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(vertical: 14),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.end,
            mainAxisSize: StacMainAxisSize.min,
            children: [
              StacText(
                data: name,
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 2),
              StacText(
                data: phone,
                textDirection: StacTextDirection.ltr,
                style: StacCustomTextStyle(
                  fontSize: 13,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.hint}}',
                ),
              ),
            ],
          ),
          StacImage(
            src: '{{appAssets.current.icons.contacts}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.hint}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _sheetDivider() => StacContainer(
  height: 1,
  decoration: StacBoxDecoration(
    color: '{{appColors.current.input.borderEnabled}}',
  ),
);

// ─── Wallet: Transfer Confirm ─────────────────────────────────────────────

StacWidget _walletTransferConfirmBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
          StacCenter(
            child: StacContainer(
              width: 56,
              height: 56,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.card}}',
                borderRadius: StacBorderRadius.all(28),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_wallet.svg',
                  imageType: StacImageType.asset,
                  width: 28,
                  height: 28,
                  color: '{{appColors.current.text.body}}',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                data: 'مبلغ انتقال',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.hint}}',
                ),
              ),
              StacFlexible(
                child: StacText(
                  data: '{{cardsManagement.wallet.transferAmount}} ریال',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.left,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 16),
          StacContainer(
            padding: StacEdgeInsets.all(16),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.card}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _summaryRowFromRegistry(
                  label: 'کیف پول مقصد',
                  value: _walletTransferMockDestinationWallet,
                ),
                StacSizedBox(height: 12),
                _summaryRowFromRegistry(
                  label: 'توضیحات',
                  value: '{{cardsManagement.wallet.transferDescription}}',
                ),
              ],
            ),
          ),
          StacSizedBox(height: 24),
          StacFilledButton(
            onPressed: StacShowDialogAction(
              dialogActionType: 'showLogoutConfirmDialog',
              warningIconAsset: 'assets/icons/ic_warning_red.svg',
              title: 'آیا از پرداخت وجه مطمئن هستید؟',
              description:
                  'بعد از پرداخت، بازگشت وجه امکان پذیر نیست. لذا از دستور پرداخت اطمینان حاصل فرمایید',
              positiveText: '{{appStrings.common.confirm}}',
              negativeText: '{{appStrings.common.cancel}}',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  StacRawJsonAction({
                    'actionType': 'navigate',
                    'widgetType': 'dashboard_wallet_transfer_receipt',
                    'navigationStyle': 'push',
                  }),
                ],
              ),
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'پرداخت',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _summaryRow({required String label, required String valueKey}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: valueKey,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.body}}',
        ),
      ),
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w400,
          color: '{{appColors.current.text.hint}}',
        ),
      ),
    ],
  );
}

StacWidget _summaryRowFromRegistry({
  required String label,
  required String value,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w400,
          color: '{{appColors.current.text.hint}}',
        ),
      ),
      StacFlexible(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

// ─── PIN: Primary ─────────────────────────────────────────────────────────

StacWidget _primaryPinSelectBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
            data: 'خدمات مورد نظر خود را انتخاب نمایید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _pinServiceRow(
            label: 'دریافت رمز اول',
            selectedKey: 'cardsManagement.pin.primaryEventIsGet',
            onTap: StacCustomSetValueAction(
              values: [
                {
                  'key': 'cardsManagement.pin.primarySelectedEventId',
                  'value': '1',
                },
                {'key': 'cardsManagement.pin.primaryEventIsGet', 'value': true},
                {
                  'key': 'cardsManagement.pin.primaryEventIsChange',
                  'value': false,
                },
              ],
            ),
          ),
          StacSizedBox(height: 12),
          _pinServiceRow(
            label: 'تغییر رمز اول',
            selectedKey: 'cardsManagement.pin.primaryEventIsChange',
            onTap: StacCustomSetValueAction(
              values: [
                {
                  'key': 'cardsManagement.pin.primarySelectedEventId',
                  'value': '2',
                },
                {
                  'key': 'cardsManagement.pin.primaryEventIsGet',
                  'value': false,
                },
                {
                  'key': 'cardsManagement.pin.primaryEventIsChange',
                  'value': true,
                },
              ],
            ),
          ),
          StacSizedBox(height: 32),
          StacCustomRegistryReactive(
            registryKey: 'cardsManagement.pin.primarySelectedEventId',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacCustomVisibility(
                  visible: '[[cardsManagement.pin.primaryEventIsGet]]',
                  child: _pinContinueButton(
                    screenName: 'dashboard_primary_pin_get',
                  ).toJson(),
                  replacement: StacCustomVisibility(
                    visible: '[[cardsManagement.pin.primaryEventIsChange]]',
                    child: _pinContinueButton(
                      screenName: 'dashboard_primary_pin_change',
                    ).toJson(),
                    replacement: _pinDisabledButton().toJson(),
                  ).toJson(),
                ),
              ],
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _pinServiceRow({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  StacWidget _rowContent({
    required String borderColor,
    required double borderWidth,
  }) {
    return StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(color: borderColor, width: borderWidth),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacText(
            data: label,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacContainer(
            width: 40,
            height: 40,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainerLowest}}',
              borderRadius: StacBorderRadius.all(20),
            ),
            child: StacCenter(
              child: StacRawJsonWidget({
                'type': 'image',
                'src': '',
                'registryKey':
                    'appAssets.current.icons.cardServicePasswordChange',
                'imageType': 'asset',
                'width': 24,
                'height': 24,
              }),
            ),
          ),
        ],
      ),
    );
  }

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomRegistryReactive(
      registryKey: selectedKey,
      child: StacCustomVisibility(
        visible: '[[${selectedKey}]]',
        child: _rowContent(
          borderColor: '{{appColors.current.button.primary.backgroundColor}}',
          borderWidth: 1.5,
        ).toJson(),
        replacement: _rowContent(
          borderColor: '{{appColors.current.input.borderEnabled}}',
          borderWidth: 1,
        ).toJson(),
      ).toJson(),
    ),
  );
}

StacWidget _pinContinueButton({required String screenName}) {
  return StacFilledButton(
    onPressed: StacSequenceAction(
      actions: [
        const StacCloseDialogAction(),
        StacRawJsonAction({
          'actionType': 'navigate',
          'widgetType': screenName,
          'navigationStyle': 'push',
        }),
      ],
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
      foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _pinDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title: 'انتخاب نشده',
      detail: 'لطفاً یک گزینه را انتخاب کنید.',
      duration: 2000,
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.input.borderEnabled}}',
      foregroundColor: '{{appColors.current.text.hint}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

// ─── PIN: Secondary ───────────────────────────────────────────────────────

StacWidget _secondaryPinSelectBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
            data: 'خدمات مورد نظر خود را انتخاب نمایید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _secPinServiceRow(
            label: 'دریافت رمز دوم',
            selectedKey: 'cardsManagement.pin.secondaryEventIsGet',
            onTap: StacCustomSetValueAction(
              values: [
                {
                  'key': 'cardsManagement.pin.secondarySelectedEventId',
                  'value': '1',
                },
                {
                  'key': 'cardsManagement.pin.secondaryEventIsGet',
                  'value': true,
                },
                {
                  'key': 'cardsManagement.pin.secondaryEventIsChange',
                  'value': false,
                },
              ],
            ),
          ),
          StacSizedBox(height: 12),
          _secPinServiceRow(
            label: 'تغییر رمز دوم',
            selectedKey: 'cardsManagement.pin.secondaryEventIsChange',
            onTap: StacCustomSetValueAction(
              values: [
                {
                  'key': 'cardsManagement.pin.secondarySelectedEventId',
                  'value': '2',
                },
                {
                  'key': 'cardsManagement.pin.secondaryEventIsGet',
                  'value': false,
                },
                {
                  'key': 'cardsManagement.pin.secondaryEventIsChange',
                  'value': true,
                },
              ],
            ),
          ),
          StacSizedBox(height: 32),
          StacCustomRegistryReactive(
            registryKey: 'cardsManagement.pin.secondarySelectedEventId',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacCustomVisibility(
                  visible: '[[cardsManagement.pin.secondaryEventIsGet]]',
                  child: _secContinueButton(
                    screenName: 'dashboard_secondary_pin_get',
                  ).toJson(),
                  replacement: StacCustomVisibility(
                    visible: '[[cardsManagement.pin.secondaryEventIsChange]]',
                    child: _secContinueButton(
                      screenName: 'dashboard_secondary_pin_change',
                    ).toJson(),
                    replacement: _secDisabledButton().toJson(),
                  ).toJson(),
                ),
              ],
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _secPinServiceRow({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  StacWidget _rowContent({
    required String borderColor,
    required double borderWidth,
  }) {
    return StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(color: borderColor, width: borderWidth),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacText(
            data: label,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacContainer(
            width: 40,
            height: 40,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainerLowest}}',
              borderRadius: StacBorderRadius.all(20),
            ),
            child: StacCenter(
              child: StacRawJsonWidget({
                'type': 'image',
                'src': '',
                'registryKey':
                    'appAssets.current.icons.cardServicePasswordChange',
                'imageType': 'asset',
                'width': 24,
                'height': 24,
              }),
            ),
          ),
        ],
      ),
    );
  }

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomRegistryReactive(
      registryKey: selectedKey,
      child: StacCustomVisibility(
        visible: '[[${selectedKey}]]',
        child: _rowContent(
          borderColor: '{{appColors.current.button.primary.backgroundColor}}',
          borderWidth: 1.5,
        ).toJson(),
        replacement: _rowContent(
          borderColor: '{{appColors.current.input.borderEnabled}}',
          borderWidth: 1,
        ).toJson(),
      ).toJson(),
    ),
  );
}

StacWidget _secContinueButton({required String screenName}) {
  return StacFilledButton(
    onPressed: StacSequenceAction(
      actions: [
        const StacCloseDialogAction(),
        StacRawJsonAction({
          'actionType': 'navigate',
          'widgetType': screenName,
          'navigationStyle': 'push',
        }),
      ],
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
      foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _secDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title: 'انتخاب نشده',
      detail: 'لطفاً یک گزینه را انتخاب کنید.',
      duration: 2000,
    ),
    style: StacButtonStyle(
      padding: StacEdgeInsets.symmetric(vertical: 8),
      minimumSize: const StacSize(0, 56),
      backgroundColor: '{{appColors.current.input.borderEnabled}}',
      foregroundColor: '{{appColors.current.text.hint}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

// ─── Reissue: Postal Code ─────────────────────────────────────────────────

StacWidget _reissuePostalCodeBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
            data: 'در صورت درخواست صدور کارت المثنی',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 15,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _infoBullet(
            text: 'شماره کارت، تاریخ انقضاء و CVV2 کارت بانکی تغییر خواهد کرد',
          ),
          StacSizedBox(height: 8),
          _infoBullet(
            text:
                'کارمزد صدور کارت المثنی از سپرده متعلق به کارت بانکی مذکور کسر خواهد شد',
          ),
          StacSizedBox(height: 8),
          _infoBullet(text: 'کارمزد صدور کارت المثنی (۵۷۰٬۰۰۰) ریال می‌باشد.'),
          StacSizedBox(height: 24),
          StacText(
            data: 'کد پستی',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: 'reissue_postal_code',
            textDirection: 'rtl',
            textAlign: 'right',
            keyboardType: 'number',
            maxLength: 10,
            onChanged: StacCustomSetValueAction(
              key: 'cardsManagement.reissue.postalCode',
              value: '[[reissue_postal_code]]',
            ),
            decoration: {
              'hintText': 'کد پستی محل سکونت را وارد کنید',
              'hintStyle': {
                'textDirection': 'rtl',
                'style': {
                  'color': '{{appColors.current.text.hint}}',
                  'fontSize': 14,
                },
              },
              'counterText': '',
              'enabledBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outlineInputBorder',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 16,
                'right': 16,
                'bottom': 16,
              },
            },
          ),
          StacSizedBox(height: 24),
          StacFilledButton(
            onPressed: StacSequenceAction(
              actions: [
                const StacCloseDialogAction(),
                StacRawJsonAction({
                  'actionType': 'navigate',
                  'widgetType': 'dashboard_card_reissue_request',
                  'navigationStyle': 'push',
                }),
              ],
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'استعلام',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _infoBullet({required String text}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacPadding(
        padding: StacEdgeInsets.only(top: 2),
        child: StacImage(
          src: '{{appAssets.current.icons.successCheck}}',
          imageType: StacImageType.asset,
          width: 18,
          height: 18,
          color: '{{appColors.current.text.hint}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacText(
          data: text,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.hint}}',
          ),
        ),
      ),
    ],
  );
}

// ─── Block ────────────────────────────────────────────────────────────────

// CARD_TO_CARD_HIDDEN: keep eventCode == 1 hidden until product enables it.
// To enable later: surface the tile and gate visibility on bankInfo.isTransfer == true,
// else show "card_to_card_not_available" snackbar.

StacWidget _cardBlockBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 24),
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
          StacSizedBox(height: 20),
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.start,
            children: [
              StacImage(
                src: 'assets/icons/ic_warning_red.svg',
                imageType: StacImageType.asset,
                width: 56,
                height: 56,
              ),
            ],
          ),
          StacSizedBox(height: 16),
          StacText(
            data: '{{appStrings.cardsManagement.block.title}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data:
                'در صورت ارسال درخواست مسدودی، تمامی امکانات کارت شما غیرفعال می‌شود و برای استفاده مجدد از کارت باید به صورت حضوری به شعبه بانک مراجعه نمایید.',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w400,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacSizedBox(height: 20),
          StacText(
            data: '{{appStrings.cardsManagement.block.reasonTitle}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 20),
          _blockReasonRow(
            label: '{{appStrings.cardsManagement.block.reasonLost}}',
            reasonId: '1',
          ),
          StacSizedBox(height: 12),
          _blockReasonRow(
            label: '{{appStrings.cardsManagement.block.reasonStolen}}',
            reasonId: '2',
          ),
          StacSizedBox(height: 32),
          StacFilledButton(
            onPressed: StacShowDialogAction(
              title: '{{appStrings.cardsManagement.block.confirmTitle}}',
              description:
                  'کارت [[cardsManagement.sheet.cardNumber]] مسدود خواهد شد. این عملیات قابل بازگشت نیست.',
              positiveText: '{{appStrings.common.confirm}}',
              negativeText: '{{appStrings.common.cancel}}',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  StacCustomSnackBarAction(
                    title: '{{appStrings.cardsManagement.block.successTitle}}',
                    detail: 'کارت در اسرع وقت مسدود خواهد شد. (mock)',
                    duration: 3500,
                  ),
                ],
              ),
              negativeAction: const StacCloseDialogAction(),
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor: '{{appColors.current.state.error}}',
              foregroundColor: '{{appColors.current.text.inverse}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: '{{appStrings.cardsManagement.block.title}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _blockReasonRow({required String label, required String reasonId}) {
  return StacGestureDetector(
    onTap: StacCustomSetValueAction(
      key: 'cardsManagement.block.selectedReasonId',
      value: reasonId,
    ),
    child: StacCustomRegistryReactive(
      registryKey: 'cardsManagement.block.selectedReasonId',
      child: StacContainer(
        padding: StacEdgeInsets.all(14),
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacText(
              data: label,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacCustomVisibility(
              visible:
                  '[[cardsManagement.block.selectedReasonId]] == "$reasonId"',
              child: StacContainer(
                width: 20,
                height: 20,
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.button.primary.backgroundColor}}',
                  borderRadius: StacBorderRadius.all(10),
                ),
                child: StacCenter(
                  child: StacContainer(
                    width: 8,
                    height: 8,
                    decoration: StacBoxDecoration(
                      color: '#FFFFFF',
                      borderRadius: StacBorderRadius.all(4),
                    ),
                  ),
                ),
              ).toJson(),
              replacement: StacContainer(
                width: 20,
                height: 20,
                decoration: StacBoxDecoration(
                  borderRadius: StacBorderRadius.all(10),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 2,
                  ),
                ),
              ).toJson(),
            ),
          ],
        ),
      ).toJson(),
    ),
  );
}

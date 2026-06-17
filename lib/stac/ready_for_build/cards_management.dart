import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
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
const _walletTransferMockDestinationWallet =
    '{{appStrings.generated.card_management.card_management_root.sample_cardholder_name}}';

@StacScreen(screenName: 'card_management_root')
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
              _buildWalletCard(
                balance:
                    '{{appStrings.generated.card_management.cards_management.title}}',
              ).toJson(),
              _buildTobankCard(
                cardNumber:
                    '{{appStrings.generated.transfer.transfer_amount.card_number_label}}',
                title:
                    '{{appStrings.cardsManagement.cards.gardeshgariVirtual}}',
                expDate:
                    '{{appStrings.generated.card_management.cards_management.date_value}}',
                amount:
                    '{{appStrings.generated.card_management.cards_management.amount_value}}',
                depositNumber: '0107500462808',
                amountVisibleKey: 'cardsManagement.tobankCard.0.amountVisible',
                showRefresh: true,
              ).toJson(),
              _buildThirdPartyCard(
                bankName: '{{appStrings.cardsManagement.cards.samanBank}}',
                cardNumber:
                    '{{appStrings.generated.card_management.cards_management.card_number}}',
                owner: 'test',
                expDate:
                    '{{appStrings.generated.card_management.cards_management.date_value_text}}',
              ).toJson(),
              _buildTobankCard(
                cardNumber:
                    '{{appStrings.generated.card_management.cards_management.card_number_text}}',
                title: '{{appStrings.cardsManagement.cards.secondDeposit}}',
                expDate:
                    '{{appStrings.generated.card_management.cards_management.date_value_label}}',
                amount:
                    '{{appStrings.generated.card_management.cards_management.amount_value_text}}',
                depositNumber: '0107500462816',
                amountVisibleKey: 'cardsManagement.tobankCard.1.amountVisible',
              ).toJson(),
              _buildThirdPartyCard(
                bankName: '{{appStrings.cardsManagement.cards.mellatBank}}',
                cardNumber:
                    '{{appStrings.generated.card_management.cards_management.card_number_label}}',
                owner: 'ali',
                expDate:
                    '{{appStrings.generated.card_management.cards_management.date_value_message}}',
              ).toJson(),
              _buildBlockedCard(
                cardNumber:
                    '{{appStrings.generated.card_management.cards_management.card_number_message}}',
                bankName: '{{appStrings.homePage.cards.bankTitle}}',
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
                data: '{{appStrings.common.rial}}',
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
                  data: '{{appStrings.homePage.cards.bankTitle}}',
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
                  data: '{{appStrings.common.rial}}',
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
                  '{{appStrings.generated.card_management.card_management_root.sample_cardholder_name}}',
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
                  '{{appStrings.generated.card_management.card_management_root.sample_cardholder_name}}',
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
                title: 'wallet_transfer',
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
                title: 'wallet_charge',
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
          onTap: NavigationAction(
            fileName: 'card_management_balance',
            navMode: NavModes.dart,
            navigationStyle: NavigationStyle.push,
          ),
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
                title: 'secondary_pin_select',
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
                title: 'primary_pin_select',
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
                title: 'card_block',
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
              onTap: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'cardsManagement.reissue.postalInquiryEnabled',
                    value: false,
                  ),
                  StacCustomSetValueAction(
                    key: 'cardsManagement.reissue.postalCode',
                    value: '',
                  ),
                  StacShowBottomSheetAction(
                    title: 'card_reissue',
                    backgroundColor: '#00000000',
                    sheet: _reissuePostalCodeBottomSheet().toJson(),
                  ),
                ],
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
        title: 'card_details',
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
        title: 'share_card',
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
            data:
                '{{appStrings.generated.card_management.card_management_root.details}}',
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
            title:
                '{{appStrings.generated.card_management.card_management_root.edit_card}}',
            iconAsset: 'assets/icons/ic_card_edit.svg',
            onTap: StacSequenceAction(
              actions: [
                const StacCloseDialogAction(),
                NavigationAction(
                  fileName: 'card_management_edit',
                  navMode: NavModes.dart,
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
          ),
          StacCustomVisibility(
            visible: '[[cardsManagement.sheet.showDelete]]',
            child: StacColumn(
              children: [
                StacSizedBox(height: 16),
                _cardDetailActionItem(
                  title:
                      '{{appStrings.generated.card_management.card_management_root.delete_card}}',
                  iconAsset: 'assets/icons/ic_card_delete.svg',
                  onTap: StacShowDialogAction(
                    title:
                        '{{appStrings.generated.card_management.card_management_root.delete_card}}',
                    description:
                        '{{appStrings.generated.card_management.card_management_root.delete_card_message}}',
                    positiveText: '{{appStrings.common.confirm}}',
                    negativeText: '{{appStrings.common.cancel}}',
                    positiveAction: StacSequenceAction(
                      actions: [
                        const StacCloseDialogAction(),
                        NavigationAction(
                          fileName: 'card_management_root',
                          navMode: NavModes.dart,
                          navigationStyle: NavigationStyle.pushAndRemoveAll,
                        ),
                        StacCustomSnackBarAction(
                          title:
                              '{{appStrings.generated.card_management.card_management_root.delete_card_text}}',
                          detail:
                              '{{appStrings.generated.card_management.card_management_root.successfully_delete_card_list}}',
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
            data:
                '{{appStrings.generated.card_management.card_management_root.share}}',
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
            title: '{{appStrings.profile.real.destinations.cardNumberLabel}}',
            valueKey: 'cardsManagement.share.cardNumber',
            iconAsset: 'assets/icons/ic_share_card.svg',
          ),
          StacCustomVisibility(
            visible: '[[cardsManagement.share.showDeposit]]',
            child: StacColumn(
              children: [
                StacSizedBox(height: 16),
                _shareInfoItem(
                  title:
                      '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.select_card}}',
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
              onTap: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'cardsManagement.reissue.postalInquiryEnabled',
                    value: false,
                  ),
                  StacCustomSetValueAction(
                    key: 'cardsManagement.reissue.postalCode',
                    value: '',
                  ),
                  StacShowBottomSheetAction(
                    title: 'card_reissue',
                    backgroundColor: '#00000000',
                    sheet: _reissuePostalCodeBottomSheet().toJson(),
                  ),
                ],
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
      autovalidateMode: StacAutovalidateMode.always,
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.topup_wallet_money}}',
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
                    '{{appStrings.generated.card_management.card_management_root.amount_wallet_money_not_services}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.amount_topup}}',
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
              thousandsSeparator:
                  '{{appStrings.common.persianThousandsSeparator}}',
              onChanged: StacCustomSetValueAction(
                values: [
                  {
                    'key': 'cardsManagement.wallet.chargeAmount',
                    'value': const StacGetFormValueAction(
                      id: 'wallet_charge_amount',
                    ),
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
                'hintText':
                    '{{appStrings.generated.card_management.card_management_root.amount_rial_topup_enter_message}}',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
                },
                'helperText':
                    '{{appStrings.generated.card_management.card_management_root.balance_amount_rial_topup}}',
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
                      '{{appStrings.generated.card_management.card_management_root.rial_message}}',
                      rawValue: '50000',
                      fieldValue:
                          '{{appStrings.generated.card_management.cards_management.amount_value_label}}',
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
                      '{{appStrings.generated.card_management.card_management_root.rial_label}}',
                      rawValue: '200000',
                      fieldValue:
                          '{{appStrings.generated.card_management.cards_management.amount_value_message}}',
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
                      '{{appStrings.generated.card_management.card_management_root.rial_description}}',
                      rawValue: '500000',
                      fieldValue:
                          '{{appStrings.generated.card_management.cards_management.amount_value_item}}',
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
                      '{{appStrings.generated.card_management.card_management_root.rial_hint}}',
                      rawValue: '1000000',
                      fieldValue:
                          '{{appStrings.generated.card_management.cards_management.amount_value_alt}}',
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
          title: 'wallet_payment_method',
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
      data: '{{appStrings.common.continue}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _walletChargeDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title:
          '{{appStrings.generated.card_management.card_management_root.select_amount_topup}}',
      detail:
          '{{appStrings.generated.card_management.card_management_root.select_amount_topup_enter_message}}',
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
      data: '{{appStrings.common.continue}}',
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
          visible: '[[$selectedKey]]',
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
            data:
                '{{appStrings.generated.card_management.card_management_root.top_up_balance_wallet_money}}',
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
            title: '{{appStrings.promissory.payableAmount}}',
            valueKey: 'cardsManagement.wallet.chargeAmount',
            suffix: '{{appStrings.common.rial}}',
          ),
          StacSizedBox(height: 28),
          StacText(
            data: '{{appStrings.promissory.paymentMethod}}',
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
                      data:
                          '{{appStrings.generated.card_management.card_management_root.bank}}',
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
              title:
                  '{{appStrings.generated.card_management.card_management_root.top_up_balance_confirm}}',
              description:
                  '{{appStrings.generated.card_management.card_management_root.top_up_balance_wallet_money_message}}',
              positiveText: '{{appStrings.common.confirm}}',
              negativeText: '{{appStrings.common.cancel}}',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  StacCustomSnackBarAction(
                    title:
                        '{{appStrings.generated.card_management.card_management_root.top_up_balance_successfully_submit}}',
                    detail:
                        '{{appStrings.generated.card_management.card_management_root.balance_wallet_money_mock}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.payment}}',
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
      autovalidateMode: StacAutovalidateMode.always,
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.money_transfer_wallet_money}}',
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
              data: '{{appStrings.authentication.mobileNumberLabel}}',
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
                    supportTextDirection: 'rtl',
                    autovalidateMode: 'always',
                    keyboardType: 'phone',
                    maxLength: 11,
                    inputFormatters: const [
                      {'type': 'allow', 'rule': '[0-9]'},
                    ],
                    validatorRules: const [
                      {
                        'rule': 'matches',
                        'options': {'pattern': r'^09\d{9}$'},
                        'message':
                            '{{appStrings.generated.card_management.card_management_root.mobile_number_not}}',
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
                      'hintText':
                          '{{appStrings.generated.card_management.card_management_root.mobile_number_enter_message}}',
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
                    permissionDeniedMessage:
                        '{{appStrings.generated.card_management.card_management_root.not}}',
                    invalidMobileMessage:
                        '{{appStrings.generated.card_management.card_management_root.mobile_number}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.amount_transfer}}',
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
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              formatThousands: true,
              thousandsSeparator:
                  '{{appStrings.common.persianThousandsSeparator}}',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'^\d{5,}$'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_root.amount_rial_transfer}}',
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
                'hintText':
                    '{{appStrings.generated.card_management.card_management_root.amount_rial_enter_message}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.description}}',
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
                'hintText':
                    '{{appStrings.generated.card_management.card_management_root.money_transfer_description_enter_message}}',
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
                    title: 'wallet_transfer_confirm',
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
                data: '{{appStrings.common.continue}}',
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
                data:
                    '{{appStrings.generated.card_management.card_management_root.amount_transfer}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.hint}}',
                ),
              ),
              StacFlexible(
                child: StacText(
                  data:
                      '{{appStrings.generated.card_management.card_management_root.rial}}',
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
                  label:
                      '{{appStrings.generated.card_management.card_management_root.wallet_money}}',
                  value: _walletTransferMockDestinationWallet,
                ),
                StacSizedBox(height: 12),
                _summaryRowFromRegistry(
                  label: '{{appStrings.promissory.descriptionLabel}}',
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
              title:
                  '{{appStrings.generated.card_management.card_management_root.payment_money}}',
              description:
                  '{{appStrings.generated.card_management.card_management_root.irreversible_payment_warning}}',
              positiveText: '{{appStrings.common.confirm}}',
              negativeText: '{{appStrings.common.cancel}}',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  const StacCloseDialogAction(),
                  NavigationAction(
                    fileName: 'card_management_wallet_receipt',
                    navMode: NavModes.dart,
                    navigationStyle: NavigationStyle.push,
                  ),
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.payment}}',
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
            data:
                '{{appStrings.generated.card_management.card_management_root.select_services}}',
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
            label:
                '{{appStrings.generated.card_management.card_management_root.get_first_pin_title}}',
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
            label:
                '{{appStrings.generated.card_management.card_management_root.change_first_pin_title}}',
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
                    screenName: 'card_management_primary_pin_get',
                  ).toJson(),
                  replacement: StacCustomVisibility(
                    visible: '[[cardsManagement.pin.primaryEventIsChange]]',
                    child: _pinContinueButton(
                      screenName: 'card_management_primary_pin_change',
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
  StacWidget rowContent({
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
        visible: '[[$selectedKey]]',
        child: rowContent(
          borderColor: '{{appColors.current.button.primary.backgroundColor}}',
          borderWidth: 1.5,
        ).toJson(),
        replacement: rowContent(
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
        NavigationAction(
          fileName: screenName,
          navMode: NavModes.dart,
          navigationStyle: NavigationStyle.push,
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
      data: '{{appStrings.common.continue}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _pinDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title:
          '{{appStrings.generated.card_management.card_management_root.select}}',
      detail:
          '{{appStrings.generated.card_management.card_management_root.select_message}}',
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
      data: '{{appStrings.common.continue}}',
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
            data:
                '{{appStrings.generated.card_management.card_management_root.select_services}}',
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
            label:
                '{{appStrings.generated.card_management.card_management_root.get_second_pin_title}}',
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
            label:
                '{{appStrings.generated.card_management.card_management_root.change_second_pin_title}}',
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
                    screenName: 'card_management_secondary_pin_get',
                  ).toJson(),
                  replacement: StacCustomVisibility(
                    visible: '[[cardsManagement.pin.secondaryEventIsChange]]',
                    child: _secContinueButton(
                      screenName: 'card_management_secondary_pin_change',
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
  StacWidget rowContent({
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
        visible: '[[$selectedKey]]',
        child: rowContent(
          borderColor: '{{appColors.current.button.primary.backgroundColor}}',
          borderWidth: 1.5,
        ).toJson(),
        replacement: rowContent(
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
        NavigationAction(
          fileName: screenName,
          navMode: NavModes.dart,
          navigationStyle: NavigationStyle.push,
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
      data: '{{appStrings.common.continue}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
    ),
  );
}

StacWidget _secDisabledButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title:
          '{{appStrings.generated.card_management.card_management_root.select}}',
      detail:
          '{{appStrings.generated.card_management.card_management_root.select_message}}',
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
      data: '{{appStrings.common.continue}}',
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
              data:
                  '{{appStrings.generated.card_management.card_management_root.card_reissue_request}}',
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
              text:
                  '{{appStrings.generated.card_management.card_management_root.card_number_date_cvv2_card}}',
            ),
            StacSizedBox(height: 8),
            _infoBullet(
              text:
                  '{{appStrings.generated.card_management.card_management_root.card_reissue_deposit_fee_card_description}}',
            ),
            StacSizedBox(height: 8),
            _infoBullet(
              text:
                  '{{appStrings.generated.card_management.card_management_root.card_reissue_rial_fee}}',
            ),
            StacSizedBox(height: 24),
            StacText(
              data: '{{appStrings.profile.real.bankInfo.postalCodeLabel}}',
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
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              maxLength: 10,
              inputFormatters: const [
                {'type': 'allow', 'rule': '[0-9۰-۹]'},
              ],
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'^[0-9۰-۹]{10}$'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_root.postal_code_message}}',
                },
              ],
              onChanged: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    key: 'cardsManagement.reissue.postalCode',
                    value: '[[reissue_postal_code]]',
                  ),
                  const StacValidateFieldsAction(
                    resultKey: 'cardsManagement.reissue.postalInquiryEnabled',
                    fields: [
                      {'id': 'reissue_postal_code', 'rule': r'^[0-9۰-۹]{10}$'},
                    ],
                  ),
                ],
              ),
              decoration: {
                'hintText':
                    '{{appStrings.profile.real.bankInfo.postalCodeHint}}',
                'hintStyle': {
                  'textDirection': 'rtl',
                  'style': {
                    'color': '{{appColors.current.text.hint}}',
                    'fontSize': 14,
                  },
                },
                'counterText': '',
                'suffixIcon': {
                  'type': 'icon',
                  'icon': 'close',
                  'size': 20,
                  'color': '{{appColors.current.text.title}}',
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
              enabledKey: 'cardsManagement.reissue.postalInquiryEnabled',
              onPressed: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  NavigationAction(
                    fileName: 'card_management_reissue_request',
                    navMode: NavModes.dart,
                    navigationStyle: NavigationStyle.push,
                  ),
                ],
              ),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                elevation: 0,
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              disabledStyle: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor:
                    '{{appColors.current.background.surfaceContainerHigh}}',
                foregroundColor: '{{appColors.current.text.hint}}',
                elevation: 0,
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              child: StacText(
                data: '{{appStrings.profile.real.bankInfo.inquiryButtonText}}',
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
            data: '{{appStrings.cardsManagement.block.description}}',
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
          StacCustomRegistryReactive(
            registryKey: 'cardsManagement.block.isReasonSelected',
            child: StacCustomVisibility(
              visible: '[[cardsManagement.block.isReasonSelected]]',
              child: _blockSubmitButton().toJson(),
              replacement: _blockDisabledSubmitButton().toJson(),
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _blockReasonRow({required String label, required String reasonId}) {
  StacWidget rowContainer({required bool selected}) {
    return StacContainer(
      padding: StacEdgeInsets.all(14),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color: selected
              ? '{{appColors.current.state.error}}'
              : '{{appColors.current.input.borderEnabled}}',
          width: selected ? 1.5 : 1,
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
          if (selected)
            StacContainer(
              width: 20,
              height: 20,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.state.error}}',
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
            )
          else
            StacContainer(
              width: 20,
              height: 20,
              decoration: StacBoxDecoration(
                borderRadius: StacBorderRadius.all(10),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }

  return StacGestureDetector(
    onTap: StacCustomSetValueAction(
      values: [
        {'key': 'cardsManagement.block.selectedReasonId', 'value': reasonId},
        {'key': 'cardsManagement.block.isReasonSelected', 'value': true},
      ],
    ),
    child: StacCustomRegistryReactive(
      registryKey: 'cardsManagement.block.selectedReasonId',
      child: StacCustomVisibility(
        visible: '[[cardsManagement.block.selectedReasonId]] == "$reasonId"',
        child: rowContainer(selected: true).toJson(),
        replacement: rowContainer(selected: false).toJson(),
      ).toJson(),
    ),
  );
}

StacWidget _blockSubmitButton() {
  return StacFilledButton(
    onPressed: StacShowDialogAction(
      dialogActionType: 'showLogoutConfirmDialog',
      warningIconAsset: 'assets/icons/ic_warning_red.svg',
      title: '{{appStrings.cardsManagement.block.confirmTitle}}',
      description: '{{appStrings.cardsManagement.block.confirmDescription}}',
      positiveText: '{{appStrings.common.confirm}}',
      negativeText: '{{appStrings.common.cancel}}',
      positiveAction: StacSequenceAction(
        actions: [
          const StacCloseDialogAction(),
          NavigationAction(
            fileName: 'card_management_root',
            navMode: NavModes.dart,
            navigationStyle: NavigationStyle.pushAndRemoveAll,
          ),
          StacCustomSnackBarAction(
            title: '{{appStrings.cardsManagement.block.successTitle}}',
            detail: '{{appStrings.cardsManagement.block.successDetail}}',
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
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
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
  );
}

StacWidget _blockDisabledSubmitButton() {
  return StacFilledButton(
    onPressed: const StacCustomSnackBarAction(
      title:
          '{{appStrings.generated.card_management.card_management_root.select_text}}',
      detail:
          '{{appStrings.generated.card_management.card_management_root.select_card_message}}',
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
      data: '{{appStrings.cardsManagement.block.title}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 14,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.text.hint}}',
      ),
    ),
  );
}

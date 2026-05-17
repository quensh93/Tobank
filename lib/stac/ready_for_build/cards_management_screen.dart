import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/widgets/profile_real_app_bar.dart';

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

@StacScreen(screenName: 'dashboard_real_cards_management')
StacWidget dashboardRealCardsManagement() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'مدیریت کارت‌ها'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacTobankCardManagementSlider(
            height: 184,
            initialPage: 0,
            indicatorTopSpacing: 16,
            indicatorActiveColor: '#E31A2F',
            indicatorInactiveColor: '#F2F4F7',
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
                title: 'گردشگری - شعبه مجازی',
                expDate: '۰۶/۰۹',
                amount: '۱۲,۴۵۰,۰۰۰',
                depositNumber: '0107500462808',
                amountVisibleKey: 'cardsManagement.tobankCard.0.amountVisible',
                showRefresh: true,
              ).toJson(),
              _buildThirdPartyCard(
                bankName: 'بانک سامان',
                cardNumber: '۶۲۱۹ ۸۶۱۰ ۵۵۵۴ ۱۴۲۸',
                owner: 'test',
                expDate: '۰۵/۰۷',
              ).toJson(),
              _buildTobankCard(
                cardNumber: '۵۰۵۴ ۱۶۱۷ ۰۵۰۳ ۰۶۰۳',
                title: 'گردشگری - سپرده دوم',
                expDate: '۰۷/۱۰',
                amount: '۸,۳۲۰,۰۰۰',
                depositNumber: '0107500462816',
                amountVisibleKey: 'cardsManagement.tobankCard.1.amountVisible',
              ).toJson(),
              _buildThirdPartyCard(
                bankName: 'بانک ملت',
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
            src: '{{appAssets.current.icons.tobankLogo}}',
            imageType: StacImageType.asset,
            width: 38,
            height: 38,
          ),
        ),
        StacPositioned(
          top: 18,
          left: 16,
          child: StacText(
            data: 'کیف پول توبانک',
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
                  src: '{{appAssets.current.icons.gardeshgari}}',
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
                      src: '{{appAssets.current.icons.refresh}}',
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
                  ),
                  child: StacImage(
                    src: 'assets/icons/ic_menu.svg',
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
                    src: 'assets/icons/ic_share.svg',
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
                  ),
                  child: StacImage(
                    src: 'assets/icons/ic_menu.svg',
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
                    src: 'assets/icons/ic_share.svg',
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
          data: 'مسدود شده',
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
              src: '{{appAssets.current.icons.block}}',
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
          title: _serviceTopUpTitle,
          iconRegistryKey: 'appAssets.current.icons.cardService',
          onTap: const StacShowResultAction(
            title: _serviceTopUpTitle,
            content: _servicePlaceholderContent,
          ),
        ),
      ),
      StacSizedBox(width: 12),
      StacExpanded(
        child: _serviceTile(
          title: _serviceTransferTitle,
          iconRegistryKey: 'appAssets.current.icons.cardService',
          onTap: const StacShowResultAction(
            title: _serviceTransferTitle,
            content: _servicePlaceholderContent,
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
          onTap: const StacShowResultAction(
            title: _serviceBalanceTitle,
            content: _servicePlaceholderContent,
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
              title: _serviceFirstPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              onTap: const StacShowResultAction(
                title: _serviceFirstPinTitle,
                content: _servicePlaceholderContent,
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceSecondPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              onTap: const StacShowResultAction(
                title: _serviceSecondPinTitle,
                content: _servicePlaceholderContent,
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
              title: _serviceReissueTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceReissue',
              onTap: const StacShowResultAction(
                title: _serviceReissueTitle,
                content: _servicePlaceholderContent,
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceBlockTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceBlock',
              onTap: const StacShowResultAction(
                title: _serviceBlockTitle,
                content: _servicePlaceholderContent,
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
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'cardsManagement.sheet.showDelete', 'value': showDelete},
          {'key': 'cardsManagement.sheet.isDefault', 'value': isDefault},
          {'key': 'cardsManagement.sheet.title', 'value': title},
          {'key': 'cardsManagement.sheet.cardNumber', 'value': cardNumber},
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
            onTap: const StacCloseDialogAction(
              result: {
                'actionType': 'showResult',
                'title': 'ویرایش کارت',
                'content': 'این بخش به زودی فعال می‌شود.',
              },
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
                  onTap: const StacCloseDialogAction(
                    result: {
                      'actionType': 'showResult',
                      'title': 'حذف کارت',
                      'content': 'این بخش به زودی فعال می‌شود.',
                    },
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
                src: 'assets/icons/ic_share.svg',
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
              title: _serviceFirstPinTitle,
              iconRegistryKey:
                  'appAssets.current.icons.cardServicePasswordChange',
              enabled: false,
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceSecondPinTitle,
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
              title: _serviceReissueTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceReissue',
              onTap: const StacShowResultAction(
                title: _serviceReissueTitle,
                content: _servicePlaceholderContent,
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: _serviceTile(
              title: _serviceBlockTitle,
              iconRegistryKey: 'appAssets.current.icons.cardServiceBlock',
              enabled: false,
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
    if (color != null) 'color': color,
  });
}

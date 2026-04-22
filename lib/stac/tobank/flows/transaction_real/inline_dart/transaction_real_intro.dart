import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transaction_real_intro')
StacWidget transactionRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'trIntroIsTobankTab', 'value': false},
        {'key': 'trIntroChipAllSelected', 'value': true},
        {'key': 'trIntroChipWalletSelected', 'value': false},
        {'key': 'trIntroShowSuccessTx', 'value': true},
        {'key': 'trIntroShowFailedTx', 'value': true},
        {'key': 'trFilterDirectionReceive', 'value': false},
        {'key': 'trFilterDirectionSend', 'value': false},
        {'key': 'trFilterWalletTypeSelected', 'value': false},
        {'key': 'trFilterTypeGiftCard', 'value': false},
        {'key': 'trFilterTypeTransferWallet', 'value': false},
        {'key': 'trFilterTypeCardToCard', 'value': false},
        {'key': 'trFilterTypeBuyInternet', 'value': false},
        {'key': 'trFilterTypeBuyRecharge', 'value': false},
        {'key': 'trFilterTypeCharity', 'value': false},
        {'key': 'trFilterTypeWalletCharge', 'value': false},
        {'key': 'trFilterTypeBillPayment', 'value': false},
        {'key': 'trFilterTypeGroupBill', 'value': false},
        {'key': 'trFilterTypeRefund', 'value': false},
        {'key': 'trFilterTypeSafeBox', 'value': false},
        {'key': 'trFilterStatusSuccessSelected', 'value': false},
        {'key': 'trFilterStatusFailedSelected', 'value': false},
        {'key': 'trFilterStatusNoLimit', 'value': true},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 65),
          _buildTopTabs(),

          StacExpanded(
            child: StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 14),
              child: StacCustomVisibility(
                visible: '[[trIntroIsTobankTab]]',
                child: _buildToBankContent().toJson(),
                replacement: _buildDepositsContent().toJson(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 20 , vertical: 10),

    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.circular(12)
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: _buildTopTabItem(
            title: 'ØªÙˆØ¨Ø§Ù†Ú©',
            selectedVisible: '[[trIntroIsTobankTab]]',
            onTap: const StacCustomSetValueAction(
              key: 'trIntroIsTobankTab',
              value: true,
            ),
          ),
        ),
        StacContainer(
          width: 1,
          height: 25,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacExpanded(
          child: _buildTopTabItem(
            title: 'Ø³Ù¾Ø±Ø¯Ù‡â€ŒÙ‡Ø§',
            selectedVisible: '[[!trIntroIsTobankTab]]',
            onTap: const StacCustomSetValueAction(
              key: 'trIntroIsTobankTab',
              value: false,
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildTopTabItem({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      width: 999999,
      height: 54,
      color: 'transparent',
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        children: [
          StacCustomVisibility(
            visible: selectedVisible,
            child: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w800,
                color: '{{appColors.current.text.title}}',
              ),
            ).toJson(),
            replacement: StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.hint}}',
              ),
            ).toJson(),
          ),
          StacSizedBox(height: 8),
          StacCustomVisibility(
            visible: selectedVisible,
            child: StacContainer(
              width: 56,
              height: 3,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.primary.color}}',
                borderRadius: StacBorderRadius.all(3),
              ),
            ).toJson(),
            replacement: StacContainer(
              width: 56,
              height: 3,
              color: 'transparent',
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildToBankContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 14),
        _buildToBankHeaderFilters(),
        StacSizedBox(height: 16),
        StacCustomVisibility(
          visible: '[[trIntroChipAllSelected]]',
          child: StacColumn(
            children: [
              StacCustomVisibility(
                visible: '[[trIntroShowSuccessTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount: 'Û±,Û°Û°Û¶,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ø§Ù‚Ø³Ø§Ø·',
                      subtitle: 'Û°Û± ÙØ±ÙˆØ±Ø¯ÛŒÙ† Û±Û´Û°Ûµ - Û±Û±:Û´Û³',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û³Û¸,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø³Ø±ÙˆÛŒØ³ Ú©Ø§Ø±Ù…Ø²Ø¯ Ø³ÙØªÙ‡',
                      subtitle: 'Û°Û² Ø§Ø³ÙÙ†Ø¯ Û±Û´Û°Û´ - Û±Ûµ:Û²Û·',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª',
                      subtitle: 'Û°Û¶ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û±:Û°Û²',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
              StacCustomVisibility(
                visible: '[[trIntroShowFailedTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount: 'Û³Û±Û³,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø³Ø±ÙˆÛŒØ³ Ú©Ø§Ø±Ù…Ø²Ø¯ Ø³ÙØªÙ‡',
                      subtitle: 'ÛµÛ¸ Ø¨Ù‡Ù…Ù† Û±Û´Û°Û´ - Û±Û°:Û°Ûµ',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'ÛµÛ°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„ ØªÙˆØ¨Ø§Ù†Ú©',
                      subtitle: 'ÛµÛ¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û´:Û°Û³',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª',
                      subtitle: 'Û°Û¶ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Ûµ:Û°Û¸',
                      isSuccess: false,
                    ),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacCustomVisibility(
          visible: '[[trIntroChipWalletSelected]]',
          child: StacColumn(
            children: [
              StacCustomVisibility(
                visible: '[[trIntroShowSuccessTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount: 'Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'ØªØ±Ø§Ú©Ù†Ø´ Ú©ÛŒÙ Ù¾ÙˆÙ„',
                      subtitle: 'Û°Û³ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û³:Û³Û°',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û¸,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø³Ø±ÙˆÛŒØ³ Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ',
                      subtitle: 'Û°Û± Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û²:Û°Û±',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û¸Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø³Ø±ÙˆÛŒØ³ Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ',
                      subtitle: 'Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:Û±Û¶',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û±,Û³Û¶Û¸,ÛµÛ°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø³ÙØ§Ø±Ø´ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡',
                      subtitle: 'Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:ÛµÛ°',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û±,Û´Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'ØªØ±Ø§Ú©Ù†Ø´ Ú©ÛŒÙ Ù¾ÙˆÙ„',
                      subtitle: 'Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:Û´Û°',
                      isSuccess: true,
                    ),
                    StacSizedBox(height: 10),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
              StacCustomVisibility(
                visible: '[[trIntroShowFailedTx]]',
                child: StacColumn(
                  children: [
                    _buildTransactionCard(
                      amount: 'ÛµÛ°,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„ ØªÙˆØ¨Ø§Ù†Ú©',
                      subtitle: 'Û°Û¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û´:Û°Û³',
                      isSuccess: false,
                    ),
                    StacSizedBox(height: 10),
                    _buildTransactionCard(
                      amount: 'Û²Ûµ,Û°Û°Û° Ø±ÛŒØ§Ù„',
                      title: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ú©ÛŒÙ Ù¾ÙˆÙ„',
                      subtitle: 'Û°Û¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û°:Û±Û¶',
                      isSuccess: false,
                    ),
                  ],
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacSizedBox(height: 10),
      ],
    ),
  );
}

StacWidget _buildToBankHeaderFilters() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacGestureDetector(
        onTap: const StacNavigateAction(
          routeName: 'transaction_real_filter',
          navigationStyle: NavigationStyle.push,
        ),

        child: StacContainer(
          height: 36,
          padding: StacEdgeInsets.symmetric(horizontal: 12),
          decoration: StacBoxDecoration(
            color: 'transparent',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            mainAxisAlignment: StacMainAxisAlignment.center,
            textDirection: StacTextDirection.rtl,
            children: [
              StacIcon(
                icon: 'tune',
                size: 16,
                color: '{{appColors.current.text.subtitle}}',
              ),
              StacSizedBox(width: 6),
              StacText(
                data: 'ÙÛŒÙ„ØªØ±Ù‡Ø§',
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(width: 6),
      StacContainer(
        width: 1,
        height: 25,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      StacSizedBox(width: 6),
      _buildToggleChip(
        title: 'Ù‡Ù…Ù‡',
        selectedVisible: '[[trIntroChipAllSelected]]',
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'trIntroChipAllSelected', 'value': true},
            {'key': 'trIntroChipWalletSelected', 'value': false},
            {'key': 'trIntroShowSuccessTx', 'value': true},
            {'key': 'trIntroShowFailedTx', 'value': true},
          ],
        ),
      ),
      StacSizedBox(width: 8),
      _buildToggleChip(
        title: 'ØªØ±Ø§Ú©Ù†Ø´ Ù‡Ø§ÛŒ Ú©ÛŒÙ Ù¾ÙˆÙ„',
        selectedVisible: '[[trIntroChipWalletSelected]]',
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'trIntroChipAllSelected', 'value': false},
            {'key': 'trIntroChipWalletSelected', 'value': true},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildToggleChip({
  required String title,
  required String selectedVisible,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.secondary.secondaryContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.secondary.color}}',
            width: 1,
          ),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.secondary.color}}',
            ),
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        decoration: StacBoxDecoration(
          color: 'transparent',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildDepositsContent() {
  return StacSingleChildScrollView(
    child: StacColumn(
      children: [
        StacSizedBox(height: 14),
        _buildTransactionCard(
          amount: 'Û²Û¹Û¹,Û¹Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ù„',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: 'ÛµÛ°Û°,Û°Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ù„',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: 'ÛµÛ°Û°,Û°Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ù„',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: 'Û±Û°,ÛµÛ°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ù„',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: 'ÛµÛ´Û³,Û¸Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ø§ÛŒØ§',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: true,
        ),
        StacSizedBox(height: 10),
        _buildTransactionCard(
          amount: 'ÛµÛ´Û³,Û¹Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„',
          title: 'Ù¾Ø§ÛŒØ§',
          subtitle: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±',
          isSuccess: false,
        ),
        StacSizedBox(height: 10),
      ],
    ),
  );
}

StacWidget _buildTransactionCard({
  required String amount,
  required String title,
  required String subtitle,
  required bool isSuccess,
}) {
  return StacContainer(
    padding: StacEdgeInsets.only(top: 14, bottom: 14, right: 14, left: 14),
    decoration: StacBoxDecoration(
      color: 'transparent',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacSizedBox(
          width: 28,
          height: 28,
          child: StacImage(
            src: isSuccess
                ? '{{appAssets.icons.transactionItemSuccessCurrent}}'
                : '{{appAssets.icons.transactionItemFailedCurrent}}',
            imageType: StacImageType.asset,
            width: 28,
            height: 28,
          ),
        ),
        StacSizedBox(width: 12),
        StacExpanded(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
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
                  StacSizedBox(width: 12),
                  StacText(
                    data: amount,
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.left,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 8),
              StacText(
                data: subtitle,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 13,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

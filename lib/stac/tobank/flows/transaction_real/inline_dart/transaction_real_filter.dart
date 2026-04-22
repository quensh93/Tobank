import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'transaction_real_app_bar.dart';

@StacScreen(screenName: 'transaction_real_filter')
StacWidget transactionRealFilter() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTransactionRealAppBar(title: 'ÙÛŒÙ„ØªØ± ØªØ±Ø§Ú©Ù†Ø´â€ŒÙ‡Ø§'),
      body: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 6),
            StacCustomVisibility(
              visible: '[[trIntroChipWalletSelected]]',
              child: StacColumn(
                children: [
                  _buildDirectionRow(),
                  StacSizedBox(height: 18),
                ],
              ).toJson(),
              replacement: StacSizedBox(height: 2).toJson(),
            ),
            _sectionTitle('Ø¨Ø§Ø²Ù‡ Ø²Ù…Ø§Ù†ÛŒ'),
            StacSizedBox(height: 12),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(
                  child: _buildDateField(
                    title: 'Ø§Ø² ØªØ§Ø±ÛŒØ®',
                    fieldId: 'trFilterFromDate',
                  ),
                ),
                StacSizedBox(width: 10),
                StacExpanded(
                  child: _buildDateField(
                    title: 'ØªØ§ ØªØ§Ø±ÛŒØ®',
                    fieldId: 'trFilterToDate',
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 20),
            _sectionTitle('Ù†ÙˆØ¹ ØªØ±Ø§Ú©Ù†Ø´'),
            StacSizedBox(height: 12),
            _buildTypeChips(),
            StacSizedBox(height: 20),
            _sectionTitle('ÙˆØ¶Ø¹ÛŒØª ØªØ±Ø§Ú©Ù†Ø´'),
            StacSizedBox(height: 12),
            _buildStatusRow(),
            StacSizedBox(height: 26),
            StacFilledButton(
              onPressed: _applyAndBackAction(),
              style: StacButtonStyle(
                minimumSize: StacSize(999999, 56),
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10),
                ),
              ),
              child: StacText(
                data: 'ÙÛŒÙ„ØªØ± Ù†ØªØ§ÛŒØ¬',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
            StacSizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}

StacAction _applyAndBackAction() {
  return const StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'trIntroIsTobankTab', 'value': true},
          {
            'key': 'trIntroChipWalletSelected',
            'value': true,
            'condition': 'trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipAllSelected',
            'value': false,
            'condition': 'trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipWalletSelected',
            'value': false,
            'condition': '!trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroChipAllSelected',
            'value': true,
            'condition': '!trFilterWalletTypeSelected',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': true,
            'condition': 'trFilterStatusNoLimit',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': true,
            'condition': 'trFilterStatusNoLimit',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': true,
            'condition': 'trFilterStatusSuccessSelected',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': false,
            'condition': 'trFilterStatusSuccessSelected',
          },
          {
            'key': 'trIntroShowSuccessTx',
            'value': false,
            'condition': 'trFilterStatusFailedSelected',
          },
          {
            'key': 'trIntroShowFailedTx',
            'value': true,
            'condition': 'trFilterStatusFailedSelected',
          },
        ],
      ),
      StacNavigateAction(navigationStyle: NavigationStyle.pop),
    ],
  );
}

StacWidget _sectionTitle(String title) {
  return StacText(
    data: title,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 19,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildDirectionRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.start,
    children: [
      _buildDirectionChip(
        title: 'Ø¯Ø±ÛŒØ§ÙØª ÙˆØ¬Ù‡',
        icon: 'south',
        selectedVisible: '[[trFilterDirectionReceive]]',
        selectedColor: '{{appColors.current.success.color}}',
        onTap: const StacSequenceAction(
          actions: [
            StacCustomSetValueAction(
              key: 'trFilterDirectionReceive',
              value: '{{!trFilterDirectionReceive}}',
            ),
            StacCustomSetValueAction(
              key: 'trFilterDirectionSend',
              value: false,
            ),
          ],
        ),
      ),
      StacSizedBox(width: 8),
      _buildDirectionChip(
        title: 'Ø§Ø±Ø³Ø§Ù„ ÙˆØ¬Ù‡',
        icon: 'north',
        selectedVisible: '[[trFilterDirectionSend]]',
        selectedColor: '{{appColors.current.warning.color}}',
        onTap: const StacSequenceAction(
          actions: [
            StacCustomSetValueAction(
              key: 'trFilterDirectionSend',
              value: '{{!trFilterDirectionSend}}',
            ),
            StacCustomSetValueAction(
              key: 'trFilterDirectionReceive',
              value: false,
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildDirectionChip({
  required String title,
  required String icon,
  required String selectedVisible,
  required String selectedColor,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        width: 120,
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 8),
        decoration: StacBoxDecoration(
          color: selectedColor,
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 0.7,
          ),
        ),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(
              icon: icon,
              size: 16,
              color: '{{appColors.current.text.onPrimary}}',
            ),
            StacSizedBox(width: 6),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.onPrimary}}',
              ),
            ),
          ],
        ),
      ).toJson(),
      replacement: StacContainer(
        width: 120,
        height: 36,
        padding: StacEdgeInsets.symmetric(horizontal: 8),
        decoration: StacBoxDecoration(
          color: 'transparent',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 0.7,
          ),
        ),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacIcon(
              icon: icon,
              size: 16,
              color: '{{appColors.current.text.hint}}',
            ),
            StacSizedBox(width: 6),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildDateField({
  required String title,
  required String fieldId,
}) {
  return StacGestureDetector(
    onTap: StacPersianDatePickerAction(
      formFieldId: fieldId,
      firstDate: '1400/01/01',
      lastDate: '1450/12/29',
      includeTime: true,
    ),
    child: StacContainer(
      height: 52,
      padding: StacEdgeInsets.symmetric(horizontal: 14),
      decoration: StacBoxDecoration(
        color: 'transparent',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.ltr,
        children: [
          StacImage(
            src: '{{appAssets.icons.calendar}}',
            imageType: StacImageType.asset,
            width: 20,
            height: 20,
            color: '{{appColors.current.secondary.color}}',
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacCustomRegistryReactive(
              registryKey: 'form.$fieldId',
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ).toJson(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildTypeChips() {
  return StacColumn(
    children: [
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'Ø®Ø±ÛŒØ¯ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡',
          key: 'trFilterTypeGiftCard',
        ),
        center: _buildTypeChip(
          title: 'Ø§Ù†ØªÙ‚Ø§Ù„ Ú©ÛŒÙ Ù¾ÙˆÙ„',
          key: 'trFilterTypeTransferWallet',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeTransferWallet',
                value: '{{!trFilterTypeTransferWallet}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeTransferWallet}}',
              ),
            ],
          ),
        ),
        right: _buildTypeChip(
          title: 'Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª',
          key: 'trFilterTypeCardToCard',
        ),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'Ø®Ø±ÛŒØ¯ Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ',
          key: 'trFilterTypeBuyInternet',
        ),
        center: _buildTypeChip(
          title: 'Ø®Ø±ÛŒØ¯ Ø´Ø§Ø±Ú˜ Ù…Ø³ØªÙ‚ÛŒÙ…',
          key: 'trFilterTypeBuyRecharge',
        ),
        right: _buildTypeChip(title: 'Ù†ÛŒÚ©ÙˆÚ©Ø§Ø±ÛŒ', key: 'trFilterTypeCharity'),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„',
          key: 'trFilterTypeWalletCharge',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeWalletCharge',
                value: '{{!trFilterTypeWalletCharge}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeWalletCharge}}',
              ),
            ],
          ),
        ),
        center: _buildTypeChip(
          title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ù‚Ø¨ÙˆØ¶',
          key: 'trFilterTypeBillPayment',
        ),
        right: _buildTypeChip(
          title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ú¯Ø±ÙˆÙ‡ÛŒ Ù‚Ø¨ÙˆØ¶',
          key: 'trFilterTypeGroupBill',
        ),
      ),
      StacSizedBox(height: 8),
      _buildTypeRow(
        left: _buildTypeChip(
          title: 'Ø§Ø³ØªØ±Ø¯Ø§Ø¯ ÙˆØ¬Ù‡',
          key: 'trFilterTypeRefund',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterTypeRefund',
                value: '{{!trFilterTypeRefund}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterWalletTypeSelected',
                value: '{{trFilterTypeRefund}}',
              ),
            ],
          ),
        ),
        center: _buildTypeChip(
          title: 'ØµÙ†Ø¯ÙˆÙ‚ Ø§Ù…Ø§Ù†Ø§Øª',
          key: 'trFilterTypeSafeBox',
        ),
        right: StacSizedBox(),
      ),
    ],
  );
}

StacWidget _buildTypeRow({
  required StacWidget left,
  required StacWidget center,
  required StacWidget right,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(child: left),
      StacSizedBox(width: 8),
      StacExpanded(child: center),
      StacSizedBox(width: 8),
      StacExpanded(child: right),
    ],
  );
}

StacWidget _buildTypeChip({
  required String title,
  required String key,
  StacAction? onTap,
}) {
  return StacGestureDetector(
    onTap: onTap ?? StacCustomSetValueAction(key: key, value: '{{!$key}}'),
    child: StacCustomVisibility(
      visible: '[[$key]]',
      child: StacContainer(
        height: 44,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.secondary.color}}',
          borderRadius: StacBorderRadius.all(6),
        ),
        child: StacCenter(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.onPrimary}}',
            ),
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 44,
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
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildStatusRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(
        child: _buildStatusChip(
          title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÙˆÙÙ‚',
          iconSrc: '{{appAssets.icons.transactionItemSuccessCurrent}}',
          selectedVisible: '[[trFilterStatusSuccessSelected]]',
          selectedColor: '{{appColors.current.success.color}}',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterStatusSuccessSelected',
                value: '{{!trFilterStatusSuccessSelected}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusFailedSelected',
                value: false,
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusNoLimit',
                value: '{{!trFilterStatusSuccessSelected}}',
              ),
            ],
          ),
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: _buildStatusChip(
          title: 'Ù¾Ø±Ø¯Ø§Ø®Øª Ù†Ø§Ù…ÙˆÙÙ‚',
          iconSrc: '{{appAssets.icons.transactionItemFailedCurrent}}',
          selectedVisible: '[[trFilterStatusFailedSelected]]',
          selectedColor: '{{appColors.current.error.color}}',
          onTap: const StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'trFilterStatusFailedSelected',
                value: '{{!trFilterStatusFailedSelected}}',
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusSuccessSelected',
                value: false,
              ),
              StacCustomSetValueAction(
                key: 'trFilterStatusNoLimit',
                value: '{{!trFilterStatusFailedSelected}}',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildStatusChip({
  required String title,
  required String iconSrc,
  required String selectedVisible,
  required String selectedColor,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: selectedVisible,
      child: StacContainer(
        height: 44,
        padding: StacEdgeInsets.symmetric(horizontal: 10),
        decoration: StacBoxDecoration(
          color: selectedColor,
          borderRadius: StacBorderRadius.all(8),
        ),
        child: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.center,
          textDirection: StacTextDirection.rtl,
          children: [
            StacImage(
              src: iconSrc,
              imageType: StacImageType.asset,
              width: 18,
              height: 18,
            ),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.onPrimary}}',
              ),
            ),
          ],
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 44,
        padding: StacEdgeInsets.symmetric(horizontal: 10),
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
            StacImage(
              src: iconSrc,
              imageType: StacImageType.asset,
              width: 18,
              height: 18,
            ),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),
      ).toJson(),
    ),
  );
}

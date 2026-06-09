import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_wallet_transfer_receipt')
StacWidget dashboardWalletTransferReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: '{{appStrings.cardsManagement.wallet.receiptTitle}}', showBack: true, backOnRight: true),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 72,
              height: 72,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.state.successContainer}}',
                borderRadius: StacBorderRadius.all(36),
              ),
              child: StacCenter(
                child: StacImage(
                  src: '{{appAssets.icons.successCheck}}',
                  imageType: StacImageType.asset,
                  width: 40,
                  height: 40,
                  color: '{{appColors.current.state.success}}',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: '{{appStrings.cardsManagement.wallet.transferSuccess}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 32),
          _receiptCard(),
          StacSizedBox(height: 32),
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: _actionChip(
                  label: 'اشتراک‌گذاری',
                  iconAsset: '{{appAssets.current.icons.share}}',
                  onTap: const StacCustomSnackBarAction(
                    title: 'اشتراک‌گذاری',
                    detail: '{{appStrings.common.comingSoon}}',
                    duration: 3000,
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: _actionChip(
                  label: 'پرینت رسید',
                  iconAsset: '{{appAssets.icons.printReceipt}}',
                  onTap: const StacCustomSnackBarAction(
                    title: 'پرینت رسید',
                    detail: '{{appStrings.common.comingSoon}}',
                    duration: 3000,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

StacWidget _receiptCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(20),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.card}}',
      borderRadius: StacBorderRadius.all(16),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        _receiptRow(label: '{{appStrings.cardsManagement.wallet.from}}', value: '{{appStrings.cardsManagement.wallet.title}}'),
        StacSizedBox(height: 16),
        _receiptRowRegistry(
          label: '{{appStrings.cardsManagement.wallet.to}}',
          valueKey: 'cardsManagement.wallet.transferPhone',
        ),
        StacSizedBox(height: 16),
        _receiptRowRegistry(
          label: '{{appStrings.cardsManagement.wallet.amountLabel}}',
          valueKey: 'cardsManagement.wallet.transferAmount',
        ),
        StacSizedBox(height: 16),
        _receiptRow(label: '{{appStrings.cardsManagement.wallet.statusLabel}}', value: 'موفق'),
        StacSizedBox(height: 16),
        _receiptRow(label: '{{appStrings.cardsManagement.wallet.trackingNumber}}', value: '1234567890'),
      ],
    ),
  );
}

StacWidget _receiptRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
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

StacWidget _receiptRowRegistry({
  required String label,
  required String valueKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: '{{$valueKey}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
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

StacWidget _actionChip({
  required String label,
  required String iconAsset,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 12),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.center,
        mainAxisSize: StacMainAxisSize.min,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 20,
            height: 20,
            color: '{{appColors.current.text.title}}',
          ),
          StacSizedBox(width: 8),
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
    ),
  );
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_wallet_transfer_receipt')
StacWidget dashboardWalletTransferReceipt() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'رسید انتقال وجه', showBack: true),
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
                color: '#E8F5E9',
                borderRadius: StacBorderRadius.all(36),
              ),
              child: StacCenter(
                child: StacImage(
                  src: '{{appAssets.current.icons.successCheck}}',
                  imageType: StacImageType.asset,
                  width: 40,
                  height: 40,
                  color: '#43A047',
                ),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'انتقال وجه با موفقیت انجام شد',
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
                    title: 'اشتراک‌گذاری (mock)',
                    detail: 'این قابلیت در نسخه بعدی فعال می‌شود.',
                    duration: 3000,
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: _actionChip(
                  label: 'چاپ رسید',
                  iconAsset: '{{appAssets.current.icons.print}}',
                  onTap: const StacCustomSnackBarAction(
                    title: 'چاپ رسید (mock)',
                    detail: 'این قابلیت در نسخه بعدی فعال می‌شود.',
                    duration: 3000,
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(16),
              ),
            ),
            child: StacText(
              data: 'بازگشت به کارت‌ها',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
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
        _receiptRow(label: 'از', value: 'کیف پول توبانک'),
        StacSizedBox(height: 16),
        _receiptRowRegistry(
          label: 'به',
          valueKey: 'cardsManagement.wallet.transferPhone',
        ),
        StacSizedBox(height: 16),
        _receiptRowRegistry(
          label: 'مبلغ (ریال)',
          valueKey: 'cardsManagement.wallet.transferAmount',
        ),
        StacSizedBox(height: 16),
        _receiptRow(label: 'وضعیت', value: 'موفق'),
        StacSizedBox(height: 16),
        _receiptRow(label: 'شماره پیگیری', value: '1234567890'),
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
        data: '[[$valueKey]]',
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
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 20,
            height: 20,
            color: '{{appColors.current.text.body}}',
          ),
          StacSizedBox(width: 8),
          StacText(
            data: label,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.body}}',
            ),
          ),
        ],
      ),
    ),
  );
}

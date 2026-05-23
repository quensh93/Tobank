import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_card_balance')
StacWidget dashboardCardBalance() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'موجودی کارت', showBack: true),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.all(20),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.card}}',
              borderRadius: StacBorderRadius.all(16),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.end,
              children: [
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                  children: [
                    StacText(
                      data: '[[cardsManagement.sheet.cardNumber]]',
                      textDirection: StacTextDirection.ltr,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacImage(
                      src: '{{appAssets.current.icons.bank}}',
                      imageType: StacImageType.asset,
                      width: 36,
                      height: 36,
                    ),
                  ],
                ),
                StacSizedBox(height: 24),
                StacText(
                  data: 'موجودی',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.hint}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacRow(
                  textDirection: StacTextDirection.rtl,
                  mainAxisAlignment: StacMainAxisAlignment.end,
                  children: [
                    StacText(
                      data: 'ریال',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.text.body}}',
                      ),
                    ),
                    StacSizedBox(width: 8),
                    StacText(
                      data: '۱۲،۳۴۵،۶۷۸',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 28,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StacSizedBox(height: 24),
          StacFilledButton(
            onPressed: StacCustomSnackBarAction(
              title: 'موجودی به‌روز شد',
              detail: 'موجودی کارت با موفقیت دریافت شد. (mock)',
              duration: 2500,
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 8),
              minimumSize: const StacSize(0, 56),
              backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor: '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(8),
              ),
            ),
            child: StacText(
              data: 'تلاش مجدد',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(fontSize: 14, fontWeight: StacFontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
}

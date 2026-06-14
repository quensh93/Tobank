import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_close_result')
StacWidget depositCloseResult() {
  return StacStatefulWidget(
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: 'بستن سپرده',
        showSupport: true,
      ),
      body: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _resultCard(),
            StacExpanded(child: StacSizedBox()),
            StacFilledButton(
              onPressed: const StacNavigateAction(
                navigationStyle: NavigationStyle.pop,
              ),
              style: StacButtonStyle(
                minimumSize: const StacSize(0, 64),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              child: StacText(
                data: 'بازگشت',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _resultCard() {
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
      child: StacColumn(
        children: [
          StacImage(
            src: 'assets/icons/ic_success_new.svg',
            imageType: StacImageType.asset,
            width: 40,
            height: 40,
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'درخواست شما با موفقیت ثبت شد!',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.title}}',
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data:
                'این درخواست توسط همکاران ما بررسی می‌گردد و مراتب از طریق پیامک به شما اطلاع‌رسانی خواهد شد',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              height: 1.6,
            ),
          ),
        ],
      ),
    ),
  );
}

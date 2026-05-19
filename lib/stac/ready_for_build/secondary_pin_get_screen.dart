import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_secondary_pin_get')
StacWidget dashboardSecondaryPinGet() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'دریافت رمز دوم', showBack: true),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            padding: StacEdgeInsets.all(16),
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
                  data: 'شماره کارت',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.hint}}',
                  ),
                ),
                StacText(
                  data: '۵۰۵۴ - ۱۶۱۷ - ۰۳۰۲ - ۰۳۹۰',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
          StacExpanded(child: StacSizedBox(height: 0)),
          StacFilledButton(
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'dashboard_secondary_pin_result',
              'navigationStyle': 'push',
            }),
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
              data: 'تایید و دریافت رمز دوم',
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

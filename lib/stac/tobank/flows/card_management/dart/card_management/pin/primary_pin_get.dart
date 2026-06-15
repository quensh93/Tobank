import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'card_management_primary_pin_get')
StacWidget dashboardPrimaryPinGet() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'دریافت رمز اول', showSupport: true, showBack: true),
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
                  data: 'شماره کارت:',
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
            onPressed: NavigationAction(fileName: 'card_management_primary_pin_result', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
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
              data: 'تایید و دریافت رمز اول',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
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

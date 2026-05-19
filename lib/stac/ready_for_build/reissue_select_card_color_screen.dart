import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'dashboard_card_reissue_select_card_color')
StacWidget dashboardCardReissueSelectCardColor() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(title: 'صدور کارت المثنی', showBack: true),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacText(
            data: 'رنگ کارت خود را انتخاب کنید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 15,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          StacCenter(
            child: StacContainer(
              width: 260,
              height: 160,
              decoration: StacBoxDecoration(
                color: '#1E1E1E',
                borderRadius: StacBorderRadius.all(16),
              ),
              child: StacPadding(
                padding: StacEdgeInsets.all(16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacRow(
                      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                      children: [
                        StacText(
                          data: 'TOBANK',
                          textDirection: StacTextDirection.ltr,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w700,
                            color: '#FFFFFF',
                          ),
                        ),
                      ],
                    ),
                    StacExpanded(child: StacSizedBox(height: 0)),
                    StacText(
                      data: 'گردشگری',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 12,
                        fontWeight: StacFontWeight.w400,
                        color: '#FFFFFF',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data: 'روی کارت',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.hint}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacRow(
            mainAxisAlignment: StacMainAxisAlignment.center,
            children: [
              _colorCircle(id: 'black', hex: '#1E1E1E'),
              StacSizedBox(width: 12),
              _colorCircle(id: 'gray', hex: '#8F8F8F'),
              StacSizedBox(width: 12),
              _colorCircle(id: 'blue', hex: '#1FA3E3'),
              StacSizedBox(width: 12),
              _colorCircle(id: 'red', hex: '#E31A2F'),
              StacSizedBox(width: 12),
              _colorCircle(id: 'green', hex: '#43A047'),
            ],
          ),
          StacExpanded(child: StacSizedBox(height: 0)),
          StacFilledButton(
            onPressed: StacShowDialogAction(
              title: 'تایید انتخاب',
              description: 'آیا از انتخاب رنگ کارت المثنی اطمینان دارید؟',
              positiveText: 'تایید',
              negativeText: 'انصراف',
              positiveAction: StacSequenceAction(
                actions: [
                  const StacCloseDialogAction(),
                  StacRawJsonAction({
                    'actionType': 'navigate',
                    'widgetType': 'dashboard_card_reissue_receipt',
                    'navigationStyle': 'push',
                  }),
                ],
              ),
              negativeAction: const StacCloseDialogAction(),
            ),
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
              data: 'تایید و ادامه',
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

StacWidget _colorCircle({required String id, required String hex}) {
  return StacGestureDetector(
    onTap: StacCustomSetValueAction(
      key: 'cardsManagement.reissue.selectedTemplate',
      value: id,
    ),
    child: StacContainer(
      width: 40,
      height: 40,
      decoration: StacBoxDecoration(
        color: hex,
        borderRadius: StacBorderRadius.all(20),
      ),
    ),
  );
}

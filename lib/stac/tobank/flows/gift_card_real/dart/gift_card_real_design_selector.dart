import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_design_selector')
StacWidget giftCardRealDesignSelector() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacText(
            data: 'متن و تصویر مورد نظر خود را انتخاب کنید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 18),
          StacContainer(
            height: 260,
            padding: StacEdgeInsets.only(
              left: 10,
              right: 10,
              top: 14,
              bottom: 14,
            ),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surface}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildDashedLine(),
                StacExpanded(
                  child: StacCenter(
                    child: StacText(
                      data: 'تصویر مورد نظر شما',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.center,
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                ),
                _buildDashedLine(),
                StacSizedBox(height: 22),
                StacText(
                  data: 'متن مورد نظر شما',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 16),
                StacText(
                  data: '۵۰۵۴  ۱۶۳۰  ****  ****',
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 21,
                    fontWeight: StacFontWeight.w900,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 62),
          StacGestureDetector(
            onTap: const StacNavigateAction(
              routeName: 'gift_card_real_select_design',
              navigationStyle: NavigationStyle.push,
            ),
            child: StacColumn(
              children: [
                StacContainer(
                  width: 55,
                  height: 55,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    shape: StacBoxShape.circle,
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacCenter(
                    child: StacImage(
                      src: 'assets/icons/ic_image_text.svg',
                      imageType: StacImageType.asset,
                      width: 31,
                      height: 31,
                    ),
                  ),
                ),
                StacSizedBox(height: 16),
                StacText(
                  data: 'انتخاب متن و تصویر',
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildDashedLine() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: List.generate(
      52,
      (_) => StacContainer(
        width: 4,
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ),
  );
}

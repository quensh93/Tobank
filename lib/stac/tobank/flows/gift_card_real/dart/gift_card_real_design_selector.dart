import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_design_selector')
StacWidget giftCardRealDesignSelector() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'giftCardRealHasSelection', 'value': false},
        {'key': 'giftCardRealFinalMessage', 'value': 'متن مورد نظر شما'},
        {'key': 'giftCardRealSelectedPlanTitle', 'value': 'طرح انتخابی'},
        {'key': 'giftCardRealSelectedPlanPrimaryColor', 'value': '#BEE56C'},
        {'key': 'giftCardRealSelectedPlanSecondaryColor', 'value': '#87CE77'},
        {'key': 'giftCardRealSelectedPlanAccentColor', 'value': '#43AB9D'},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.only(left: 16, right: 16, top: 26),
              child: StacCustomRegistryReactive(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacCustomVisibility(
                      visible: '[[giftCardRealHasSelection]]',
                      child: StacText(
                        data: 'متن و تصویر انتخابی خود را بررسی و تایید نمایید',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ).toJson(),
                    ),
                    StacCustomVisibility(
                      visible: '[[!giftCardRealHasSelection]]',
                      child: StacText(
                        data: 'متن و تصویر مورد نظر خود را انتخاب کنید',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ).toJson(),
                    ),
                    StacSizedBox(height: 16),
                    StacContainer(
                      decoration: StacBoxDecoration(
                        color: '{{appColors.current.background.surface}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color: '{{appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacCustomVisibility(
                        visible: '[[giftCardRealHasSelection]]',
                        replacement: _buildEmptyPreviewCard().toJson(),
                        child: _buildSelectedPreviewCard().toJson(),
                      ),
                    ),
                    StacSizedBox(height: 42),
                    StacGestureDetector(
                      onTap: const StacNavigateAction(
                        routeName: 'gift_card_real_select_design',
                        navigationStyle: NavigationStyle.push,
                      ),
                      child: StacColumn(
                        children: [
                          StacContainer(
                            width: 82,
                            height: 82,
                            decoration: StacBoxDecoration(
                              color: '{{appColors.current.background.surface}}',
                              shape: StacBoxShape.circle,
                              border: StacBorder.all(
                                color:
                                    '{{appColors.current.input.borderEnabled}}',
                                width: 1,
                              ),
                            ),
                            child: StacCenter(
                              child: StacImage(
                                src: 'assets/icons/ic_image_text.svg',
                                imageType: StacImageType.asset,
                                width: 37,
                                height: 37,
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
                    StacSizedBox(height: 24),
                  ],
                ).toJson(),
              ),
            ),
          ),
          StacCustomRegistryReactive(
            child: StacCustomVisibility(
              visible: '[[giftCardRealHasSelection]]',
              child: StacPadding(
                padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: StacFilledButton(
                  onPressed: const StacNavigateAction(
                    routeName: 'gift_card_real_receiver_info',
                    navigationStyle: NavigationStyle.push,
                  ),
                  style: StacButtonStyle(
                    fixedSize: StacSize(999999, 62),
                    backgroundColor: '{{appColors.current.primary.color}}',
                    foregroundColor: '{{appColors.current.primary.onPrimary}}',
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(14),
                    ),
                    elevation: 0,
                  ),
                  child: StacText(
                    data: 'تایید و ذخیره',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ),
                ),
              ).toJson(),
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildSelectedPreviewCard() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacContainer(
        height: 208,
        clipBehavior: StacClip.hardEdge,
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.only(
            topLeft: 12,
            topRight: 12,
            bottomLeft: 0,
            bottomRight: 0,
          ),
          color: '{{appColors.current.background.surfaceContainer}}',
        ),
        child: StacStack(
          children: [
            StacPositioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: StacImage(
                src: '{{giftCardRealSelectedPlanImageUrl}}',
                imageType: StacImageType.network,
                fit: StacBoxFit.cover,
              ),
            ),
            StacPositioned(
              top: 0,
              right: 0,
              left: 0,
              child: StacContainer(
                height: 54,
                padding: StacEdgeInsets.symmetric(horizontal: 12),
                color: '#F7FAFD',
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                  crossAxisAlignment: StacCrossAxisAlignment.center,
                  children: [
                    StacImage(
                      src: 'assets/icons/shetab.svg',
                      imageType: StacImageType.asset,
                      width: 112,
                      height: 30,
                      fit: StacBoxFit.contain,
                    ),
                    StacImage(
                      src: 'assets/icons/gardeshgary.svg',
                      imageType: StacImageType.asset,
                      width: 110,
                      height: 26,
                      fit: StacBoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      StacSizedBox(height: 20),
      StacText(
        data: '{{giftCardRealFinalMessage}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 17,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 18),
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
      StacSizedBox(height: 22),
    ],
  );
}

StacWidget _buildEmptyPreviewCard() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacSizedBox(height: 16),
      _buildDashedLine(),
      StacSizedBox(
        height: 96,
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
      StacSizedBox(height: 18),
    ],
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

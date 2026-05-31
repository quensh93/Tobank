import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'gift_card_design_selector')
StacWidget giftCardRealDesignSelector() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(values: []),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'کارت هدیه',
      ),
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
                        routeName: 'gift_card_select_design',
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
                    routeName: 'gift_card_receiver_info',
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
      StacContainer(
        decoration: StacBoxDecoration(
          color: '#F7FAFD',
          borderRadius: StacBorderRadius.only(
            topLeft: 0,
            topRight: 0,
            bottomLeft: 11,
            bottomRight: 11,
          ),
        ),
        child: StacColumn(
          mainAxisAlignment: StacMainAxisAlignment.center,
          children: [
            StacSizedBox(height: 12),
            StacText(
              data: '{{giftCardRealFinalMessage}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 12),
            StacText(
              data: '۵۰۵۴  ۱۶۳۰  ****  ****',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 19,
                fontWeight: StacFontWeight.w900,
                color: '#000000',
              ),
            ),
          ],
        ),
      ),
      StacSizedBox(height: 8),
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


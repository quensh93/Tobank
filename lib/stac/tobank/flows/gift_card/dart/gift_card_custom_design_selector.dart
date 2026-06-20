import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'gift_card_custom_design_selector')
StacWidget giftCardRealCustomDesignSelector() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(values: []),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.homePage.services.giftCard}}',
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
                      visible: '[[giftCardRealCustomHasSelection]]',
                      child: StacText(
                        data:
                            '{{appStrings.generated.gift_card.gift_card_custom_design_selector.select_confirm_image_text}}',
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
                      visible: '[[!giftCardRealCustomHasSelection]]',
                      child: StacText(
                        data:
                            '{{appStrings.generated.gift_card.gift_card_custom_design_selector.select_image_text}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ).toJson(),
                    ),
                    StacSizedBox(height: 20),
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
                        visible: '[[giftCardRealCustomHasSelection]]',
                        replacement: _buildEmptyPreviewCard().toJson(),
                        child: _buildSelectedPreviewCard().toJson(),
                      ),
                    ),
                    StacCustomVisibility(
                      visible: '[[giftCardRealCustomHasReplacementMessage]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacSizedBox(height: 14),
                          StacContainer(
                            decoration: StacBoxDecoration(
                              color: '{{appColors.current.background.surface}}',
                              borderRadius: StacBorderRadius.all(12),
                              border: StacBorder.all(
                                color:
                                    '{{appColors.current.input.borderEnabled}}',
                                width: 1,
                              ),
                            ),
                            child: _buildReplacementPreviewCard(),
                          ),
                        ],
                      ).toJson(),
                    ),
                    StacCustomVisibility(
                      visible: '[[!giftCardRealCustomHasReplacementMessage]]',
                      child: StacColumn(
                        children: [
                          StacSizedBox(height: 42),
                          StacGestureDetector(
                            onTap: NavigationAction(
                              fileName: 'gift_card_image_selector',
                              navMode: NavModes.dart,
                              navigationStyle: NavigationStyle.push,
                            ),
                            child: StacColumn(
                              children: [
                                StacContainer(
                                  width: 82,
                                  height: 82,
                                  decoration: StacBoxDecoration(
                                    color:
                                        '{{appColors.current.background.surface}}',
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
                                  data:
                                      '{{appStrings.generated.gift_card.gift_card_custom_design_selector.select_image_text_alt}}',
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
                  ],
                ).toJson(),
              ),
            ),
          ),
          StacCustomRegistryReactive(
            child: StacCustomVisibility(
              visible: '[[giftCardRealCustomHasSelection]]',
              child: StacPadding(
                padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: StacFilledButton(
                  onPressed: NavigationAction(
                    fileName: 'gift_card_receiver_info',
                    navMode: NavModes.dart,
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
                    data: '{{appStrings.profile.real.changePassword.submit}}',
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

StacWidget _buildReplacementPreviewCard() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacContainer(
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
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacContainer(
              height: 55,
              padding: StacEdgeInsets.symmetric(horizontal: 8),
              color: '#F7FAFD',
              child: StacRow(
                textDirection: StacTextDirection.ltr,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacImage(
                    src: 'assets/icons/shetab.svg',
                    imageType: StacImageType.asset,
                    width: 49,
                    height: 21,
                    fit: StacBoxFit.contain,
                  ),
                  StacImage(
                    src: 'assets/icons/gardeshgary.svg',
                    imageType: StacImageType.asset,
                    width: 117,
                    height: 29,
                    fit: StacBoxFit.contain,
                  ),
                ],
              ),
            ),
            StacSizedBox(height: 8),
            StacContainer(
              height: 118,
              child: StacRawJsonWidget({
                'type': 'registryReactive',
                'child': {
                  'type': 'image',
                  'src': '{{giftCardRealSelectedPlanImageUrl}}',
                  'registryKey': 'giftCardRealSelectedPlanImageUrl',
                  'fit': 'cover',
                  'errorBuilder': {
                    'type': 'center',
                    'child': {
                      'type': 'icon',
                      'icon': 'image_outlined',
                      'size': 36,
                      'color': '{{appColors.current.text.subtitle}}',
                    },
                  },
                },
              }),
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
            StacSizedBox(height: 4),
            StacText(
              data: '{{giftCardRealCustomReplacementMessage}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 4),
            StacText(
              data:
                  '{{appStrings.generated.gift_card.gift_card_design_selector.title}}',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w900,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 4),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildSelectedPreviewCard() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacContainer(
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
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacContainer(
              height: 43,
              padding: StacEdgeInsets.symmetric(horizontal: 8),
              color: '#F7FAFD',
              child: StacRow(
                textDirection: StacTextDirection.ltr,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacImage(
                    src: 'assets/icons/shetab.svg',
                    imageType: StacImageType.asset,
                    width: 49,
                    height: 21,
                    fit: StacBoxFit.contain,
                  ),
                  StacImage(
                    src: 'assets/icons/gardeshgary.svg',
                    imageType: StacImageType.asset,
                    width: 117,
                    height: 29,
                    fit: StacBoxFit.contain,
                  ),
                ],
              ),
            ),
            StacContainer(
              height: 118,
              child: StacRawJsonWidget({
                'type': 'registryReactive',
                'child': {
                  'type': 'image',
                  'src': '{{giftCardRealCustomImagePath}}',
                  'registryKey': 'giftCardRealCustomImagePath',
                  'fit': 'cover',
                  'errorBuilder': {
                    'type': 'center',
                    'child': {
                      'type': 'icon',
                      'icon': 'image_outlined',
                      'size': 36,
                      'color': '{{appColors.current.text.subtitle}}',
                    },
                  },
                },
              }),
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
            StacSizedBox(height: 4),
            StacText(
              data: '{{giftCardRealFinalMessage}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 4),
            StacText(
              data:
                  '{{appStrings.generated.gift_card.gift_card_design_selector.title}}',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w900,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 4),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildEmptyPreviewCard() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacContainer(
        height: 54,
        padding: StacEdgeInsets.symmetric(horizontal: 12),
        color: '#F7FAFD',
        child: StacRow(
          textDirection: StacTextDirection.ltr,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacImage(
              src: 'assets/icons/shetab.svg',
              imageType: StacImageType.asset,
              width: 44,
              height: 16,
              fit: StacBoxFit.contain,
            ),
            StacImage(
              src: 'assets/icons/gardeshgary.svg',
              imageType: StacImageType.asset,
              width: 112,
              height: 24,
              fit: StacBoxFit.contain,
            ),
          ],
        ),
      ),
      StacContainer(
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      StacSizedBox(
        height: 140,
        child: StacCenter(
          child: StacText(
            data:
                '{{appStrings.generated.gift_card.gift_card_custom_design_selector.image}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 19,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ),
      StacContainer(height: 1, color: '#F7FAFD'),
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
              data:
                  '{{appStrings.generated.gift_card.gift_card_custom_design_selector.custom_text_hint}}',
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
              data:
                  '{{appStrings.generated.gift_card.gift_card_design_selector.title}}',
              textDirection: StacTextDirection.ltr,
              textAlign: StacTextAlign.center,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w900,
                color: '#000000',
              ),
            ),
            StacSizedBox(height: 10),
          ],
        ),
      ),
    ],
  );
}

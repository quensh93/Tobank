import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'authentication_signature_guide')
StacWidget authenticationRealSignatureGuide() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.authentication.guideLabel}}',
      showSupport: false,
    ),
    body: StacSafeArea(
      bottom: true,
      top: false,
      child: StacStack(
        children: [
          StacContainer(
            width: 999999,
            height: 999999,
            color: '{{appColors.current.background.surface}}',
          ),
          StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacContainer(
                  padding: StacEdgeInsets.all(20),
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surfaceContainer}}',
                    borderRadius: StacBorderRadius.all(18),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacText(
                        data:
                            '{{appStrings.generated.authentication.authentication_signature_guide.title}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 20,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 12),
                      StacText(
                        data:
                            '{{appStrings.generated.authentication.authentication_signature_guide.select_show_image_guide_signature}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 15,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
                StacSizedBox(height: 20),
                _buildGuideOptionCard(
                  title:
                      '{{appStrings.generated.authentication.authentication_signature_guide.image}}',
                  subtitle:
                      '{{appStrings.generated.authentication.authentication_signature_guide.page_place_submit_signature}}',
                  iconAsset: '{{appAssets.icons.visualTutorialCurrent}}',
                  onTap: NavigationAction(
                    fileName: 'authentication_signature_visual_guide',
                    navMode: NavModes.dart,
                    navigationStyle: NavigationStyle.push,
                  ),
                ),
                StacSizedBox(height: 12),
                _buildGuideOptionCard(
                  title:
                      '{{appStrings.generated.authentication.authentication_signature_guide.audio_guide}}',
                  subtitle:
                      '{{appStrings.generated.authentication.authentication_signature_guide.description}}',
                  iconAsset: '{{appAssets.icons.voiceTutorialCurrent}}',
                  onTap: const StacShowResultAction(
                    title: '{{appStrings.common.comingSoon}}',
                    content:
                        '{{appStrings.generated.authentication.authentication_signature_guide.sample_message}}',
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

StacWidget _buildGuideOptionCard({
  required String title,
  required String subtitle,
  required String iconAsset,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(16),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacContainer(
            width: 48,
            height: 48,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(24),
            ),
            child: StacCenter(
              child: StacImage(
                src: iconAsset,
                imageType: StacImageType.asset,
                width: 22,
                height: 22,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 14),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
                StacSizedBox(height: 6),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(width: 8),
          StacImage(
            src: '{{appAssets.icons.arrowRight}}',
            imageType: StacImageType.asset,
            width: 18,
            height: 18,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ],
      ),
    ),
  );
}

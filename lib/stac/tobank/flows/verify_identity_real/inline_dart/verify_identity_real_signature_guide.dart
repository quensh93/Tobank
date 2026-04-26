import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'verify_identity_real_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_signature_guide')
StacWidget verifyIdentityRealSignatureGuide() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildVerifyIdentityRealAppBar(title: 'راهنما', showSupport: false),
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
                        data: 'راهنمای ثبت امضا',
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
                            'نوع راهنما را انتخاب کنید. راهنمای تصویری نمونه‌ی امضای صحیح را نمایش می‌دهد.',
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
                  title: 'راهنمای تصویری',
                  subtitle: 'مشاهده نمونه صفحه و محل ثبت امضا',
                  iconAsset: '{{appAssets.icons.visualTutorialCurrent}}',
                  onTap: const StacNavigateAction(
                    routeName: 'verify_identity_real_signature_visual_guide',
                    navigationStyle: NavigationStyle.push,
                  ),
                ),
                StacSizedBox(height: 12),
                _buildGuideOptionCard(
                  title: 'راهنمای صوتی',
                  subtitle: 'توضیح صوتی این مرحله',
                  iconAsset: '{{appAssets.icons.voiceTutorialCurrent}}',
                  onTap: const StacShowResultAction(
                    title: '{{appStrings.common.comingSoon}}',
                    content: 'راهنمای صوتی این بخش هنوز اضافه نشده است.',
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

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_registration')
StacWidget verifyIdentityRealRegistration() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {
          'key': 'verifyIdentitySelectedJobTitle',
          'value': 'حوزه فعالیت خود را انتخاب کنید..',
        },
        {'key': 'verifyIdentityHasSelectedJob', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).title,
        centerTitle: true,
        leading: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).leading,
        actions: [
          StacPadding(
            padding: StacEdgeInsets.only(right: 15),
            child: StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(22),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_support.svg',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ),
        ],
      ),
      body: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacSizedBox(height: 16),
                    StacContainer(
                      padding: StacEdgeInsets.all(16),
                      decoration: StacBoxDecoration(
                        color: '{{appColors.current.background.surface}}',
                        borderRadius: StacBorderRadius.all(10),
                        border: StacBorder.all(
                          color: '{{appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacText(
                        data:
                            'کاربر گرامی\nبا تکمیل اطلاعات زیر، مراحل احراز هویت شما به اتمام می‌رسد و می‌توانید از خدمات برنامه استفاده کنید.',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.title}}',
                          height: 1.8,
                        ),
                      ),
                    ),
                    StacSizedBox(height: 32),
                    StacText(
                      data: 'حوزه فعالیت',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    _buildJobSelector(),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(top: 16),
              child: StacCustomReactiveElevatedButton(
                enabledKey: 'verifyIdentityHasSelectedJob',
                enabled: false,
                onPressed: const StacShowResultAction(
                  title: '{{appStrings.common.comingSoon}}',
                  content: 'مرحله بعدی ثبت‌نام هنوز پیاده‌سازی نشده است.',
                ),
                style: StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                child: StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildJobSelector() {
  return StacGestureDetector(
    onTap: const StacNavigateAction(
      routeName: 'verify_identity_real_job_selector',
      navigationStyle: NavigationStyle.push,
    ),
    child: StacCustomRegistryReactive(
      registryKey: 'verifyIdentitySelectedJobTitle',
      child: StacContainer(
        height: 56,
        padding: StacEdgeInsets.symmetric(horizontal: 16),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacExpanded(
              child: StacText(
                data: '{{verifyIdentitySelectedJobTitle}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
            ),
            StacSizedBox(width: 12),
            StacImage(
              src: 'assets/icons/ic_arrow_circle_down.svg',
              imageType: StacImageType.asset,
              width: 33,
              height: 33,

            ),
          ],
        ),
      ).toJson(),
    ),
  );
}

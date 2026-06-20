import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'user_credit_validation_report_detail')
StacWidget userCreditValidationReportDetail() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: '{{appStrings.authentication.stepValidation}}',
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacSizedBox(height: 12),
          StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacPadding(
              padding: StacEdgeInsets.all(14),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacRow(
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacImage(
                        src: 'assets/icons/ic_pdf_file.svg',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                      StacSizedBox(width: 10),
                      StacExpanded(
                        child: StacText(
                          data:
                              '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.report_credit_validation}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                      StacGestureDetector(
                        onTap: NavigationAction(
                          fileName: 'user_credit_validation_preview',
                          navMode: NavModes.dart,
                          navigationStyle: NavigationStyle.push,
                        ),
                        child: StacPadding(
                          padding: StacEdgeInsets.all(6),
                          child: StacImage(
                            src: 'assets/icons/ic_show.svg',
                            imageType: StacImageType.asset,
                            width: 24,
                            height: 24,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                      StacSizedBox(width: 8),
                      StacGestureDetector(
                        onTap: _shareValidationReportCardAction(),
                        child: StacPadding(
                          padding: StacEdgeInsets.all(6),
                          child: StacImage(
                            src: 'assets/icons/ic_share.svg',
                            imageType: StacImageType.asset,
                            width: 24,
                            height: 24,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 12),
                  StacContainer(
                    height: 1,
                    color: '{{appColors.current.input.borderEnabled}}',
                  ),
                  StacSizedBox(height: 12),
                  StacText(
                    data:
                        '{{appStrings.generated.user_credit_validation.user_credit_validation_report_detail.title}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _shareValidationReportCardAction() {
  return const StacShowResultAction(
    title:
        '{{appStrings.generated.card_management.card_management_root.share}}',
    content:
        '{{appStrings.generated.user_credit_validation.user_credit_validation_report_detail.share}}',
  );
}

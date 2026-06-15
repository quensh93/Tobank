import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'promissory_guarantee_sign_page')
StacWidget promissoryGuaranteeSignPage() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: 'ضمانت سفته',
      showBack: true,
      showSupport: true,
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(child: StacSizedBox()),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacImage(
                  src: 'assets/icons/sign-pdf.svg',
                  imageType: StacImageType.asset,
                  width: 160,
                  height: 160,
                ),
              ),
              StacSizedBox(height: 20),
              StacText(
                data:
                    'با انتخاب گزینه امضای سفته، امضاء شما پایین تصویر سفته به صورت الکترونیکی ثبت می‌شود و این عمل به منزله تایید درخواست و ثبت نهایی فرآیند است.',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  height: 1.7,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacFilledButton(
            onPressed: StacShowDialogAction(
              barrierDismissible: true,
              barrierColor: '#80000000',
              backgroundColor: '#00000000',
              dialog: _buildSignConfirmDialog().toJson(),
            ),
            style: StacButtonStyle(
              backgroundColor: '#D91F2A',
              foregroundColor: '#FFFFFF',
              elevation: 0,
              fixedSize: StacSize(999999, 56),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            child: StacText(
              data: 'امضای سفته',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '#FFFFFF',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSignConfirmDialog() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(16),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 18, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacImage(
              src: 'assets/icons/ic_warning_red.svg',
              imageType: StacImageType.asset,
              width: 56,
              height: 56,
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'از امضای ضمانت سفته مطمئن هستید؟',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
              height: 1.6,
            ),
          ),
          StacSizedBox(height: 18),
          StacRow(
            textDirection: StacTextDirection.ltr,
            children: [
              StacExpanded(
                child: StacFilledButton(
                  onPressed: StacFingerPrintAction(
                    title: 'احراز هویت',
                    description:
                        'لطفا برای ادامه امضای ضمانت سفته از اثر انگشت استفاده کنید',
                    onSuccess: {
                      'actionType': 'sequence',
                      'actions': [
                        {'actionType': 'closeDialog'},
                        NavigationAction(
                          fileName: 'promissory_guarantee_final_page',
                          navMode: NavModes.dart,
                          navigationStyle: NavigationStyle.pushReplacement,
                        ).toJson(),
                      ],
                    },
                    onFailure: {
                      'actionType': 'showSnackBar',
                      'title': 'عدم احراز هویت',
                      'description':
                          'احراز هویت انجام نشد. لطفا دوباره تلاش کنید.',
                      'type': 'error',
                    },
                  ),
                  style: StacButtonStyle(
                    fixedSize: StacSize(999999, 50),
                    backgroundColor: '#D91F2A',
                    foregroundColor: '#FFFFFF',
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                    elevation: 0,
                  ),
                  child: StacText(
                    data: 'تایید',
                    style: StacTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '#FFFFFF',
                    ),
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacOutlinedButton(
                  onPressed: const StacCloseDialogAction(),
                  style: StacButtonStyle(
                    fixedSize: StacSize(999999, 50),
                    side: StacBorderSide(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1.2,
                    ),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ),
                  child: StacText(
                    data: 'لغو',
                    style: StacTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

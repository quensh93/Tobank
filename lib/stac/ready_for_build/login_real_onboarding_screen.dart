import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'login_real_onboarding')
StacWidget promissoryRealOnboarding() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    body: StacSafeArea(
      child: StacPadding(
        padding: StacEdgeInsets.all(24),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacColumn(
                mainAxisAlignment: StacMainAxisAlignment.center,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacImage(
                    src: '{{appAssets.onboarding.page1}}',
                    imageType: StacImageType.asset,
                    height: 220,
                    fit: StacBoxFit.contain,
                  ),
                  StacSizedBox(height: 24),
                  StacText(
                    data: 'صدور و مدیریت انواع کارت',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 12),
                  StacText(
                    data:
                        'بدون نیاز به حضور شما و ضامنان در شعب، تسهیلات، کارت هدیه و کارت اعتباری مورد نظر خود را دریافت نمایید.',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 13,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(height: 20),
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    children: [
                      _dot(true),
                      StacSizedBox(width: 6),
                      _dot(false),
                      StacSizedBox(width: 6),
                      _dot(false),
                    ],
                  ),
                ],
              ),
            ),
            StacElevatedButton(
              onPressed: StacRawJsonAction({
                'actionType': 'navigate',
                'widgetType': 'login_real_validation',
                'navigationStyle': 'push',
              }),
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                fixedSize: StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
                elevation: 0,
              ),
              child: StacText(
                data: 'شروع',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _dot(bool active) {
  return StacContainer(
    width: 8,
    height: 8,
    decoration: StacBoxDecoration(
      color: active
          ? '{{appColors.current.primary.color}}'
          : '{{appColors.current.input.borderEnabled}}',
      borderRadius: StacBorderRadius.all(8),
    ),
  );
}

class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);
  @override
  String get actionType => json['actionType'] as String;
  @override
  Map<String, dynamic> toJson() => json;
}

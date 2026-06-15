import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

const String _closeDepositCommitmentTitle =
    'تعهد مشتری نسبت به عدم اتصال سپرده درخواستی';
const String _closeDepositDisclaimerText =
    'مشتری گرامی، بانک هیچ‌گونه مسئولیتی در خصوص جبران زیان مالی احتمالی ناشی از بستن سپرده‌های مرتبط با صندوق‌های سرمایه‌گذاری، سامانه سجام، کارگزاری‌های بورس، پایانه‌های فروشگاهی، سهام عدالت و ... ندارد. لذا خواهشمند است پیش از ثبت درخواست بستن سپرده، از عدم وجود ارتباطات یاد شده اطمینان حاصل نمایید';

@StacScreen(screenName: 'deposit_close_confirm')
StacWidget depositCloseConfirm() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'depositCloseConfirmRulesChecked', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: 'بستن سپرده',
        showSupport: true,
      ),
      body: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _closeDepositInfoCard(),
            StacExpanded(child: StacSizedBox()),
            _closeDepositConfirmCard(),
            StacSizedBox(height: 40),
            StacCustomReactiveElevatedButton(
              enabledKey: 'depositCloseConfirmRulesChecked',
              onPressed: NavigationAction(fileName: 'deposit_close_selector', navMode: NavModes.dart, navigationStyle: NavigationStyle.push).toJson(),
              style: StacButtonStyle(
                minimumSize: const StacSize(0, 64),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              disabledStyle: StacButtonStyle(
                minimumSize: const StacSize(0, 64),
                backgroundColor: '{{appColors.current.input.borderEnabled}}',
                foregroundColor: '{{appColors.current.text.subtitle}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              child: StacText(
                data: 'مرحله بعد',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                ),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _closeDepositInfoCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacContainer(
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.background.surfaceContainer}}',
                  borderRadius: StacBorderRadius.all(8),
                ),
                child: StacPadding(
                  padding: StacEdgeInsets.all(4),
                  child: StacImage(
                    src: 'assets/icons/ic_warning.svg',
                    imageType: StacImageType.asset,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              StacSizedBox(width: 8),
              StacExpanded(
                child: StacText(
                  data: _closeDepositCommitmentTitle,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    color: '{{appColors.current.text.title}}',
                    height: 1.6,
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 16),
          StacText(
            data: _closeDepositDisclaimerText,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.subtitle}}',
              height: 1.6,
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _closeDepositConfirmCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(8),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacSizedBox(width: 4),
          StacGestureDetector(
            onTap: const StacCustomSetValueAction(
              key: 'depositCloseConfirmRulesChecked',
              value: '{{depositCloseConfirmRulesChecked ? false : true}}',
            ),
            child: StacContainer(
              width: 22,
              height: 22,
              decoration: StacBoxDecoration(
                color: '{{depositCloseConfirmRulesChecked ? appColors.current.secondary.color : "transparent"}}',
                borderRadius: StacBorderRadius.all(3),
                border: StacBorder.all(
                  color: '{{appColors.current.text.title}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacCustomOpacity(
                  opacity: '{{depositCloseConfirmRulesChecked ? 1.0 : 0.0}}',
                  child: StacImage(
                    src: 'assets/icons/ic_check.svg',
                    imageType: StacImageType.asset,
                    width: 20,
                    height: 20,
                    color: '#FFFFFF',
                  ).toJson(),
                ),
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacExpanded(
            child: StacGestureDetector(
              onTap: const StacCustomSetValueAction(
                key: 'depositCloseConfirmRulesChecked',
                value: '{{depositCloseConfirmRulesChecked ? false : true}}',
              ),
              child: StacText(
                data: _closeDepositDisclaimerText,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  color: '{{appColors.current.text.title}}',
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


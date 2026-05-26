import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/installment_payment/dart/installment_payment_others_main.dart'
    as installment_payment_others_main_dart;

@StacScreen(screenName: 'installment_payment_api_real_menu')
StacWidget installmentPaymentApiRealMenu() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      title: 'پرداخت اقساط api. واقعی',
      showBack: true,
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisAlignment: StacMainAxisAlignment.center,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacFilledButton(
            onPressed: _loanPaymentBottomSheetAction(),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگزاری از دارت',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacFilledButton(
            onPressed: const StacNavigateAction(
              assetPath:
                  'lib/stac/tobank/flows/installment_payment/json/installment_payment_start.json',
              navigationStyle: NavigationStyle.push,
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگزاری از جیسون محلی',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacOutlinedButton(
            onPressed: StacNavigateAction.fromJson({
              'actionType': 'navigate',
              'navigationStyle': 'push',
              'request': {
                'url':
                    'http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.installment_payment_start/1',
                'method': 'post',
                'headers': {
                  'Content-Type': 'application/json',
                  'Accept': '*/*',
                },
                'body': {
                  'operator': 'is',
                  'dimension': {'app': 'mobile'},
                },
              },
            }),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
            ),
            child: StacText(
              data: 'بارگزاری از json api',
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacShowBottomSheetAction _loanPaymentBottomSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#00000000',
    sheet: _loanPaymentBottomSheet().toJson(),
  );
}

StacWidget _loanPaymentBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 46,
              height: 6,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data: 'پرداخت اقساط',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 20,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          _loanBottomSheetItem(
            title: 'پرداخت اقساط خود',
            onTap: const StacSequenceAction(
              actions: [
                StacNavigateAction(navigationStyle: NavigationStyle.pop),
                StacNavigateAction(
                  routeName: 'installment_payment_list_main',
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
          ),
          StacDivider(
            color: '{{appColors.current.input.borderEnabled}}',
            thickness: 1,
            height: 16,
          ),
          _loanBottomSheetItem(
            title: 'پرداخت اقساط دیگران',
            onTap: StacSequenceAction(
              actions: [
                const StacNavigateAction(navigationStyle: NavigationStyle.pop),
                StacNavigateAction(
                  widgetJson: installment_payment_others_main_dart
                      .installmentPaymentOthersMain()
                      .toJson(),
                  navigationStyle: NavigationStyle.push,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _loanBottomSheetItem({
  required String title,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      width: 999999,
      padding: StacEdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
  );
}

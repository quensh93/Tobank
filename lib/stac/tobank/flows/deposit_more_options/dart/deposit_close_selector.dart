import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_close_selector')
StacWidget depositCloseSelector() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {
          'key': 'depositCloseSelector.depositNumber',
          'value': '۱۱۹.۹۲۹۰.۱۶۱۲۹۸۸.۱',
        },
        {'key': 'depositCloseSelector.balance', 'value': '۰ ریال'},
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
            StacSizedBox(height: 12),
            _selectorDepositInfoCard(),
            StacSizedBox(height: 45),
            StacFilledButton(
              onPressed: StacRawJsonAction(
                _showCloseDepositConfirmDialogAction(),
              ),
              style: StacButtonStyle(
                minimumSize: const StacSize(0, 64),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              child: StacText(
                data: 'تایید و بستن سپرده',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                ),
              ),
            ),
            StacExpanded(child: StacSizedBox()),
          ],
        ),
      ),
    ),
  );
}

Map<String, dynamic> _showCloseDepositConfirmDialogAction() {
  return {
    'actionType': 'showAppDialog',
    'barrierDismissible': true,
    'barrierColor': '#B3000000',
    'backgroundColor': '#00000000',
    'dialog': _closeDepositConfirmDialogWidget().toJson(),
  };
}

StacWidget _closeDepositConfirmDialogWidget() {
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
            child:  StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_warning_red.svg',
                  width: 55,
                  height: 55,
                  imageType: StacImageType.asset,
                ),
              ),
          ),
          StacSizedBox(height: 18),
          StacText(
            data: 'شما درخواست بستن سپرده زیر را دارید. آیا مطمئن هستید؟',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              color: '{{appColors.current.text.title}}',
              fontSize: 17,
              fontWeight: StacFontWeight.w600,
              height: 1.8,
            ),
          ),
          StacSizedBox(height: 16),
          StacContainer(
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(11),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacPadding(
              padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: StacRow(
                textDirection: StacTextDirection.rtl,
                mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                children: [
                  StacText(
                    data: 'شماره سپرده',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.subtitle}}',
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                    ),
                  ),
                  StacText(
                    data: '{{depositCloseSelector.depositNumber}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      color: '{{appColors.current.text.title}}',
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacSizedBox(height: 14),
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: StacOutlinedButton(
                  onPressed: const StacCloseDialogAction(),
                  style: StacButtonStyle(
                    minimumSize: const StacSize(0, 56),
                    side: StacBorderSide(
                      color: '{{appColors.current.button.primary.backgroundColor}}',
                      width: 1.4,
                    ),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(11),
                    ),
                  ),
                  child: StacText(
                    data: 'انصراف',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      color:
                          '{{appColors.current.button.primary.backgroundColor}}',
                      fontSize: 18,
                      fontWeight: StacFontWeight.w600,
                    ),
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacFilledButton(
                  onPressed: const StacFingerPrintAction(
                    title: 'احراز هویت',
                    description:
                        'لطفا برای ادامه بستن سپرده، احراز هویت انجام دهید',
                    onSuccess: {
                      'actionType': 'sequence',
                      'actions': [
                        {'actionType': 'closeDialog'},
                        {
                          'actionType': 'navigate',
                          'fileName': 'deposit_close_result',
                          'navMode': 'dart',
                          'navigationStyle': 'push',
                        },
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
                    minimumSize: const StacSize(0, 56),
                    backgroundColor:
                        '{{appColors.current.button.primary.backgroundColor}}',
                    foregroundColor:
                        '{{appColors.current.button.primary.foregroundColor}}',
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(11),
                    ),
                  ),
                  child: StacText(
                    data: 'بستن سپرده',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
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

StacWidget _selectorDepositInfoCard() {
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
        children: [
          _selectorKeyValueRow(
            keyText: 'شماره سپرده:',
            valueKey: 'depositCloseSelector.depositNumber',
          ),
          StacSizedBox(height: 16),
          _selectorKeyValueRow(
            keyText: 'موجودی سپرده:',
            valueKey: 'depositCloseSelector.balance',
          ),
        ],
      ),
    ),
  );
}

StacWidget _selectorKeyValueRow({
  required String keyText,
  required String valueKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacText(
        data: keyText,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.subtitle}}',
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
        ),
      ),
      StacText(
        data: '{{$valueKey}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          color: '{{appColors.current.text.title}}',
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
        ),
      ),
    ],
  );
}


import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'dashboard_card_balance')
StacWidget dashboardCardBalance() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'cardsManagement.balance.submitEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        leading: StacPadding(
          padding: StacEdgeInsets.only(left: 12),
          child: StacCenter(
            child: StacImage(
              src: '{{appAssets.icons.support}}',
              imageType: StacImageType.asset,
              width: 24,
              height: 24,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        actions: [
          StacIconButton(
            onPressed: const StacNavigateAction(
              navigationStyle: NavigationStyle.pop,
            ),
            icon: StacImage(
              src: '{{appAssets.icons.arrowBack}}',
              imageType: StacImageType.asset,
              width: 31,
              height: 31,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: StacText(
          data: 'دریافت موجودی',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _label('شماره کارت'),
              StacSizedBox(height: 8),
              _cardNumberField(),
              StacSizedBox(height: 28),
              _label('تاریخ انقضا'),
              StacSizedBox(height: 8),
              _expiryField(id: 'balance_expiry', hintText: '۰۵/۰۷'),
              StacSizedBox(height: 28),
              _label('CVV2'),
              StacSizedBox(height: 8),
              _inputField(
                id: 'balance_cvv2',
                hintText: 'CVV2 را وارد نمایید',
                keyboardType: 'number',
              ),
              StacSizedBox(height: 28),
              _label('رمز پویا'),
              StacSizedBox(height: 8),
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacExpanded(
                    child: _inputField(
                      id: 'balance_dynamic_password',
                      hintText: 'رمز پویا را وارد نمایید',
                      keyboardType: 'number',
                    ),
                  ),
                  StacSizedBox(width: 12),
                  StacFilledButton(
                    onPressed: StacCustomSnackBarAction(
                      title: 'رمز پویا ارسال شد',
                      detail: 'رمز پویا برای شماره همراه شما ارسال شد. (mock)',
                      duration: 2500,
                    ),
                    style: StacButtonStyle(
                      fixedSize: const StacSize(118, 56),
                      backgroundColor:
                          '{{appColors.current.background.surface}}',
                      foregroundColor: '{{appColors.current.text.title}}',
                      elevation: 0,
                      side: StacBorderSide(
                        color: '{{appColors.current.text.title}}',
                        width: 1,
                      ),
                      shape: StacRoundedRectangleBorder(
                        borderRadius: StacBorderRadius.all(8),
                      ),
                    ),
                    child: StacText(
                      data: 'رمز پویا',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 24),
              StacText(
                data: 'مبلغ ۱۴۱۴۰ ریال بابت کارمزد از حساب شما کسر خواهد شد',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 64),
              StacCustomReactiveElevatedButton(
                enabledKey: 'cardsManagement.balance.submitEnabled',
                onPressed: StacCustomSnackBarAction(
                  title: 'موجودی دریافت شد',
                  detail: 'موجودی کارت با موفقیت دریافت شد. (mock)',
                  duration: 2500,
                ),
                style: StacButtonStyle(
                  minimumSize: const StacSize(0, 56),
                  backgroundColor:
                      '{{appColors.current.button.primary.backgroundColor}}',
                  foregroundColor:
                      '{{appColors.current.button.primary.foregroundColor}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  minimumSize: const StacSize(0, 56),
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  foregroundColor: '{{appColors.current.text.hint}}',
                  elevation: 0,
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                child: StacText(
                  data: 'دریافت موجودی',
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
    ),
  );
}

StacWidget _label(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _cardNumberField() {
  return StacContainer(
    height: 56,
    padding: StacEdgeInsets.symmetric(horizontal: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      crossAxisAlignment: StacCrossAxisAlignment.center,
      children: [
        StacImage(
          src: '{{appAssets.icons.gardeshgari}}',
          imageType: StacImageType.asset,
          width: 42,
          height: 42,
        ),
        StacSizedBox(width: 16),
        StacExpanded(
          child: StacText(
            data: '[[cardsManagement.sheet.cardNumber]]',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacSizedBox(width: 16),
        StacImage(
          src: '{{appAssets.icons.cardBalance}}',
          imageType: StacImageType.asset,
          width: 28,
          height: 28,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );
}

StacWidget _inputField({
  required String id,
  required String hintText,
  required String keyboardType,
}) {
  return StacCustomTextFormField(
    id: id,
    textDirection: 'rtl',
    textAlign: 'right',
    keyboardType: keyboardType,
    onChanged: _balanceValidateAction(),
    decoration: {
      'hintText': hintText,
      'hintStyle': {
        'textDirection': 'rtl',
        'style': {
          'color': '{{appColors.current.text.hint}}',
          'fontSize': 16,
          'fontWeight': 'w500',
        },
      },
      'enabledBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1,
        },
        'borderRadius': {'all': 8},
      },
      'focusedBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.button.primary.backgroundColor}}',
          'width': 1.5,
        },
        'borderRadius': {'all': 8},
      },
      'contentPadding': {'left': 16, 'top': 16, 'right': 16, 'bottom': 16},
    },
  );
}

StacWidget _expiryField({required String id, required String hintText}) {
  return StacCustomTextFormField(
    id: id,
    textDirection: 'ltr',
    textAlign: 'right',
    keyboardType: 'number',
    maxLength: 5,
    readOnly: true,
    onTap: StacRawJsonAction({
      'actionType': 'showCardExpireSelectBottomSheet',
      'formFieldId': id,
      'title': 'تاریخ انقضای کارت را انتخاب نمایید',
      'monthTitle': 'ماه',
      'yearTitle': 'سال',
      'confirmText': 'تایید',
      'onSelectedAction': _balanceValidateAction().toJson(),
    }),
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    decoration: {
      'hintText': hintText,
      'hintStyle': {
        'type': 'custom',
        'fontSize': 16,
        'fontWeight': 'w500',
        'color': '{{appColors.current.text.hint}}',
      },
      'enabledBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'width': 1,
        },
        'borderRadius': {'all': 8},
      },
      'focusedBorder': {
        'type': 'outlineInputBorder',
        'borderSide': {
          'color': '{{appColors.current.button.primary.backgroundColor}}',
          'width': 1.5,
        },
        'borderRadius': {'all': 8},
      },
      'contentPadding': {'left': 16, 'top': 16, 'right': 16, 'bottom': 16},
    },
  );
}

StacAction _balanceValidateAction() {
  return const StacValidateFieldsAction(
    resultKey: 'cardsManagement.balance.submitEnabled',
    fields: [
      {'id': 'balance_expiry'},
      {'id': 'balance_cvv2'},
      {'id': 'balance_dynamic_password'},
    ],
  );
}

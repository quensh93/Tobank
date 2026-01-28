import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';

import '../../../../../core/stac/parsers/actions/close_dialog_action_parser.dart';

@StacScreen(screenName: 'promissory_deposit_select')
StacWidget promissoryDepositSelect() {
  return StacStatefulWidget(
    child: StacScaffold(
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacSizedBox(height: 8),
                  StacCenter(
                    child: StacContainer(
                      width: 36,
                      height: 4,
                      decoration: StacBoxDecoration(
                        color: '{{appColors.current.input.borderEnabled}}',
                        borderRadius: StacBorderRadius.all(8),
                      ),
                    ),
                  ),
                  StacSizedBox(height: 12),
                  StacText(
                    data: 'سپرده جهت پرداخت را انتخاب کنید',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(12),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      children: [
                        _depositItem(
                          title: '{{selectedDeposit.title}}',
                          depositNumber: '{{selectedDeposit.depositNumber}}',
                          iban: '{{selectedDeposit.depositIban}}',
                          balance:
                              '{{selectedDeposit.balance}} {{appStrings.common.rial}}',
                          cardNumber: '{{selectedDeposit.cardNumber}}',
                          selected: true,
                          onTap: StacLogAction(message: 'selected existing deposit'),
                        ),
                        StacSizedBox(height: 16),
                        _divider(),
                        StacSizedBox(height: 16),
                        _depositItem(
                          title:
                              'سپرده حقیقی سپرده سرمایه گذاری کوتاه مدت مدت - توبانک - حقیقی ریالی مهدی جمشیدیپور',
                          depositNumber: '110.9999.175558091',
                          iban: 'IR79064001100999917555809001',
                          balance: '---',
                          cardNumber: '5054 1617 0282 2333',
                          selected: false,
                          onTap: StacCustomSetValueAction(values: [
                            {'key': 'selectedDeposit.title', 'value': 'سپرده حقیقی سرمایه گذاری کوتاه مدت'},
                            {'key': 'selectedDeposit.depositNumber', 'value': '110.9999.175558091'},
                            {'key': 'selectedDeposit.depositIban', 'value': 'IR79064001100999917555809001'},
                            {'key': 'selectedDeposit.balance', 'value': '76621'},
                            {'key': 'selectedDeposit.cardNumber', 'value': '5054 1617 0282 2333'},
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.all(16),
            child: StacFilledButton(
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0,
                fixedSize: StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              onPressed: StacDialogAction(
                widget: StacAlertDialog(
                  title: StacText(
                    data: '{{appStrings.promissory.payConfirmTitle}}',
                    textDirection: StacTextDirection.rtl,
                  ),
                  content: StacText(
                    data: '{{appStrings.promissory.payConfirmMessage}}',
                    textDirection: StacTextDirection.rtl,
                  ),
                  actions: [
                    StacTextButton(
                      onPressed: StacCloseDialogAction(),
                      child: StacText(
                        data: '{{appStrings.common.cancel}}',
                        textDirection: StacTextDirection.rtl,
                      ),
                    ),
                    StacTextButton(
                      onPressed: StacSequenceAction(actions: [
                        StacCloseDialogAction(),
                        {
                          'actionType': 'navigate',
                          'widgetType': 'promissory_success',
                          'navigationStyle': 'pushReplacement',
                        }
                      ]),
                      child: StacText(
                        data: '{{appStrings.common.confirm}}',
                        textDirection: StacTextDirection.rtl,
                      ),
                    ),
                  ],
                ).toJson(),
              ),
              child: StacText(
                data: 'پرداخت',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _kv(String k, String v) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: k,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacText(
        data: v,
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _depositItem({
  required String title,
  required String depositNumber,
  required String iban,
  required String balance,
  required String cardNumber,
  required bool selected,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.all(16),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacContainer(
                width: 18,
                height: 18,
                decoration: StacBoxDecoration(
                  borderRadius: StacBorderRadius.all(18),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1,
                  ),
                  color: selected ? '{{appColors.current.primary.color}}' : 'transparent',
                ),
              ),
              StacSizedBox(width: 8),
              StacExpanded(
                child: StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ],
          ),
          StacSizedBox(height: 12),
          StacContainer(height: 1, decoration: StacBoxDecoration(color: '{{appColors.current.input.borderEnabled}}')),
          StacSizedBox(height: 12),
          _kv('شماره سپرده', depositNumber),
          StacSizedBox(height: 12),
          _kv('شماره شبا', iban),
          StacSizedBox(height: 12),
          _kv('موجودی', balance),
          StacSizedBox(height: 12),
          _kv('شماره کارت', cardNumber),
        ],
      ),
    ),
  );
}

StacWidget _divider() {
  return StacContainer(height: 1, decoration: StacBoxDecoration(color: '{{appColors.current.input.borderEnabled}}'));
}
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

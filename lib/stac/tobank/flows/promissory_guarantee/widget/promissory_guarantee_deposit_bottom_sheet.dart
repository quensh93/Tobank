import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'promissory_guarantee_deposit_bottom_sheet')
StacWidget promissoryGuaranteeDepositBottomSheet() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'selectedPromissoryGuaranteeDepositId', 'value': ''},
        {'key': 'promissoryGuaranteeDeposit1Selected', 'value': false},
        {'key': 'promissoryGuaranteeDeposit2Selected', 'value': false},
        {'key': 'promissoryGuaranteeDeposit3Selected', 'value': false},
        {'key': 'hasPromissoryGuaranteeDepositSelection', 'value': false},
      ],
    ),
    child: StacSafeArea(
      top: false,
      bottom: false,
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: const StacBorderRadius.only(topLeft: 18, topRight: 18),
        ),
        child: StacPadding(
          padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 8),
          child: StacColumn(
            mainAxisSize: StacMainAxisSize.max,
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacContainer(
                  width: 44,
                  height: 5,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.input.borderEnabled}}',
                    borderRadius: StacBorderRadius.all(999),
                  ),
                ),
              ),
              StacSizedBox(height: 24),
              StacExpanded(
                child: StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacText(
                        data: 'سپرده خود را جهت ضمانت سفته انتخاب کنید:',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 16),
                      _depositCard(
                        selectedKey: 'promissoryGuaranteeDeposit1Selected',
                        depositId: '144.9966.763020.1',
                        title: 'سپرده سرمایه گذاری کوتاه مدت علیرضا حیدریان',
                        shaba: 'IR9606400144996607630200001',
                        selectionValues: const [
                          {
                            'key': 'promissoryGuaranteeDeposit1Selected',
                            'value': true,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit2Selected',
                            'value': false,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit3Selected',
                            'value': false,
                          },
                        ],
                      ),
                      StacSizedBox(height: 16),
                      _depositCard(
                        selectedKey: 'promissoryGuaranteeDeposit2Selected',
                        depositId: '132.70.763020.1',
                        title:
                            'سپرده حقیقی حساب قرض الحسنه جاری حقیقی، ریالی علیرضا حیدریان',
                        shaba: 'IR9606400132007007630200001',
                        selectionValues: const [
                          {
                            'key': 'promissoryGuaranteeDeposit1Selected',
                            'value': false,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit2Selected',
                            'value': true,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit3Selected',
                            'value': false,
                          },
                        ],
                      ),
                      StacSizedBox(height: 16),
                      _depositCard(
                        selectedKey: 'promissoryGuaranteeDeposit3Selected',
                        depositId: '110.9992.763020.1',
                        title:
                            'سپرده حقیقی سپرده سرمایه گذاری کوتاه مدت-حقیقی ریالی علیرضا حیدریان',
                        shaba: 'IR6206400110999207630200001',
                        selectionValues: const [
                          {
                            'key': 'promissoryGuaranteeDeposit1Selected',
                            'value': false,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit2Selected',
                            'value': false,
                          },
                          {
                            'key': 'promissoryGuaranteeDeposit3Selected',
                            'value': true,
                          },
                        ],
                      ),
                      StacSizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              StacCustomReactiveElevatedButton(
                enabledKey: 'hasPromissoryGuaranteeDepositSelection',
                enabled: false,
                onPressed: StacSequenceAction(
                  actions: [
                    const StacNavigateAction(
                      navigationStyle: NavigationStyle.pop,
                    ),
                    const StacNavigateAction(
                      routeName: 'promissory_guarantee_sign_page',
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  backgroundColor: '#D91F2A',
                  foregroundColor: '#FFFFFF',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                disabledStyle: StacButtonStyle(
                  backgroundColor: '#E8A0A5',
                  foregroundColor: '#FFFFFF',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                child: StacText(
                  data: 'ثبت ضمانت سفته',
                  style: StacTextStyle(
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

StacWidget _depositCard({
  required String selectedKey,
  required String depositId,
  required String title,
  required String shaba,
  required List<Map<String, dynamic>> selectionValues,
}) {
  return StacGestureDetector(
    onTap: StacCustomSetValueAction(
      values: [
        {'key': 'selectedPromissoryGuaranteeDepositId', 'value': depositId},
        ...selectionValues,
        {'key': 'hasPromissoryGuaranteeDepositSelection', 'value': true},
      ],
    ),
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: _depositCardBody(
        title: title,
        depositId: depositId,
        shaba: shaba,
        isSelected: true,
      ).toJson(),
      replacement: _depositCardBody(
        title: title,
        depositId: depositId,
        shaba: shaba,
        isSelected: false,
      ).toJson(),
    ),
  );
}

StacWidget _depositCardBody({
  required String title,
  required String depositId,
  required String shaba,
  required bool isSelected,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: isSelected
            ? '#20C4D8'
            : '{{appColors.current.input.borderEnabled}}',
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
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacExpanded(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacText(
                      data: title,
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                        height: 1.45,
                      ),
                    ),
                    StacSizedBox(height: 16),
                    StacDivider(
                      thickness: 1,
                      color: '{{appColors.current.input.borderEnabled}}',
                    ),
                    StacSizedBox(height: 16),
                    _depositKeyValue('شماره سپرده', depositId),
                    StacSizedBox(height: 12),
                    _depositKeyValue('شماره شبا', shaba),
                  ],
                ),
              ),
              StacPadding(
                padding: StacEdgeInsets.only(top: 2),
                child: _depositRadio(isSelected: isSelected),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

StacWidget _depositRadio({required bool isSelected}) {
  return StacContainer(
    width: 24,
    height: 24,
    decoration: StacBoxDecoration(
      shape: StacBoxShape.circle,
      border: StacBorder.all(
        color: isSelected ? '#20C4D8' : '{{appColors.current.text.subtitle}}',
        width: 2,
      ),
    ),
    child: StacCenter(
      child: StacCustomOpacity(
        opacity: isSelected ? 1 : 0,
        child: StacContainer(
          width: 12,
          height: 12,
          decoration: StacBoxDecoration(
            shape: StacBoxShape.circle,
            color: '#20C4D8',
          ),
        ).toJson(),
      ),
    ),
  );
}

StacWidget _depositKeyValue(String key, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacText(
        data: '$key:',
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 15,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacExpanded(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.left,
          style: StacTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

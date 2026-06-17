import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'deposit_turnover_intro')
StacWidget depositTurnoverIntro() {
  return StacStatefulWidget(
    onInit: showDepositTurnoverBottomSheetAction(),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 26, right: 16, bottom: 24),
        child: StacColumn(
          mainAxisAlignment: StacMainAxisAlignment.center,
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacFilledButton(
              onPressed: StacShowBottomSheetAction(
                title: 'deposit_sort',
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: '#00000000',
                barrierColor: '#8B000000',
                sheet: _buildDepositTurnoverBottomSheet().toJson(),
              ),
              style: StacButtonStyle(
                fixedSize: const StacSize(999999, 48),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10),
                ),
              ),
              child: StacText(
                data:
                    '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.title}}',
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacAction showDepositTurnoverBottomSheetAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'dtFilterLatestSelected', 'value': true},
          {'key': 'dtFilterTimeSelected', 'value': false},
          {
            'key': 'dtFromDate',
            'value':
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_value}}',
          },
          {
            'key': 'dtToDate',
            'value':
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_value_text}}',
          },
        ],
      ),
      StacShowBottomSheetAction(
        title: 'deposit_filter',
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: '#00000000',
        barrierColor: '#8B000000',
        sheet: _buildDepositTurnoverBottomSheet().toJson(),
      ),
    ],
  );
}

StacWidget _buildDepositTurnoverBottomSheet() {
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
              width: 38,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(99),
              ),
            ),
          ),
          StacSizedBox(height: 24),
          StacText(
            data: '{{appStrings.homePage.deposits.quickActions.turnover}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 19,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 20),
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(8),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data:
                      '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.amount_value}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(height: 22),
          StacText(
            data:
                '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.based_on_label}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacRow(
            children: [
              StacExpanded(
                child: _filterOptionCard(
                  label:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.turnover}}',
                  selectedKey: 'dtFilterLatestSelected',
                  onTap: _selectLatestFilterAction(),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: _filterOptionCard(
                  label:
                      '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_range_label}}',
                  selectedKey: 'dtFilterTimeSelected',
                  onTap: _selectTimeRangeFilterAction(),
                ),
              ),
            ],
          ),
          StacCustomVisibility(
            visible: '[[dtFilterTimeSelected]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacSizedBox(height: 14),
                StacRow(
                  children: [
                    StacExpanded(
                      child: StacText(
                        data:
                            '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date_until}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                    StacSizedBox(width: 12),
                    StacExpanded(
                      child: StacText(
                        data:
                            '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.date}}',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                  ],
                ),
                StacSizedBox(height: 8),
                StacRow(
                  children: [
                    StacExpanded(
                      child: _dateFieldCard(
                        value: '{{dtToDate}}',
                        registryKey: 'dtToDate',
                      ),
                    ),
                    StacSizedBox(width: 12),
                    StacExpanded(
                      child: _dateFieldCard(
                        value: '{{dtFromDate}}',
                        registryKey: 'dtFromDate',
                      ),
                    ),
                  ],
                ),
              ],
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          StacSizedBox(height: 22),
          StacFilledButton(
            onPressed: StacCloseDialogAction(
              result: _buildDepositTurnoverFingerPrintAction().toJson(),
            ),
            style: StacButtonStyle(
              fixedSize: const StacSize(999999, 52),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(12),
              ),
            ),
            child: StacText(
              data: '{{appStrings.authentication.confirmAndContinue}}',
              style: StacTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _buildDepositTurnoverFingerPrintAction() {
  return const StacFingerPrintAction(
    title:
        '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.mobile_pin_bank}}',
    description:
        '{{appStrings.generated.child_loan.child_loan_child_check.continue}}',
    onSuccess: {
      'actionType': 'navigate',
      'fileName': 'deposit_turnover_transactions',
      'navMode': 'dart',
      'navigationStyle': 'push',
    },
    onFailure: {
      'actionType': 'showSnackBar',
      'title':
          '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.authentication_failed}}',
      'detail':
          '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.try_again}}',
      'type': 'error',
    },
  );
}

StacAction _selectLatestFilterAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'dtFilterLatestSelected', 'value': true},
      {'key': 'dtFilterTimeSelected', 'value': false},
    ],
  );
}

StacAction _selectTimeRangeFilterAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'dtFilterLatestSelected', 'value': false},
          {'key': 'dtFilterTimeSelected', 'value': true},
        ],
      ),
      _openDepositDateRangePickerAction(),
    ],
  );
}

StacAction _openDepositDateRangePickerAction() {
  return StacRawJsonAction({
    'actionType': 'persianDateRangePicker',
    'startDateKey': 'dtFromDate',
    'endDateKey': 'dtToDate',
    'helpText':
        '{{appStrings.generated.deposit_turnover.deposit_turnover_intro.select}}',
    'confirmText': '{{appStrings.common.confirm}}',
    'cancelText': '{{appStrings.common.cancel}}',
    'firstDate': '1400/01/01',
    'lastDate': '1450/12/29',
  });
}

StacWidget _filterOptionCard({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  return StacCustomVisibility(
    visible: '[[$selectedKey]]',
    child: _selectedFilterOptionCard(label: label, onTap: onTap).toJson(),
    replacement: _unselectedFilterOptionCard(
      label: label,
      onTap: onTap,
    ).toJson(),
  );
}

StacWidget _selectedFilterOptionCard({
  required String label,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.secondary.color}}',
          width: 1.4,
        ),
        color: '{{appColors.current.secondary.secondaryContainer}}',
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: label,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.secondary.color}}',
            ),
          ),
          StacContainer(
            width: 24,
            height: 24,
            decoration: StacBoxDecoration(
              shape: StacBoxShape.circle,
              border: StacBorder.all(
                color: '{{appColors.current.secondary.color}}',
                width: 2,
              ),
            ),
            child: StacCenter(
              child: StacContainer(
                width: 10,
                height: 10,
                decoration: StacBoxDecoration(
                  shape: StacBoxShape.circle,
                  color: '{{appColors.current.secondary.color}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _unselectedFilterOptionCard({
  required String label,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1.4,
        ),
        color: '{{appColors.current.background.surfaceContainer}}',
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: label,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacContainer(
            width: 24,
            height: 24,
            decoration: StacBoxDecoration(
              shape: StacBoxShape.circle,
              border: StacBorder.all(
                color: '{{appColors.current.text.title}}',
                width: 2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _dateFieldCard({
  required String value,
  required String registryKey,
}) {
  return StacGestureDetector(
    onTap: _openDepositDateRangePickerAction(),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15.5),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        textDirection: StacTextDirection.rtl,
        children: [
          StacCustomWidget.fromJson({
            'type': 'registryReactive',
            'registryKey': registryKey,
            'child': StacText(
              data: value,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ).toJson(),
          }),
          StacImage(
            src: '{{appAssets.current.icons.calendar}}',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
  );
}

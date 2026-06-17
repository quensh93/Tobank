import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

@StacScreen(screenName: 'charge_package_list')
StacWidget chargeRealPackageList() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {'key': 'crChargePreset50', 'value': false},
            {'key': 'crChargePreset100', 'value': true},
            {'key': 'crChargePreset200', 'value': false},
            {'key': 'crChargePreset500', 'value': false},
            {'key': 'crChargePreset1000', 'value': false},
            {'key': 'crChargeHasPreset', 'value': true},
            {'key': 'crChargeAmazing', 'value': false},
            {'key': 'crChargeCanToggleAmazing', 'value': true},
            {'key': 'crChargeOptionalMode', 'value': false},
            {'key': 'crChargeOptionalInRange', 'value': false},
            {'key': 'crChargeContinueOptionalValid', 'value': false},
            {'key': 'crChargeShowAmountError', 'value': false},
            {'key': 'crChargeEnteredAmount', 'value': ''},
            {
              'key': 'crChargeSelectedPresetAmount',
              'value':
                  '{{appStrings.generated.charge.charge_package_list.title}}',
            },
          ],
        ),
        _showChargeAmountSheetAction(),
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '{{appStrings.homePage.services.topUp}}',
      ),
      body: StacSafeArea(
        top: false,
        child: StacPadding(
          padding: StacEdgeInsets.only(left: 16, top: 14, right: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data: '{{appStrings.generated.charge.charge_add_sim.title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              StacContainer(
                height: 56,
                padding: StacEdgeInsets.symmetric(horizontal: 12),
                decoration: StacBoxDecoration(
                  borderRadius: StacBorderRadius.all(10),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1,
                  ),
                ),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacImage(
                      src: 'assets/icons/ic_pick_contact.svg',
                      imageType: StacImageType.asset,
                      width: 20,
                      height: 20,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                    StacSizedBox(width: 8),
                    StacExpanded(
                      child: StacText(
                        data: '{{crActiveSimNumber}}',
                        textDirection: StacTextDirection.ltr,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacAction _showChargeAmountSheetAction() {
  return StacShowBottomSheetAction(
    title: 'charge_package',
    backgroundColor: '#8B63708C',
    sheet: _buildChargeAmountSheet().toJson(),
  );
}

StacWidget _buildChargeAmountSheet() {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.only(topLeft: 22, topRight: 22),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacContainer(
            width: 44,
            height: 5,
            decoration: StacBoxDecoration(
              color: '#D0D5DD',
              borderRadius: StacBorderRadius.all(99),
            ),
          ),
        ),
        StacSizedBox(height: 18),
        StacText(
          data:
              '{{appStrings.generated.card_management.card_management_root.amount_topup}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 24,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 18),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: _presetAmountItem(
                label: '{{appStrings.generated.charge.charge_intro.rial}}',
                selectedKey: 'crChargePreset50',
                onTap: _selectPreset('50'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label: '{{appStrings.generated.charge.charge_intro.rial_text}}',
                selectedKey: 'crChargePreset100',
                onTap: _selectPreset('100'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label:
                    '{{appStrings.generated.charge.charge_intro.rial_label}}',
                selectedKey: 'crChargePreset200',
                onTap: _selectPreset('200'),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 10),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: _presetAmountItem(
                label:
                    '{{appStrings.generated.charge.charge_intro.rial_message}}',
                selectedKey: 'crChargePreset500',
                onTap: _selectPreset('500'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label: '{{appStrings.generated.charge.charge_intro.rial_item}}',
                selectedKey: 'crChargePreset1000',
                onTap: _selectPreset('1000'),
              ),
            ),
            StacExpanded(child: StacSizedBox()),
          ],
        ),
        StacSizedBox(height: 12),
        StacCustomVisibility(
          visible: '[[!crChargeAmazing]]',
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCustomTextFormField(
                id: 'crChargeDesiredAmount',
                textDirection: 'rtl',
                textAlign: 'center',
                keyboardType: 'number',
                decoration: {
                  ...StacInputDecoration(
                    hintText:
                        '{{appStrings.generated.charge.charge_intro.amount}}',
                    hintStyle: StacCustomTextStyle(
                      color: '#98A2B3',
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                    ),
                    contentPadding: StacEdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    prefixText: '{{appStrings.common.rial}}',
                    prefixStyle: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                      color: '#98A2B3',
                    ),
                  ).toJson(),
                  'hintTextAlign': 'center',
                  'hintTextDirection': 'rtl',
                  'counterText': '',
                },
                onChanged: _onDesiredAmountChanged(),
              ),
              StacCustomVisibility(
                visible: '[[crChargeShowAmountError]]',
                child: StacPadding(
                  padding: StacEdgeInsets.only(top: 8, right: 6),
                  child: StacText(
                    data:
                        '{{appStrings.generated.charge.charge_intro.amount_topup_enter}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 13,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.feedback.error}}',
                    ),
                  ),
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ],
          ).toJson(),
          replacement: StacSizedBox().toJson(),
        ),
        StacSizedBox(height: 14),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: '{{appStrings.generated.charge.charge_intro.topup_text}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacExpanded(child: StacSizedBox()),
            StacCustomVisibility(
              visible: '[[crChargeCanToggleAmazing]]',
              child: StacCustomReactiveSwitch(
                valueKey: 'crChargeAmazing',
                initialValue: false,
                scale: 0.85,
                activeColor: '#20C4D8',
                onChanged: _onAmazingChanged(),
              ).toJson(),
              replacement: StacContainer(
                width: 48,
                height: 28,
                decoration: StacBoxDecoration(
                  color: '#EAECF0',
                  borderRadius: StacBorderRadius.all(16),
                ),
                child: StacAlign(
                  alignment: StacAlignmentDirectional.centerStart,
                  child: StacContainer(
                    margin: StacEdgeInsets.only(left: 3, right: 3),
                    width: 22,
                    height: 22,
                    decoration: StacBoxDecoration(
                      color: '#C4C4C4',
                      shape: StacBoxShape.circle,
                    ),
                  ),
                ),
              ).toJson(),
            ),
          ],
        ),
        StacSizedBox(height: 18),
        StacCustomVisibility(
          visible: '[[crChargeOptionalMode]]',
          child: StacCustomVisibility(
            visible: '[[crChargeContinueOptionalValid]]',
            child: _continueButton(
              onPressed: _optionalContinueAction(),
            ).toJson(),
            replacement: _continueButton(
              onPressed: const StacCustomSetValueAction(
                key: 'crChargeShowAmountError',
                value: true,
              ),
            ).toJson(),
          ).toJson(),
          replacement: _continueButton(
            onPressed: _presetContinueAction(),
          ).toJson(),
        ),
      ],
    ),
  );
}

StacWidget _presetAmountItem({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        height: 54,
        alignment: StacAlignment.center,
        decoration: StacBoxDecoration(
          color: '#EAFBFD',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        height: 54,
        alignment: StacAlignment.center,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ).toJson(),
    ),
  );
}

StacAction _selectPreset(String preset) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crChargePreset50', 'value': preset == '50'},
      {'key': 'crChargePreset100', 'value': preset == '100'},
      {'key': 'crChargePreset200', 'value': preset == '200'},
      {'key': 'crChargePreset500', 'value': preset == '500'},
      {'key': 'crChargePreset1000', 'value': preset == '1000'},
      {'key': 'crChargeHasPreset', 'value': true},
      {'key': 'crChargeOptionalMode', 'value': false},
      {'key': 'crChargeShowAmountError', 'value': false},
      {'key': 'crChargeCanToggleAmazing', 'value': true},
      {'key': 'crChargeContinueOptionalValid', 'value': false},
      {
        'key': 'crChargeSelectedPresetAmount',
        'value':
            '{{appStrings.generated.charge.charge_package_list.amount_value}}',
        'condition': 'crChargePreset50',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '{{appStrings.generated.charge.charge_package_list.title}}',
        'condition': 'crChargePreset100',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value':
            '{{appStrings.generated.charge.charge_package_list.amount_value_text}}',
        'condition': 'crChargePreset200',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value':
            '{{appStrings.generated.charge.charge_package_list.amount_value_label}}',
        'condition': 'crChargePreset500',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value':
            '{{appStrings.generated.charge.charge_package_list.amount_value_message}}',
        'condition': 'crChargePreset1000',
      },
    ],
  );
}

StacAction _onDesiredAmountChanged() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'crChargeOptionalMode', 'value': true},
          {'key': 'crChargeHasPreset', 'value': false},
          {'key': 'crChargePreset50', 'value': false},
          {'key': 'crChargePreset100', 'value': false},
          {'key': 'crChargePreset200', 'value': false},
          {'key': 'crChargePreset500', 'value': false},
          {'key': 'crChargePreset1000', 'value': false},
          {'key': 'crChargeCanToggleAmazing', 'value': false},
          {'key': 'crChargeAmazing', 'value': false},
          {'key': 'crChargeShowAmountError', 'value': false},
          {'key': 'crChargeContinueOptionalValid', 'value': false},
        ],
      ),
      StacCustomSetValueAction(
        key: 'crChargeEnteredAmount',
        value: StacGetFormValueAction(id: 'crChargeDesiredAmount'),
      ),
      const StacValidateFieldsAction(
        resultKey: 'crChargeOptionalInRange',
        fields: [
          {'id': 'crChargeDesiredAmount', 'rule': r'^[0-9۰-۹٠-٩,٬]+$'},
        ],
      ),
      const StacCustomSetValueAction(
        values: [
          {
            'key': 'crChargeContinueOptionalValid',
            'value': true,
            'condition': 'crChargeOptionalInRange',
          },
          {
            'key': 'crChargeShowAmountError',
            'value': true,
            'condition': '!crChargeOptionalInRange',
          },
        ],
      ),
    ],
  );
}

StacAction _onAmazingChanged() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'crChargeHasPreset', 'value': false},
      {'key': 'crChargeOptionalMode', 'value': false},
      {'key': 'crChargeShowAmountError', 'value': false},
      {'key': 'crChargePreset50', 'value': false},
      {'key': 'crChargePreset100', 'value': false},
      {'key': 'crChargePreset200', 'value': false},
      {'key': 'crChargePreset500', 'value': false},
      {'key': 'crChargePreset1000', 'value': false},
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '{{appStrings.generated.charge.charge_package_list.title}}',
      },
    ],
  );
}

StacAction _presetContinueAction() {
  return const StacSequenceAction(
    actions: [
      StacNavigateAction(navigationStyle: NavigationStyle.pop),
      StacCustomSetValueAction(
        values: [
          {
            'key': 'crPkgSelectedAmount',
            'value': '{{crChargeSelectedPresetAmount}}',
          },
          {
            'key': 'crPkgSelectedName',
            'value':
                '{{appStrings.generated.charge.charge_package_list.topup}}',
          },
        ],
      ),
      NavigationAction(
        fileName: 'charge_payment',
        navMode: NavModes.dart,
        navigationStyle: NavigationStyle.push,
      ),
    ],
  );
}

StacAction _optionalContinueAction() {
  return const StacSequenceAction(
    actions: [
      StacNavigateAction(navigationStyle: NavigationStyle.pop),
      StacCustomSetValueAction(
        values: [
          {'key': 'crPkgSelectedAmount', 'value': '{{crChargeEnteredAmount}}'},
          {
            'key': 'crPkgSelectedName',
            'value':
                '{{appStrings.generated.charge.charge_package_list.topup}}',
          },
        ],
      ),
      NavigationAction(
        fileName: 'charge_payment',
        navMode: NavModes.dart,
        navigationStyle: NavigationStyle.push,
      ),
    ],
  );
}

StacWidget _continueButton({required StacAction onPressed}) {
  return StacFilledButton(
    onPressed: onPressed,
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      backgroundColor: '{{appColors.current.primary.color}}',
      foregroundColor: '{{appColors.current.primary.onPrimary}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
      elevation: 0,
    ),
    child: StacText(
      data: '{{appStrings.authentication.confirmAndContinue}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.primary.onPrimary}}',
      ),
    ),
  );
}

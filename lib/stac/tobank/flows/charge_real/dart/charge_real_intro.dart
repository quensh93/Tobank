import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/charge_real/dart/widgets/charge_real_widgets.dart';

@StacScreen(screenName: 'charge_real_intro')
StacWidget chargeRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {
          'key': 'crSimHasItems',
          'value': true,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSimShowDuplicateBanner',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crSim1Visible',
          'value': true,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim1Number',
          'value': '09124764369',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim1Operator',
          'value': 'همراه اول',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim1Logo',
          'value': 'assets/icons/ic_hamrah_aval.svg',
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crSim2Visible',
          'value': true,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim2Number',
          'value': '09102311173',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim2Operator',
          'value': 'همراه اول',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim2Logo',
          'value': 'assets/icons/ic_hamrah_aval.svg',
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crSim3Visible',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim3Number',
          'value': '09198747874',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim3Operator',
          'value': 'ایرانسل',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim3Logo',
          'value': 'assets/icons/ic_irancell.svg',
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crSim1Selected',
          'value': true,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim2Selected',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSim3Selected',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crActiveSimNumber',
          'value': '09124764369',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crActiveSimOperator',
          'value': 'همراه اول',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crActiveSimLogo',
          'value': 'assets/icons/ic_hamrah_aval.svg',
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crSheetTargetSim1',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSheetTargetSim2',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSheetTargetSim3',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSheetOperator',
          'value': 'همراه اول',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSheetNumber',
          'value': '09124764369',
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crSheetLogo',
          'value': 'assets/icons/ic_hamrah_aval.svg',
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crShowSimActionSheet',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crShowSimEditSheet',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },
        {
          'key': 'crShowSimDeleteDialog',
          'value': false,
          'condition': '!crChargeFlowInitialized',
        },

        {
          'key': 'crChargeFlowInitialized',
          'value': true,
          'condition': '!crChargeFlowInitialized',
        },
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: 'شارژ',
      ),
      body: StacStack(
        children: [
          StacSafeArea(
            child: StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  StacSizedBox(height: 24),
                  StacText(
                    data: 'سیم‌کارت‌ها',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.right,
                    style: StacCustomTextStyle(
                      fontSize: 21,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),
                  StacExpanded(
                    child: StacCustomVisibility(
                      visible: '[[crSimHasItems]]',
                      child: StacSingleChildScrollView(
                        child: StacColumn(
                          crossAxisAlignment: StacCrossAxisAlignment.stretch,
                          children: [
                            StacCustomVisibility(
                              visible: '[[crSimShowDuplicateBanner]]',
                              child: StacPadding(
                                padding: StacEdgeInsets.only(bottom: 18),
                                child: buildChargeRealDuplicateBanner(),
                              ).toJson(),
                              replacement: StacSizedBox().toJson(),
                            ),
                            StacCustomRegistryReactive(
                              child: StacColumn(
                                crossAxisAlignment:
                                    StacCrossAxisAlignment.stretch,
                                children: [
                                  _buildSimCard(
                                    visibleKey: 'crSim1Visible',
                                    selectedKey: 'crSim1Selected',
                                    operatorValue: '{{crSim1Operator}}',
                                    numberValue: '{{crSim1Number}}',
                                    logoValue: '{{crSim1Logo}}',
                                    longPressAction: _showSimActionsFor(
                                      operator: '{{crSim1Operator}}',
                                      number: '{{crSim1Number}}',
                                      logo: '{{crSim1Logo}}',
                                      isTarget1: true,
                                    ),
                                    selectAction: _openPackageFlow(
                                      index: 1,
                                      number: '{{crSim1Number}}',
                                      operator: '{{crSim1Operator}}',
                                      logo: '{{crSim1Logo}}',
                                    ),
                                  ),
                                  _buildSimCard(
                                    visibleKey: 'crSim2Visible',
                                    selectedKey: 'crSim2Selected',
                                    operatorValue: '{{crSim2Operator}}',
                                    numberValue: '{{crSim2Number}}',
                                    logoValue: '{{crSim2Logo}}',
                                    longPressAction: _showSimActionsFor(
                                      operator: '{{crSim2Operator}}',
                                      number: '{{crSim2Number}}',
                                      logo: '{{crSim2Logo}}',
                                      isTarget2: true,
                                    ),
                                    selectAction: _openPackageFlow(
                                      index: 2,
                                      number: '{{crSim2Number}}',
                                      operator: '{{crSim2Operator}}',
                                      logo: '{{crSim2Logo}}',
                                    ),
                                  ),
                                  _buildSimCard(
                                    visibleKey: 'crSim3Visible',
                                    selectedKey: 'crSim3Selected',
                                    operatorValue: '{{crSim3Operator}}',
                                    numberValue: '{{crSim3Number}}',
                                    logoValue: '{{crSim3Logo}}',
                                    longPressAction: _showSimActionsFor(
                                      operator: '{{crSim3Operator}}',
                                      number: '{{crSim3Number}}',
                                      logo: '{{crSim3Logo}}',
                                      isTarget3: true,
                                    ),
                                    selectAction: _openPackageFlow(
                                      index: 3,
                                      number: '{{crSim3Number}}',
                                      operator: '{{crSim3Operator}}',
                                      logo: '{{crSim3Logo}}',
                                    ),
                                  ),
                                ],
                              ).toJson(),
                            ),
                          ],
                        ),
                      ).toJson(),
                      replacement: StacCenter(
                        child: StacColumn(
                          mainAxisSize: StacMainAxisSize.min,
                          children: [
                            StacImage(
                              src:
                                  'assets/icons/ic_charge_empty_list_light.svg',
                              imageType: StacImageType.asset,
                              width: 106,
                              height: 106,
                              fit: StacBoxFit.contain,
                            ),
                            StacSizedBox(height: 24),
                            StacText(
                              data: 'شارژی نخریده‌اید',
                              textDirection: StacTextDirection.rtl,
                              textAlign: StacTextAlign.center,
                              style: StacCustomTextStyle(
                                fontSize: 18,
                                fontWeight: StacFontWeight.w500,
                                color: '{{appColors.current.text.title}}',
                              ),
                            ),
                            StacSizedBox(height: 8),
                            StacText(
                              data: 'اولین شارژ خود را بخرید',
                              textDirection: StacTextDirection.rtl,
                              textAlign: StacTextAlign.center,
                              style: StacCustomTextStyle(
                                fontSize: 18,
                                fontWeight: StacFontWeight.w500,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                          ],
                        ),
                      ).toJson(),
                    ),
                  ),
                  StacSizedBox(height: 12),
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.center,
                    children: [
                      buildChargeRealAddButton(
                        routeName: 'charge_real_add_sim',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          StacCustomVisibility(
            visible: '[[crShowSimDeleteDialog]]',
            child: _buildDeleteDialogOverlay().toJson(),
            replacement: StacSizedBox().toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildSimCard({
  required String visibleKey,
  required String selectedKey,
  required String operatorValue,
  required String numberValue,
  required String logoValue,
  required StacAction longPressAction,
  required StacAction selectAction,
}) {
  return StacCustomVisibility(
    visible: '[[$visibleKey]]',
    child: StacPadding(
      padding: StacEdgeInsets.only(bottom: 10),
      child: buildChargeRealSimCardItem(
        operatorName: operatorValue,
        number: numberValue,
        logo: logoValue,
        useFilledCardVisible: '[[$selectedKey]]',
        onTap: selectAction,
        onLongPress: longPressAction,
      ),
    ).toJson(),
    replacement: StacSizedBox().toJson(),
  );
}

StacAction _openPackageFlow({
  required int index,
  required String number,
  required String operator,
  required String logo,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'crSim1Selected', 'value': index == 1},
          {'key': 'crSim2Selected', 'value': index == 2},
          {'key': 'crSim3Selected', 'value': index == 3},
          {'key': 'crActiveSimNumber', 'value': number},
          {'key': 'crActiveSimOperator', 'value': operator},
          {'key': 'crActiveSimLogo', 'value': logo},
          {'key': 'crSimShowDuplicateBanner', 'value': false},
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
          {'key': 'crChargeSelectedPresetAmount', 'value': '۱۰۰,۰۰۰'},
        ],
      ),
      _showChargeAmountSheetAction(),
    ],
  );
}

StacAction _showChargeAmountSheetAction() {
  return StacShowBottomSheetAction(
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
          data: 'مبلغ شارژ',
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
                label: '۵۰,۰۰۰ ریال',
                selectedKey: 'crChargePreset50',
                onTap: _selectPreset('50'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label: '۱۰۰,۰۰۰ ریال',
                selectedKey: 'crChargePreset100',
                onTap: _selectPreset('100'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label: '۲۰۰,۰۰۰ ریال',
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
                label: '۵۰۰,۰۰۰ ریال',
                selectedKey: 'crChargePreset500',
                onTap: _selectPreset('500'),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: _presetAmountItem(
                label: '۱,۰۰۰,۰۰۰ ریال',
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
                    hintText: 'مبلغ دلخواه',
                    hintStyle: StacCustomTextStyle(
                      color: '#98A2B3',
                      fontSize: 16,
                      fontWeight: StacFontWeight.w500,
                    ),
                    contentPadding: StacEdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    prefixText: 'ریال',
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
                    data: 'مبلغ شارژ را وارد کنید.',
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
              data: 'شارژ شگفت انگیز',
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
        'value': '۵۰,۰۰۰',
        'condition': 'crChargePreset50',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '۱۰۰,۰۰۰',
        'condition': 'crChargePreset100',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '۲۰۰,۰۰۰',
        'condition': 'crChargePreset200',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '۵۰۰,۰۰۰',
        'condition': 'crChargePreset500',
      },
      {
        'key': 'crChargeSelectedPresetAmount',
        'value': '۱,۰۰۰,۰۰۰',
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
      {'key': 'crChargeSelectedPresetAmount', 'value': '۱۰۰,۰۰۰'},
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
          {'key': 'crPkgSelectedName', 'value': 'شارژ {{crActiveSimOperator}}'},
        ],
      ),
      StacNavigateAction(
        routeName: 'charge_real_payment',
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
          {'key': 'crPkgSelectedName', 'value': 'شارژ {{crActiveSimOperator}}'},
        ],
      ),
      StacNavigateAction(
        routeName: 'charge_real_payment',
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
      data: 'تایید و ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.primary.onPrimary}}',
      ),
    ),
  );
}

StacAction _showSimActionsFor({
  required String operator,
  required String number,
  required String logo,
  bool isTarget1 = false,
  bool isTarget2 = false,
  bool isTarget3 = false,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': 'crSheetTargetSim1', 'value': isTarget1},
          {'key': 'crSheetTargetSim2', 'value': isTarget2},
          {'key': 'crSheetTargetSim3', 'value': isTarget3},
          {'key': 'crSheetOperator', 'value': operator},
          {'key': 'crSheetNumber', 'value': number},
          {'key': 'crSheetLogo', 'value': logo},
          {'key': 'crShowSimDeleteDialog', 'value': false},
        ],
      ),
      _showSimActionSheetAction(),
    ],
  );
}

StacAction _showSimActionSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildActionSheet().toJson(),
  );
}

StacAction _showSimEditSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildEditSheet().toJson(),
  );
}

StacWidget _buildActionSheet() {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 14, top: 10, right: 14, bottom: 16),
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
        StacSizedBox(height: 20),
        StacText(
          data: '{{crSheetOperator}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 24,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 6),
        StacText(
          data: '{{crSheetNumber}}',
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 18),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacGestureDetector(
          onTap: StacSequenceAction(
            actions: [
              const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              _showSimEditSheetAction(),
            ],
          ),
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(vertical: 14),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacIcon(
                  icon: 'edit_outlined',
                  size: 22,
                  color: '{{appColors.current.text.title}}',
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: 'ویرایش',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
        ),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacGestureDetector(
          onTap: const StacSequenceAction(
            actions: [
              StacNavigateAction(navigationStyle: NavigationStyle.pop),
              StacCustomSetValueAction(
                values: [
                  {'key': 'crShowSimDeleteDialog', 'value': true},
                ],
              ),
            ],
          ),
          child: StacPadding(
            padding: StacEdgeInsets.symmetric(vertical: 14),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacIcon(icon: 'delete_outline', size: 25, color: '#E31D35'),
                StacSizedBox(width: 8),
                StacText(
                  data: 'حذف کردن',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w500,
                    color: '#E31D35',
                  ),
                ),
              ],
            ),
          ),
        ),
        StacSizedBox(height: 12),
        StacFilledButton(
          onPressed: const StacNavigateAction(
            navigationStyle: NavigationStyle.pop,
          ),
          style: StacButtonStyle(
            fixedSize: StacSize(999999, 56),
            backgroundColor: '{{appColors.current.primary.color}}',
            foregroundColor: '{{appColors.current.primary.onPrimary}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(10),
            ),
            elevation: 0,
          ),
          child: StacText(
            data: 'انصراف',
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
  );
}

StacWidget _buildEditSheet() {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 14, top: 10, right: 14, bottom: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.only(topLeft: 22, topRight: 22),
    ),
    child: StacForm(
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
          StacSizedBox(height: 20),
          StacCenter(
            child: StacContainer(
              width: 56,
              height: 56,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(28),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: '{{crSheetLogo}}',
                  imageType: StacImageType.asset,
                  width: 36,
                  height: 23,
                  fit: StacBoxFit.contain,
                ),
              ),
            ),
          ),
          StacSizedBox(height: 12),
          StacText(
            data: '{{crSheetNumber}}',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 14),
          StacCustomTextFormField(
            id: 'crEditOperatorField',
            textDirection: 'rtl',
            textAlign: 'center',
            initialValue: '{{crSheetOperator}}',
            maxLength: 20,
            decoration: StacInputDecoration(
              filled: false,
              contentPadding: StacEdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ).toJson(),
          ),
          StacSizedBox(height: 12),
          StacFilledButton(
            onPressed: StacSequenceAction(
              actions: [
                const StacCustomSetValueAction(
                  values: [
                    {
                      'key': 'crSim1Operator',
                      'value': StacGetFormValueAction(
                        id: 'crEditOperatorField',
                      ),
                      'condition': 'crSheetTargetSim1',
                    },
                    {
                      'key': 'crSim2Operator',
                      'value': StacGetFormValueAction(
                        id: 'crEditOperatorField',
                      ),
                      'condition': 'crSheetTargetSim2',
                    },
                    {
                      'key': 'crSim3Operator',
                      'value': StacGetFormValueAction(
                        id: 'crEditOperatorField',
                      ),
                      'condition': 'crSheetTargetSim3',
                    },
                    {
                      'key': 'crSheetOperator',
                      'value': StacGetFormValueAction(
                        id: 'crEditOperatorField',
                      ),
                    },
                  ],
                ),
                const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              ],
            ),
            style: StacButtonStyle(
              fixedSize: StacSize(999999, 56),
              backgroundColor: '{{appColors.current.primary.color}}',
              foregroundColor: '{{appColors.current.primary.onPrimary}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
              elevation: 0,
            ),
            child: StacText(
              data: 'ذخیره',
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
  );
}

StacWidget _buildDeleteDialogOverlay() {
  return StacStack(
    children: [
      StacContainer(width: 999999, height: 999999, color: '#8B63708C'),
      StacCenter(
        child: StacContainer(
          margin: StacEdgeInsets.symmetric(horizontal: 18),
          padding: StacEdgeInsets.only(
            left: 14,
            top: 16,
            right: 14,
            bottom: 14,
          ),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surface}}',
            borderRadius: StacBorderRadius.all(14),
          ),
          child: StacColumn(
            mainAxisSize: StacMainAxisSize.min,
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacContainer(
                  width: 56,
                  height: 56,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surfaceContainer}}',
                    borderRadius: StacBorderRadius.all(28),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacCenter(
                    child: StacImage(
                      src: '{{crSheetLogo}}',
                      imageType: StacImageType.asset,
                      width: 36,
                      height: 23,
                      fit: StacBoxFit.contain,
                    ),
                  ),
                ),
              ),
              StacSizedBox(height: 12),
              StacText(
                data: '{{crSheetNumber}}',
                textDirection: StacTextDirection.ltr,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 12),
              StacText(
                data: 'پس از تایید، سیم‌کارت از لیست حذف خواهد شد.',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.center,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              StacRow(
                children: [
                  StacExpanded(
                    child: StacOutlinedButton(
                      onPressed: const StacCustomSetValueAction(
                        values: [
                          {'key': 'crShowSimDeleteDialog', 'value': false},
                        ],
                      ),
                      style: StacButtonStyle(
                        fixedSize: StacSize(999999, 52),
                        side: StacBorderSide(
                          color: '{{appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(10),
                        ),
                      ),
                      child: StacText(
                        data: 'انصراف',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                  ),
                  StacSizedBox(width: 10),
                  StacExpanded(
                    child: StacFilledButton(
                      onPressed: const StacCustomSetValueAction(
                        values: [
                          {
                            'key': 'crSim1Visible',
                            'value': false,
                            'condition': 'crSheetTargetSim1',
                          },
                          {
                            'key': 'crSim2Visible',
                            'value': false,
                            'condition': 'crSheetTargetSim2',
                          },
                          {
                            'key': 'crSim3Visible',
                            'value': false,
                            'condition': 'crSheetTargetSim3',
                          },
                          {
                            'key': 'crSim1Selected',
                            'value': false,
                            'condition': 'crSheetTargetSim1',
                          },
                          {
                            'key': 'crSim2Selected',
                            'value': false,
                            'condition': 'crSheetTargetSim2',
                          },
                          {
                            'key': 'crSim3Selected',
                            'value': false,
                            'condition': 'crSheetTargetSim3',
                          },
                          {'key': 'crSimHasItems', 'value': false},
                          {
                            'key': 'crSimHasItems',
                            'value': true,
                            'condition': 'crSim1Visible',
                          },
                          {
                            'key': 'crSimHasItems',
                            'value': true,
                            'condition': 'crSim2Visible',
                          },
                          {
                            'key': 'crSimHasItems',
                            'value': true,
                            'condition': 'crSim3Visible',
                          },
                          {'key': 'crShowSimDeleteDialog', 'value': false},
                          {'key': 'crShowSimActionSheet', 'value': false},
                          {'key': 'crShowSimEditSheet', 'value': false},
                          {'key': 'crSimShowDuplicateBanner', 'value': false},
                        ],
                      ),
                      style: StacButtonStyle(
                        fixedSize: StacSize(999999, 52),
                        backgroundColor: '{{appColors.current.primary.color}}',
                        foregroundColor:
                            '{{appColors.current.primary.onPrimary}}',
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(10),
                        ),
                        elevation: 0,
                      ),
                      child: StacText(
                        data: 'حذف کردن',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.primary.onPrimary}}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

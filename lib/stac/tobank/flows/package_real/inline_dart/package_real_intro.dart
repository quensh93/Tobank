import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/package_real/dart/widgets/package_real_widgets.dart';

@StacScreen(screenName: 'package_real_intro')
StacWidget packageRealIntro() {
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
        title: 'اینترنت',
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
                                child: buildPackageRealDuplicateBanner(),
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
                              data: 'بسته‌ی اینترنتی نخریده‌اید',
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
                              data: 'اولین بسته اینترنت خود را بخرید',
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
                      buildPackageRealAddButton(
                        routeName: 'package_real_add_sim',
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
      child: buildPackageRealSimCardItem(
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
        ],
      ),
      const StacNavigateAction(
        routeName: 'package_real_package_list',
        navigationStyle: NavigationStyle.push,
      ),
    ],
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

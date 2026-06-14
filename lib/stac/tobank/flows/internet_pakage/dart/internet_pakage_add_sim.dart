import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'internet_pakage_add_sim')
StacWidget packageRealAddSim() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'crAddCanContinue', 'value': false},
        {'key': 'crAddEnteredPhone', 'value': ''},
        {'key': 'crAddIsValidPrefix', 'value': false},
        {'key': 'crAddIsUnsupported', 'value': false},
        {'key': 'crAddIsDuplicate', 'value': false},
        {'key': 'crAddIs0920', 'value': false},
        {'key': 'crAddIsMci', 'value': false},
        {'key': 'crAddCaseUnsupported', 'value': false},
        {'key': 'crAddCaseDuplicate', 'value': false},
        {'key': 'crAddCaseNormal', 'value': false},
        {'key': 'crAddCasePorted', 'value': false},
        {'key': 'crAddCaseInvalidAction', 'value': false},
        {'key': 'crAddShowInvalidError', 'value': false},
        {'key': 'crAddShowUnsupportedError', 'value': false},
        {'key': 'crAddShowDuplicateDialog', 'value': false},
        {'key': 'crAddShowOperatorSheet', 'value': false},
        {'key': 'crAddShowSimTypeSheet', 'value': false},
        {'key': 'crAddOpMciSel', 'value': false},
        {'key': 'crAddOpIrancellSel', 'value': false},
        {'key': 'crAddOpRightelSel', 'value': true},
        {'key': 'crAddTypePermanentSel', 'value': true},
        {'key': 'crAddTypeCreditSel', 'value': false},
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
            top: false,
            bottom: true,
            child: StacForm(
              autovalidateMode: StacAutovalidateMode.onUserInteraction,
              child: StacColumn(
                children: [
                  StacExpanded(
                    child: StacSingleChildScrollView(
                      padding: StacEdgeInsets.only(
                        left: 16,
                        top: 14,
                        right: 16,
                      ),
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacText(
                            data: 'شماره سیم کارت را وارد کنید',
                            textDirection: StacTextDirection.rtl,
                            textAlign: StacTextAlign.right,
                            style: StacCustomTextStyle(
                              fontSize: 18,
                              fontWeight: StacFontWeight.w700,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 18),
                          StacCustomRegistryReactive(
                            child: StacCustomTextFormField(
                              id: 'crAddPhone',
                              textDirection: 'ltr',
                              textAlign: 'center',
                              maxLength: 11,
                              inputFormatters: const [
                                {'type': 'allow', 'rule': '[0-9]'},
                              ],
                              decoration: {
                                ...StacInputDecoration(
                                  hintText: '09123456789',
                                  hintStyle: StacCustomTextStyle(
                                    color: '#98A2B3',
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w500,
                                  ),
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  prefixIcon: StacPadding(
                                    padding: StacEdgeInsets.only(
                                      left: 12,
                                      right: 8,
                                    ),
                                    child: StacGestureDetector(
                                      onTap: StacPickContactPhoneAction(
                                        formFieldId: 'crAddPhone',
                                        targetKey: 'crAddEnteredPhone',
                                        onContactSelected:
                                            _addValidationAction(),
                                        permissionDeniedMessage:
                                            'دسترسی مخاطبین مجاز نیست',
                                        invalidMobileMessage:
                                            'شماره همراه معتبر در مخاطب یافت نشد',
                                      ),
                                      child: StacImage(
                                        src: 'assets/icons/ic_pick_contact.svg',
                                        imageType: StacImageType.asset,
                                        width: 20,
                                        height: 20,
                                        color:
                                            '{{appColors.current.text.subtitle}}',
                                      ),
                                    ),
                                  ),
                                ).toJson(),
                                'counterText': '',
                              },
                              keyboardType: 'number',
                              textInputAction: 'done',
                              onChanged: _addValidationAction(),
                            ).toJson(),
                          ),
                          StacCustomVisibility(
                            visible: '[[crAddShowInvalidError]]',
                            child: StacPadding(
                              padding: StacEdgeInsets.only(top: 8, right: 6),
                              child: StacText(
                                data: 'شماره همراه نامعتبر است',
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
                          StacCustomVisibility(
                            visible: '[[crAddShowUnsupportedError]]',
                            child: StacPadding(
                              padding: StacEdgeInsets.only(top: 8, right: 6),
                              child: StacText(
                                data: 'اپراتور مورد نظر پشتیبانی نمی‌شود',
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
                      ),
                    ),
                  ),
                  _buildDisabledContinueButton(),
                  _buildCaseContinueButton(
                    visibleKey: 'crAddCaseNormal',
                    onPressed: _normalContinueAction(),
                  ),
                  _buildCaseContinueButton(
                    visibleKey: 'crAddCaseDuplicate',
                    onPressed: _duplicateContinueAction(),
                  ),
                  _buildCaseContinueButton(
                    visibleKey: 'crAddCasePorted',
                    onPressed: _portedContinueAction(),
                  ),
                  _buildCaseContinueButton(
                    visibleKey: 'crAddCaseUnsupported',
                    onPressed: _unsupportedContinueAction(),
                  ),
                  _buildCaseContinueButton(
                    visibleKey: 'crAddCaseInvalidAction',
                    onPressed: _invalidContinueAction(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacAction _addValidationAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'crAddShowInvalidError', 'value': false},
          {'key': 'crAddShowUnsupportedError', 'value': false},
          {'key': 'crAddCaseUnsupported', 'value': false},
          {'key': 'crAddCaseDuplicate', 'value': false},
          {'key': 'crAddCaseNormal', 'value': false},
          {'key': 'crAddCasePorted', 'value': false},
          {'key': 'crAddCaseInvalidAction', 'value': false},
          {'key': 'crAddShowDuplicateDialog', 'value': false},
          {'key': 'crAddShowOperatorSheet', 'value': false},
          {'key': 'crAddShowSimTypeSheet', 'value': false},
        ],
      ),
      StacCustomSetValueAction(
        key: 'crAddEnteredPhone',
        value: StacGetFormValueAction(id: 'crAddPhone'),
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddCanContinue',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^09\d{9}$'},
        ],
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddIsValidPrefix',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^09\d{9}$'},
        ],
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddIs0920',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^0920\d{7}$'},
        ],
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddIsMci',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^091(0|2)\d{7}$'},
        ],
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddIsUnsupported',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^092[1-9]\d{7}$'},
        ],
      ),
      const StacValidateFieldsAction(
        resultKey: 'crAddIsDuplicate',
        fields: [
          {'id': 'crAddPhone', 'rule': r'^(09124764369|09102311173)$'},
        ],
      ),
      const StacCustomSetValueAction(
        values: [
          {
            'key': 'crAddCaseUnsupported',
            'value': true,
            'condition': 'crAddIsUnsupported',
          },
          {
            'key': 'crAddCaseDuplicate',
            'value': true,
            'condition': 'crAddIsDuplicate',
          },
          {'key': 'crAddCasePorted', 'value': true, 'condition': 'crAddIs0920'},
          {
            'key': 'crAddCaseNormal',
            'value': true,
            'condition': 'crAddIsValidPrefix',
          },
          {
            'key': 'crAddCaseNormal',
            'value': false,
            'condition': 'crAddIsUnsupported',
          },
          {
            'key': 'crAddCaseNormal',
            'value': false,
            'condition': 'crAddIsDuplicate',
          },
          {
            'key': 'crAddCaseNormal',
            'value': false,
            'condition': 'crAddIs0920',
          },
          {
            'key': 'crAddCaseInvalidAction',
            'value': true,
            'condition': 'crAddCanContinue',
          },
          {
            'key': 'crAddCaseInvalidAction',
            'value': false,
            'condition': 'crAddCaseUnsupported',
          },
          {
            'key': 'crAddCaseInvalidAction',
            'value': false,
            'condition': 'crAddCaseDuplicate',
          },
          {
            'key': 'crAddCaseInvalidAction',
            'value': false,
            'condition': 'crAddCaseNormal',
          },
          {
            'key': 'crAddCaseInvalidAction',
            'value': false,
            'condition': 'crAddCasePorted',
          },
        ],
      ),
    ],
  );
}

StacAction _normalContinueAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'crSimHasItems', 'value': true},
          {'key': 'crSimShowDuplicateBanner', 'value': false},
          {'key': 'crSim3Visible', 'value': true},
          {'key': 'crSim3Operator', 'value': 'ایرانسل'},
          {'key': 'crSim3Logo', 'value': 'assets/icons/ic_irancell.svg'},
          {'key': 'crSim1Selected', 'value': false},
          {'key': 'crSim2Selected', 'value': false},
          {'key': 'crSim3Selected', 'value': true},
          {'key': 'crActiveSimOperator', 'value': 'ایرانسل'},
          {'key': 'crActiveSimLogo', 'value': 'assets/icons/ic_irancell.svg'},
          {
            'key': 'crSim3Operator',
            'value': 'همراه اول',
            'condition': 'crAddIsMci',
          },
          {
            'key': 'crSim3Logo',
            'value': 'assets/icons/ic_hamrah_aval.svg',
            'condition': 'crAddIsMci',
          },
          {
            'key': 'crActiveSimOperator',
            'value': 'همراه اول',
            'condition': 'crAddIsMci',
          },
          {
            'key': 'crActiveSimLogo',
            'value': 'assets/icons/ic_hamrah_aval.svg',
            'condition': 'crAddIsMci',
          },
          {'key': 'crShowSimActionSheet', 'value': false},
          {'key': 'crShowSimEditSheet', 'value': false},
          {'key': 'crShowSimDeleteDialog', 'value': false},
          {'key': 'crAddShowInvalidError', 'value': false},
          {'key': 'crAddShowUnsupportedError', 'value': false},
        ],
      ),
      const StacCustomSetValueAction(
        key: 'crSim3Number',
        value: '{{crAddEnteredPhone}}',
      ),
      const StacCustomSetValueAction(
        key: 'crActiveSimNumber',
        value: '{{crAddEnteredPhone}}',
      ),
      NavigationAction(fileName: 'internet_pakage_list', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
    ],
  );
}

StacAction _portedContinueAction() {
  return _showOperatorSheetAction();
}

StacAction _duplicateContinueAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'crAddShowInvalidError', 'value': false},
          {'key': 'crAddShowUnsupportedError', 'value': false},
        ],
      ),
      _showDuplicateDialogAction(),
    ],
  );
}

StacAction _unsupportedContinueAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'crAddShowInvalidError', 'value': false},
      {'key': 'crAddShowUnsupportedError', 'value': true},
    ],
  );
}

StacAction _invalidContinueAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'crAddShowInvalidError', 'value': true},
      {'key': 'crAddShowUnsupportedError', 'value': false},
    ],
  );
}

StacAction _operatorSelectAction(String op) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crAddOpMciSel', 'value': op == 'mci'},
      {'key': 'crAddOpIrancellSel', 'value': op == 'irancell'},
      {'key': 'crAddOpRightelSel', 'value': op == 'rightel'},
    ],
  );
}

StacAction _showOperatorSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildOperatorSheet().toJson(),
  );
}

StacAction _showSimTypeSheetAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildSimTypeSheet().toJson(),
  );
}

StacAction _showDuplicateDialogAction() {
  return StacShowBottomSheetAction(
    backgroundColor: '#8B63708C',
    sheet: _buildDuplicateDialog().toJson(),
  );
}

StacAction _simTypeSelectAction(String type) {
  return StacCustomSetValueAction(
    values: [
      {'key': 'crAddTypePermanentSel', 'value': type == 'permanent'},
      {'key': 'crAddTypeCreditSel', 'value': type == 'credit'},
    ],
  );
}

StacAction _confirmPortedFlowAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'crSimHasItems', 'value': true},
          {'key': 'crSimShowDuplicateBanner', 'value': false},
          {'key': 'crSim3Visible', 'value': true},
          {'key': 'crSim1Selected', 'value': false},
          {'key': 'crSim2Selected', 'value': false},
          {'key': 'crSim3Selected', 'value': true},
          {'key': 'crShowSimActionSheet', 'value': false},
          {'key': 'crShowSimEditSheet', 'value': false},
          {'key': 'crShowSimDeleteDialog', 'value': false},
          {'key': 'crAddShowOperatorSheet', 'value': false},
          {'key': 'crAddShowSimTypeSheet', 'value': false},
          {
            'key': 'crSim3Operator',
            'value': 'همراه اول',
            'condition': 'crAddOpMciSel',
          },
          {
            'key': 'crSim3Logo',
            'value': 'assets/icons/ic_hamrah_aval.svg',
            'condition': 'crAddOpMciSel',
          },
          {
            'key': 'crSim3Operator',
            'value': 'ایرانسل',
            'condition': 'crAddOpIrancellSel',
          },
          {
            'key': 'crSim3Logo',
            'value': 'assets/icons/ic_irancell.svg',
            'condition': 'crAddOpIrancellSel',
          },
          {
            'key': 'crSim3Operator',
            'value': 'رایتل',
            'condition': 'crAddOpRightelSel',
          },
          {
            'key': 'crSim3Logo',
            'value': 'assets/icons/ic_rightel.svg',
            'condition': 'crAddOpRightelSel',
          },
          {
            'key': 'crActiveSimOperator',
            'value': 'همراه اول',
            'condition': 'crAddOpMciSel',
          },
          {
            'key': 'crActiveSimLogo',
            'value': 'assets/icons/ic_hamrah_aval.svg',
            'condition': 'crAddOpMciSel',
          },
          {
            'key': 'crActiveSimOperator',
            'value': 'ایرانسل',
            'condition': 'crAddOpIrancellSel',
          },
          {
            'key': 'crActiveSimLogo',
            'value': 'assets/icons/ic_irancell.svg',
            'condition': 'crAddOpIrancellSel',
          },
          {
            'key': 'crActiveSimOperator',
            'value': 'رایتل',
            'condition': 'crAddOpRightelSel',
          },
          {
            'key': 'crActiveSimLogo',
            'value': 'assets/icons/ic_rightel.svg',
            'condition': 'crAddOpRightelSel',
          },
        ],
      ),
      const StacCustomSetValueAction(
        key: 'crSim3Number',
        value: '{{crAddEnteredPhone}}',
      ),
      const StacCustomSetValueAction(
        key: 'crActiveSimNumber',
        value: '{{crAddEnteredPhone}}',
      ),
      NavigationAction(fileName: 'internet_pakage_list', navMode: NavModes.dart, navigationStyle: NavigationStyle.push),
    ],
  );
}

StacWidget _buildDisabledContinueButton() {
  return StacCustomVisibility(
    visible: '[[!crAddCanContinue]]',
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 18),
      child: StacFilledButton(
        onPressed: null,
        style: StacButtonStyle(
          fixedSize: StacSize(99999, 56),
          backgroundColor: '#D0D5DD',
          foregroundColor: '#98A2B3',
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
          elevation: 0,
        ),
        child: StacText(
          data: 'ادامه',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '#98A2B3',
          ),
        ),
      ),
    ).toJson(),
    replacement: StacSizedBox().toJson(),
  );
}

StacWidget _buildCaseContinueButton({
  required String visibleKey,
  required StacAction onPressed,
}) {
  return StacCustomVisibility(
    visible: '[[$visibleKey]]',
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 18),
      child: StacRawJsonWidget({
        'type': 'reactiveElevatedButton',
        'enabled': true,
        'style': StacButtonStyle(
          fixedSize: StacSize(99999, 56),
          backgroundColor: '{{appColors.current.primary.color}}',
          foregroundColor: '{{appColors.current.primary.onPrimary}}',
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
          elevation: 0,
        ).toJson(),
        'child': StacText(
          data: 'ادامه',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.primary.onPrimary}}',
          ),
        ).toJson(),
        'onPressed': onPressed.toJson(),
      }),
    ).toJson(),
    replacement: StacSizedBox().toJson(),
  );
}

StacWidget _buildOperatorSheet() {
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
        StacSizedBox(height: 16),
        StacText(
          data: 'اپراتور',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: 'در صورت ترابرد سیم‌کارت اپراتور خود را انتخاب نمایید',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 13,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 14),
        _operatorItem(
          title: 'همراه اول',
          logo: 'assets/icons/ic_hamrah_aval.svg',
          selectedKey: 'crAddOpMciSel',
          onTap: _operatorSelectAction('mci'),
        ),
        StacSizedBox(height: 10),
        _operatorItem(
          title: 'ایرانسل',
          logo: 'assets/icons/ic_irancell.svg',
          selectedKey: 'crAddOpIrancellSel',
          onTap: _operatorSelectAction('irancell'),
        ),
        StacSizedBox(height: 10),
        _operatorItem(
          title: 'رایتل',
          logo: 'assets/icons/ic_rightel.svg',
          selectedKey: 'crAddOpRightelSel',
          onTap: _operatorSelectAction('rightel'),
        ),
        StacSizedBox(height: 14),
        StacFilledButton(
          onPressed: StacSequenceAction(
            actions: [
              const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              _showSimTypeSheetAction(),
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
            data: 'تایید و ادامه',
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

StacWidget _operatorItem({
  required String title,
  required String logo,
  required String selectedKey,
  required StacAction onTap,
}) {
  final row = StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          src: logo,
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
        ),
        StacSizedBox(width: 10),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w500,
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacCustomVisibility(
          visible: '[[$selectedKey]]',
          child: StacContainer(
            width: 22,
            height: 22,
            decoration: StacBoxDecoration(
              color: '#20C4D8',
              shape: StacBoxShape.circle,
            ),
            child: StacCenter(
              child: StacIcon(icon: 'check', size: 16, color: '#FFFFFF'),
            ),
          ).toJson(),
          replacement: StacContainer(
            width: 22,
            height: 22,
            decoration: StacBoxDecoration(
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
              shape: StacBoxShape.circle,
            ),
          ).toJson(),
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: row,
      ).toJson(),
      replacement: row.toJson(),
    ),
  );
}

StacWidget _buildSimTypeSheet() {
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
        StacSizedBox(height: 16),
        StacText(
          data: 'نوع سیم کارت',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
          ),
        ),
        StacSizedBox(height: 8),
        StacText(
          data: '{{crAddEnteredPhone}}',
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 16,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 14),
        _simTypeItem(
          title: 'دائمی',
          selectedKey: 'crAddTypePermanentSel',
          onTap: _simTypeSelectAction('permanent'),
        ),
        StacSizedBox(height: 10),
        _simTypeItem(
          title: 'اعتباری',
          selectedKey: 'crAddTypeCreditSel',
          onTap: _simTypeSelectAction('credit'),
        ),
        StacSizedBox(height: 14),
        StacFilledButton(
          onPressed: StacSequenceAction(
            actions: [
              const StacNavigateAction(navigationStyle: NavigationStyle.pop),
              _confirmPortedFlowAction(),
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
            data: 'تایید و ادامه',
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

StacWidget _simTypeItem({
  required String title,
  required String selectedKey,
  required StacAction onTap,
}) {
  final row = StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacCustomVisibility(
          visible: '[[$selectedKey]]',
          child: StacContainer(
            width: 22,
            height: 22,
            decoration: StacBoxDecoration(
              color: '#20C4D8',
              shape: StacBoxShape.circle,
            ),
            child: StacCenter(
              child: StacIcon(icon: 'check', size: 16, color: '#FFFFFF'),
            ),
          ).toJson(),
          replacement: StacContainer(
            width: 22,
            height: 22,
            decoration: StacBoxDecoration(
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
              shape: StacBoxShape.circle,
            ),
          ).toJson(),
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(10),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: row,
      ).toJson(),
      replacement: row.toJson(),
    ),
  );
}

StacWidget _buildDuplicateDialog() {
  return StacContainer(
    margin: StacEdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
    padding: StacEdgeInsets.only(left: 14, top: 16, right: 14, bottom: 12),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(color: '#2B8BFA', width: 2),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacContainer(
            width: 28,
            height: 28,
            decoration: StacBoxDecoration(
              color: '#FFCD29',
              shape: StacBoxShape.circle,
            ),
            child: StacCenter(
              child: StacIcon(
                icon: 'error_outline',
                size: 18,
                color: '#FFFFFF',
              ),
            ),
          ),
        ),
        StacSizedBox(height: 10),
        StacText(
          data: 'مجاز نیست',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 10),
        StacText(
          data:
              'شماره انتخابی شما جز سیم‌کارت‌های تکراری می‌باشد، لطفا یکی دیگر انتخاب کنید.',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacCustomTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 14),
        StacFilledButton(
          onPressed: const StacNavigateAction(
            navigationStyle: NavigationStyle.pop,
          ),
          style: StacButtonStyle(
            fixedSize: StacSize(999999, 44),
            backgroundColor: '{{appColors.current.primary.color}}',
            foregroundColor: '{{appColors.current.primary.onPrimary}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(8),
            ),
            elevation: 0,
          ),
          child: StacText(
            data: 'متوجه شدم',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.primary.onPrimary}}',
            ),
          ),
        ),
      ],
    ),
  );
}

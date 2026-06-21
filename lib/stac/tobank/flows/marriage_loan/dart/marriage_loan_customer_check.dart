import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'marriage_loan_customer_check')
StacWidget marriageLoanCustomerCheckScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'marriageLoanAmountExpanded', 'value': false},
        {
          'key': 'marriageLoanAmountText',
          'value':
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_hint}}',
        },
        {'key': 'marriageLoanTrackingHasValue', 'value': false},
        {'key': 'marriageLoanTrackingValid', 'value': true},
        {'key': 'marriageLoanVeteran', 'value': false},
        {'key': 'marriageLoanAmountSelected', 'value': false},
        {'key': 'marriageLoanContinueEnabled', 'value': false},
        {'key': 'marriageLoanContinueLoading', 'value': false},
        {'key': 'marriageLoanTaskSpouseCompleted', 'value': false},
        {'key': 'marriageLoanTaskSpouseFlowCompleted', 'value': false},
        {'key': 'marriageLoanTaskDocsCompleted', 'value': false},
        {'key': 'marriageLoanTaskMarriageLicenseCompleted', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.marriage_loan.marriage_loan_menu.title}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _infoCard(),
                    StacSizedBox(height: 24),
                    _label(
                      '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.branch_label}}',
                    ),
                    StacSizedBox(height: 8),
                    _disabledInputBox(
                      '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.branch_value}}',
                    ),
                    StacSizedBox(height: 24),
                    _sectionTitleWithInfo(
                      '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.tracking_code_title}}',
                      onInfoTap: _trackingCodeHelperBottomSheetAction(),
                    ),
                    StacSizedBox(height: 8),
                    _trackingBox(),
                    _trackingError(),
                    StacSizedBox(height: 16),
                    _sectionTitleWithInfo(
                      '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_title}}',
                      onInfoTap: const StacAction(
                        jsonData: {
                          'actionType': 'navigate',
                          'fileName': 'marriage_loan_amount_detail',
                          'navMode': '{{marriageLoanFlowNavMode}}',
                          'navigationStyle': 'push',
                        },
                      ),
                    ),
                    StacSizedBox(height: 8),
                    _amountSelector(),
                    StacSizedBox(height: 18),
                    _veteranCheckbox(),
                    StacSizedBox(height: 28),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: _continueButton(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _infoCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data:
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.information}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        _rowValue(
          '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.full_name}}',
          '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.customer_name}}',
        ),
        StacSizedBox(height: 10),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacSizedBox(height: 10),
        _rowValue(
          '{{appStrings.login.nationalCodeTitle}}',
          '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.national_code}}',
        ),
      ],
    ),
  );
}

StacWidget _rowValue(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacText(
        data: value,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _label(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _sectionTitleWithInfo(String text, {StacAction? onInfoTap}) {
  return StacAlign(
    alignment: StacAlignmentDirectional.centerEnd,
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacText(
          data: text,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(width: 8),
        StacGestureDetector(
          onTap: onInfoTap,
          child: StacPadding(
            padding: StacEdgeInsets.all(4),
            child: StacImage(
              src: 'assets/icons/ic_info.svg',
              imageType: StacImageType.asset,
              width: 24,
              height: 24,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacAction _trackingCodeHelperBottomSheetAction() {
  return StacShowBottomSheetAction(
    title: 'marriage_loan_tracking_code_helper',
    backgroundColor: '#8B000000',
    sheet: _trackingCodeHelperBottomSheet().toJson(),
  );
}

StacWidget _trackingCodeHelperBottomSheet() {
  return StacContainer(
    width: 999999,
    padding: StacEdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
    ),
    child: StacColumn(
      mainAxisSize: StacMainAxisSize.min,
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacCenter(
          child: StacContainer(
            width: 56,
            height: 6,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.input.borderEnabled}}',
              borderRadius: StacBorderRadius.all(999),
            ),
          ),
        ),
        StacSizedBox(height: 28),
        StacText(
          data:
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.tracking_helper_title}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        StacText(
          data:
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.tracking_helper_message}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w400,
            height: 1.8,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacSizedBox(height: 24),
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacText(
              data:
                  '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.central_bank_system}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacGestureDetector(
              onTap: StacAction(
                jsonData: {
                  'actionType': 'launchUrl',
                  'url': 'https://ve.cbi.ir',
                  'mode': 'externalApplication',
                },
              ),
              child: StacRow(
                textDirection: StacTextDirection.ltr,
                mainAxisSize: StacMainAxisSize.min,
                children: [
                  StacImage(
                    src: 'assets/icons/ic_website.svg',
                    imageType: StacImageType.asset,
                    width: 22,
                    height: 22,
                    color: '{{appColors.current.text.title}}',
                  ),
                  StacSizedBox(width: 8),
                  StacColumn(
                    mainAxisSize: StacMainAxisSize.min,
                    crossAxisAlignment: StacCrossAxisAlignment.start,
                    children: [
                      StacText(
                        data:
                            '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.cbi_website}}',
                        textDirection: StacTextDirection.ltr,
                        style: StacTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 1),
                      StacContainer(
                        width: 58,
                        height: 1,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        StacSizedBox(height: 40),
        StacElevatedButton(
          onPressed: const StacNavigateAction(
            navigationStyle: NavigationStyle.pop,
          ),
          style: StacButtonStyle(
            elevation: 0,
            fixedSize: StacSize(999999, 56),
            backgroundColor: '{{appColors.current.primary.color}}',
            foregroundColor: '#FFFFFF',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(12),
            ),
          ),
          child: StacText(
            data: '{{appStrings.common.close}}',
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '#FFFFFF',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _disabledInputBox(String value) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 13),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacText(
      data: value,
      textDirection: StacTextDirection.rtl,
      textAlign: StacTextAlign.right,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '#A0A7B4',
      ),
    ),
  );
}

StacWidget _trackingBox() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 3),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color:
            '{{marriageLoanTrackingHasValue && !marriageLoanTrackingValid ? appColors.current.error.color : appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacCustomTextFormField(
            id: 'marriage_loan_tracking_code',
            keyboardType: 'number',
            maxLength: 10,
            inputFormatters: const [
              {'type': 'allow', 'rule': '[0-9۰-۹]'},
            ],
            onChanged: StacSequenceAction(
              actions: [
                const StacValidateFieldsAction(
                  resultKey: 'marriageLoanTrackingHasValue',
                  fields: [
                    {'id': 'marriage_loan_tracking_code', 'rule': r'^.{1,}$'},
                  ],
                ),
                const StacValidateFieldsAction(
                  resultKey: 'marriageLoanTrackingValid',
                  fields: [
                    {
                      'id': 'marriage_loan_tracking_code',
                      'rule': r'^[0-9۰-۹]{10}$',
                    },
                  ],
                ),
                _updateContinueEnabledAction(),
              ],
            ),
            textDirection: 'ltr',
            textAlign: 'right',
            decoration: {
              'hintText':
                  '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.tracking_code_hint}}',
              'counterText': '',
              'border': {'type': 'none'},
              'enabledBorder': {'type': 'none'},
              'focusedBorder': {'type': 'none'},
              'contentPadding': {'left': 0, 'top': 3, 'right': 0, 'bottom': 3},
            },
            style: const {
              'fontSize': 16,
              'fontWeight': 'w700',
              'color': '{{appColors.current.text.title}}',
            },
          ),
        ),
        StacSizedBox(width: 10),
        StacRawJsonWidget({
          'type': 'visibility',
          'visible': '{{marriageLoanTrackingHasValue}}',
          'child': StacGestureDetector(
            onTap: StacSequenceAction(
              actions: [
                const StacCustomSetValueAction(
                  values: [
                    {'key': 'marriage_loan_tracking_code', 'value': ''},
                    {'key': 'marriageLoanTrackingHasValue', 'value': false},
                    {'key': 'marriageLoanTrackingValid', 'value': true},
                  ],
                ),
                _updateContinueEnabledAction(),
              ],
            ),
            child: StacImage(
              src: 'assets/icons/ic_close.svg',
              imageType: StacImageType.asset,
              width: 20,
              height: 20,
              color: '{{appColors.current.text.title}}',
            ),
          ).toJson(),
        }),
      ],
    ),
  );
}

StacWidget _trackingError() {
  return StacRawJsonWidget({
    'type': 'visibility',
    'visible': '{{marriageLoanTrackingHasValue && !marriageLoanTrackingValid}}',
    'child': StacPadding(
      padding: StacEdgeInsets.only(top: 6),
      child: StacText(
        data:
            '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.tracking_code_error}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.error.color}}',
        ),
      ),
    ).toJson(),
  });
}

StacWidget _amountSelector() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          key: 'marriageLoanAmountExpanded',
          value: '{{!marriageLoanAmountExpanded}}',
        ),
        child: StacContainer(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(10),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                data: '{{marriageLoanAmountText}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacImage(
                src: '{{appAssets.icons.arrowCircleDown}}',
                imageType: StacImageType.asset,
                width: 28,
                height: 28,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ],
          ),
        ),
      ),
      StacRawJsonWidget({
        'type': 'visibility',
        'visible': '{{marriageLoanAmountExpanded}}',
        'child': StacContainer(
          margin: StacEdgeInsets.only(top: 2),
          padding: StacEdgeInsets.symmetric(vertical: 10),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(4),
            boxShadow: [
              StacBoxShadow(
                color: '#26000000',
                blurRadius: 18,
                offset: StacOffset(dx: 0, dy: 8),
              ),
            ],
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _amountOption(
                '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_300}}',
              ),
              _amountOption(
                '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_350}}',
              ),
              _amountOption(
                '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_600}}',
              ),
              _amountOption(
                '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.amount_700}}',
              ),
            ],
          ),
        ).toJson(),
      }),
    ],
  );
}

StacWidget _amountOption(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'marriageLoanAmountText', 'value': title},
            {'key': 'marriageLoanAmountExpanded', 'value': false},
            {'key': 'marriageLoanAmountSelected', 'value': true},
          ],
        ),
        _updateContinueEnabledAction(),
      ],
    ),
    child: StacContainer(
      width: 999999,
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
  );
}

StacCustomSetValueAction _updateContinueEnabledAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'marriageLoanContinueEnabled', 'value': false},
      {
        'key': 'marriageLoanContinueEnabled',
        'value': true,
        'condition':
            'marriageLoanTrackingValid && marriageLoanTrackingHasValue && marriageLoanAmountSelected',
      },
    ],
  );
}

StacWidget _veteranCheckbox() {
  return StacAlign(
    alignment: StacAlignmentDirectional.centerEnd,
    child: StacGestureDetector(
      onTap: const StacCustomSetValueAction(
        key: 'marriageLoanVeteran',
        value: '{{marriageLoanVeteran ? false : true}}',
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisSize: StacMainAxisSize.min,
        children: [
          StacContainer(
            width: 22,
            height: 22,
            decoration: StacBoxDecoration(
              color:
                  '{{marriageLoanVeteran ? appColors.current.secondary.color : "transparent"}}',
              borderRadius: StacBorderRadius.all(4),
              border: StacBorder.all(
                color:
                    '{{marriageLoanVeteran ? appColors.current.secondary.color : appColors.current.text.title}}',
                width: 2,
              ),
            ),
            child: StacCenter(
              child: StacCustomOpacity(
                opacity: '{{marriageLoanVeteran ? 1.0 : 0.0}}',
                child: StacImage(
                  src: 'assets/icons/ic_check.svg',
                  imageType: StacImageType.asset,
                  color: '{{appColors.current.text.buttonPrimary}}',
                  width: 19,
                  height: 19,
                ).toJson(),
              ),
            ),
          ),
          StacSizedBox(width: 12),
          StacText(
            data:
                '{{appStrings.generated.marriage_loan.marriage_loan_customer_check.veteran}}',
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _continueButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'marriageLoanContinueEnabled',
    loadingKey: 'marriageLoanContinueLoading',
    onPressed: StacAction(
      jsonData: {
        'actionType': 'fingerPrint',
        'title': 'احراز هویت',
        'description': 'برای ادامه فرایند تسهیلات ازدواج احراز هویت کنید',
        'onSuccess': {
          'actionType': 'navigate',
          'fileName': 'marriage_loan_task_list',
          'navMode': '{{marriageLoanFlowNavMode}}',
          'navigationStyle': 'push',
        },
      },
    ).toJson(),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      backgroundColor: '{{appColors.current.primary.color}}',
      disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
    ).toJson(),
    child: StacText(
      data: '{{appStrings.common.continue}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 20,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}

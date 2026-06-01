import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_customer_check')
StacWidget childLoanCustomerCheckScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanChildSelected', 'value': false},
        {'key': 'childLoanChildExpanded', 'value': false},
        {'key': 'childLoanChildrenText', 'value': 'انتخاب فرزند'},
        {'key': 'child_loan_child_count', 'value': 'انتخاب فرزند'},
        {'key': 'childLoanAmountText', 'value': 'ابتدا فرزند را انتخاب کنید'},
        {'key': 'childLoanTrackingHasValue', 'value': false},
        {'key': 'childLoanContinueEnabled', 'value': false},
        {'key': 'childLoanContinueLoading', 'value': false},
        {'key': 'childLoanTaskResidenceCompleted', 'value': false},
        {'key': 'childLoanTaskChildInfoCompleted', 'value': false},
        {'key': 'childLoanTaskDocsCompleted', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: 'تسهیلات فرزندآوری',
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
                    _label('شعبه عامل'),
                    StacSizedBox(height: 8),
                    _inputBox('تهران - شعبه مرکزی'),
                    StacSizedBox(height: 24),
                    _trackingTitle(),
                    StacSizedBox(height: 8),
                    _trackingBox(),
                    StacSizedBox(height: 16),
                    _label('فرزند'),
                    StacSizedBox(height: 8),
                    _childrenSelector(),
                    _hiddenChildSelectionField(),
                    _loanAmountSection(),
                    StacSizedBox(height: 24),
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
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          data: 'اطلاعات شما',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        _rowValue('نام و نام‌خانوادگی', 'علی سینایی اصل'),
        StacSizedBox(height: 10),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacSizedBox(height: 10),
        _rowValue('کد ملی', '۱۲۷۲۲۱۲۵۱۹۱'),
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
          fontWeight: StacFontWeight.w600,
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
      fontSize: 16,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _inputBox(String value) {
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
        color: '#8A94A6',
      ),
    ),
  );
}

StacWidget _trackingTitle() {
  return StacAlign(
    alignment: StacAlignmentDirectional.centerEnd,
    child: StacRow(
      textDirection: StacTextDirection.ltr,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacText(
          data: 'کد رهگیری بانک مرکزی',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
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
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacCustomTextFormField(
            id: 'child_loan_tracking_code',
            keyboardType: 'number',
            maxLength: 15,
            inputFormatters: const [
              {'type': 'allow', 'rule': '[0-9۰-۹]'},
            ],
            onChanged: const StacSequenceAction(
              actions: [
                StacValidateFieldsAction(
                  resultKey: 'childLoanTrackingHasValue',
                  fields: [
                    {'id': 'child_loan_tracking_code', 'rule': r'^.{1,}$'},
                  ],
                ),
                StacValidateFieldsAction(
                  resultKey: 'childLoanContinueEnabled',
                  fields: [
                    {'id': 'child_loan_tracking_code', 'rule': r'^.{1,}$'},
                    {'id': 'child_loan_child_count_field', 'rule': r'^.{1,}$'},
                  ],
                ),
              ],
            ),
            textDirection: 'ltr',
            textAlign: 'right',
            decoration: {
              'hintText': 'کد رهگیری بانک مرکزی متقاضی را وارد نمایید',
              'counterText': '',
              'border': {'type': 'none'},
              'enabledBorder': {'type': 'none'},
              'focusedBorder': {'type': 'none'},
              'contentPadding': {'left': 0, 'top': 3, 'right': 0, 'bottom': 3},
            },
            style: const {
              'fontSize': 16,
              'fontWeight': 'w600',
              'color': '{{appColors.current.text.title}}',
            },
          ),
        ),
        StacSizedBox(width: 10),
        StacRawJsonWidget({
          'type': 'visibility',
          'visible': '[[childLoanTrackingHasValue]]',
          'child': StacGestureDetector(
            onTap: const StacCustomSetValueAction(
              values: [
                {'key': 'child_loan_tracking_code', 'value': ''},
                {'key': 'childLoanTrackingHasValue', 'value': false},
                {'key': 'childLoanContinueEnabled', 'value': false},
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

StacWidget _childrenSelector() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          key: 'childLoanChildExpanded',
          value: '{{!childLoanChildExpanded}}',
        ),
        child: StacContainer(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 13),
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
                data: '{{childLoanChildrenText}}',
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
                width: 30,
                height: 30,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ],
          ),
        ),
      ),
      StacRawJsonWidget({
        'type': 'visibility',
        'visible': '[[childLoanChildExpanded]]',
        'child': StacContainer(
          margin: StacEdgeInsets.only(top: 2),
          padding: StacEdgeInsets.symmetric(vertical: 8),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _childOption('فرزند نخست'),
              _childOption('فرزند دوم'),
              _childOption('فرزند سوم'),
              _childOption('فرزند چهارم'),
              _childOption('فرزند پنجم یا بالاتر'),
            ],
          ),
        ).toJson(),
      }),
    ],
  );
}

StacWidget _childOption(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'childLoanChildrenText', 'value': title},
            {'key': 'child_loan_child_count', 'value': title},
            {'key': 'child_loan_child_count_field', 'value': title},
            {
              'key': 'childLoanAmountText',
              'value': _loanAmountByChildTitle(title),
            },
            {'key': 'childLoanChildSelected', 'value': true},
            {'key': 'childLoanChildExpanded', 'value': false},
          ],
        ),
        const StacValidateFieldsAction(
          resultKey: 'childLoanContinueEnabled',
          fields: [
            {'id': 'child_loan_tracking_code', 'rule': r'^.{1,}$'},
            {'id': 'child_loan_child_count_field', 'rule': r'^.{1,}$'},
          ],
        ),
      ],
    ),
    child: StacContainer(
      width: 999999,
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
  );
}

StacWidget _hiddenChildSelectionField() {
  return StacVisibility(
    visible: false,
    child: StacCustomTextFormField(
      id: 'child_loan_child_count_field',
      decoration: const {'hintText': ''},
    ),
  );
}

String _loanAmountByChildTitle(String title) {
  const int baseAmount = 400000000;

  int step = 1;
  if (title == 'فرزند دوم') step = 2;
  if (title == 'فرزند سوم') step = 3;
  if (title == 'فرزند چهارم') step = 4;
  if (title == 'فرزند پنجم یا بالاتر') step = 5;

  final double factor = 1 + (0.3 * (step - 1));
  final int amount = (baseAmount * factor).round();
  return _formatAmountFa(amount);
}

String _formatAmountFa(int amount) {
  final String s = amount.toString();
  final StringBuffer out = StringBuffer();
  int c = 0;
  for (int i = s.length - 1; i >= 0; i--) {
    out.write(s[i]);
    c++;
    if (c % 3 == 0 && i != 0) {
      out.write(',');
    }
  }
  final String grouped = out.toString().split('').reversed.join();
  return '$grouped ریال';
}

StacWidget _loanAmountSection() {
  return StacCustomVisibility(
    visible: '[[childLoanChildSelected]]',
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 16),
        StacContainer(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                data: 'مبلغ تسهیلات',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data: '{{childLoanAmountText}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
      ],
    ).toJson(),
  );
}

StacWidget _continueButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'childLoanContinueEnabled',
    loadingKey: 'childLoanContinueLoading',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'لطفا برای ادامه از اثر انگشت استفاده کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'values': [
              {'key': 'crDetailVariantMarriageLoan', 'value': false},
              {'key': 'crDetailVariantChildLoan', 'value': true},
              {'key': 'crDetailVariantCompleteDocsDone', 'value': false},
              {'key': 'crDetailVariantCompleteDocsEmpty', 'value': false},
            ],
          },
          {
            'actionType': 'navigate',
            'routeName': 'child_loan_task_list',
            'navigationStyle': 'push',
          },
        ],
      },
    ).toJson(),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      backgroundColor: '{{appColors.current.primary.color}}',
      disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
    ).toJson(),
    child: StacText(
      data: 'ادامه',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 20,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}

import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_child_check')
StacWidget childLoanChildCheckScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanChildNationalHasValue', 'value': false},
        {'key': 'childLoanChildCheckNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'بارگذاری اطلاعات هویتی فرزند',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _title('اطلاعات هویتی فرزند'),
              StacSizedBox(height: 16),
              _title('کد ملی فرزند'),
              StacSizedBox(height: 8),
              _nationalCodeField(),
              StacSizedBox(height: 16),
              _title('تاریخ تولد فرزند'),
              StacSizedBox(height: 8),
              _birthDateField(),
              StacSizedBox(height: 40),
              _nextButton(),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _title(String text) {
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

StacWidget _nationalCodeField() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 3),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(color: '{{appColors.current.input.borderEnabled}}', width: 1),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacCustomTextFormField(
            id: 'child_loan_child_national_code',
            keyboardType: 'number',
            maxLength: 10,
            inputFormatters: const [
              {'type': 'allow', 'rule': '[0-9۰-۹]'},
            ],
            textDirection: 'ltr',
            textAlign: 'right',
            onChanged: const StacSequenceAction(
              actions: [
                StacValidateFieldsAction(
                  resultKey: 'childLoanChildNationalHasValue',
                  fields: [
                    {
                      'id': 'child_loan_child_national_code',
                      'rule': r'^.{1,}$',
                    },
                  ],
                ),
                StacValidateFieldsAction(
                  resultKey: 'childLoanChildCheckNextEnabled',
                  fields: [
                    {
                      'id': 'child_loan_child_national_code',
                      'rule': r'^[0-9۰-۹]{10}$',
                    },
                    {'id': 'child_loan_child_birthdate', 'rule': r'^.{1,}$'},
                  ],
                ),
              ],
            ),
            decoration: {
              'hintText': 'کد ملی فرزند را وارد نمایید',
              'counterText': '',
              'border': {'type': 'none'},
              'enabledBorder': {'type': 'none'},
              'focusedBorder': {'type': 'none'},
              'contentPadding': {'left': 0, 'top': 8, 'right': 0, 'bottom': 8},
              'hintStyle': {
                'fontSize': 15,
                'fontWeight': 'w500',
                'color': '{{appColors.current.text.subtitle}}',
              },
            },
            style: const {
              'fontSize': 17,
              'fontWeight': 'w700',
              'color': '{{appColors.current.text.title}}',
            },
          ),
        ),
        StacSizedBox(width: 10),
        StacRawJsonWidget({
          'type': 'visibility',
          'visible': '[[childLoanChildNationalHasValue]]',
          'child': StacGestureDetector(
            onTap: const StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  values: [
                    {'key': 'child_loan_child_national_code', 'value': ''},
                    {'key': 'childLoanChildNationalHasValue', 'value': false},
                    {'key': 'childLoanChildCheckNextEnabled', 'value': false},
                  ],
                ),
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

StacWidget _birthDateField() {
  return StacGestureDetector(
    onTap: const StacSequenceAction(
      actions: [
        {
          'actionType': 'persianDatePicker',
          'formFieldId': 'child_loan_child_birthdate',
        },
        StacValidateFieldsAction(
          resultKey: 'childLoanChildCheckNextEnabled',
          fields: [
            {'id': 'child_loan_child_national_code', 'rule': r'^[0-9۰-۹]{10}$'},
            {'id': 'child_loan_child_birthdate', 'rule': r'^.{1,}$'},
          ],
        ),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(color: '{{appColors.current.input.borderEnabled}}', width: 1),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacCustomTextFormField(
              id: 'child_loan_child_birthdate',
              readOnly: true,
              textDirection: 'ltr',
              textAlign: 'right',
              decoration: {
                'hintText': 'تاریخ تولد فرزند را انتخاب نمایید',
                'counterText': '',
                'border': {'type': 'none'},
                'enabledBorder': {'type': 'none'},
                'focusedBorder': {'type': 'none'},
                'contentPadding': {
                  'left': 0,
                  'top': 8,
                  'right': 0,
                  'bottom': 8,
                },
                'hintStyle': {
                  'fontSize': 15,
                  'fontWeight': 'w500',
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
              style: const {
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            ),
          ),
          StacSizedBox(width: 10),
          StacImage(
            src: 'assets/icons/ic_calendar.svg',
            imageType: StacImageType.asset,
            width: 33,
            height: 33,
            color: '{{appColors.current.secondary.color}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _nextButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'childLoanChildCheckNextEnabled',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'لطفا برای ادامه از اثر انگشت استفاده کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'childLoanTaskChildInfoCompleted',
            'value': true,
          },
          {'actionType': 'navigate', 'navigationStyle': 'pop'},
        ],
      },
    ).toJson(),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      backgroundColor: '{{appColors.current.primary.color}}',
      disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(14)),
    ).toJson(),
    child: StacText(
      data: 'مرحله بعد',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 19,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}

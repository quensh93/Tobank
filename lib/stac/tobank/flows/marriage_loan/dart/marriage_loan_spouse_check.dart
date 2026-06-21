import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'marriage_loan_spouse_check')
StacWidget marriageLoanSpouseCheckScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'marriageLoanSpouseCanContinue', 'value': false},
        {'key': 'marriageLoanSpouseLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.title}}',
        showBack: true,
        showSupport: true,
      ),
      backgroundColor: '#FFFFFF',
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.always,
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _title(
                '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.identity_information}}',
              ),
              StacSizedBox(height: 28),
              _label(
                '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.national_code}}',
              ),
              StacSizedBox(height: 8),
              _nationalCodeField(),
              StacSizedBox(height: 28),
              _label(
                '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.birthdate}}',
              ),
              StacSizedBox(height: 8),
              _birthdateField(),
              StacSizedBox(height: 48),
              _nextButton(),
              StacSizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _title(String data) {
  return StacText(
    data: data,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _label(String data) {
  return StacText(
    data: data,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacTextStyle(
      fontSize: 17,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _nationalCodeField() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 0),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacCustomTextFormField(
      id: 'marriage_loan_spouse_national_code',
      keyboardType: 'number',
      maxLength: 10,
      inputFormatters: const [
        {'type': 'allow', 'rule': '[0-9۰-۹]'},
      ],
      onChanged: _spouseFormValidationAction(),
      textDirection: 'ltr',
      textAlign: 'right',
      decoration: {
        'hintText':
            '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.national_code_hint}}',
        'hintStyle': StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ).toJson(),
        'counterText': '',
        'border': {'type': 'none'},
        'enabledBorder': {'type': 'none'},
        'focusedBorder': {'type': 'none'},
        'contentPadding': {'horizontal': 8, 'vertical': 16},
      },
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.title}}',
      ).toJson(),
    ),
  );
}

StacWidget _birthdateField() {
  return StacGestureDetector(
    onTap: StacPersianDatePickerAction(
      formFieldId: 'marriage_loan_spouse_birthdate',
      firstDate: '1300/01/01',
      lastDate: '1450/12/29',
      onDateSelected: _spouseFormValidationAction().toJson(),
    ),
    child: StacContainer(
      height: 56,
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacStack(
        alignment: StacAlignment.center,
        children: [
          StacCustomTextFormField(
            id: 'marriage_loan_spouse_birthdate',
            readOnly: true,
            enabled: false,
            textDirection: 'rtl',
            textAlign: 'right',
            textAlignVertical: 'center',
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ).toJson(),
            decoration: {
              'hintText':
                  '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.birthdate_hint}}',
              'hintTextAlign': 'right',
              'hintTextDirection': 'rtl',
              'hintStyle': StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.hint}}',
              ).toJson(),
              'border': {'type': 'none'},
              'enabledBorder': {'type': 'none'},
              'focusedBorder': {'type': 'none'},
              'disabledBorder': {'type': 'none'},
              'contentPadding': {
                'left': 56,
                'right': 12,
                'top': 0,
                'bottom': 0,
              },
            },
            keyboardType: 'text',
          ),
          StacPositioned(
            left: 6,
            top: 0,
            bottom: 0,
            child: StacCenter(
              child: StacImage(
                src: 'assets/icons/ic_calendar.svg',
                imageType: StacImageType.asset,
                width: 28,
                height: 28,
                color: '{{appColors.current.secondary.color}}',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _nextButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'marriageLoanSpouseCanContinue',
    loadingKey: 'marriageLoanSpouseLoading',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'برای تکمیل اطلاعات همسر متقاضی احراز هویت کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'marriageLoanTaskSpouseCompleted',
            'value': true,
          },
          {
            'actionType': 'customSnackBar',
            'title': 'ثبت اطلاعات',
            'detail': 'اطلاعات همسر متقاضی با موفقیت ثبت شد',
            'duration': 1800,
          },
          {
            'actionType': 'navigate',
            'fileName': 'marriage_loan_customer_document',
            'navMode': '{{marriageLoanFlowNavMode}}',
            'navigationStyle': 'pushReplacement',
          },
        ],
      },
    ).toJson(),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      backgroundColor: '{{appColors.current.primary.color}}',
      disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
      foregroundColor: '#FFFFFF',
      disabledForegroundColor: '{{appColors.current.text.subtitle}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
    ).toJson(),
    child: StacText(
      data:
          '{{appStrings.generated.marriage_loan.marriage_loan_spouse_check.next_step}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 18,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}

StacValidateFieldsAction _spouseFormValidationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'marriageLoanSpouseCanContinue',
    fields: [
      {'id': 'marriage_loan_spouse_national_code', 'rule': r'^[0-9۰-۹]{10}$'},
      {'id': 'marriage_loan_spouse_birthdate', 'rule': r'^.+$'},
    ],
  );
}

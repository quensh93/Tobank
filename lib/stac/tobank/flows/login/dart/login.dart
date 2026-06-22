import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/config/sdui_build_config.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'login_form_dart')
StacWidget loginForm() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isLoginFormValid', 'value': false},
        {'key': 'isLoginLoading', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacRow(
          mainAxisAlignment: StacMainAxisAlignment.end,
          children: [
            StacText(
              // اعتبارسنجی
              data: '{{appStrings.login.validationTitle}}',
              style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.always,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          textDirection: StacTextDirection.rtl,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.all(16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      // توضیحات اعتبارسنجی
                      data: '{{appStrings.login.validationInstructions}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w400,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 24),
                    _buildMobileNumberField(),
                    StacSizedBox(height: 16),
                    _buildNationalCodeField(),
                    StacSizedBox(height: 16),
                    _buildHiddenGpayField(),
                    StacSizedBox(height: 16),
                    _buildHiddenCifField(),
                    _buildBirthDateField(),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: _buildSubmitButton(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildMobileNumberField() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        // شماره همراه
        data: '{{appStrings.login.mobileNumberLabel}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.text.label}}'),
      ),
      StacSizedBox(height: 8),
      StacCustomTextFormField(
        id: 'mobile_number',
        textDirection: 'rtl',
        textAlign: 'right',
        supportTextDirection: 'rtl',
        autovalidateMode: 'always',
        maxLength: 11,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        decoration: StacInputDecoration(
          // شماره همراه خود را وارد نمایید
          hintText: '{{appStrings.login.mobileNumberPlaceholder}}',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ).toJson(),
        keyboardType: 'phone',
        textInputAction: 'next',
        validatorRules: const [
          {
            'rule': 'matches',
            'options': {'pattern': r'^09\d{9}$'},
            // فرمت شماره موبایل صحیح نیست
            'message': '{{appStrings.login.mobileNumberError}}',
          },
        ],
        onChanged: _loginValidationAction(),
      ),
    ],
  );
}

StacWidget _buildNationalCodeField() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        // کد ملی
        data: '{{appStrings.login.nationalCodeTitle}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.text.label}}'),
      ),
      StacSizedBox(height: 8),
      StacCustomTextFormField(
        id: 'national_code',
        textDirection: 'rtl',
        textAlign: 'right',
        supportTextDirection: 'rtl',
        autovalidateMode: 'always',
        maxLength: 10,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        decoration: StacInputDecoration(
          // کد ملی خود را بدون خط تیره وارد نمایید
          hintText: '{{appStrings.login.nationalCodePlaceholder}}',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ).toJson(),
        keyboardType: 'number',
        textInputAction: 'next',
        validatorRules: const [
          {
            'rule': 'matches',
            'options': {'pattern': r'^\d{10}$'},
            // کد ملی باید 10 رقم باشد
            'message': '{{appStrings.login.nationalCodeError}}',
          },
        ],
        onChanged: _loginValidationAction(),
      ),
    ],
  );
}

StacWidget _buildHiddenGpayField() {
  return StacVisibility(
    visible: false,
    child: StacCustomTextFormField(
      id: 'gpay_token',
      textDirection: 'ltr',
      textAlign: 'left',
      decoration: StacInputDecoration(
        // مثال: 1234
        hintText: '1234',
        filled: false,
        contentPadding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ).toJson(),
      keyboardType: 'text',
      textInputAction: 'next',
      onChanged: _loginValidationAction(),
    ),
  );
}

StacWidget _buildHiddenCifField() {
  return StacVisibility(
    visible: false,
    child: StacCustomTextFormField(
      id: 'cif',
      textDirection: 'ltr',
      textAlign: 'left',
      decoration: StacInputDecoration(
        // مثال: 123
        hintText: '123',
        filled: false,
        contentPadding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ).toJson(),
      keyboardType: 'text',
      textInputAction: 'next',
      onChanged: _loginValidationAction(),
    ),
  );
}

StacWidget _buildBirthDateField() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        // تاریخ تولد
        data: '{{appStrings.login.birthdateLabel}}',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.text.label}}'),
      ),
      StacSizedBox(height: 8),
      StacGestureDetector(
        onTap: StacPersianDatePickerAction(
          formFieldId: 'birthdate',
          firstDate: '1300/01/01',
          lastDate: '1450/12/29',
          onDateSelected: _loginValidationAction().toJson(),
        ),
        child: StacTextFormField(
          id: 'birthdate',
          readOnly: true,
          enabled: false,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          decoration: StacInputDecoration(
            // تاریخ تولد خود را انتخاب نمایید
            hintText: '{{appStrings.login.birthdatePlaceholder}}',
            hintStyle: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.hint}}',
            ),
            filled: false,
            contentPadding: StacEdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            prefixIcon: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: 'assets/icons/ic_calendar.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                fit: StacBoxFit.scaleDown,
                color: '{{appColors.current.secondary.color}}',
              ),
            ),
          ),
          keyboardType: StacTextInputType.text,
          autovalidateMode: StacAutovalidateMode.always,
          validatorRules: const [
            StacFormFieldValidator(
              rule: 'matches',
              options: {'pattern': r'.+'},
              // تاریخ تولد الزامی است
              message: '{{appStrings.login.birthdateError}}',
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildSubmitButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'isLoginFormValid',
    loadingKey: 'isLoginLoading',
    onPressed: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'isLoginLoading', 'value': true},
            {
              'key': 'login.mobile',
              'value': const StacGetFormValueAction(
                id: 'mobile_number',
              ).toJson(),
            },
            {
              'key': 'login.nationalCode',
              'value': const StacGetFormValueAction(
                id: 'national_code',
              ).toJson(),
            },
            {
              'key': 'login.gpayToken',
              'value': const StacGetFormValueAction(id: 'gpay_token').toJson(),
            },
            {
              'key': 'login.cif',
              'value': const StacGetFormValueAction(id: 'cif').toJson(),
            },
            {
              'key': 'login.birthDate',
              'value': const StacGetFormValueAction(id: 'birthdate').toJson(),
            },
            {
              'key': 'login.birthDateClean',
              'value': "{{replace(login.birthDate,'/','')}}",
            },
          ],
        ),
        StacNetworkRequestAction(
          url: SduiBuildConfig.bizUrl('logins/v1.0/tobank/users'),
          method: 'post',
          headers: const {
            'accept': '*/*',
            'app-platform': 'android',
            'app-store': 'application/json',
            'app-version': '456',
            'authorization': 'Bearer null',
            'content-type': 'application/json',
            'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
            'serviceauthorization':
                'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
          },
          data: const {
            'nationalId': '{{login.nationalCode}}',
            'mobileNumber': '{{login.mobile}}',
            'gpayToken': '{{login.gpayToken}}',
            'birthDate': '{{login.birthDateClean}}',
            'cif': '{{login.cif}}',
          },
          results: [
            StacNetworkResult(
              statusCode: 200,
              action: StacSequenceAction(
                actions: [
                  StacCustomSetValueAction(
                    values: const [
                      {'key': 'isLoginLoading', 'value': false},
                      {
                        'key': 'auth.accessToken',
                        'value': '{{data.result.data.access_token}}',
                      },
                      {
                        'key': 'auth.accessTokenRaw',
                        'value':
                            "{{replace(data.result.data.access_token,'Bearer ','')}}",
                      },
                      {
                        'key': 'userData.nationalCode',
                        'value': '{{login.nationalCode}}',
                      },
                    ],
                  ),
                  const StacAuthPersistAction(
                    accessToken: '{{data.result.data.access_token}}',
                    nationalCode: '{{login.nationalCode}}',
                  ),
                  const {
                    'actionType': 'navigate',
                    'fileName': 'dashboard_shell',
                    'navMode': 'dart',
                    'navigationStyle': 'pushReplacement',
                  },
                ],
              ).toJson(),
            ),
            StacNetworkResult(
              statusCode: -1,
              action: const StacCustomSetValueAction(
                key: 'isLoginLoading',
                value: false,
              ).toJson(),
            ),
          ],
        ),
      ],
    ).toJson(),
    style: StacButtonStyle(
      backgroundColor: '{{appColors.current.primary.color}}',
      elevation: 0,
      fixedSize: StacSize(999999, 56),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(8)),
    ).toJson(),
    child: StacText(
      // ورود و ذخیره توکن
      data: '{{appStrings.login.receiveVerificationCode}}',
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.bold,
        color: '{{appColors.current.primary.onPrimary}}',
      ),
    ).toJson(),
  );
}

StacValidateFieldsAction _loginValidationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'isLoginFormValid',
    fields: [
      {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
      {'id': 'national_code', 'rule': r'^\d{10}$'},
      {'id': 'birthdate', 'rule': r'.+'},
    ],
  );
}

class StacAuthPersistAction extends StacAction {
  const StacAuthPersistAction({
    required this.accessToken,
    required this.nationalCode,
  });

  final String accessToken;
  final String nationalCode;

  @override
  String get actionType => 'auth_persist';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'auth_persist',
    'accessToken': accessToken,
    'nationalCode': nationalCode,
  };
}

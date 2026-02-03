import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import '../../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';

@StacScreen(screenName: 'promissory_real_login_form')
StacWidget promissoryRealLoginForm() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isLoginFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.loginDynamic}}',
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
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
                      data: '{{appStrings.promissory.enterInfoBelow}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 24),

                    // Mobile Number
                    StacText(
                      data: '{{appStrings.promissory.issuerPhoneNumber}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'mobile_number',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 11,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.mobileExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'phone',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message':
                              '{{appStrings.promissory.mobileFormatError}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // National Code
                    StacText(
                      data: '{{appStrings.promissory.nationalCode}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'national_code',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 10,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText:
                            '{{appStrings.promissory.nationalCode10Digit}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message':
                              '{{appStrings.promissory.nationalCodeLengthError}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // GPay Token
                    StacText(
                      data: 'GPay Token',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'gpay_token',
                      'textDirection': 'ltr',
                      'textAlign': 'left',
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.gpayTokenExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'text',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'.+',
                          'message':
                              '{{appStrings.promissory.gpayTokenRequired}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // CIF
                    StacText(
                      data: 'CIF',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'cif',
                      'textDirection': 'ltr',
                      'textAlign': 'left',
                      'decoration': StacInputDecoration(
                        hintText: '{{appStrings.promissory.cifExample}}',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ).toJson(),
                      'keyboardType': 'text',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'.+',
                          'message': '{{appStrings.promissory.cifRequired}}',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isLoginFormValid',
                        fields: [
                          {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          {'id': 'national_code', 'rule': r'^\d{10}$'},
                          {'id': 'gpay_token', 'rule': r'.+'},
                          {'id': 'cif', 'rule': r'.+'},
                          {'id': 'birthdate', 'rule': r'.+'},
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Birth Date (Using Date Picker Action)
                    StacText(
                      data: '{{appStrings.promissory.birthdate}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.label}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacGestureDetector(
                      onTap: StacPersianDatePickerAction(
                        formFieldId: 'birthdate',
                        firstDate: '1300/01/01',
                        lastDate: '1450/12/29',
                        onDateSelected: StacValidateFieldsAction(
                          resultKey: 'isLoginFormValid',
                          fields: [
                            {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                            {'id': 'national_code', 'rule': r'^\d{10}$'},
                            {'id': 'gpay_token', 'rule': r'.+'},
                            {'id': 'cif', 'rule': r'.+'},
                            {'id': 'birthdate', 'rule': r'.+'},
                          ],
                        ).toJson(),
                      ),
                      child: StacTextFormField(
                        id: 'birthdate',
                        readOnly: true,
                        enabled: false,
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText: '{{appStrings.promissory.birthdate}}',
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
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                        ),
                        keyboardType: StacTextInputType.text,
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: r'.+',
                            message:
                                '{{appStrings.promissory.birthdateRequired}}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isLoginFormValid',
                'onPressed': StacSequenceAction(
                  actions: [
                    // Copy form values to use in body
                    StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'login.mobile',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'mobile_number',
                          }).toJson(),
                        },
                        {
                          'key': 'login.nationalCode',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'national_code',
                          }).toJson(),
                        },
                        {
                          'key': 'login.gpayToken',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'gpay_token',
                          }).toJson(),
                        },
                        {
                          'key': 'login.cif',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'cif',
                          }).toJson(),
                        },
                        {
                          'key': 'login.birthDate',
                          'value': StacRawJsonAction({
                            'actionType': 'getFormValue',
                            'id': 'birthdate',
                          }).toJson(),
                        },
                        // Format birthdate: remove slashes
                        {
                          'key': 'login.birthDateClean',
                          'value': '{{replace(login.birthDate,"/","")}}',
                        },
                      ],
                    ),
                    StacNetworkRequestAction(
                      url:
                          'http://192.168.107.22:8280/api/digitalbanking/logins/v1.0/tobank/users',
                      method: 'post',
                      headers: {
                        'accept': '*/*',
                        'app-platform': 'android',
                        'app-store': 'application/json',
                        'app-version': '456',
                        'authorization':
                            'Bearer null', // As in original service
                        'content-type': 'application/json',
                        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                        'serviceauthorization':
                            'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                      },
                      data: {
                        'nationalId': '{{login.nationalCode}}',
                        'mobileNumber': '{{login.mobile}}',
                        'gpayToken': '{{login.gpayToken}}',
                        'birthDate': '{{login.birthDateClean}}',
                        'cif': '{{login.cif}}',
                      },
                      results: [
                        {
                          'statusCode': 200,
                          'action': StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                values: [
                                  {
                                    'key': 'auth.accessToken',
                                    'value': '{{data.access_token}}',
                                  },
                                  {
                                    'key': 'userData.nationalCode',
                                    'value': '{{login.nationalCode}}',
                                  },
                                ],
                              ),
                              StacRawJsonAction({
                                'actionType': 'showSnackBar',
                                'content': {
                                  'type': 'text',
                                  'data':
                                      '{{appStrings.promissory.loginSuccess}}',
                                },
                              }),
                              StacRawJsonAction({
                                'actionType': 'navigate',
                                'widgetType': 'promissory_real_receiver',
                                'navigationStyle': 'push',
                              }),
                            ],
                          ),
                        },
                        {
                          'statusCode': 'default',
                          'action': StacRawJsonAction({
                            'actionType': 'showSnackBar',
                            'content': {
                              'type': 'text',
                              'data': '{{appStrings.promissory.loginError}}',
                            },
                          }),
                        },
                      ],
                    ),
                  ],
                ),
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(8),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.loginSaveToken}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

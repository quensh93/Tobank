import 'package:stac_core/stac_core.dart';
import '../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import '../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';
import 'package:tobank_sdui/core/stac/parsers/actions/close_dialog_action_parser.dart';
// import 'package:flutter/material.dart' show Method; // Removed incorrect import

/// Dart STAC version of Tobank login/validation screen.
///
/// NOTE: This file generates JSON that matches GET_tobank_login.json structure.
/// Some style variables in numeric/bool fields (like padding, height, filled)
/// may need to be manually added to the generated JSON since Dart type system
/// doesn't allow strings where doubles/bools are expected.
@StacScreen(screenName: 'tobank_login_dart')
StacWidget tobankLoginDart() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isFormValid', value: false),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.login.validationTitle}}',
          textDirection: StacTextDirection.rtl,
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
                padding: StacEdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data: '{{appStrings.login.validationTitle}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.pageTitle}}'),
                    ),
                    StacSizedBox(height: 16.0),
                    StacText(
                      data: '{{appStrings.login.validationInstructions}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 16.0),
                    StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacText(
                          data: '{{appStrings.login.mobileNumberLabel}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                        ),
                        StacSizedBox(height: 8.0),
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
                            hintText:
                                '{{appStrings.login.mobileNumberPlaceholder}}',
                            hintStyle: StacCustomTextStyle(
                              color: '{{appStyles.input.login.hintStyleColor}}',
                              fontSize: 14.0,
                              fontWeight: StacFontWeight.w500,
                            ),
                            filled: false,
                            fillColor: '{{appStyles.input.login.fillColor}}',
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                          ).toJson(),
                          'keyboardType': 'number',
                          'textInputAction': 'next',
                          'style': StacCustomTextStyle(
                            fontSize: 16.0,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appStyles.input.login.textStyleColor}}',
                          ).toJson(),
                          'validatorRules': [
                            {
                              'rule': r'^09\d{9}$',
                              'message':
                                  '{{appStrings.login.mobileNumberError}}',
                            },
                          ],
                          'onChanged': StacValidateFieldsAction(
                            resultKey: 'isFormValid',
                            fields: [
                              {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                              {'id': 'national_code', 'rule': r'^\d{10}$'},
                              {
                                'id': 'birthdate',
                                'rule': r'^\d{4}/\d{2}/\d{2}$',
                              },
                            ],
                          ).toJson(),
                        }),
                        StacSizedBox(height: 16.0),
                        StacText(
                          data: '{{appStrings.login.nationalCodeTitle}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                        ),
                        StacSizedBox(height: 8.0),
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
                                '{{appStrings.login.nationalCodePlaceholder}}',
                            hintStyle: StacCustomTextStyle(
                              color: '{{appStyles.input.login.hintStyleColor}}',
                              fontSize: 14.0,
                              fontWeight: StacFontWeight.w500,
                            ),
                            filled: false,
                            fillColor: '{{appStyles.input.login.fillColor}}',
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                          ).toJson(),
                          'keyboardType': 'number',
                          'textInputAction': 'done',
                          'style': StacCustomTextStyle(
                            fontSize: 16.0,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appStyles.input.login.textStyleColor}}',
                          ).toJson(),
                          'validatorRules': [
                            {
                              'rule': r'^\d{10}$',
                              'message':
                                  '{{appStrings.login.nationalCodeError}}',
                            },
                          ],
                          'onChanged': StacValidateFieldsAction(
                            resultKey: 'isFormValid',
                            fields: [
                              {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                              {'id': 'national_code', 'rule': r'^\d{10}$'},
                              {
                                'id': 'birthdate',
                                'rule': r'^\d{4}/\d{2}/\d{2}$',
                              },
                            ],
                          ).toJson(),
                        }),
                        StacSizedBox(height: 16.0),
                        StacText(
                          data: '{{appStrings.login.birthdateLabel}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                        ),
                        StacSizedBox(height: 8.0),
                        StacGestureDetector(
                          onTap: StacPersianDatePickerAction(
                            formFieldId: 'birthdate',
                            firstDate: '1350/01/01',
                            lastDate: '1450/12/29',
                            onDateSelected: StacValidateFieldsAction(
                              resultKey: 'isFormValid',
                              fields: [
                                {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                                {'id': 'national_code', 'rule': r'^\d{10}$'},
                                {
                                  'id': 'birthdate',
                                  'rule': r'^\d{4}/\d{2}/\d{2}$',
                                },
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
                              hintText:
                                  '{{appStrings.login.birthdatePlaceholder}}',
                              hintStyle: StacCustomTextStyle(
                                color:
                                    '{{appStyles.input.loginDatePicker.hintStyleColor}}',
                                fontSize: 14.0,
                                fontWeight: StacFontWeight.w500,
                              ),
                              filled: false,
                              fillColor:
                                  '{{appStyles.input.loginDatePicker.fillColor}}',
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              prefixIcon: StacPadding(
                                padding: StacEdgeInsets.all(8.0),
                                child: StacImage(
                                  src: 'assets/icons/ic_calendar.svg',
                                  imageType: StacImageType.asset,
                                  width: 24.0,
                                  height: 24.0,
                                  fit: StacBoxFit.scaleDown,
                                  color:
                                      '{{appStyles.input.loginDatePicker.suffixIconColor}}',
                                ),
                              ),
                            ),
                            keyboardType: StacTextInputType.text,
                            style: StacCustomTextStyle(
                              fontSize: 16.0,
                              fontWeight: StacFontWeight.w600,
                              color:
                                  '{{appStyles.input.loginDatePicker.textStyleColor}}',
                            ),
                            validatorRules: [
                              StacFormFieldValidator(
                                rule: '^\\d{4}/\\d{2}/\\d{2}\$',
                                message: '{{appStrings.login.birthdateError}}',
                              ),
                            ],
                          ),
                        ),
                        StacSizedBox(height: 24.0),
                        StacRow(
                          mainAxisAlignment: StacMainAxisAlignment.center,
                          textDirection: StacTextDirection.rtl,
                          children: [
                            StacText(
                              data:
                                  '{{appStrings.login.agreeWithRulesMessage}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacAliasTextStyle(
                                '{{appStyles.text.agreementRegular}}',
                              ),
                            ),
                            StacTextButton(
                              onPressed: StacNavigateAction(
                                request: StacNetworkRequest(
                                  url:
                                      'https://api.tobank.com/screens/tobank_rules',
                                  method: Method.get,
                                ),
                                navigationStyle: NavigationStyle.push,
                              ),
                              style: StacButtonStyle(
                                foregroundColor:
                                    '{{appColors.current.secondary.color}}',
                              ),
                              child: StacText(
                                data:
                                    '{{appStrings.login.rulesAndRegulations}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacAliasTextStyle(
                                  '{{appStyles.text.agreementLink}}',
                                ),
                              ),
                            ),
                            StacText(
                              data: '{{appStrings.login.agreeSuffix}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacAliasTextStyle(
                                '{{appStyles.text.agreementRegular}}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.all(16.0),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isFormValid',
                'enabled': false,
                'onPressed': StacSetValueAction(
                  values: [
                    {
                      'key': 'form.mobile_number',
                      'value': StacGetFormValue(id: 'mobile_number').toJson(),
                    },
                    {
                      'key': 'form.national_code',
                      'value': StacGetFormValue(id: 'national_code').toJson(),
                    },
                    {
                      'key': 'form.birthdate',
                      'value': StacGetFormValue(id: 'birthdate').toJson(),
                    },
                    {
                      'key': 'appData.mobile_number',
                      'value': StacGetFormValue(id: 'mobile_number').toJson(),
                    },
                  ],
                  action: StacNetworkRequest(
                    url: 'https://api.tobank.com/verify-identity',
                    method: Method.post,
                    contentType: 'application/json',
                    body: {
                      'mobile_number': StacGetFormValue(
                        id: 'mobile_number',
                      ).toJson(),
                      'national_code': StacGetFormValue(
                        id: 'national_code',
                      ).toJson(),
                      'birthdate': StacGetFormValue(id: 'birthdate').toJson(),
                    },
                    results: [
                      StacNetworkResult(
                        statusCode: 200,
                        action: StacDialogAction(
                          widget: StacAlertDialog(
                            title: StacText(
                              data:
                                  '{{appStrings.login.dialogRequestResultTitle}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 18.0,
                                fontWeight: StacFontWeight.w700,
                                color: 'onSurface',
                              ),
                            ),
                            content: StacSingleChildScrollView(
                              child: StacColumn(
                                crossAxisAlignment:
                                    StacCrossAxisAlignment.stretch,
                                textDirection: StacTextDirection.rtl,
                                mainAxisSize: StacMainAxisSize.min,
                                children: [
                                  StacText(
                                    data:
                                        '{{appStrings.login.dialogRequestSentLabel}}',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14.0,
                                      fontWeight: StacFontWeight.w600,
                                      color: 'onSurface',
                                    ),
                                  ),
                                  StacSizedBox(height: 8),
                                  StacText(
                                    data:
                                        'URL: https://api.tobank.com/verify-identity\nMethod: POST\n\nBody:\n{\n  "mobile_number": "{{form.mobile_number}}",\n  "national_code": "{{form.national_code}}",\n  "birthdate": "{{form.birthdate}}"\n}',
                                    textDirection: StacTextDirection.ltr,
                                    style: StacCustomTextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'monospace',
                                      color: 'onSurface',
                                    ),
                                  ),
                                  StacSizedBox(height: 16),
                                  StacText(
                                    data:
                                        '{{appStrings.login.dialogResponseReceivedLabel}}',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14.0,
                                      fontWeight: StacFontWeight.w600,
                                      color: 'onSurface',
                                    ),
                                  ),
                                  StacSizedBox(height: 8),
                                  StacText(
                                    data:
                                        'Status: 200 OK\n\nResponse:\n{\n  "success": true,\n  "message": "{{appStrings.login.otpSentSuccessMessage}}",\n  "otpCode": "123456",\n  "expiresIn": 120\n}',
                                    textDirection: StacTextDirection.ltr,
                                    style: StacCustomTextStyle(
                                      fontSize: 11.0,
                                      fontFamily: 'monospace',
                                      color: 'onSurface',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              StacTextButton(
                                onPressed: StacCloseDialogAction(),
                                child: StacText(
                                  data:
                                      '{{appStrings.login.dialogConfirmButton}}',
                                  textDirection: StacTextDirection.rtl,
                                ),
                              ),
                            ],
                          ).toJson(),
                        ).toJson(),
                      ),
                    ],
                  ),
                ).toJson(),
                'style': StacButtonStyle(
                  backgroundColor:
                      '{{appStyles.button.primary.backgroundColor}}',
                  elevation: 0.0,
                  fixedSize: StacSize(999999.0, 56.0),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10.0),
                  ),
                  padding: StacEdgeInsets.only(top: 8.0, bottom: 8.0),
                  textStyle: StacCustomTextStyle(
                    color: '{{appStyles.button.primary.textStyleColor}}',
                    fontWeight: StacFontWeight.w600,
                    fontSize: 16.0,
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.login.receiveVerificationCode}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    color: '{{appStyles.button.primary.textStyleColor}}',
                    fontSize: 16.0,
                    fontWeight: StacFontWeight.w600,
                  ),
                ).toJson(),
              }),
            ),
            StacSizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

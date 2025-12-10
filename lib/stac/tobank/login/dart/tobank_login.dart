import 'package:stac_core/stac_core.dart';
import '../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';

/// Dart STAC version of Tobank login/validation screen.
///
/// NOTE: This file generates JSON that matches GET_tobank_login.json structure.
/// Some style variables in numeric/bool fields (like padding, height, filled)
/// may need to be manually added to the generated JSON since Dart type system
/// doesn't allow strings where doubles/bools are expected.
@StacScreen(screenName: 'tobank_login_dart')
StacWidget tobankLoginDart() {
  return StacScaffold(
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
                horizontal:
                    16.0, // TODO: Use {{appStyles.spacing.screenPaddingHorizontal}} in generated JSON
                vertical:
                    16.0, // TODO: Use {{appStyles.spacing.screenPaddingVertical}} in generated JSON
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
                  StacSizedBox(
                    height: 16.0,
                  ), // TODO: Use {{appStyles.spacing.betweenSections}} in generated JSON
                  StacText(
                    data: '{{appStrings.login.validationInstructions}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                  ),
                  StacSizedBox(
                    height: 16.0,
                  ), // TODO: Use {{appStyles.spacing.betweenSections}} in generated JSON
                  StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacText(
                        data: '{{appStrings.login.mobileNumberLabel}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacAliasTextStyle('{{appStyles.text.label}}'),
                      ),
                      StacSizedBox(
                        height: 8.0,
                      ), // TODO: Use {{appStyles.spacing.betweenLabelAndInput}} in generated JSON
                      StacTextFormField(
                        id: 'mobile_number',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText:
                              '{{appStrings.login.mobileNumberPlaceholder}}',
                          hintStyle: StacCustomTextStyle(
                            color: '{{appStyles.input.login.hintStyleColor}}',
                            fontSize:
                                14.0, // TODO: Use {{appStyles.input.login.hintStyleFontSize}} in generated JSON
                            fontWeight: StacFontWeight
                                .w500, // TODO: Use {{appStyles.input.login.hintStyleFontWeight}} in generated JSON
                          ),
                          filled:
                              false, // TODO: Use {{appStyles.input.login.filled}} in generated JSON
                          fillColor: '{{appStyles.input.login.fillColor}}',
                          // NOTE: Border properties (enabledBorderType, etc.) are not in base StacInputDecoration class
                          // These need to be added manually to generated JSON or via extended class
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal:
                                20.0, // TODO: Use {{appStyles.input.login.contentPaddingHorizontal}} in generated JSON
                            vertical:
                                16.0, // TODO: Use {{appStyles.input.login.contentPaddingVertical}} in generated JSON
                          ),
                        ),
                        keyboardType: StacTextInputType.number,
                        textInputAction: StacTextInputAction.next,
                        style: StacCustomTextStyle(
                          fontSize:
                              16.0, // TODO: Use {{appStyles.input.login.textStyleFontSize}} in generated JSON
                          fontWeight: StacFontWeight
                              .w600, // TODO: Use {{appStyles.input.login.textStyleFontWeight}} in generated JSON
                          color: '{{appStyles.input.login.textStyleColor}}',
                        ),
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: '^09\\d{9}\$',
                            message: '{{appStrings.login.mobileNumberError}}',
                          ),
                        ],
                      ),
                      StacSizedBox(
                        height: 16.0,
                      ), // TODO: Use {{appStyles.spacing.betweenSections}} in generated JSON
                      StacText(
                        data: '{{appStrings.login.nationalCodeTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacAliasTextStyle('{{appStyles.text.label}}'),
                      ),
                      StacSizedBox(
                        height: 8.0,
                      ), // TODO: Use {{appStyles.spacing.betweenLabelAndInput}} in generated JSON
                      StacTextFormField(
                        id: 'national_code',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        decoration: StacInputDecoration(
                          hintText:
                              '{{appStrings.login.nationalCodePlaceholder}}',
                          hintStyle: StacCustomTextStyle(
                            color: '{{appStyles.input.login.hintStyleColor}}',
                            fontSize:
                                14.0, // TODO: Use {{appStyles.input.login.hintStyleFontSize}} in generated JSON
                            fontWeight: StacFontWeight
                                .w500, // TODO: Use {{appStyles.input.login.hintStyleFontWeight}} in generated JSON
                          ),
                          filled:
                              false, // TODO: Use {{appStyles.input.login.filled}} in generated JSON
                          fillColor: '{{appStyles.input.login.fillColor}}',
                          // NOTE: Border properties need to be added manually to generated JSON
                          contentPadding: StacEdgeInsets.symmetric(
                            horizontal:
                                20.0, // TODO: Use {{appStyles.input.login.contentPaddingHorizontal}} in generated JSON
                            vertical:
                                16.0, // TODO: Use {{appStyles.input.login.contentPaddingVertical}} in generated JSON
                          ),
                        ),
                        keyboardType: StacTextInputType.number,
                        textInputAction: StacTextInputAction.done,
                        style: StacCustomTextStyle(
                          fontSize:
                              16.0, // TODO: Use {{appStyles.input.login.textStyleFontSize}} in generated JSON
                          fontWeight: StacFontWeight
                              .w600, // TODO: Use {{appStyles.input.login.textStyleFontWeight}} in generated JSON
                          color: '{{appStyles.input.login.textStyleColor}}',
                        ),
                        validatorRules: [
                          StacFormFieldValidator(
                            rule: '^\\d{10}\$',
                            message: '{{appStrings.login.nationalCodeError}}',
                          ),
                        ],
                      ),
                      StacSizedBox(
                        height: 16.0,
                      ), // TODO: Use {{appStyles.spacing.betweenSections}} in generated JSON
                      StacText(
                        data: '{{appStrings.login.birthdateLabel}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacAliasTextStyle('{{appStyles.text.label}}'),
                      ),
                      StacSizedBox(
                        height: 8.0,
                      ), // TODO: Use {{appStyles.spacing.betweenLabelAndInput}} in generated JSON
                      StacGestureDetector(
                        onTap: StacPersianDatePickerAction(
                          formFieldId: 'birthdate',
                          firstDate: '1350/01/01',
                          lastDate: '1450/12/29',
                        ),
                        child: StacTextFormField(
                          id: 'birthdate',
                          readOnly: true,
                          enabled: false,
                          // initialValue is not needed - controller will be updated directly by date picker action
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.right,
                          decoration: StacInputDecoration(
                            hintText:
                                '{{appStrings.login.birthdatePlaceholder}}',
                            hintStyle: StacCustomTextStyle(
                              color:
                                  '{{appStyles.input.loginDatePicker.hintStyleColor}}',
                              fontSize:
                                  14.0, // TODO: Use {{appStyles.input.loginDatePicker.hintStyleFontSize}} in generated JSON
                              fontWeight: StacFontWeight
                                  .w500, // TODO: Use {{appStyles.input.loginDatePicker.hintStyleFontWeight}} in generated JSON
                            ),
                            filled:
                                false, // TODO: Use {{appStyles.input.loginDatePicker.filled}} in generated JSON
                            fillColor:
                                '{{appStyles.input.loginDatePicker.fillColor}}',
                            // NOTE: Border properties need to be added manually to generated JSON
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal:
                                  16.0, // TODO: Use {{appStyles.input.loginDatePicker.contentPaddingHorizontal}} in generated JSON
                              vertical:
                                  16.0, // TODO: Use {{appStyles.input.loginDatePicker.contentPaddingVertical}} in generated JSON
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
                            fontSize:
                                16.0, // TODO: Use {{appStyles.input.loginDatePicker.textStyleFontSize}} in generated JSON
                            fontWeight: StacFontWeight
                                .w600, // TODO: Use {{appStyles.input.loginDatePicker.textStyleFontWeight}} in generated JSON
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
                      StacSizedBox(
                        height: 24.0,
                      ), // TODO: Use {{appStyles.spacing.beforeAgreement}} in generated JSON
                      StacRow(
                        mainAxisAlignment: StacMainAxisAlignment.center,
                        textDirection: StacTextDirection.rtl,
                        children: [
                          StacText(
                            data: '{{appStrings.login.agreeWithRulesMessage}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacAliasTextStyle('{{appStyles.text.agreementRegular}}'),
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
                              foregroundColor: '{{appColors.current.secondary.color}}',
                            ),
                            child: StacText(
                              data: '{{appStrings.login.rulesAndRegulations}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacAliasTextStyle('{{appStyles.text.agreementLink}}'),
                            ),
                          ),
                          StacText(
                            data: '{{appStrings.login.agreeSuffix}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacAliasTextStyle('{{appStyles.text.agreementRegular}}'),
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
            padding: StacEdgeInsets.all(
              16.0,
            ), // TODO: Use {{appStyles.spacing.buttonPadding}} in generated JSON
            child: StacElevatedButton(
              onPressed: StacFormValidate(
                isValid: StacSetValueAction(
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
                          widget: {
                            'type': 'alertDialog',
                            'title': {
                              'type': 'text',
                              'data':
                                  '{{appStrings.login.dialogRequestResultTitle}}',
                              'textDirection': 'rtl',
                              'style': {
                                'type': 'custom',
                                'fontSize': 18.0,
                                'fontWeight': 'w700',
                                'color': 'onSurface',
                              },
                            },
                            'content': {
                              'type': 'singleChildScrollView',
                              'child': {
                                'type': 'column',
                                'crossAxisAlignment': 'stretch',
                                'textDirection': 'rtl',
                                'mainAxisSize': 'min',
                                'children': [
                                  {
                                    'type': 'text',
                                    'data':
                                        '{{appStrings.login.dialogRequestSentLabel}}',
                                    'textDirection': 'rtl',
                                    'style': {
                                      'type': 'custom',
                                      'fontSize': 14.0,
                                      'fontWeight': 'w600',
                                      'color': 'onSurface',
                                    },
                                  },
                                  {'type': 'sizedBox', 'height': 8},
                                  {
                                    'type': 'text',
                                    'data':
                                        'URL: https://api.tobank.com/verify-identity\nMethod: POST\n\nBody:\n{\n  "mobile_number": "{{form.mobile_number}}",\n  "national_code": "{{form.national_code}}",\n  "birthdate": "{{form.birthdate}}"\n}',
                                    'textDirection': 'ltr',
                                    'style': {
                                      'type': 'custom',
                                      'fontSize': 11.0,
                                      'fontFamily': 'monospace',
                                      'color': 'onSurface',
                                    },
                                  },
                                  {'type': 'sizedBox', 'height': 16},
                                  {
                                    'type': 'text',
                                    'data':
                                        '{{appStrings.login.dialogResponseReceivedLabel}}',
                                    'textDirection': 'rtl',
                                    'style': {
                                      'type': 'custom',
                                      'fontSize': 14.0,
                                      'fontWeight': 'w600',
                                      'color': 'onSurface',
                                    },
                                  },
                                  {'type': 'sizedBox', 'height': 8},
                                  {
                                    'type': 'text',
                                    'data':
                                        'Status: 200 OK\n\nResponse:\n{\n  "success": true,\n  "message": "کد تایید با موفقیت ارسال شد",\n  "otpCode": "123456",\n  "expiresIn": 120\n}',
                                    'textDirection': 'ltr',
                                    'style': {
                                      'type': 'custom',
                                      'fontSize': 11.0,
                                      'fontFamily': 'monospace',
                                      'color': 'onSurface',
                                    },
                                  },
                                ],
                              },
                            },
                            'actions': [
                              {
                                'type': 'textButton',
                                'child': {
                                  'type': 'text',
                                  'data':
                                      '{{appStrings.login.dialogConfirmButton}}',
                                  'textDirection': 'rtl',
                                },
                                'onPressed': {'actionType': 'closeDialog'},
                              },
                            ],
                          },
                        ).toJson(),
                      ),
                    ],
                    // NOTE: onError is not supported in StacNetworkRequest Dart class
                    // Error handling should be done via results with error status codes
                    // or manually added to generated JSON
                  ),
                ),
                isNotValid: null,
              ),
              style: StacButtonStyle(
                backgroundColor: '{{appStyles.button.primary.backgroundColor}}',
                elevation:
                    0.0, // TODO: Use {{appStyles.button.primary.elevation}} in generated JSON
                fixedSize: StacSize(
                  999999.0,
                  56.0, // TODO: Use {{appStyles.button.primary.height}} in generated JSON
                ),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10.0),
                ),
                padding: StacEdgeInsets.only(
                  top:
                      8.0, // TODO: Use {{appStyles.button.primary.paddingTop}} in generated JSON
                  bottom:
                      8.0, // TODO: Use {{appStyles.button.primary.paddingBottom}} in generated JSON
                ),
                textStyle: StacCustomTextStyle(
                  color: '{{appStyles.button.primary.textStyleColor}}',
                  fontWeight: StacFontWeight
                      .w600, // TODO: Use {{appStyles.button.primary.textStyleFontWeight}} in generated JSON
                  fontSize:
                      16.0, // TODO: Use {{appStyles.button.primary.textStyleFontSize}} in generated JSON
                ),
              ),
              child: StacText(
                data: '{{appStrings.login.receiveVerificationCode}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  color: '{{appStyles.button.primary.textStyleColor}}',
                  fontSize:
                      16.0, // TODO: Use {{appStyles.button.primary.textStyleFontSize}} in generated JSON
                  fontWeight: StacFontWeight
                      .w600, // TODO: Use {{appStyles.button.primary.textStyleFontWeight}} in generated JSON
                ),
              ),
            ),
          ),
          StacSizedBox(height: 24),
        ],
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

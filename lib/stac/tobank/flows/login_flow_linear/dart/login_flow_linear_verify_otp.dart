import 'package:stac_core/stac_core.dart';

/// Linear Login Flow - Verify OTP Screen
///
/// This is the linear version of the verify OTP screen.
/// When OTP is verified successfully, it navigates back to menu.
/// No config file is used - navigation is handled internally.
@StacScreen(screenName: 'tobank_login_flow_linear_verify_otp')
StacWidget tobankLoginFlowLinearVerifyOtp() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.verifyOtp.title}}',
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
              padding: StacEdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacText(
                    data: '{{appStrings.verifyOtp.receiveVerificationCode}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 20.0,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                      fontFamily: 'IranYekan',
                    ),
                  ),
                  StacSizedBox(height: 16.0),
                  StacText(
                    data: 'کد تایید به شماره {{appData.mobile_number}} ارسال شد',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 14.0,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                      fontFamily: 'IranYekan',
                    ),
                  ),
                  StacSizedBox(height: 16.0),
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacExpanded(
                        child: StacText(
                          data: '{{appStrings.verifyOtp.wrongNumber}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 16.0,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                            fontFamily: 'IranYekan',
                          ),
                        ),
                      ),
                      StacTextButton(
                        onPressed: StacNavigateAction(
                          navigationStyle: NavigationStyle.pop,
                        ),
                        child: StacRow(
                          mainAxisAlignment: StacMainAxisAlignment.center,
                          mainAxisSize: StacMainAxisSize.min,
                          textDirection: StacTextDirection.rtl,
                          children: [
                            StacImage(
                              src: '{{appAssets.icons.edit}}',
                              imageType: StacImageType.asset,
                              width: 16.0,
                              height: 16.0,
                              color: '{{appColors.current.secondary.color}}',
                            ),
                            StacSizedBox(width: 8.0),
                            StacText(
                              data: '{{appStrings.verifyOtp.edit}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14.0,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.secondary.color}}',
                                fontFamily: 'IranYekan',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  StacSizedBox(height: 24.0),
                  StacRow(
                    textDirection: StacTextDirection.rtl,
                    crossAxisAlignment: StacCrossAxisAlignment.start,
                    children: [
                      StacExpanded(
                        child: StacSizedBox(
                          height: 56.0,
                          child: StacTextFormField(
                            id: 'otp_code',
                            textDirection: StacTextDirection.ltr,
                            textAlign: StacTextAlign.right,
                            keyboardType: StacTextInputType.number,
                            textInputAction: StacTextInputAction.done,
                            maxLength: 5,
                            decoration: StacInputDecoration(
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                            ),
                            style: StacCustomTextStyle(
                              fontSize: 24.0,
                              fontWeight: StacFontWeight.w600,
                              fontFamily: 'IranYekan',
                              letterSpacing: 8.0,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                        ),
                      ),
                      StacSizedBox(width: 8.0),
                      StacOutlinedButton(
                        onPressed: StacNetworkRequest(
                          url: 'https://api.tobank.com/resend-otp',
                          method: Method.post,
                          contentType: 'application/json',
                          body: {
                            'mobile_number': StacGetFormValue(id: 'mobile_number').toJson(),
                          },
                          results: [
                            StacNetworkResult(
                              statusCode: 200,
                              action: StacSetValueAction(
                                values: [
                                  {'key': 'form.otp_code', 'value': ''},
                                ],
                              ).toJson(),
                            ),
                          ],
                        ),
                        style: StacButtonStyle(
                          fixedSize: StacSize(90.0, 40.0),
                          shape: StacRoundedRectangleBorder(
                            borderRadius: StacBorderRadius.all(8.0),
                          ),
                        ),
                        child: StacText(
                          data: '{{appStrings.verifyOtp.sendAgain}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14.0,
                            fontWeight: StacFontWeight.w600,
                            fontFamily: 'IranYekan',
                            color: '{{appColors.current.secondary.color}}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.all(16.0),
            child: StacElevatedButton(
              onPressed: StacFormValidate(
                isValid: StacSetValueAction(
                  values: [
                    {
                      'key': 'form.otp_code',
                      'value': StacGetFormValue(id: 'otp_code').toJson(),
                    },
                  ],
                  action: StacNetworkRequest(
                    url: 'https://api.tobank.com/verify-otp',
                    method: Method.post,
                    contentType: 'application/json',
                    body: {
                      'mobile_number': StacGetFormValue(id: 'mobile_number').toJson(),
                      'otp_code': StacGetFormValue(id: 'otp_code').toJson(),
                    },
                    results: [
                      StacNetworkResult(
                        statusCode: 200,
                        action: StacDialogAction(
                          widget: {
                            'type': 'alertDialog',
                            'title': {
                              'type': 'text',
                              'data': 'پایان روند',
                              'textDirection': 'rtl',
                              'textAlign': 'center',
                              'style': {
                                'type': 'custom',
                                'fontSize': 20.0,
                                'fontWeight': 'w700',
                                'color': '{{appColors.current.text.title}}',
                              },
                            },
                            'contentPadding': {
                              'left': 24,
                              'right': 24,
                              'top': 20,
                              'bottom': 24,
                            },
                            'content': {
                              'type': 'column',
                              'crossAxisAlignment': 'center',
                              'mainAxisSize': 'min',
                              'children': [
                                {
                                  'type': 'image',
                                  'src': '{{appAssets.icons.success}}',
                                  'imageType': 'asset',
                                  'width': 80,
                                  'height': 80,
                                  'color': '{{appColors.current.success.color}}',
                                },
                                {'type': 'sizedBox', 'height': 20},
                                {
                                  'type': 'text',
                                  'data': 'تبریک! روند لاگین با موفقیت تکمیل شد.',
                                  'textDirection': 'rtl',
                                  'textAlign': 'center',
                                  'style': {
                                    'type': 'custom',
                                    'fontSize': 16.0,
                                    'fontWeight': 'w500',
                                    'color': '{{appColors.current.text.title}}',
                                    'height': 1.5,
                                  },
                                },
                                {'type': 'sizedBox', 'height': 12},
                                {
                                  'type': 'text',
                                  'data': 'اسپلش ← آنبردینگ ← ورود ← تایید کد',
                                  'textDirection': 'rtl',
                                  'textAlign': 'center',
                                  'style': {
                                    'type': 'custom',
                                    'fontSize': 13.0,
                                    'color': '{{appColors.current.text.subtitle}}',
                                  },
                                },
                                {'type': 'sizedBox', 'height': 24},
                                {
                                  'type': 'sizedBox',
                                  'width': double.infinity,
                                  'child': {
                                    'type': 'filledButton',
                                    'style': {
                                      'backgroundColor': '{{appColors.current.primary.color}}',
                                      'foregroundColor': '{{appColors.current.primary.onPrimary}}',
                                      'minimumSize': {
                                        'width': double.infinity,
                                        'height': 48,
                                      },
                                      'shape': {
                                        'type': 'roundedRectangle',
                                        'borderRadius': {
                                          'topLeft': 12,
                                          'topRight': 12,
                                          'bottomLeft': 12,
                                          'bottomRight': 12,
                                        },
                                      },
                                    },
                                    'child': {
                                      'type': 'text',
                                      'data': 'بازگشت به منو',
                                      'textDirection': 'rtl',
                                      'style': {
                                        'type': 'custom',
                                        'fontSize': 16.0,
                                        'color': '{{appColors.current.primary.onPrimary}}',
                                        'fontWeight': 'w600',
                                      },
                                    },
                                    'onPressed': {
                                      'actionType': 'multiAction',
                                      'actions': [
                                        {'actionType': 'closeDialog'},
                                        {
                                          'actionType': 'navigate',
                                          'navigationStyle': 'popAll',
                                        },
                                      ],
                                    },
                                  },
                                },
                              ],
                            },
                          },
                        ).toJson(),
                      ),
                    ],
                  ),
                ),
                isNotValid: null,
              ),
              style: StacButtonStyle(
                backgroundColor: '{{appStyles.button.primary.backgroundColor}}',
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
              ),
              child: StacText(
                data: '{{appStrings.verifyOtp.continueLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  color: '{{appStyles.button.primary.textStyleColor}}',
                  fontSize: 16.0,
                  fontWeight: StacFontWeight.w600,
                  fontFamily: 'IranYekan',
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


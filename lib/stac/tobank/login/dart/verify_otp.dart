import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import '../../../../core/stac/builders/stac_stateful_widget.dart';

/// Dart STAC version of Tobank OTP verification screen.
///
/// NOTE: This file generates JSON that matches GET_tobank_verify_otp.json structure.
/// Some style variables in numeric/bool fields (like padding, height, filled)
/// may need to be manually added to the generated JSON since Dart type system
/// doesn't allow strings where doubles/bools are expected.
@StacScreen(screenName: 'tobank_verify_otp_dart')
StacWidget tobankVerifyOtpDart() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(key: 'isFormValid', value: false),
    child: StacScaffold(
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
                padding: StacEdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    // Title: "دریافت کد تایید"
                    StacText(
                      data: '{{appStrings.verifyOtp.receiveVerificationCode}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 20.0,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 16.0),
                    // Subtitle: "کد تایید به شماره ... ارسال شد"
                    StacText(
                      data:
                          'کد تایید به شماره {{appData.mobile_number}} ارسال شد',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14.0,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 16.0),
                    // Row with "شماره اشتباه است" and Edit button
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
                                  color:
                                      '{{appColors.current.secondary.color}}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 24.0),
                    // OTP Input Row: TextField + Resend Button
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      crossAxisAlignment: StacCrossAxisAlignment.start,
                      children: [
                        StacExpanded(
                          child: StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'otp_code',
                            'textDirection': 'ltr',
                            'textAlign': 'right',
                            'maxLength': 5,
                            'inputFormatters': [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            'keyboardType': 'number',
                            'textInputAction': 'done',
                            'decoration': {
                              ...StacInputDecoration(
                                filled: false,
                                contentPadding: StacEdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 16.0,
                                ),
                              ).toJson(),
                              'helperText': ' ',
                              'helperStyle': {'type': 'custom', 'height': 0.5},
                            },
                            'style': StacCustomTextStyle(
                              fontSize: 24.0,
                              fontWeight: StacFontWeight.w600,
                              fontFamily: 'IranYekan',
                              letterSpacing: 8.0,
                              color: '{{appColors.current.text.title}}',
                            ).toJson(),
                            'validatorRules': [
                              {
                                'rule': r'^\d{5}$',
                                'message': 'کد تایید باید 5 رقم باشد',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isFormValid',
                              fields: [
                                {'id': 'otp_code', 'rule': r'^\d{5}$'},
                              ],
                            ).toJson(),
                          }),
                        ),
                        StacSizedBox(width: 8.0),
                        StacOutlinedButton(
                          onPressed: StacNetworkRequest(
                            url: 'https://api.tobank.com/resend-otp',
                            method: Method.post,
                            contentType: 'application/json',
                            body: {
                              'mobile_number': StacGetFormValue(
                                id: 'mobile_number',
                              ).toJson(),
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
                            fixedSize: StacSize(120.0, 60.0),
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
            // Continue Button at Bottom
            StacPadding(
              padding: StacEdgeInsets.all(16.0),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isFormValid',
                'enabled': false,
                'onPressed': StacSetValueAction(
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
                      'mobile_number': StacGetFormValue(
                        id: 'mobile_number',
                      ).toJson(),
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
                                  'color':
                                      '{{appColors.current.success.color}}',
                                },
                                {'type': 'sizedBox', 'height': 20},
                                {
                                  'type': 'text',
                                  'data':
                                      'تبریک! روند لاگین با موفقیت تکمیل شد.',
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
                                    'color':
                                        '{{appColors.current.text.subtitle}}',
                                  },
                                },
                                {'type': 'sizedBox', 'height': 24},
                                {
                                  'type': 'sizedBox',
                                  'width': 999999.0,
                                  'child': {
                                    'type': 'filledButton',
                                    'style': {
                                      'backgroundColor':
                                          '{{appColors.current.primary.color}}',
                                      'foregroundColor':
                                          '{{appColors.current.primary.onPrimary}}',
                                      'minimumSize': {
                                        'width': 999999.0,
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
                                        'color':
                                            '{{appColors.current.primary.onPrimary}}',
                                        'fontWeight': 'w600',
                                      },
                                    },
                                    'onPressed': {
                                      'actionType': 'multiAction',
                                      'actions': [
                                        {'actionType': 'closeDialog'},
                                        {
                                          'actionType': 'flowNext',
                                          'fallback': {
                                            'actionType': 'navigate',
                                            'navigationStyle': 'popAll',
                                          },
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
                  data: '{{appStrings.verifyOtp.continueLabel}}',
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

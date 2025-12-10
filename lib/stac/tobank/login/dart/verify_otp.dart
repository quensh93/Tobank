import 'package:stac_core/stac_core.dart';

/// Dart STAC version of Tobank OTP verification screen.
///
/// NOTE: This file generates JSON that matches GET_tobank_verify_otp.json structure.
/// Some style variables in numeric/bool fields (like padding, height, filled)
/// may need to be manually added to the generated JSON since Dart type system
/// doesn't allow strings where doubles/bools are expected.
@StacScreen(screenName: 'tobank_verify_otp_dart')
StacWidget tobankVerifyOtpDart() {
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
                    color: 'onSurface',
                  ),
                ),
                StacSizedBox(height: 16.0),
                // Subtitle: "کد تایید به شماره ... ارسال شد"
                StacText(
                  data: 'کد تایید به شماره {{appData.mobile_number}} ارسال شد',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14.0,
                    fontWeight: StacFontWeight.w500,
                    color: 'onSurface',
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
                          color: 'onSurface',
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
                            src: 'assets/icons/ic_edit.svg',
                            imageType: StacImageType.asset,
                            width: 16.0,
                            height: 16.0,
                            color: 'secondary',
                          ),
                          StacSizedBox(width: 8.0),
                          StacText(
                            data: '{{appStrings.verifyOtp.edit}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14.0,
                              fontWeight: StacFontWeight.w600,
                              color: 'secondary',
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
                            color: 'onSurface',
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
                          'mobile_number': StacGetFormValue(
                            id: 'mobile_number',
                          ).toJson(),
                        },
                        results: [
                          StacNetworkResult(
                            statusCode: 200,
                            action: StacSetValueAction(
                              values: [
                                {
                                  'key': 'form.otp_code',
                                  'value': '',
                                },
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
                          color: 'secondary',
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
                    'mobile_number': StacGetFormValue(
                      id: 'mobile_number',
                    ).toJson(),
                    'otp_code': StacGetFormValue(id: 'otp_code').toJson(),
                  },
                  results: [
                    StacNetworkResult(
                      statusCode: 200,
                      action: StacNavigateAction(
                        assetPath: 'lib/stac/.build/tobank_home.json',
                        navigationStyle: NavigationStyle.push,
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
              fixedSize: StacSize(
                999999.0,
                56.0,
              ),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10.0),
              ),
              padding: StacEdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
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

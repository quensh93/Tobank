import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_verify_otp')
StacWidget verifyIdentityRealVerifyOtp() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(key: 'isVerifyIdentityOtpValid', value: false),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).title,
        centerTitle: true,
        leading: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).leading,
        actions: [
          StacPadding(
            padding: StacEdgeInsets.only(right: 15),
            child: StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(22),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_support.svg',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ),
        ],
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacSizedBox(height: 12),
                    StacText(
                      data: 'دریافت کد تایید',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 20,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 24),
                    StacText(
                      data: 'کد ارسالی به شماره 09103611173 را وارد نمایید.',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 15,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.subtitle}}',
                        height: 1.8,
                      ),
                    ),
                    StacSizedBox(height: 24),
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      crossAxisAlignment: StacCrossAxisAlignment.start,
                      children: [
                        StacExpanded(
                          child: StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'verify_identity_otp_code',
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
                                hintText: 'کد تایید',
                                hintStyle: StacCustomTextStyle(
                                  fontSize: 15,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.hint}}',
                                ),
                                filled: false,
                                contentPadding: StacEdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                              ).toJson(),
                              'helperText': ' ',
                              'helperStyle': {'type': 'custom', 'height': 0.5},
                            },
                            'style': StacCustomTextStyle(
                              fontSize: 18,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                              letterSpacing: 4,
                            ).toJson(),
                            'validatorRules': [
                              {
                                'rule': r'^\d{5}$',
                                'message': '{{appStrings.verifyOtp.otpCodeError}}',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isVerifyIdentityOtpValid',
                              fields: [
                                {'id': 'verify_identity_otp_code', 'rule': r'^\d{5}$'},
                              ],
                            ).toJson(),
                          }),
                        ),
                        StacSizedBox(width: 12),
                        const StacCustomWidget.fromJson({
                          'type': 'otpCountdownButton',
                          'initialSeconds': 120,
                          'retryLabel': 'تلاش مجدد',
                          'iconAsset': 'assets/icons/ic_clock.svg',
                          'borderColor': '{{appColors.current.input.borderEnabled}}',
                          'countdownTextColor': '{{appColors.current.text.subtitle}}',
                          'retryTextColor': '{{appColors.current.primary.color}}',
                          'backgroundColor': '{{appColors.current.background.surface}}',
                          'height': 53,
                          'minWidth': 132,
                          'onRetry': {
                            'actionType': 'showSnackBar',
                            'backgroundColor': '#2E7D32',
                            'content': {
                              'type': 'text',
                              'data': 'کد فعالسازی دوباره ارسال شد',
                              'style': {
                                'type': 'custom',
                                'color': '#FFFFFF',
                                'fontSize': 14,
                              },
                            },
                          },
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isVerifyIdentityOtpValid',
                'enabled': false,
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 64),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                ).toJson(),
                'disabledStyle': StacButtonStyle(
                  backgroundColor:
                      '{{appColors.current.background.surfaceContainerHigh}}',
                  elevation: 0,
                  fixedSize: const StacSize(999999, 64),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(14),
                  ),
                ).toJson(),
                'child': StacText(
                  data: 'تایید کد',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
                'onPressed': const StacNavigateAction(
                  routeName: 'verify_identity_real_national_card_front',
                  navigationStyle: NavigationStyle.push,
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

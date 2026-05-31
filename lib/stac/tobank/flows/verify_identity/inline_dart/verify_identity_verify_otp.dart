import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'verify_identity_verify_otp')
StacWidget verifyIdentityRealVerifyOtp() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'isVerifyIdentityOtpValid',
      value: false,
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ),
      body: StacSafeArea(
        bottom: true,
        top: false,
        child: StacForm(
          autovalidateMode: StacAutovalidateMode.onUserInteraction,
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacExpanded(
                child: StacSingleChildScrollView(
                  padding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      StacSizedBox(height: 12),
                      StacText(
                        data: '{{appStrings.authentication.otpTitle}}',
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
                        data: '{{appStrings.authentication.otpDescription}}',
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
                            child: StacCustomTextFormField(
                              id: 'verify_identity_otp_code',
                              textDirection: 'ltr',
                              textAlign: 'right',
                              maxLength: 5,
                              inputFormatters: const [
                                {'type': 'allow', 'rule': '[0-9]'},
                              ],
                              keyboardType: 'number',
                              textInputAction: 'done',
                              decoration: {
                                ...StacInputDecoration(
                                  hintText:
                                      '{{appStrings.authentication.otpCodeHint}}',
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
                                'helperStyle': {
                                  'type': 'custom',
                                  'height': 0.5,
                                },
                              },
                              style: StacCustomTextStyle(
                                fontSize: 18,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.text.title}}',
                                letterSpacing: 4,
                              ).toJson(),
                              validatorRules: const [
                                {
                                  'rule': r'^\d{5}$',
                                  'message':
                                      '{{appStrings.verifyOtp.otpCodeError}}',
                                },
                              ],
                              onChanged: StacValidateFieldsAction(
                                resultKey: 'isVerifyIdentityOtpValid',
                                fields: [
                                  {
                                    'id': 'verify_identity_otp_code',
                                    'rule': r'^\d{5}$',
                                  },
                                ],
                              ).toJson(),
                            ),
                          ),
                          StacSizedBox(width: 12),
                          StacCustomWidget.fromJson({
                            'type': 'otpCountdownButton',
                            'initialSeconds': 120,
                            'retryLabel':
                                '{{appStrings.authentication.otpRetryLabel}}',
                            'iconAsset': '{{appAssets.icons.timer}}',
                            'borderColor':
                                '{{appColors.current.input.borderEnabled}}',
                            'expiredBorderColor':
                                '{{appColors.current.primary.color}}',
                            'countdownTextColor':
                                '{{appColors.current.text.subtitle}}',
                            'retryTextColor':
                                '{{appColors.current.text.title}}',
                            'backgroundColor':
                                '{{appColors.current.background.surface}}',
                            'height': 56,
                            'minWidth': 132,
                            'onRetry': StacCustomSnackBarAction(
                              title: 'اعلان',
                              detail:
                                  '{{appStrings.authentication.otpResentMessage}}',
                            ).toJson(),
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
                    data: '{{appStrings.authentication.confirmOtpButton}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ).toJson(),
                  'onPressed': const StacNavigateAction(
                    routeName: 'verify_identity_national_card_front',
                    navigationStyle: NavigationStyle.push,
                  ).toJson(),
                }),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


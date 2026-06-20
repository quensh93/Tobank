import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'biometric_test_menu')
StacWidget biometricTestMenu() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data:
            '{{appStrings.generated.biometric_test.biometric_test_menu.title}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      centerTitle: true,
      leading: StacIconButton(
        onPressed: const StacNavigateAction(
          navigationStyle: NavigationStyle.pop,
        ),
        icon: StacImage(
          src: '{{appAssets.icons.arrowRight}}',
          imageType: StacImageType.asset,
          width: 24,
          height: 24,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ),
    body: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacSingleChildScrollView(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.availability_check_title}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.passkey}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkAvailability',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.status_submit}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.status_active_current_submit_user}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkRegistration',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.status_passkey}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.account_credential_real_web_authn}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'checkPasskeyRegistration',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.credential}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_new_main_credential_user}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricRegister',
                  'title':
                      '{{appStrings.generated.biometric_test.biometric_test_menu.credential}}',
                  'description':
                      '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_credential}}',
                  'userId': 'biometric_test_user',
                  'passkeyOnly': true,
                  'onSuccess': {
                    'actionType': 'customSnackBar',
                    'message':
                        '{{appStrings.generated.biometric_test.biometric_test_menu.credential_text}}',
                  },
                  'onFailure': {
                    'actionType': 'customSnackBar',
                    'message':
                        '{{appStrings.generated.biometric_test.biometric_test_menu.failed_credential}}',
                    'backgroundColor': '#B00020',
                  },
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.credential_debug}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.details_submit_credential_result}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'createCredential',
                  'userId': 'biometric_test_user',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.authentication}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.new_authenticate_submit_credential}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'authenticate',
                  'reason': 'Biometric module test',
                  'userId': 'biometric_test_user',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_finger_print}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_new_main_stac_submit}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'fingerPrint',
                  'title':
                      '{{appStrings.generated.biometric_test.biometric_test_menu.title}}',
                  'description':
                      '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_continue_new_credential}}',
                  'userId': 'biometric_test_user',
                  'onSuccess': {
                    'actionType': 'customSnackBar',
                    'message':
                        '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_success}}',
                  },
                  'onFailure': {
                    'actionType': 'customSnackBar',
                    'message':
                        '{{appStrings.generated.biometric_test.biometric_test_menu.authentication_failed_cancel}}',
                    'backgroundColor': '#B00020',
                  },
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.delete_credential}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.save_credential_until_submit_again}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'clearCredential',
                },
              ),
            ),
            StacSizedBox(height: 12),
            _buildActionButton(
              title:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.biometric}}',
              description:
                  '{{appStrings.generated.biometric_test.biometric_test_menu.until}}',
              action: const StacAction(
                jsonData: {
                  'actionType': 'biometricDebug',
                  'operation': 'logProbe',
                  'message': 'biometric_test_menu_log_probe',
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildActionButton({
  required String title,
  required String description,
  required StacAction action,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacFilledButton(
        onPressed: action,
        style: StacButtonStyle(
          padding: StacEdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
          backgroundColor:
              '{{appColors.current.button.primary.backgroundColor}}',
          foregroundColor:
              '{{appColors.current.button.primary.foregroundColor}}',
        ),
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.center,
          style: StacTextStyle(fontSize: 15, fontWeight: StacFontWeight.w600),
        ),
      ),
      StacSizedBox(height: 6),
      StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 4),
        child: StacText(
          data: description,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 11,
            height: 1.45,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
    ],
  );
}

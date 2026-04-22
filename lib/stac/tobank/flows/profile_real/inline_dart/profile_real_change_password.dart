import 'package:stac_core/stac_core.dart';
import 'profile_real_app_bar.dart';

@StacScreen(screenName: 'profile_real_change_password')
StacWidget profileRealChangePassword() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildProfileRealAppBar(title: 'ØªØºÛŒÛŒØ± Ø±Ù…Ø² Ø¹Ø¨ÙˆØ±'),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _passwordSection(
                  label: 'Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± ÙØ¹Ù„ÛŒ',
                  fieldId: 'profileRealCurrentPassword',
                  hint: 'Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± ÙØ¹Ù„ÛŒ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯',
                  action: StacTextInputAction.next,
                ),
                StacSizedBox(height: 16),
                _passwordSection(
                  label: 'Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± Ø¬Ø¯ÛŒØ¯',
                  fieldId: 'profileRealNewPassword',
                  hint: 'Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± Ø¬Ø¯ÛŒØ¯ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯',
                  action: StacTextInputAction.next,
                ),
                StacSizedBox(height: 12),
                _passwordRule(text: 'Ø´Ø§Ù…Ù„ Ø­Ø±ÙˆÙ Ú©ÙˆÚ†Ú© Ùˆ Ø¨Ø²Ø±Ú¯ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ'),
                StacSizedBox(height: 8),
                _passwordRule(text: 'Ø´Ø§Ù…Ù„ Ø­Ø¯Ø§Ù‚Ù„ Û¸ Ú©Ø§Ø±Ø§Ú©ØªØ±'),
                StacSizedBox(height: 8),
                _passwordRule(text: 'Ø´Ø§Ù…Ù„ Ø¹Ø¯Ø¯'),
                StacSizedBox(height: 20),
                _passwordSection(
                  label: 'ØªÚ©Ø±Ø§Ø± Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± Ø¬Ø¯ÛŒØ¯',
                  fieldId: 'profileRealConfirmNewPassword',
                  hint: 'Ø±Ù…Ø² Ø¹Ø¨ÙˆØ± Ø¬Ø¯ÛŒØ¯ Ø±Ø§ Ø¯ÙˆØ¨Ø§Ø±Ù‡ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯',
                  action: StacTextInputAction.done,
                ),
              ],
            ),
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacContainer(
            height: 56,
            decoration: StacBoxDecoration(
              color: '#A4A7AC',
              borderRadius: StacBorderRadius.all(10),
            ),
            child: StacCenter(
              child: StacText(
                data: 'ØªØ§ÛŒÛŒØ¯ Ùˆ Ø°Ø®ÛŒØ±Ù‡',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '#F4F4F5',
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _passwordRule({required String text}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.start,
    children: [
      StacIcon(
        icon: 'info_outline',
        size: 16,
        color: '{{appColors.current.text.hint}}',
      ),
      StacSizedBox(width: 4),
      StacText(
        data: text,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ),
      ),
    ],
  );
}

StacWidget _passwordSection({
  required String label,
  required String fieldId,
  required String hint,
  required StacTextInputAction action,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: fieldId,
        obscureText: true,
        obscuringCharacter: '*',
        keyboardType: StacTextInputType.visiblePassword,
        textInputAction: action,
        textDirection: StacTextDirection.ltr,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
        decoration: StacInputDecoration(
          hintText: hint,
          hintStyle: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w400,
            color: '{{appColors.current.text.hint}}',
          ),
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
      ),
    ],
  );
}

import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_change_password')
StacWidget profileRealChangePassword() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      showBack: true,
      title: 'تغییر رمز عبور',
    ),
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
                  label: 'رمز عبور فعلی',
                  fieldId: 'profileRealCurrentPassword',
                  hint: 'رمز عبور فعلی را وارد کنید',
                  action: StacTextInputAction.next,
                ),
                StacSizedBox(height: 16),
                _passwordSection(
                  label: 'رمز عبور جدید',
                  fieldId: 'profileRealNewPassword',
                  hint: 'رمز عبور جدید را وارد کنید',
                  action: StacTextInputAction.next,
                ),
                StacSizedBox(height: 12),
                _passwordRule(text: 'شامل حروف کوچک و بزرگ انگلیسی'),
                StacSizedBox(height: 8),
                _passwordRule(text: 'شامل حداقل ۸ کاراکتر'),
                StacSizedBox(height: 8),
                _passwordRule(text: 'شامل عدد'),
                StacSizedBox(height: 20),
                _passwordSection(
                  label: 'تکرار رمز عبور جدید',
                  fieldId: 'profileRealConfirmNewPassword',
                  hint: 'رمز عبور جدید را دوباره وارد کنید',
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
                data: 'تایید و ذخیره',
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

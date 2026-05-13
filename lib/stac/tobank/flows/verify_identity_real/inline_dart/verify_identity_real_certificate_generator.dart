import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_certificate_generator')
StacWidget verifyIdentityRealCertificateGenerator() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'isVerifyIdentityCertificateInfoValid', 'value': false},
        {'key': 'hasVerifyIdentityEnglishFirstNameInput', 'value': false},
        {'key': 'hasVerifyIdentityEnglishLastNameInput', 'value': false},
        {'key': 'hasVerifyIdentityEmailInput', 'value': false},
        {'key': 'hasVerifyIdentityHomePhoneInput', 'value': false},
      ],
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
                      StacSizedBox(height: 8),
                      StacText(
                        data: 'لطفا اطلاعات تکمیلی مورد نیاز را وارد کنید',
                        textDirection: StacTextDirection.rtl,
                        textAlign: StacTextAlign.right,
                        style: StacCustomTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.subtitle}}',
                          height: 1.8,
                        ),
                      ),
                      StacSizedBox(height: 28),
                      _buildFieldLabel('نام به انگلیسی'),
                      StacSizedBox(height: 8),
                      _buildEnglishInfoField(
                        id: 'verify_identity_english_first_name',
                        hasValueKey: 'hasVerifyIdentityEnglishFirstNameInput',
                        hintText: 'نام خود را به انگلیسی وارد کنید',
                        keyboardType: 'text',
                        textInputAction: 'next',
                        validatorRule: r'^[A-Za-z ]{2,}$',
                        validatorMessage:
                            'لطفا نام را به انگلیسی و به‌صورت صحیح وارد کنید',
                        inputFormatters: const [
                          {'type': 'allow', 'rule': '[A-Za-z ]'},
                        ],
                        maxLength: 40,
                      ),
                      StacSizedBox(height: 18),
                      _buildFieldLabel('نام خانوادگی به انگلیسی'),
                      StacSizedBox(height: 8),
                      _buildEnglishInfoField(
                        id: 'verify_identity_english_last_name',
                        hasValueKey: 'hasVerifyIdentityEnglishLastNameInput',
                        hintText: 'نام خانوادگی خود را به انگلیسی وارد کنید',
                        keyboardType: 'text',
                        textInputAction: 'next',
                        validatorRule: r'^[A-Za-z ]{2,}$',
                        validatorMessage:
                            'لطفا نام خانوادگی را به انگلیسی و به‌صورت صحیح وارد کنید',
                        inputFormatters: const [
                          {'type': 'allow', 'rule': '[A-Za-z ]'},
                        ],
                        maxLength: 60,
                      ),
                      StacSizedBox(height: 18),
                      _buildFieldLabel('ایمیل'),
                      StacSizedBox(height: 8),
                      _buildEnglishInfoField(
                        id: 'verify_identity_email',
                        hasValueKey: 'hasVerifyIdentityEmailInput',
                        hintText: 'ایمیل خود را وارد کنید',
                        keyboardType: 'emailAddress',
                        textInputAction: 'next',
                        validatorRule:
                            r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
                        validatorMessage: 'لطفا ایمیل معتبر وارد کنید',
                        maxLength: 80,
                      ),
                      StacSizedBox(height: 18),
                      _buildFieldLabel('شماره تلفن منزل'),
                      StacSizedBox(height: 8),
                      _buildEnglishInfoField(
                        id: 'verify_identity_home_phone',
                        hasValueKey: 'hasVerifyIdentityHomePhoneInput',
                        hintText:
                            'شماره تلفن منزل را با پیش شماره استان وارد کنید',
                        keyboardType: 'phone',
                        textInputAction: 'done',
                        validatorRule: r'^0\d{10}$',
                        validatorMessage:
                            'لطفا شماره تلفن منزل را با پیش‌شماره صحیح وارد کنید',
                        inputFormatters: const [
                          {'type': 'allow', 'rule': '[0-9]'},
                        ],
                        maxLength: 11,
                      ),
                    ],
                  ),
                ),
              ),
              StacPadding(
                padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: StacCustomReactiveElevatedButton(
                  enabledKey: 'isVerifyIdentityCertificateInfoValid',
                  enabled: false,
                  onPressed: const StacNavigateAction(
                    routeName: 'verify_identity_real_final',
                    navigationStyle: NavigationStyle.push,
                  ),
                  style: StacButtonStyle(
                    backgroundColor: '{{appColors.current.primary.color}}',
                    elevation: 0,
                    fixedSize: const StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  disabledStyle: StacButtonStyle(
                    backgroundColor:
                        '{{appColors.current.background.surfaceContainerHigh}}',
                    elevation: 0,
                    fixedSize: const StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  child: StacText(
                    data: 'تکمیل فرآیند',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ).toJson(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _buildFieldLabel(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _buildEnglishInfoField({
  required String id,
  required String hasValueKey,
  required String hintText,
  required String keyboardType,
  required String textInputAction,
  required String validatorRule,
  required String validatorMessage,
  List<Map<String, dynamic>>? inputFormatters,
  int? maxLength,
}) {
  final json = StacCustomTextFormField(
    id: id,
    textDirection: 'ltr',
    textAlign: 'right',
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    decoration: {
      ...StacInputDecoration(
        hintText: hintText,
        hintStyle: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ),
        filled: false,
        contentPadding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 18),
        suffixIcon: StacRawJsonWidget({
          'type': 'visibility',
          'visible': '[[$hasValueKey]]',
          'child': StacGestureDetector(
            onTap: _buildClearFieldAction(id: id, hasValueKey: hasValueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(12),
              child: StacIcon(
                icon: StacIcons.close,
                size: 20,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ).toJson(),
        }),
      ).toJson(),
      'helperText': ' ',
      'helperStyle': {'type': 'custom', 'height': 0.5},
    },
    style: StacCustomTextStyle(
      fontSize: 16,
      fontWeight: StacFontWeight.w600,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    validatorRules: [
      {'rule': validatorRule, 'message': validatorMessage},
    ],
    onChanged: StacSequenceAction(
      actions: [
        StacValidateFieldsAction(
          resultKey: hasValueKey,
          fields: [
            {'id': id},
          ],
        ),
        _certificateValidationAction(),
      ],
    ).toJson(),
  ).toJson();

  if (maxLength != null) {
    json['maxLength'] = maxLength;
  }
  if (inputFormatters != null) {
    json['inputFormatters'] = inputFormatters;
  }

  return StacRawJsonWidget(json);
}

StacSequenceAction _buildClearFieldAction({
  required String id,
  required String hasValueKey,
}) {
  return StacSequenceAction(
    actions: [
      StacCustomSetValueAction(
        values: [
          {'key': id, 'value': ''},
          {'key': hasValueKey, 'value': false},
          {'key': 'isVerifyIdentityCertificateInfoValid', 'value': false},
        ],
      ),
    ],
  );
}

StacValidateFieldsAction _certificateValidationAction() {
  return const StacValidateFieldsAction(
    resultKey: 'isVerifyIdentityCertificateInfoValid',
    fields: [
      {'id': 'verify_identity_english_first_name', 'rule': r'^[A-Za-z ]{2,}$'},
      {'id': 'verify_identity_english_last_name', 'rule': r'^[A-Za-z ]{2,}$'},
      {
        'id': 'verify_identity_email',
        'rule': r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
      },
      {'id': 'verify_identity_home_phone', 'rule': r'^0\d{10}$'},
    ],
  );
}

import 'package:stac_core/stac_core.dart';
import '../../../../core/stac/builders/stac_custom_actions.dart';
import '../../../../core/stac/builders/stac_stateful_widget.dart';

/// Example of using StacStatefulWidget in Dart to generate 'stateFull' JSON.
///
/// This matches the structure of tobank_stateful_example.json but written in Dart.
@StacScreen(screenName: 'tobank_stateful_example_dart')
StacWidget tobankStatefulExampleDart() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'screenId', 'value': 'stateful_example'},
            {'key': 'lastStatus', 'value': 'idle'},
            {'key': 'lastMessage', 'value': '-'},
            {'key': 'live.mobile_number', 'value': '-'},
            {'key': 'live.national_code', 'value': '-'},
            {'key': 'live.birthdate', 'value': '-'},
            {'key': 'parallelEnabled', 'value': false},
            {'key': 'initAt', 'value': '{{now()}}'},
          ],
        ),
        StacLogAction(
          message:
              '?????? screen=stateful_example action=national_code_input tracking=enabled',
        ),
        StacLogAction(message: 'screen=stateful_example action=onInit'),
      ],
    ),
    onBuild: StacLogAction(message: 'screen=stateful_example action=onBuild'),
    onDispose: StacSequenceAction(
      actions: [
        StacLogAction(message: 'screen=stateful_example action=onDispose'),
        StacLogAction(
          message: 'screen=stateful_example lifetimeMs={{now() - initAt}}',
        ),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'تست استیت فول',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.text.title}}'),
        ),
        centerTitle: true,
      ),
      body: StacSingleChildScrollView(
        child: StacForm(
          autovalidateMode: StacAutovalidateMode.onUserInteraction,
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            textDirection: StacTextDirection.rtl,
            children: [
              StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data:
                          'این صفحه برای تست stateFull، اکشن‌های زنجیره‌ای، لاگ، تاخیر، و درخواست شبکه است.',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 12),
                    StacText(
                      data: 'آخرین وضعیت:',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.title}}'),
                    ),
                    StacTextFormField(
                      id: 'lastStatus',
                      readOnly: true,
                      enabled: true,
                      decoration: StacInputDecoration(
                        hintText: 'وضعیت آخرین اجرا',
                        filled: true,
                        fillColor: '{{appColors.current.background.surface}}',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: 'پیام:',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.title}}'),
                    ),
                    StacTextFormField(
                      id: 'lastMessage',
                      readOnly: true,
                      enabled: true,
                      decoration: StacInputDecoration(
                        hintText: 'آخرین پیام',
                        filled: true,
                        fillColor: '{{appColors.current.background.surface}}',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: 'تغییرات فرم (زنده):',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.title}}'),
                    ),
                    StacTextFormField(
                      id: 'live.mobile_number',
                      readOnly: true,
                      enabled: true,
                      decoration: StacInputDecoration(
                        hintText: 'شماره موبایل',
                        filled: true,
                        fillColor: '{{appColors.current.background.surface}}',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacTextFormField(
                      id: 'live.national_code',
                      readOnly: true,
                      enabled: true,
                      decoration: StacInputDecoration(
                        hintText: 'کد ملی',
                        filled: true,
                        fillColor: '{{appColors.current.background.surface}}',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacTextFormField(
                      id: 'live.birthdate',
                      readOnly: true,
                      enabled: true,
                      decoration: StacInputDecoration(
                        hintText: 'تاریخ تولد',
                        filled: true,
                        fillColor: '{{appColors.current.background.surface}}',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 16),
                    StacFilledButton(
                      onPressed: StacSequenceAction(
                        actions: [
                          StacCustomSetValueAction(
                            key: 'runStart',
                            value: '{{now()}}',
                          ),
                          StacLogAction(
                            message: 'screen=stateful_example action=runStart',
                          ),
                          StacDelayAction(milliseconds: 300),
                          StacNetworkRequestAction(
                            url:
                                'https://api.tobank.com/stateful_example_status',
                            method: 'get',
                            results: [
                              {
                                'statusCode': 200,
                                'action': StacSequenceAction(
                                  actions: [
                                    StacCustomSetValueAction(
                                      key: 'lastStatus',
                                      value: 'success',
                                    ),
                                    StacCustomSetValueAction(
                                      key: 'lastMessage',
                                      value: 'دریافت موفق از API',
                                    ),
                                    StacLogAction(
                                      message:
                                          'screen=stateful_example action=apiSuccess',
                                    ),
                                  ],
                                ),
                              },
                              {
                                'statusCode': 500,
                                'action': StacSequenceAction(
                                  actions: [
                                    StacCustomSetValueAction(
                                      key: 'lastStatus',
                                      value: 'error',
                                    ),
                                    StacCustomSetValueAction(
                                      key: 'lastMessage',
                                      value: 'خطای سرور در API',
                                    ),
                                    StacLogAction(
                                      message:
                                          'screen=stateful_example action=apiServerError',
                                    ),
                                  ],
                                ),
                              },
                            ],
                          ),
                          StacDelayAction(milliseconds: 200),
                          StacNetworkRequestAction(
                            url:
                                'https://api.tobank.com/stateful_example_error',
                            method: 'get',
                            results: [
                              {
                                'statusCode': 400,
                                'action': StacSequenceAction(
                                  actions: [
                                    StacCustomSetValueAction(
                                      key: 'lastStatus',
                                      value: 'error',
                                    ),
                                    StacCustomSetValueAction(
                                      key: 'lastMessage',
                                      value: 'خطای اعتبارسنجی',
                                    ),
                                    StacLogAction(
                                      message:
                                          'screen=stateful_example action=apiClientError',
                                    ),
                                  ],
                                ),
                              },
                            ],
                          ),
                          StacLogAction(
                            message:
                                'screen=stateful_example action=runDone durationMs={{now() - runStart}}',
                          ),
                        ],
                      ),
                      style: StacButtonStyle(
                        backgroundColor: '{{appColors.current.primary.color}}',
                        foregroundColor:
                            '{{appColors.current.primary.onPrimary}}',
                        minimumSize: StacSize(999999, 48),
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.circular(12),
                        ),
                      ),
                      child: StacText(
                        data: 'اجرای تست کامل',
                        textDirection: StacTextDirection.rtl,
                        style: StacAliasTextStyle(
                          '{{appColors.current.primary.onPrimary}}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StacContainer(
                margin: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 1,
                color: '{{appColors.current.input.borderEnabled}}',
              ),
              StacPadding(
                padding: StacEdgeInsets.only(
                  left: 16,
                  top: 12,
                  right: 16,
                  bottom: 16,
                ),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacText(
                      data: 'فرم ورود (تست)',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.pageTitle}}'),
                    ),
                    StacSizedBox(height: 12),
                    StacText(
                      data: '{{appStrings.login.validationInstructions}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacAliasTextStyle('{{appStyles.text.subtitle}}'),
                    ),
                    StacSizedBox(height: 16),
                    StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacText(
                          data: '{{appStrings.login.mobileNumberLabel}}',
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                          textDirection: StacTextDirection.rtl,
                        ),
                        StacSizedBox(height: 8.0),
                        StacRawJsonWidget({
                          'type': 'textFormField',
                          'id': 'mobile_number',
                          'decoration': StacInputDecoration(
                            hintText:
                                '{{appStrings.login.mobileNumberPlaceholder}}',
                            hintStyle: StacCustomTextStyle(
                              color: '{{appStyles.input.login.hintStyleColor}}',
                              fontSize: 14.0,
                              fontWeight: StacFontWeight.w500,
                            ),
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                            filled: false,
                            fillColor: '{{appStyles.input.login.fillColor}}',
                          ).toJson(),
                          'keyboardType': StacTextInputType.number.name,
                          'textInputAction': StacTextInputAction.next.name,
                          'textAlign': StacTextAlign.right.name,
                          'style': StacCustomTextStyle(
                            color: '{{appStyles.input.login.textStyleColor}}',
                            fontSize: 16.0,
                            fontWeight: StacFontWeight.w600,
                          ).toJson(),
                          'textDirection': StacTextDirection.rtl.name,
                          'validatorRules': [
                            StacFormFieldValidator(
                              rule: r'^09\d{9}$',
                              message: '{{appStrings.login.mobileNumberError}}',
                            ).toJson(),
                          ],
                          'onChanged': StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                key: 'live.mobile_number',
                                value: StacGetFormValueAction(
                                  id: 'mobile_number',
                                ),
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=fieldChanged field=mobile_number value={{live.mobile_number}}',
                              ),
                              StacValidateFieldsAction(
                                resultKey: 'parallelEnabled',
                                fields: [
                                  {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                                  {'id': 'national_code', 'rule': r'^\d{10}$'},
                                  {
                                    'id': 'birthdate',
                                    'rule': r'^\d{4}/\d{2}/\d{2}$',
                                  },
                                ],
                              ),
                            ],
                          ).toJson(),
                        }),
                        StacSizedBox(height: 16.0),
                        StacText(
                          data: '{{appStrings.login.nationalCodeTitle}}',
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                          textDirection: StacTextDirection.rtl,
                        ),
                        StacSizedBox(height: 8.0),
                        StacRawJsonWidget({
                          'type': 'textFormField',
                          'id': 'national_code',
                          'decoration': StacInputDecoration(
                            hintText:
                                '{{appStrings.login.nationalCodePlaceholder}}',
                            hintStyle: StacCustomTextStyle(
                              color: '{{appStyles.input.login.hintStyleColor}}',
                              fontSize: 14.0,
                              fontWeight: StacFontWeight.w500,
                            ),
                            contentPadding: StacEdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                            filled: false,
                            fillColor: '{{appStyles.input.login.fillColor}}',
                          ).toJson(),
                          'keyboardType': StacTextInputType.number.name,
                          'textInputAction': StacTextInputAction.done.name,
                          'textAlign': StacTextAlign.right.name,
                          'style': StacCustomTextStyle(
                            color: '{{appStyles.input.login.textStyleColor}}',
                            fontSize: 16.0,
                            fontWeight: StacFontWeight.w600,
                          ).toJson(),
                          'textDirection': StacTextDirection.rtl.name,
                          'validatorRules': [
                            StacFormFieldValidator(
                              rule: r'^\d{10}$',
                              message: '{{appStrings.login.nationalCodeError}}',
                            ).toJson(),
                          ],
                          'onChanged': StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                key: 'live.national_code',
                                value: StacGetFormValueAction(
                                  id: 'national_code',
                                ),
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=fieldChanged field=national_code value={{live.national_code}}',
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=national_code_input value={{live.national_code}}',
                              ),
                              StacValidateFieldsAction(
                                resultKey: 'parallelEnabled',
                                fields: [
                                  {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                                  {'id': 'national_code', 'rule': r'^\d{10}$'},
                                  {
                                    'id': 'birthdate',
                                    'rule': r'^\d{4}/\d{2}/\d{2}$',
                                  },
                                ],
                              ),
                            ],
                          ).toJson(),
                        }),
                        StacSizedBox(height: 16.0),
                        StacText(
                          data: '{{appStrings.login.birthdateLabel}}',
                          style: StacAliasTextStyle('{{appStyles.text.label}}'),
                          textDirection: StacTextDirection.rtl,
                        ),
                        StacSizedBox(height: 8.0),
                        StacGestureDetector(
                          onTap: StacSequenceAction(
                            actions: [
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=birthdatePickerOpen',
                              ),
                              StacPersianDatePickerAction(
                                formFieldId: 'birthdate',
                                firstDate: '1350/01/01',
                                lastDate: '1450/12/29',
                                onDateSelected: StacSequenceAction(
                                  actions: [
                                    StacValidateFieldsAction(
                                      resultKey: 'parallelEnabled',
                                      fields: [
                                        {
                                          'id': 'mobile_number',
                                          'rule': r'^09\d{9}$',
                                        },
                                        {
                                          'id': 'national_code',
                                          'rule': r'^\d{10}$',
                                        },
                                        {
                                          'id': 'birthdate',
                                          'rule': r'^\d{4}/\d{2}/\d{2}$',
                                        },
                                      ],
                                    ),
                                    StacCustomSetValueAction(
                                      key: 'live.birthdate',
                                      value: StacGetFormValueAction(
                                        id: 'birthdate',
                                      ),
                                    ),
                                    StacLogAction(
                                      message:
                                          'screen=stateful_example action=birthdateChanged value={{live.birthdate}}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'birthdate',
                            'readOnly': true,
                            'enabled': false,
                            'decoration': StacInputDecoration(
                              hintText:
                                  '{{appStrings.login.birthdatePlaceholder}}',
                              hintStyle: StacCustomTextStyle(
                                color:
                                    '{{appStyles.input.loginDatePicker.hintStyleColor}}',
                                fontSize: 14.0,
                                fontWeight: StacFontWeight.w500,
                              ),
                              prefixIcon: StacPadding(
                                padding: StacEdgeInsets.all(8.0),
                                child: StacImage(
                                  src: 'assets/icons/ic_calendar.svg',
                                  imageType: StacImageType.asset,
                                  color:
                                      '{{appStyles.input.loginDatePicker.suffixIconColor}}',
                                  width: 24.0,
                                  height: 24.0,
                                  fit: StacBoxFit.scaleDown,
                                ),
                              ),
                              contentPadding: StacEdgeInsets.all(16.0),
                              filled: false,
                              fillColor:
                                  '{{appStyles.input.loginDatePicker.fillColor}}',
                            ).toJson(),
                            'keyboardType': StacTextInputType.text.name,
                            'textAlign': StacTextAlign.right.name,
                            'style': StacCustomTextStyle(
                              color:
                                  '{{appStyles.input.loginDatePicker.textStyleColor}}',
                              fontSize: 16.0,
                              fontWeight: StacFontWeight.w600,
                            ).toJson(),
                            'textDirection': StacTextDirection.rtl.name,
                            'validatorRules': [
                              StacFormFieldValidator(
                                rule: r'^\d{4}/\d{2}/\d{2}$',
                                message: '{{appStrings.login.birthdateError}}',
                              ).toJson(),
                            ],
                          }),
                        ),
                        StacSizedBox(height: 24.0),
                        StacRow(
                          mainAxisAlignment: StacMainAxisAlignment.center,
                          mainAxisSize: StacMainAxisSize.min,
                          textDirection: StacTextDirection.rtl,
                          children: [
                            StacText(
                              data:
                                  '{{appStrings.login.agreeWithRulesMessage}}',
                              style: StacAliasTextStyle(
                                '{{appStyles.text.agreementRegular}}',
                              ),
                              textDirection: StacTextDirection.rtl,
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
                              child: StacText(
                                data:
                                    '{{appStrings.login.rulesAndRegulations}}',
                                style: StacAliasTextStyle(
                                  '{{appStyles.text.agreementLink}}',
                                ),
                                textDirection: StacTextDirection.rtl,
                              ),
                            ),
                            StacText(
                              data: '{{appStrings.login.agreeSuffix}}',
                              style: StacAliasTextStyle(
                                '{{appStyles.text.agreementRegular}}',
                              ),
                              textDirection: StacTextDirection.rtl,
                            ),
                          ],
                        ),
                        StacSizedBox(height: 20),
                        StacRawJsonWidget({
                          'type': 'reactiveElevatedButton',
                          'enabledKey': 'parallelEnabled',
                          'enabled': false,
                          'style': StacButtonStyle(
                            backgroundColor:
                                '{{appStyles.button.primary.backgroundColor}}',
                            elevation: 0.0,
                            textStyle: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                color:
                                    '{{appStyles.button.primary.textStyleColor}}',
                                fontSize: 16.0,
                                fontWeight: StacFontWeight.w600,
                              ).toJson(),
                            ),
                            padding: StacEdgeInsets.symmetric(vertical: 8.0),
                            fixedSize: StacSize(999999.0, 52.0),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.circular(10.0),
                            ),
                          ).toJson(),
                          'disabledStyle': StacButtonStyle(
                            backgroundColor: '#3a3f4b',
                            elevation: 0.0,
                            textStyle: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                color: '#cbd5e1',
                                fontSize: 16.0,
                                fontWeight: StacFontWeight.w600,
                              ).toJson(),
                            ),
                            padding: StacEdgeInsets.symmetric(vertical: 8.0),
                            fixedSize: StacSize(999999.0, 52.0),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.circular(10.0),
                            ),
                          ).toJson(),
                          'child': StacText(
                            data: 'ارسال موازی (دو درخواست)',
                            textDirection: StacTextDirection.rtl,
                            style: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                color: '#FFFFFF',
                                fontSize: 16.0,
                                fontWeight: StacFontWeight.w600,
                              ).toJson(),
                            ),
                          ).toJson(),
                          'onPressed': StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                key: 'submitAt',
                                value: '{{now()}}',
                              ),
                              StacCustomSetValueAction(
                                key: 'live.mobile_number',
                                value: StacGetFormValueAction(
                                  id: 'mobile_number',
                                ),
                              ),
                              StacCustomSetValueAction(
                                key: 'live.national_code',
                                value: StacGetFormValueAction(
                                  id: 'national_code',
                                ),
                              ),
                              StacCustomSetValueAction(
                                key: 'live.birthdate',
                                value: StacGetFormValueAction(id: 'birthdate'),
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=formSubmitParallel start',
                              ),
                              StacAction.fromJson(
                                StacRawJsonWidget({
                                  'actionType': 'multiAction',
                                  'sync': false,
                                  'actions': [
                                    StacNetworkRequestAction(
                                      url:
                                          'https://api.tobank.com/stateful_example_parallel_a',
                                      method: 'get',
                                      results: [
                                        {
                                          'statusCode': 200,
                                          'action': StacSequenceAction(
                                            actions: [
                                              StacCustomSetValueAction(
                                                key: 'lastStatus',
                                                value: 'parallel_a_ok',
                                              ),
                                              StacCustomSetValueAction(
                                                key: 'lastMessage',
                                                value: 'درخواست A موفق',
                                              ),
                                              StacLogAction(
                                                message:
                                                    'screen=stateful_example action=parallelA status=200',
                                              ),
                                            ],
                                          ),
                                        },
                                      ],
                                    ).toJson(),
                                    StacNetworkRequestAction(
                                      url:
                                          'https://api.tobank.com/stateful_example_parallel_b',
                                      method: 'get',
                                      results: [
                                        {
                                          'statusCode': 500,
                                          'action': StacSequenceAction(
                                            actions: [
                                              StacCustomSetValueAction(
                                                key: 'lastStatus',
                                                value: 'parallel_b_error',
                                              ),
                                              StacCustomSetValueAction(
                                                key: 'lastMessage',
                                                value: 'درخواست B خطا داشت',
                                              ),
                                              StacLogAction(
                                                message:
                                                    'screen=stateful_example action=parallelB status=500',
                                              ),
                                            ],
                                          ),
                                        },
                                      ],
                                    ).toJson(),
                                  ],
                                }).json,
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=formSubmitParallel queued durationMs={{now() - submitAt}}',
                              ),
                            ],
                          ).toJson(),
                        }),
                        StacText(
                          data:
                              'سناریو: ذخیره مقادیر فرم → اجرای دو درخواست هم‌زمان (A=200، B=500) → به‌روزرسانی آخرین وضعیت و پیام.',
                          textDirection: StacTextDirection.rtl,
                          style: StacTextStyle.fromJson(
                            StacCustomTextStyle(
                              fontSize: 12.0,
                              color: '{{appColors.current.text.subtitle}}',
                            ).toJson(),
                          ),
                        ),
                        StacSizedBox(height: 12),
                        StacElevatedButton(
                          style: StacButtonStyle(
                            backgroundColor:
                                '{{appColors.current.success.color}}',
                            elevation: 0.0,
                            textStyle: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                color: '#FFFFFF',
                                fontSize: 15.0,
                                fontWeight: StacFontWeight.w600,
                              ).toJson(),
                            ),
                            padding: StacEdgeInsets.symmetric(vertical: 8.0),
                            fixedSize: StacSize(999999.0, 48.0),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                key: 'flowSuccessStart',
                                value: '{{now()}}',
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=flowSuccessStart',
                              ),
                              StacDelayAction(milliseconds: 2000),
                              StacNetworkRequestAction(
                                url:
                                    'https://api.tobank.com/stateful_example_status',
                                method: 'get',
                                results: [
                                  {
                                    'statusCode': 200,
                                    'action': StacSequenceAction(
                                      actions: [
                                        StacCustomSetValueAction(
                                          key: 'lastStatus',
                                          value: 'success',
                                        ),
                                        StacCustomSetValueAction(
                                          key: 'lastMessage',
                                          value: 'توالی موفق انجام شد',
                                        ),
                                        StacLogAction(
                                          message:
                                              'screen=stateful_example action=flowSuccessApiOk',
                                        ),
                                        StacRawJsonWidget({
                                          'actionType': 'showDialog',
                                          'widget': {
                                            'type': 'alertDialog',
                                            'title': StacText(
                                              data: 'موفقیت',
                                              textDirection:
                                                  StacTextDirection.rtl,
                                              style: StacTextStyle.fromJson(
                                                StacCustomTextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      StacFontWeight.w700,
                                                  color:
                                                      '{{appColors.current.text.title}}',
                                                ).toJson(),
                                              ),
                                            ).toJson(),
                                            'content': StacText(
                                              data:
                                                  'درخواست با موفقیت انجام شد.',
                                              textDirection:
                                                  StacTextDirection.rtl,
                                              style: StacTextStyle.fromJson(
                                                StacCustomTextStyle(
                                                  fontSize: 14.0,
                                                  color:
                                                      '{{appColors.current.text.subtitle}}',
                                                ).toJson(),
                                              ),
                                            ).toJson(),
                                            'actions': [
                                              StacTextButton(
                                                child: StacText(
                                                  data: 'باشه',
                                                  textDirection:
                                                      StacTextDirection.rtl,
                                                ),
                                                onPressed: StacAction.fromJson(
                                                  StacRawJsonWidget({
                                                    'actionType': 'closeDialog',
                                                  }).json,
                                                ),
                                              ).toJson(),
                                            ],
                                          },
                                        }).json,
                                      ],
                                    ),
                                  },
                                ],
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=flowSuccessDone durationMs={{now() - flowSuccessStart}}',
                              ),
                            ],
                          ),
                          child: StacText(
                            data: 'ادامه تست توالی موفق',
                            textDirection: StacTextDirection.rtl,
                            style: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                fontSize: 15.0,
                                fontWeight: StacFontWeight.w600,
                                color: '#FFFFFF',
                              ).toJson(),
                            ),
                          ),
                        ),
                        StacText(
                          data:
                              'سناریو: ۲ ثانیه مکث → درخواست status (200) → نمایش دیالوگ موفقیت → ثبت لاگ و زمان اجرا.',
                          textDirection: StacTextDirection.rtl,
                          style: StacTextStyle.fromJson(
                            StacCustomTextStyle(
                              fontSize: 12.0,
                              color: '{{appColors.current.text.subtitle}}',
                            ).toJson(),
                          ),
                        ),
                        StacSizedBox(height: 12),
                        StacElevatedButton(
                          style: StacButtonStyle(
                            backgroundColor:
                                '{{appColors.current.error.color}}',
                            elevation: 0.0,
                            textStyle: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                color: '#FFFFFF',
                                fontSize: 15.0,
                                fontWeight: StacFontWeight.w600,
                              ).toJson(),
                            ),
                            padding: StacEdgeInsets.symmetric(vertical: 8.0),
                            fixedSize: StacSize(999999.0, 48.0),
                            shape: StacRoundedRectangleBorder(
                              borderRadius: StacBorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: StacSequenceAction(
                            actions: [
                              StacCustomSetValueAction(
                                key: 'flowErrorStart',
                                value: '{{now()}}',
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=flowErrorStart',
                              ),
                              StacDelayAction(milliseconds: 2000),
                              StacNetworkRequestAction(
                                url:
                                    'https://api.tobank.com/stateful_example_error',
                                method: 'get',
                                results: [
                                  {
                                    'statusCode': 400,
                                    'action': StacSequenceAction(
                                      actions: [
                                        StacCustomSetValueAction(
                                          key: 'lastStatus',
                                          value: 'error',
                                        ),
                                        StacCustomSetValueAction(
                                          key: 'lastMessage',
                                          value: 'توالی خطا انجام شد',
                                        ),
                                        StacLogAction(
                                          message:
                                              'screen=stateful_example action=flowErrorApiBad',
                                        ),
                                        StacRawJsonWidget({
                                          'actionType': 'showSnackBar',
                                          'duration': {'milliseconds': 3000},
                                          'backgroundColor': '#000000',
                                          'content': StacText(
                                            data: 'خطا در انجام درخواست',
                                            textDirection:
                                                StacTextDirection.rtl,
                                            style: StacTextStyle.fromJson(
                                              StacCustomTextStyle(
                                                fontSize: 13.0,
                                                color: '#FFFFFF',
                                              ).toJson(),
                                            ),
                                          ).toJson(),
                                        }).json,
                                      ],
                                    ),
                                  },
                                ],
                              ),
                              StacLogAction(
                                message:
                                    'screen=stateful_example action=flowErrorDone durationMs={{now() - flowErrorStart}}',
                              ),
                            ],
                          ),
                          child: StacText(
                            data: 'ادامه تست توالی خطا',
                            textDirection: StacTextDirection.rtl,
                            style: StacTextStyle.fromJson(
                              StacCustomTextStyle(
                                fontSize: 15.0,
                                fontWeight: StacFontWeight.w600,
                                color: '#FFFFFF',
                              ).toJson(),
                            ),
                          ),
                        ),
                        StacText(
                          data:
                              'سناریو: ۲ ثانیه مکث → درخواست error (400) → نمایش اسنک‌بار خطا → ثبت لاگ و زمان اجرا.',
                          textDirection: StacTextDirection.rtl,
                          style: StacTextStyle.fromJson(
                            StacCustomTextStyle(
                              fontSize: 12.0,
                              color: '{{appColors.current.text.subtitle}}',
                            ).toJson(),
                          ),
                        ),
                        StacSizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Helper Classes (copied from other files or defined for Dart builder compatibility)
// -----------------------------------------------------------------------------

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

class StacFormFieldValidator {
  final String rule;
  final String message;

  const StacFormFieldValidator({required this.rule, required this.message});

  Map<String, dynamic> toJson() {
    return {'rule': rule, 'message': message};
  }
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

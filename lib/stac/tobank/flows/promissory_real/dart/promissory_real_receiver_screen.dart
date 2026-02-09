import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import '../../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';
// Note: Adjusted relative imports based on file location

/// Promissory Real Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// Supports both Individual (حقیقی) and Legal (حقوقی) receiver types.
/// Uses Real API for identity inquiry.
@StacScreen(screenName: 'promissory_real_receiver')
StacWidget promissoryRealReceiver() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        // Receiver type: true = Individual, false = Legal
        StacCustomSetValueAction(key: 'isIndividualSelected', value: true),
        StacCustomSetValueAction(key: 'isLegalSelected', value: false),
        StacCustomSetValueAction(key: 'isReceiverFormValid', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.issuanceTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacSizedBox(height: 16),
                    // Title
                    StacText(
                      data: '{{appStrings.promissory.receiveInfo}}',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Receiver Type Selection Row
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        // Individual Button
                        StacExpanded(
                          child: StacGestureDetector(
                            onTap: StacSequenceAction(
                              actions: [
                                StacCustomSetValueAction(
                                  key: 'isIndividualSelected',
                                  value: true,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isLegalSelected',
                                  value: false,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isReceiverFormValid',
                                  value: false,
                                ),
                              ],
                            ),
                            child: StacContainer(
                              padding: StacEdgeInsets.symmetric(vertical: 12),
                              decoration: StacBoxDecoration(
                                borderRadius: StacBorderRadius.all(8),
                                border: StacBorder.all(
                                  color:
                                      '{{isIndividualSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                                  width: 1,
                                ),
                              ),
                              child: StacPadding(
                                padding: StacEdgeInsets.symmetric(horizontal: 16 , vertical: 6),
                                child: StacRow(
                                  textDirection: StacTextDirection.rtl,
                                  crossAxisAlignment: StacCrossAxisAlignment.center,
                                  children: [
                                    // Radio indicator
                                    StacContainer(
                                      width: 20,
                                      height: 20,
                                      decoration: StacBoxDecoration(
                                        color: 'transparent',
                                        borderRadius: StacBorderRadius.all(9999),
                                        border: StacBorder.all(
                                          color:
                                              '{{isIndividualSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                                          width: 2,
                                        ),
                                      ),
                                      child: StacCenter(
                                        child: StacContainer(
                                          width: 10,
                                          height: 10,
                                          decoration: StacBoxDecoration(
                                            color:
                                                '{{isIndividualSelected ? appColors.current.secondary.color : "transparent"}}',
                                            borderRadius: StacBorderRadius.all(9999),
                                          ),
                                        ),
                                      ),
                                    ),
                                    StacSizedBox(width: 8),
                                    // Label
                                    StacExpanded(
                                      child: StacText(
                                        data:
                                            '{{appStrings.promissory.receiverTypeIndividual}}',
                                        textDirection: StacTextDirection.rtl,
                                        style: StacCustomTextStyle(
                                          fontSize: 14,
                                          fontWeight: StacFontWeight.w600,
                                          color: '{{appColors.current.text.title}}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        StacSizedBox(width: 8),
                        // Legal Button
                        StacExpanded(
                          child: StacGestureDetector(
                            onTap: StacSequenceAction(
                              actions: [
                                StacCustomSetValueAction(
                                  key: 'isLegalSelected',
                                  value: true,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isIndividualSelected',
                                  value: false,
                                ),
                                StacCustomSetValueAction(
                                  key: 'isReceiverFormValid',
                                  value: false,
                                ),
                              ],
                            ),
                            child: StacContainer(
                              padding: StacEdgeInsets.symmetric(vertical: 12),
                              decoration: StacBoxDecoration(
                                borderRadius: StacBorderRadius.all(8),
                                border: StacBorder.all(
                                  color:
                                      '{{isLegalSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                                  width: 1,
                                ),
                              ),
                              child: StacPadding(
                                padding: StacEdgeInsets.symmetric(horizontal: 16 , vertical: 6),
                                child: StacRow(
                                  textDirection: StacTextDirection.rtl,
                                  crossAxisAlignment: StacCrossAxisAlignment.center,
                                  children: [
                                    // Radio indicator
                                    StacContainer(
                                      width: 20,
                                      height: 20,
                                      decoration: StacBoxDecoration(
                                        color: 'transparent',
                                        borderRadius: StacBorderRadius.all(9999),
                                        border: StacBorder.all(
                                          color:
                                              '{{isLegalSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                                          width: 2,
                                        ),
                                      ),
                                      child: StacCenter(
                                        child: StacContainer(
                                          width: 10,
                                          height: 10,
                                          decoration: StacBoxDecoration(
                                            color:
                                                '{{isLegalSelected ? appColors.current.secondary.color : "transparent"}}',
                                            borderRadius: StacBorderRadius.all(9999),
                                          ),
                                        ),
                                      ),
                                    ),
                                    StacSizedBox(width: 8),
                                    // Label
                                    StacExpanded(
                                      child: StacText(
                                        data:
                                            '{{appStrings.promissory.receiverTypeLegal}}',
                                        textDirection: StacTextDirection.rtl,
                                        style: StacCustomTextStyle(
                                          fontSize: 14,
                                          fontWeight: StacFontWeight.w600,
                                          color: '{{appColors.current.text.title}}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 16),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '{{isIndividualSelected}}',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacText(
                            data: '{{appStrings.promissory.nationalCode}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'receiver_national_code',
                            'textDirection': 'rtl',
                            'textAlign': 'right',
                            'maxLength': 10,
                            'inputFormatters': [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            'decoration': StacInputDecoration(
                              hintText: '{{appStrings.promissory.enterNationalCode}}',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            'keyboardType': 'number',
                            'textInputAction': 'next',
                            'validatorRules': [
                              {
                                'rule': r'^\d{10}$',
                                'message': '{{appStrings.promissory.nationalCodeError}}',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: [
                                {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                                {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                                {
                                  'id': 'receiver_birthdate',
                                  'rule': r'^\d{4}/\d{2}/\d{2}$',
                                },
                              ],
                            ).toJson(),
                          }),
                          StacSizedBox(height: 16),
                          StacText(
                            data: '{{appStrings.promissory.mobileNumber}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'receiver_mobile',
                            'textDirection': 'rtl',
                            'textAlign': 'right',
                            'maxLength': 11,
                            'inputFormatters': [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            'decoration': StacInputDecoration(
                              hintText: '{{appStrings.promissory.enterMobileNumber}}',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            'keyboardType': 'phone',
                            'textInputAction': 'next',
                            'validatorRules': [
                              {
                                'rule': r'^09\d{9}$',
                                'message': '{{appStrings.promissory.mobileNumberError}}',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: [
                                {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                                {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                                {
                                  'id': 'receiver_birthdate',
                                  'rule': r'^\d{4}/\d{2}/\d{2}$',
                                },
                              ],
                            ).toJson(),
                          }),
                          StacSizedBox(height: 16),
                          StacText(
                            data: '{{appStrings.promissory.birthdate}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacGestureDetector(
                            onTap: StacPersianDatePickerAction(
                              formFieldId: 'receiver_birthdate',
                              firstDate: '1350/01/01',
                              lastDate: '1450/12/29',
                              onDateSelected: StacValidateFieldsAction(
                                resultKey: 'isReceiverFormValid',
                                fields: [
                                  {
                                    'id': 'receiver_national_code',
                                    'rule': r'^\d{10}$',
                                  },
                                  {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                                  {
                                    'id': 'receiver_birthdate',
                                    'rule': r'^\d{4}/\d{2}/\d{2}$',
                                  },
                                ],
                              ).toJson(),
                            ),
                            child: StacTextFormField(
                              id: 'receiver_birthdate',
                              readOnly: true,
                              enabled: false,
                              textDirection: StacTextDirection.rtl,
                              textAlign: StacTextAlign.right,
                              decoration: StacInputDecoration(
                                hintText: '{{appStrings.promissory.selectBirthdate}}',
                                hintStyle: StacCustomTextStyle(
                                  color: '{{appColors.current.text.subtitle}}',
                                  fontSize: 15,
                                  fontWeight: StacFontWeight.w500,
                                ),
                                filled: false,
                                contentPadding: StacEdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                prefixIcon: StacPadding(
                                  padding: StacEdgeInsets.all(8),
                                  child: StacImage(
                                    src: 'assets/icons/ic_calendar.svg',
                                    imageType: StacImageType.asset,
                                    width: 24,
                                    height: 24,
                                    fit: StacBoxFit.scaleDown,
                                    color: '{{appColors.current.text.subtitle}}',
                                  ),
                                ),
                              ),
                              keyboardType: StacTextInputType.text,
                              style: StacCustomTextStyle(
                                fontSize: 16,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.text.title}}',
                              ),
                              validatorRules: [
                                StacFormFieldValidator(
                                  rule: r'^\d{4}/\d{2}/\d{2}$',
                                  message: '{{appStrings.promissory.selectBirthdateError}}',
                                ),
                              ],
                            ),
                          ),
                          StacSizedBox(height: 40),
                        ],
                      ).toJson(),
                    }),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '{{isLegalSelected}}',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                            children: [
                              StacExpanded(
                                child: StacText(
                                  data: 'انتخاب بانک گردشگری به عنوان دریافت‌کننده',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                              ),
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisSize: StacMainAxisSize.min,
                                children: [
                                  StacImage(
                                    src: 'assets/icons/ic_gardeshgari.svg',
                                    imageType: StacImageType.asset,
                                    width: 24,
                                    height: 24,
                                    fit: StacBoxFit.scaleDown,
                                  ),
                                  StacSizedBox(width: 8),
                                  StacRawJsonWidget({
                                    'type': 'reactiveSwitch',
                                    'id': 'legal_receiver_bank_switch',
                                    'valueKey': 'isLegalReceiverTourismBank',
                                    'activeColor': '{{appColors.current.secondary.color}}',
                                  }),
                                ],
                              ),
                            ],
                          ),
                          StacSizedBox(height: 16),
                          StacText(
                            data: 'شناسه ملی',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'legal_national_id',
                            'textDirection': 'rtl',
                            'textAlign': 'right',
                            'maxLength': 11,
                            'inputFormatters': [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            'decoration': StacInputDecoration(
                              hintText: 'شناسه ملی دریافت‌کننده را وارد کنید',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            'keyboardType': 'number',
                            'textInputAction': 'next',
                            'validatorRules': [
                              {
                                'rule': r'^\d{11}$',
                                'message': 'شناسه ملی معتبر نیست',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: [
                                {'id': 'legal_national_id', 'rule': r'^\d{11}$'},
                                {'id': 'legal_contact_number', 'rule': r'^09\d{9}$'},
                              ],
                            ).toJson(),
                          }),
                          StacSizedBox(height: 16),
                          StacText(
                            data: 'شماره تماس',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacRawJsonWidget({
                            'type': 'textFormField',
                            'id': 'legal_contact_number',
                            'textDirection': 'rtl',
                            'textAlign': 'right',
                            'maxLength': 11,
                            'inputFormatters': [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            'decoration': StacInputDecoration(
                              hintText: 'شماره تماس دریافت‌کننده را وارد نمایید',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            'keyboardType': 'phone',
                            'textInputAction': 'done',
                            'validatorRules': [
                              {
                                'rule': r'^09\\d{9}$',
                                'message': '{{appStrings.promissory.mobileNumberError}}',
                              },
                            ],
                            'onChanged': StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: [
                                {'id': 'legal_national_id', 'rule': r'^\d{10}$'},
                                {'id': 'legal_contact_number', 'rule': r'^09\d{10}$'},
                              ],
                            ).toJson(),
                          }),
                          StacSizedBox(height: 40),
                        ],
                      ).toJson(),
                    }),
                  ],
                ),
              ),
            ),
            // Continue Button (With Real API Call and Loading State)
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isReceiverFormValid',
                'loadingKey': 'receiver.isLoading',
                'onPressed': {
                  'actionType': 'sequence',
                  'actions': [
                    // Set loading state to true
                    {
                      'actionType': 'setValue',
                      'values': [
                        {'key': 'receiver.isLoading', 'value': true},
                        {'key': 'receiver.error', 'value': null},
                      ],
                    },
                    // Copy form values into registry for use in URL templating
                    {
                      'actionType': 'setValue',
                      'values': [
                        {
                          'key': 'receiver.nationalCode',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_national_code',
                          },
                        },
                        {
                          'key': 'form.receiver_national_code',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_national_code',
                          },
                        },
                        {
                          'key': 'receiver.mobile',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_mobile',
                          },
                        },
                        {
                          'key': 'form.receiver_mobile',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_mobile',
                          },
                        },
                        {
                          'key': 'receiver.birthDate',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_birthdate',
                          },
                        },
                        {
                          'key': 'form.receiver_birthdate',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_birthdate',
                          },
                        },
                        {
                          'key': 'receiver.birthDateCompact',
                          'value': "{{replace(receiver.birthDate,'/','')}}",
                        },
                      ],
                    },
                    // Call identity API (real) then navigate on success
                    {
                      'actionType': 'networkRequest',
                      'url':
                          'http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/identity/{{receiver.nationalCode}}/{{receiver.birthDateCompact}}',
                      'method': 'get',
                      'headers': {
                        'accept': '*/*',
                        'app-platform': 'android',
                        'app-store': 'application/json',
                        'app-version': '456',
                        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                        'serviceauthorization':
                            'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                        'authorization': '{{auth.accessToken}}',
                      },
                      'results': [
                        {
                          'statusCode': 200,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiverIdentity.raw',
                                    'value': '{{data.data}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.name',
                                    'value': '{{data.data.name}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.family',
                                    'value': '{{data.data.family}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.fullName',
                                    'value':
                                        '{{data.data.name}} {{data.data.family}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.fatherName',
                                    'value': '{{data.data.fatherName}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.gender',
                                    'value': '{{data.data.gender}}',
                                  },
                                  {
                                    'key': 'receiverIdentity.nationalId',
                                    'value': '{{data.data.nationalId}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'navigate',
                                'widgetType':
                                    'promissory_real_data', // Navigate to Real Data Screen
                                'navigationStyle': 'push',
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': 422,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiver.error',
                                    'value':
                                        '{{appStrings.promissory.invalidDataError}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.invalidDataErrorDetail}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': 401,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.sessionExpiredError}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': -1, // Fallback for any other errors
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiver.isLoading', 'value': false},
                                  {
                                    'key': 'receiver.error',
                                    'value':
                                        '{{appStrings.promissory.serverConnectionError}}',
                                  },
                                ],
                              },
                              {
                                'actionType': 'customSnackBar',
                                'message':
                                    '{{appStrings.promissory.serverConnectionErrorDetail}}',
                                'backgroundColor': '#D32F2F',
                                'duration': 4000,
                              },
                            ],
                          },
                        },
                      ],
                    },
                  ],
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

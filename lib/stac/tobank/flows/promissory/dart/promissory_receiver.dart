import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/config/sdui_config.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import 'package:tobank_sdui/stac_core/parsers/actions/date/persian_date_picker_action_model.dart';
// Note: Adjusted relative imports based on file location

/// Promissory Real Flow - Receiver Information Page
///
/// This screen collects the receiver (?????) information.
/// Supports both Individual (?????) and Legal (?????) receiver types.
/// Uses Real API for identity inquiry.
@StacScreen(screenName: 'promissory_receiver')
StacWidget promissoryRealReceiver() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        // Receiver type: true = Individual, false = Legal
        StacCustomSetValueAction(key: 'recipientType', value: true),
        StacCustomSetValueAction(key: 'isIndividualSelected', value: true),
        StacCustomSetValueAction(key: 'isLegalSelected', value: false),
        StacCustomSetValueAction(key: 'isReceiverFormValid', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: '{{appStrings.promissory.issuanceTitle}}',
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
                      // اطلاعات دریافت کننده
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
                                  key: 'recipientType',
                                  value: true,
                                ),
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
                                padding: StacEdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                child: StacRow(
                                  textDirection: StacTextDirection.rtl,
                                  crossAxisAlignment:
                                      StacCrossAxisAlignment.center,
                                  children: [
                                    // Radio indicator
                                    StacContainer(
                                      width: 20,
                                      height: 20,
                                      decoration: StacBoxDecoration(
                                        color: 'transparent',
                                        borderRadius: StacBorderRadius.all(
                                          9999,
                                        ),
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
                                            borderRadius: StacBorderRadius.all(
                                              9999,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    StacSizedBox(width: 8),
                                    // Label
                                    StacExpanded(
                                      child: StacText(
                                        data:
                                            // حقیقی
                                            '{{appStrings.promissory.receiverTypeIndividual}}',
                                        textDirection: StacTextDirection.rtl,
                                        style: StacCustomTextStyle(
                                          fontSize: 14,
                                          fontWeight: StacFontWeight.w600,
                                          color:
                                              '{{appColors.current.text.title}}',
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
                                  key: 'recipientType',
                                  value: false,
                                ),
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
                                padding: StacEdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                child: StacRow(
                                  textDirection: StacTextDirection.rtl,
                                  crossAxisAlignment:
                                      StacCrossAxisAlignment.center,
                                  children: [
                                    // Radio indicator
                                    StacContainer(
                                      width: 20,
                                      height: 20,
                                      decoration: StacBoxDecoration(
                                        color: 'transparent',
                                        borderRadius: StacBorderRadius.all(
                                          9999,
                                        ),
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
                                            borderRadius: StacBorderRadius.all(
                                              9999,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    StacSizedBox(width: 8),
                                    // Label
                                    StacExpanded(
                                      child: StacText(
                                        data:
                                            // حقوقی
                                            '{{appStrings.promissory.receiverTypeLegal}}',
                                        textDirection: StacTextDirection.rtl,
                                        style: StacCustomTextStyle(
                                          fontSize: 14,
                                          fontWeight: StacFontWeight.w600,
                                          color:
                                              '{{appColors.current.text.title}}',
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
                    StacCustomVisibility(
                      visible: '[[isIndividualSelected]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacText(
                            // کد ملی
                            data: '{{appStrings.promissory.nationalCode}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacCustomTextFormField(
                            id: 'receiver_national_code',
                            textDirection: 'rtl',
                            textAlign: 'right',
                            maxLength: 10,
                            inputFormatters: const [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            decoration: StacInputDecoration(
                              // کد ملی دریافت کننده را وارد نمایید
                              hintText:
                                  '{{appStrings.promissory.enterNationalCode}}',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            keyboardType: 'number',
                            textInputAction: 'next',
                            validatorRules: const [
                              {
                                'rule': r'^\d{10}$',
                                // کد ملی معتبر وارد نمایید
                                'message':
                                    '{{appStrings.promissory.nationalCodeError}}',
                              },
                            ],
                            onChanged: StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: const [
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
                          StacSizedBox(height: 16),
                          StacText(
                            // شماره موبایل
                            data: '{{appStrings.promissory.mobileNumber}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(height: 8),
                          StacCustomTextFormField(
                            id: 'receiver_mobile',
                            textDirection: 'rtl',
                            textAlign: 'right',
                            maxLength: 11,
                            inputFormatters: const [
                              {'type': 'allow', 'rule': '[0-9]'},
                            ],
                            decoration: StacInputDecoration(
                              // شماره موبایل دریافت کننده را وارد نمایید
                              hintText:
                                  '{{appStrings.promissory.enterMobileNumber}}',
                              filled: false,
                              contentPadding: StacEdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ).toJson(),
                            keyboardType: 'phone',
                            textInputAction: 'next',
                            validatorRules: const [
                              {
                                'rule': r'^09\d{9}$',
                                // شماره همراه معتبر وارد نمایید
                                'message':
                                    '{{appStrings.promissory.mobileNumberError}}',
                              },
                            ],
                            onChanged: StacValidateFieldsAction(
                              resultKey: 'isReceiverFormValid',
                              fields: const [
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
                          StacSizedBox(height: 16),
                          StacText(
                            // تاریخ تولد
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
                                  {
                                    'id': 'receiver_mobile',
                                    'rule': r'^09\d{9}$',
                                  },
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
                                // تاریخ تولد دریافت کنننده را انتخاب نمایید
                                hintText:
                                    '{{appStrings.promissory.selectBirthdate}}',
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
                                    color:
                                        '{{appColors.current.text.subtitle}}',
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
                                  // تاریخ تولد را انتخاب نمایید
                                  message:
                                      '{{appStrings.promissory.selectBirthdateError}}',
                                ),
                              ],
                            ),
                          ),
                          StacSizedBox(height: 40),
                        ],
                      ).toJson(),
                    ),
                    StacCustomVisibility(
                      visible: '[[isLegalSelected]]',
                      child: StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                            children: [
                              StacExpanded(
                                child: StacText(
                                  // اطلاعات ذینفع (دریافت‌کننده)
                                  data:
                                      '{{appStrings.promissory.selectGardeshgariAsReceiver}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 15,
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
                                  ),
                                  StacSizedBox(width: 8),
                                  StacCustomReactiveSwitch(
                                    id: 'legal_receiver_bank_switch',
                                    valueKey: 'isLegalReceiverTourismBank',
                                    activeColor:
                                        '{{appColors.current.secondary.color}}',
                                    onChanged: StacSequenceAction(
                                      actions: [
                                        StacCustomSetValueAction(
                                          values: [
                                            {
                                              'key': 'legal_national_id',
                                              'value': '10320435268',
                                              'condition':
                                                  'isLegalReceiverTourismBank',
                                            },
                                            {
                                              'key': 'legal_contact_number',
                                              'value': '02123952395',
                                              'condition':
                                                  'isLegalReceiverTourismBank',
                                            },
                                            {
                                              'key': 'legal_national_id',
                                              'value': '',
                                              'condition':
                                                  '!isLegalReceiverTourismBank',
                                            },
                                            {
                                              'key': 'legal_contact_number',
                                              'value': '',
                                              'condition':
                                                  '!isLegalReceiverTourismBank',
                                            },
                                            {
                                              'key': 'isReceiverFormValid',
                                              'value': true,
                                              'condition':
                                                  'isLegalReceiverTourismBank',
                                            },
                                            {
                                              'key': 'isReceiverFormValid',
                                              'value': false,
                                              'condition':
                                                  '!isLegalReceiverTourismBank',
                                            },
                                          ],
                                        ),
                                      ],
                                    ).toJson(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          StacCustomVisibility(
                            visible: '[[!isLegalReceiverTourismBank]]',
                            child: StacColumn(
                              crossAxisAlignment:
                                  StacCrossAxisAlignment.stretch,
                              children: [
                                StacSizedBox(height: 16),
                                StacText(
                                  // شناسه ملی
                                  data: '{{appStrings.promissory.nationalId}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                                StacSizedBox(height: 8),
                                StacCustomTextFormField(
                                  id: 'legal_national_id',
                                  textDirection: 'rtl',
                                  textAlign: 'right',
                                  maxLength: 11,
                                  inputFormatters: const [
                                    {'type': 'allow', 'rule': '[0-9]'},
                                  ],
                                  decoration: StacInputDecoration(
                                    // شناسه ملی شرکت را وارد نمایید
                                    hintText:
                                        '{{appStrings.promissory.enterNationalId}}',
                                    filled: false,
                                    contentPadding: StacEdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ).toJson(),
                                  keyboardType: 'number',
                                  textInputAction: 'next',
                                  validatorRules: const [
                                    {
                                      'rule': r'^\d{10,}$',
                                      // کد ملی معتبر وارد نمایید
                                      'message':
                                          '{{appStrings.promissory.nationalCodeError}}',
                                    },
                                  ],
                                  onChanged: StacValidateFieldsAction(
                                    resultKey: 'isReceiverFormValid',
                                    fields: const [
                                      {
                                        'id': 'legal_national_id',
                                        'rule': r'^\d{10,}$',
                                      },
                                      {
                                        'id': 'legal_contact_number',
                                        'rule': r'^\d{10,}$',
                                      },
                                    ],
                                  ).toJson(),
                                ),
                                StacSizedBox(height: 16),
                                StacText(
                                  // شماره تماس
                                  data:
                                      '{{appStrings.promissory.contactNumber}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                                StacSizedBox(height: 8),
                                StacCustomTextFormField(
                                  id: 'legal_contact_number',
                                  textDirection: 'rtl',
                                  textAlign: 'right',
                                  maxLength: 11,
                                  inputFormatters: const [
                                    {'type': 'allow', 'rule': '[0-9]'},
                                  ],
                                  decoration: StacInputDecoration(
                                    // شماره تماس شرکت را وارد نمایید
                                    hintText:
                                        '{{appStrings.promissory.enterContactNumber}}',
                                    filled: false,
                                    contentPadding: StacEdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ).toJson(),
                                  keyboardType: 'phone',
                                  textInputAction: 'done',
                                  validatorRules: const [
                                    {
                                      'rule': r'^\d{10,}$',
                                      // شماره همراه معتبر وارد نمایید
                                      'message':
                                          '{{appStrings.promissory.mobileNumberError}}',
                                    },
                                  ],
                                  onChanged: StacValidateFieldsAction(
                                    resultKey: 'isReceiverFormValid',
                                    fields: const [
                                      {
                                        'id': 'legal_national_id',
                                        'rule': r'^\d{10,}$',
                                      },
                                      {
                                        'id': 'legal_contact_number',
                                        'rule': r'^\d{10,}$',
                                      },
                                    ],
                                  ).toJson(),
                                ),
                                StacSizedBox(height: 40),
                              ],
                            ).toJson(),
                          ),
                          StacCustomVisibility(
                            visible: '[[isLegalReceiverTourismBank]]',
                            child: StacColumn(
                              crossAxisAlignment:
                                  StacCrossAxisAlignment.stretch,
                              children: [
                                StacSizedBox(height: 16),
                                StacText(
                                  // شناسه ملی
                                  data: '{{appStrings.promissory.nationalId}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                                StacSizedBox(height: 8),
                                StacCustomContainer(
                                  decoration: StacBoxDecoration(
                                    border: StacBorder.all(
                                      color:
                                          '{{appColors.current.input.borderEnabled}}',
                                    ),
                                    borderRadius: const StacBorderRadius.all(
                                      12,
                                    ),
                                    color:
                                        '{{appColors.current.background.surfaceContainer}}',
                                  ).toJson(),
                                  child: StacPadding(
                                    padding: const StacEdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    child: StacText(
                                      data: '10320435268',
                                      textAlign: StacTextAlign.right,
                                      style: StacCustomTextStyle(
                                        fontSize: 16,
                                        fontWeight: StacFontWeight.w600,
                                        color:
                                            '{{appColors.current.text.title}}',
                                      ),
                                    ),
                                  ).toJson(),
                                ),
                                StacSizedBox(height: 16),
                                StacText(
                                  // شماره تماس
                                  data:
                                      '{{appStrings.promissory.contactNumber}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 14,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.title}}',
                                  ),
                                ),
                                StacSizedBox(height: 8),
                                StacCustomContainer(
                                  decoration: StacBoxDecoration(
                                    border: StacBorder.all(
                                      color:
                                          '{{appColors.current.input.borderEnabled}}',
                                    ),
                                    borderRadius: const StacBorderRadius.all(
                                      12,
                                    ),
                                    color:
                                        '{{appColors.current.background.surfaceContainer}}',
                                  ).toJson(),
                                  child: StacPadding(
                                    padding: const StacEdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    child: StacText(
                                      data: '02123952395',
                                      textAlign: StacTextAlign.right,
                                      textDirection: StacTextDirection.ltr,
                                      style: StacCustomTextStyle(
                                        fontSize: 16,
                                        fontWeight: StacFontWeight.w600,
                                        color:
                                            '{{appColors.current.text.title}}',
                                      ),
                                    ),
                                  ).toJson(),
                                ),
                                StacSizedBox(height: 40),
                              ],
                            ).toJson(),
                          ),
                        ],
                      ).toJson(),
                    ),
                  ],
                ),
              ),
            ),
            // Continue Button (With Real API Call and Loading State)
            StacCustomVisibility(
              visible: '[[isIndividualSelected]]',
              child: StacPadding(
                padding: StacEdgeInsets.all(16),
                child: StacCustomReactiveElevatedButton(
                  enabledKey: 'isReceiverFormValid',
                  loadingKey: 'receiver.isLoading',
                  onPressed: {
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
                            SduiConfig.bizUrl('customers/v1.0/identity/{{receiver.nationalCode}}/{{receiver.birthDateCompact}}'),
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
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
                                      'promissory_data', // Navigate to Real Data Screen
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                    {
                                      'key': 'receiver.error',
                                      'value':
                                          // اطلاعات وارد شده صحیح نمی‌باشد
                                          '{{appStrings.promissory.invalidDataError}}',
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.invalidDataErrorDetail}}',
                                  duration: 4000,
                                ).toJson(),
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.sessionExpiredError}}',
                                  duration: 4000,
                                ).toJson(),
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                    {
                                      'key': 'receiver.error',
                                      'value':
                                          // خطا در برقراری ارتباط با سرور
                                          '{{appStrings.promissory.serverConnectionError}}',
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                                  duration: 4000,
                                ).toJson(),
                              ],
                            },
                          },
                        ],
                      },
                    ],
                  },
                  style: StacButtonStyle(
                    backgroundColor: '{{appColors.current.primary.color}}',
                    elevation: 0,
                    fixedSize: StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  child: StacText(
                    // ادامه
                    data: '{{appStrings.common.continue}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.bold,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ).toJson(),
                ),
              ).toJson(),
            ),
            // Legal Receiver Continue Button
            StacCustomVisibility(
              visible: '[[isLegalSelected]]',
              child: StacPadding(
                padding: StacEdgeInsets.all(16),
                child: StacCustomReactiveElevatedButton(
                  enabledKey: 'isReceiverFormValid',
                  loadingKey: 'receiver.isLoading',
                  onPressed: {
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
                            'key': 'receiver.legalNationalId',
                            'value': {
                              'actionType': 'getFormValue',
                              'id': 'legal_national_id',
                            },
                            'condition': '!isLegalReceiverTourismBank',
                          },
                          {
                            'key': 'receiver.legalNationalId',
                            'value': '{{legal_national_id}}',
                            'condition': 'isLegalReceiverTourismBank',
                          },
                          {
                            'key': 'form.legal_national_id',
                            'value': {
                              'actionType': 'getFormValue',
                              'id': 'legal_national_id',
                            },
                            'condition': '!isLegalReceiverTourismBank',
                          },
                          {
                            'key': 'form.legal_national_id',
                            'value': '{{legal_national_id}}',
                            'condition': 'isLegalReceiverTourismBank',
                          },
                          {
                            'key': 'form.legal_contact_number',
                            'value': {
                              'actionType': 'getFormValue',
                              'id': 'legal_contact_number',
                            },
                            'condition': '!isLegalReceiverTourismBank',
                          },
                          {
                            'key': 'form.legal_contact_number',
                            'value': '{{legal_contact_number}}',
                            'condition': 'isLegalReceiverTourismBank',
                          },
                        ],
                      },
                      // Call identity API (real) then navigate on success
                      {
                        'actionType': 'networkRequest',
                        'url':
                            SduiConfig.bizUrl('customers/v1.0/identity/{{receiver.legalNationalId}}'),
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                    {
                                      'key': 'receiverIdentity.raw',
                                      'value': '{{data.data}}',
                                    },
                                    {
                                      'key': 'receiverIdentity.name',
                                      'value': '{{data.data.name}}',
                                    },
                                    {
                                      'key': 'receiverIdentity.fullName',
                                      'value':
                                          '{{data.data.name}}', // Used in next screen
                                    },
                                    {
                                      'key': 'receiverIdentity.nationalId',
                                      'value': '{{data.data.nationalId}}',
                                    },
                                    {
                                      'key': 'receiverIdentity.phone',
                                      'value': '{{data.data.phone}}',
                                    },
                                    {
                                      'key': 'receiverIdentity.address',
                                      'value': '{{data.data.address}}',
                                    },
                                    {
                                      'key': 'form.paymentPlace',
                                      'value': '{{data.data.address}}',
                                    },
                                  ],
                                },
                                {
                                  'actionType': 'navigate',
                                  'widgetType':
                                      'promissory_data', // Navigate to Real Data Screen
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                    {
                                      'key': 'receiver.error',
                                      'value':
                                          // اطلاعات وارد شده صحیح نمی‌باشد
                                          '{{appStrings.promissory.invalidDataError}}',
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.invalidDataErrorDetail}}',
                                  duration: 4000,
                                ).toJson(),
                              ],
                            },
                          },
                          {
                            'statusCode': 520,
                            'action': {
                              'actionType': 'sequence',
                              'actions': [
                                {
                                  'actionType': 'setValue',
                                  'values': [
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                                  duration: 4000,
                                ).toJson(),
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
                                    {
                                      'key': 'receiver.isLoading',
                                      'value': false,
                                    },
                                    {
                                      'key': 'receiver.error',
                                      'value':
                                          // خطا در برقراری ارتباط با سرور
                                          '{{appStrings.promissory.serverConnectionError}}',
                                    },
                                  ],
                                },
                                const StacCustomSnackBarAction(
                                  title: 'خطا',
                                  detail:
                                      '{{appStrings.promissory.serverConnectionErrorDetail}}',
                                  duration: 4000,
                                ).toJson(),
                              ],
                            },
                          },
                        ],
                      },
                    ],
                  },
                  style: StacButtonStyle(
                    backgroundColor: '{{appColors.current.primary.color}}',
                    elevation: 0,
                    fixedSize: StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  child: StacText(
                    // ادامه
                    data: '{{appStrings.common.continue}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.bold,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ).toJson(),
                ),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}


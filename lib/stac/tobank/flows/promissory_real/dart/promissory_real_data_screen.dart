import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/format_number_action.dart';
import 'package:tobank_sdui/core/stac/builders/amount_to_words_action.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_detail_row.dart';

/// Promissory Real Flow - Data Entry Page
///
/// This screen collects the promissory details:
/// 1. Amount
/// 2. Due Date
/// 3. Description (Optional)
/// 4. Payment Place (Optional)
///
/// It also displays a summary of the Receiver Information.
@StacScreen(screenName: 'promissory_real_data')
StacWidget promissoryRealData() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isDataFormValid', 'value': false},
        {'key': 'isIdentityLoading', 'value': false},
        {'key': 'isOnDemand', 'value': false},
        {'key': 'transferable', 'value': true},
        {'key': 'form.promissory_amount_words', 'value': ''},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        // صدور سفته
        title: '{{appStrings.promissory.issuanceTitle}}',
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacStack(
          children: [
            StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacExpanded(
                  child: StacSingleChildScrollView(
                    padding: StacEdgeInsets.all(16),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        _buildReceiverInfoSummary(),
                        StacSizedBox(height: 24),
                        _buildPromissoryFormDetails(),
                      ],
                    ),
                  ),
                ),
                _buildSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildReceiverInfoSummary() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          //  اطلاعات  دریافت‌کننده
          data: '{{appStrings.promissory.receiveInfo}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 12),
        // National Code (Individual)
        StacCustomVisibility(
          visible: '[[recipientType]]',
          child: buildPromissoryDetailRow(
            // کد ملی
            '{{appStrings.promissory.nationalCode}}',
            '{{form.receiver_national_code}}',
          ).toJson(),
        ),
        // National ID (Legal)
        StacCustomVisibility(
          visible: '[[!recipientType]]',
          child: buildPromissoryDetailRow(
            // شناسه ملی
            '{{appStrings.promissory.nationalId}}',
            '{{receiverIdentity.nationalId}}',
          ).toJson(),
        ),
        StacSizedBox(height: 8),
        // Mobile Number (Individual)
        StacCustomVisibility(
          visible: '[[recipientType]]',
          child: buildPromissoryDetailRow(
            // شماره موبایل
            '{{appStrings.promissory.mobileNumber}}',
            '{{form.receiver_mobile}}',
          ).toJson(),
        ),
        // Phone Number (Legal)
        StacCustomVisibility(
          visible: '[[!recipientType]]',
          child: buildPromissoryDetailRow(
            // شماره تماس
            '{{appStrings.promissory.contactNumber}}',
            '{{receiverIdentity.phone}}',
          ).toJson(),
        ),
        StacSizedBox(height: 8),
        // Full Name (Individual)
        StacCustomVisibility(
          visible: '[[recipientType]]',
          child: buildPromissoryDetailRow(
            // نام و نام خانوادگی
            '{{appStrings.promissory.fullName}}',
            '{{receiverIdentity.fullName}}',
          ).toJson(),
        ),
        // Name (Legal)
        StacCustomVisibility(
          visible: '[[!recipientType]]',
          child: buildPromissoryDetailRow(
            'نام',
            '{{receiverIdentity.fullName}}',
          ).toJson(),
        ),
      ],
    ),
  );
}

StacWidget _buildPromissoryFormDetails() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        // Section Title
        StacText(
          // اطلاعات سفته
          data: '{{appStrings.promissory.detailsTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 16),
        _buildAmountInput(),
        StacSizedBox(height: 16),
        _buildDateInput(),
        StacSizedBox(height: 16),
        _buildTransferableInput(),
        StacSizedBox(height: 16),
        _buildPaymentPlaceInput(),
        StacSizedBox(height: 16),
        _buildDescriptionInput(),
        StacSizedBox(height: 16),
      ],
    ),
  );
}

StacWidget _buildAmountInput() {
  return StacColumn(
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacText(
              // مبلغ تعهد
              data: '{{appStrings.promissory.CommitmentAmount}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacContainer(
            width: 190,
            child: StacCustomRegistryReactive(
              registryKey: 'form.promissory_amount_words',
              child: {
                'type': 'text',
                'data': '{{form.promissory_amount_words}}',
                'textDirection': 'rtl',
                'textAlign': 'left',
                'maxLines': 2,
                'overflow': 'ellipsis',
                'style': {
                  'type': 'custom',
                  'fontSize': 13,
                  'fontWeight': 'w600',
                  'height': 1.35,
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
            ),
          ),
        ],
      ),
      StacSizedBox(height: 8),
      StacCustomTextFormField(
        id: 'promissory_amount',
        textDirection: 'rtl',
        textAlign: 'right',
        formatThousands: true,
        thousandsSeparator: ',',
        decoration: StacInputDecoration(
          // مبلغ سفته را به ریال وارد نمایید
          hintText: '{{appStrings.promissory.enterAmountt}}',
          hintStyle: StacTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
          ),
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ).toJson(),
        keyboardType: 'number',
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        validatorRules: const [
          {
            'rule': r'^\d+$',
            // مبلغ الزامی است
            'message': '{{appStrings.promissory.amountRequired}}',
          },
          {
            'rule': r'^(2[0-9]{7,}|[3-9][0-9]{7,}|[1-9][0-9]{8,})$',
            // حداقل مبلغ ۲۰,۰۰۰,۰۰۰ ریال می‌باشد
            'message': 'حداقل مبلغ تعهد بیست میلیون ریال می‌باشد',
          },
        ],
        onChanged: StacSequenceAction(
          actions: [
            StacCustomSetValueAction(
              key: 'form.promissory_amount_raw',
              value: StacGetFormValueAction(id: 'promissory_amount'),
            ),
            StacAmountToWordsAction(
              sourceKey: 'form.promissory_amount_raw',
              destinationKey: 'form.promissory_amount_words',
              divideBy: 10,
              minDigits: 2,
              suffix: 'تومان',
            ),
            _getFullValidationAction(),
          ],
        ),
      ),
      StacSizedBox(height: 8),
      StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data: 'حداقل مبلغ تعهد بیست میلیون ریال می‌باشد',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 12,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _buildDateInput() {
  return StacColumn(
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacText(
            // تاریخ پرداخت سفته
            data: '{{appStrings.promissory.payDatePromissory}}',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisSize: StacMainAxisSize.min,
            children: [
              StacText(
                // عندالمطالبه
                data: '{{appStrings.promissory.onDemand}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 12,
                  fontWeight: StacFontWeight.w500,
                ),
              ),
              StacSizedBox(width: 8),
              StacCustomReactiveSwitch(
                id: 'dueDateSwitch',
                valueKey: 'isOnDemand',
                activeColor: '{{appColors.current.secondary.color}}',
                onChanged: _getFullValidationAction(),
              ),
            ],
          ),
        ],
      ),
      StacSizedBox(height: 8),
      StacCustomVisibility(
        visible: '{{!isOnDemand}}',
        child: StacGestureDetector(
          onTap: StacPersianDatePickerAction(
            formFieldId: 'promissory_due_date',
            firstDate: '1403/01/01', // Example constraint
            lastDate: '1450/12/29',
            onDateSelected: _getFullValidationAction().toJson(),
          ),
          child: StacTextFormField(
            id: 'promissory_due_date',
            readOnly: true,
            enabled: false,
            style: StacCustomTextStyle(
              fontSize: 13,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            decoration: StacInputDecoration(
              // تاریخ پرداخت را انتخاب کنید
              hintText: '{{appStrings.promissory.selectDate}}',
              hintStyle: StacTextStyle(
                fontSize: 12,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.hint}}',
              ),
              filled: false,
              contentPadding: StacEdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              prefixIcon: StacIcon(
                icon: StacIcons.calendar_today,
                color: '{{appColors.current.text.subtitle}}',
                size: 20,
              ),
            ),
            validatorRules: [
              StacFormFieldValidator(
                rule: r'^\d{4}/\d{2}/\d{2}$',
                // تاریخ سررسید الزامی است
                message: '{{appStrings.promissory.dueDateRequired}}',
              ),
            ],
          ),
        ).toJson(),
      ),
    ],
  );
}

StacWidget _buildTransferableInput() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacExpanded(
        child: StacText(
          // قابل انتقال (حواله‌کرد)
          data: '{{appStrings.promissory.transferableLabel}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      StacCustomReactiveSwitch(
        id: 'transferableSwitch',
        valueKey: 'transferable',
        activeColor: '{{appColors.current.secondary.color}}',
      ),
    ],
  );
}

StacWidget _buildPaymentPlaceInput() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        // آدرس
        data: '{{appStrings.promissory.address}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacCustomVisibility(
        visible: '{{recipientType}}',
        child: StacCustomTextFormField(
          id: 'paymentPlace',
          textDirection: 'rtl',
          textAlign: 'right',
          minLines: 3,
          maxLines: 5,
          maxLength: 200,
          decoration: StacInputDecoration(
            // آدرس محل پرداخت را بنویسید (تا ۲۰۰ کاراکتر)
            hintText: '{{appStrings.promissory.paymentPlaceHint}}',
            filled: false,
            contentPadding: StacEdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ).toJson(),
          validatorRules: const [
            {
              'rule': r'^.{5,200}$',
              'message': '{{appStrings.promissory.enterPaymentPlace}}',
            },
          ],
          onChanged: _getFullValidationAction(),
        ).toJson(),
      ),
      StacCustomVisibility(
        visible: '{{!recipientType}}',
        child: StacCustomTextFormField(
          id: 'paymentPlace',
          initialValue: '{{form.paymentPlace}}',
          readOnly: true,
          enabled: false,
          textDirection: 'rtl',
          textAlign: 'right',
          minLines: 3,
          maxLines: 5,
          decoration: StacInputDecoration(
            filled: true,
            fillColor: '{{appColors.current.background.surfaceContainer}}',
            contentPadding: StacEdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ).toJson(),
          onChanged: _getFullValidationAction(),
        ).toJson(),
      ),
    ],
  );
}

StacWidget _buildDescriptionInput() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        // توضیحات (اختیاری)
        data: '{{appStrings.promissory.amountOptionalSuffix}}',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacTextFormField(
        id: 'description',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        minLines: 3,
        maxLines: 5,
        decoration: StacInputDecoration(
          // توضیحات صدور سفته را وارد نمایید
          hintText: '{{appStrings.promissory.descriptionHint}}',
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildSubmitButton() {
  return StacPadding(
    padding: StacEdgeInsets.all(16),
    child: StacCustomReactiveElevatedButton(
      enabledKey: 'isDataFormValid',
      onPressed: StacSequenceAction(
        actions: [
          // Save form data to registry
          StacCustomSetValueAction(
            key: 'form.promissory_amount_raw',
            value: StacGetFormValueAction(id: 'promissory_amount'),
          ),
          // Sanitize amount (remove separators) for downstream usage
          StacCustomSetValueAction(
            key: 'form.promissory_amount',
            value: "{{replace(form.promissory_amount_raw,',','')}}",
          ),
          // Format the clean value to be displayed with commas in Confirm Screen
          StacFormatNumberAction(
            sourceKey: 'form.promissory_amount',
            destinationKey: 'form.promissory_amount_formatted',
          ),
          StacCustomSetValueAction(
            key: 'form.promissory_due_date',
            value: StacGetFormValueAction(id: 'promissory_due_date'),
          ),
          StacCustomSetValueAction(
            key: 'form.promissory_due_date_display',
            value:
                // عندالمطالبه
                "{{isOnDemand ? appStrings.promissory.onDemand : form.promissory_due_date}}",
          ),
          StacCustomSetValueAction(
            key: 'form.description',
            value: StacGetFormValueAction(id: 'description'),
          ),
          StacCustomSetValueAction(
            key: 'form.paymentPlace',
            value: StacGetFormValueAction(id: 'paymentPlace'),
          ),
          StacCustomSetValueAction(
            key: 'form.transferable',
            value: '{{transferable}}',
          ),
          // Ensure compact birth date exists for later steps
          StacCustomSetValueAction(
            key: 'receiver.birthDateCompact',
            value: "{{replace(receiver.birthDate,'/','')}}",
          ),
          // Fetch Fees API Call
          StacCustomSetValueAction(key: 'isIdentityLoading', value: true),
          StacNetworkRequestAction(
            url:
                "http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/fees?amount={{replace(form.promissory_amount,',','')}}",
            method: 'get',
            headers: {
              'accept': 'application/json',
              'authorization': '{{auth.accessToken}}',
            },
            results: [
              {
                'statusCode': 200,
                'action': StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      values: [
                        {
                          'key': 'promissory.fees.stampFee',
                          'value': '{{data_payload.stampFee}}',
                        },
                        {
                          'key': 'promissory.fees.wage',
                          'value': '{{data_payload.wage}}',
                        },
                        {
                          'key': 'promissory.fees.total',
                          'value': '{{data_payload.total}}',
                        },
                        {'key': 'isIdentityLoading', 'value': false},
                      ],
                    ),
                    StacNavigateAction(
                      routeName: 'promissory_real_confirm',
                      navigationStyle: NavigationStyle.push,
                    ),
                  ],
                ).toJson(),
              },
              {
                'statusCode': -1, // Fallback for errors
                'action': StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      key: 'isIdentityLoading',
                      value: false,
                    ),
                    StacShowDialogAction(
                      dialog: StacAlertDialog(
                        // خطا
                        title: StacText(data: '{{appStrings.common.error}}'),
                        content: StacText(
                          // خطا در محاسبه هزینه سفته
                          data: '{{appStrings.promissory.priceCalcError}}',
                        ),
                        actions: [
                          StacTextButton(
                            onPressed: const StacCloseDialogAction(),
                            // تایید
                            child: StacText(
                              data: '{{appStrings.common.confirm}}',
                            ),
                          ),
                        ],
                      ).toJson(),
                    ),
                  ],
                ).toJson(),
              },
            ],
          ),
        ],
      ),
      style: StacButtonStyle(
        backgroundColor: '{{appColors.current.primary.color}}',
        elevation: 0,
        fixedSize: StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(12),
        ),
      ).toJson(),
      child: StacText(
        data:
            // در حال دریافت...
            // ادامه
            "{{isIdentityLoading ? appStrings.promissory.loadingText : appStrings.common.continue}}",
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.primary.onPrimary}}',
        ),
      ).toJson(),
    ),
  );
}

StacValidateFieldsAction _getFullValidationAction() {
  final fields = <Map<String, dynamic>>[
    {'id': 'promissory_amount', 'rule': r'^[\d,]+$'},
    {
      'id': 'promissory_due_date',
      'rule': r'^\d{4}/\d{2}/\d{2}$',
      'optional': 'isOnDemand',
    },
    {'id': 'paymentPlace', 'rule': r'^.{5,200}$'},
  ];
  return StacValidateFieldsAction(resultKey: 'isDataFormValid', fields: fields);
}
